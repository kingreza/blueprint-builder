//  
//  CanvasWorkflow.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/13/20.
//

import ReactiveSwift
import Workflow
import WorkflowUI

// MARK: Input and Output

struct CanvasWorkflow: Workflow {
    let node: Node?
    
    init(node: Node?) {
        self.node = node
    }
    
    enum Output {
      
    }
}

// MARK: State and Initialization

extension CanvasWorkflow {
    struct State {}

    func makeInitialState() -> CanvasWorkflow.State {
        return State()
    }

    func workflowDidChange(from previousWorkflow: CanvasWorkflow, state: inout State) {}
}

// MARK: Actions

extension CanvasWorkflow {
    enum Action: WorkflowAction {
        typealias WorkflowType = CanvasWorkflow

        func apply(toState state: inout CanvasWorkflow.State) -> CanvasWorkflow.Output? {
            switch self {
                // Update state and produce an optional output based on which action was received.
            }
        }
    }
}

// MARK: Workers

extension CanvasWorkflow {
    struct CanvasWorker: Worker {
        enum Output {}

        func run() -> SignalProducer<Output, Never> {
            fatalError()
        }

        func isEquivalent(to otherWorker: CanvasWorker) -> Bool {
            return true
        }
    }
}

// MARK: Rendering

extension CanvasWorkflow {
    // TODO: Change this to your actual rendering type
    typealias Rendering = CanvasElement

    func render(state: CanvasWorkflow.State, context: RenderContext<CanvasWorkflow>) -> Rendering {
        CanvasElement(node: node)
    }
}
