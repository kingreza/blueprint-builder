//  
//  RootWorkflow.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/15/20.
//

import ReactiveSwift
import Workflow
import WorkflowUI

// MARK: Input and Output

struct RootWorkflow: Workflow {
    enum Output {}
}

// MARK: State and Initialization

extension RootWorkflow {
    struct State {
        var selectedTemplate: Template?
    }
    
    func makeInitialState() -> RootWorkflow.State {
        return State(selectedTemplate: nil)
    }
    
    func workflowDidChange(from previousWorkflow: RootWorkflow, state: inout State) {}
}

// MARK: Actions

extension RootWorkflow {
    enum Action: WorkflowAction {
        typealias WorkflowType = RootWorkflow
        case templateTapped(Template)
        case backTapped
        func apply(toState state: inout RootWorkflow.State) -> RootWorkflow.Output? {
            switch self {
            // Update state and produce an optional output based on which action was received.
            case .templateTapped(let template):
                state.selectedTemplate = template
                return nil
            case .backTapped:
                state.selectedTemplate = nil
                return nil
            }
        }
    }
}

// MARK: Rendering

extension RootWorkflow {
    // TODO: Change this to your actual rendering type
    typealias Rendering = BackStackScreen
    
    func render(state: RootWorkflow.State, context: RenderContext<RootWorkflow>) -> Rendering {
        
        let sink = context.makeSink(of: Action.self)
        let templateListRendering = BackStackScreen.Item(
            screen: TemplateListWorkflow()
                .mapOutput({output -> Action in
                    switch output {
                    case .templateTapped(let template):
                        return .templateTapped(template)
                    }
                })
                .rendered(with: context),
            barContent: BackStackScreen.BarContent(title: "Templates")
        )
        if let template = state.selectedTemplate {
            let componentListWorkflowScreen = BackStackScreen.Item(
                screen: ComponentListWorkflow(node: template.node)
                    .mapOutput({output -> Action in })
                    .rendered(with: context),
                barContent: BackStackScreen.BarContent(
                    title: "Blueprint Builder",
                    leftItem: .button(
                        .back {
                            sink.send(.backTapped)
                        }
                    )
                )
            )
            
            return BackStackScreen(items: [templateListRendering, componentListWorkflowScreen])
        } else {
            return BackStackScreen(items: [templateListRendering])
        }
    }
}
