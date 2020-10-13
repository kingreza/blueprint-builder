//  
//  PresetListWorkflow.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/15/20.
//

import ReactiveSwift
import Workflow
import WorkflowUI
import BlueprintUI

// MARK: Input and Output

struct TemplateListWorkflow: Workflow {
    let tempaltes = Template.defaultList()
    enum Output {
        case templateTapped(Template)
    }
}

// MARK: State and Initialization

extension TemplateListWorkflow {
    struct State {}
    
    func makeInitialState() -> TemplateListWorkflow.State {
        return State()
    }
    
    func workflowDidChange(from previousWorkflow: TemplateListWorkflow, state: inout State) {}
}

// MARK: Actions

extension TemplateListWorkflow {
    enum Action: WorkflowAction {
        typealias WorkflowType = TemplateListWorkflow
        
        case templateTapped(Template)
        
        func apply(toState state: inout TemplateListWorkflow.State) -> TemplateListWorkflow.Output? {
            switch self {
            // Update state and produce an optional output based on which action was received.
            case .templateTapped(let template):
                return .templateTapped(template)
            }
        }
    }
}

// MARK: Rendering

extension TemplateListWorkflow {
    // TODO: Change this to your actual rendering type
    typealias Rendering = TemplateListScreen
    
    func render(state: TemplateListWorkflow.State, context: RenderContext<TemplateListWorkflow>) -> Rendering {
        
        let actionSink = context.makeSink(of: Action.self)
        return TemplateListScreen(
            listElement: TemplateListElement(
                templates: self.tempaltes,
                onTemplateTapped: { template in
                    actionSink.send(.templateTapped(template))
                }
            )
        )
    }
}
