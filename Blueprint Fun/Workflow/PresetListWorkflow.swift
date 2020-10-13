//  
//  PresetListWorkflow.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/15/20.
//

import ReactiveSwift
import Workflow
import WorkflowUI

// MARK: Input and Output

struct TemplateListWorkflow: Workflow {
    let
    enum Output {}
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

        func apply(toState state: inout TemplateListWorkflow.State) -> TemplateListWorkflow.Output? {
            switch self {
                // Update state and produce an optional output based on which action was received.
            }
        }
    }
}

// MARK: Workers

extension TemplateListWorkflow {
    struct PresetListWorker: Worker {
        enum Output {}

        func run() -> SignalProducer<Output, Never> {
            fatalError()
        }

        func isEquivalent(to otherWorker: PresetListWorker) -> Bool {
            return true
        }
    }
}

// MARK: Rendering

extension TemplateListWorkflow {
    // TODO: Change this to your actual rendering type
    typealias Rendering = String

    func render(state: TemplateListWorkflow.State, context: RenderContext<TemplateListWorkflow>) -> Rendering {
        #warning("Don't forget your compose implementation and to return the correct rendering type!")
        return "This is likely not the rendering that you want to return"
    }
}
