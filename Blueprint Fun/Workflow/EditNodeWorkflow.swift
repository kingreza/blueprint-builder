//  
//  EditNodeWorkflow.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import ReactiveSwift
import Workflow
import WorkflowUI

// MARK: Input and Output

struct EditNodeWorkflow: Workflow {
    var node: Node
    enum Output {
        case editCanceled
    }
}

// MARK: State and Initialization

extension EditNodeWorkflow {
    struct State {
        var node: Node
        var modifyingPresets: [String: ModifyingPreset]
    }
    
    func makeInitialState() -> EditNodeWorkflow.State {
        return State(
            node: self.node,
            modifyingPresets: [:]
        )
    }
    
    func workflowDidChange(from previousWorkflow: EditNodeWorkflow, state: inout State) {}
}

// MARK: Actions

extension EditNodeWorkflow {
    enum Action: WorkflowAction {
        typealias WorkflowType = EditNodeWorkflow
        
        case editCanceled
        case presetChanged(ModifyingOutlet, ModifyingPreset?)
        func apply(toState state: inout EditNodeWorkflow.State) -> EditNodeWorkflow.Output? {
            switch self {
            // Update state and produce an optional output based on which action was received.
            case .editCanceled:
                return .editCanceled
            case .presetChanged(let modifyingOutlet, let modifyingPreset):
                if let modifyingPreset = modifyingPreset {
                    guard let indexOfPreset = modifyingOutlet.options.firstIndex(where: {$0.name == modifyingPreset.name}) else {
                        fatalError("could not find current preset in defined presets")
                    }
                    let nextIndex = (indexOfPreset + 1) % modifyingOutlet.options.count
                    let nextPreset = modifyingOutlet.options[nextIndex]
                    state.modifyingPresets[modifyingOutlet.name] = nextPreset
                    state.node = state.node.modify(outlet: modifyingOutlet, preset: nextPreset)
                } else {
                    guard let firstPreset = modifyingOutlet.options.first else {
                        return nil
                    }
                    state.node = state.node.modify(outlet: modifyingOutlet, preset: firstPreset)
                    state.modifyingPresets[modifyingOutlet.name] = firstPreset
                }
                return nil
            }
        }
    }
}

// MARK: Rendering

extension EditNodeWorkflow {
    // TODO: Change this to your actual rendering type
    typealias Rendering = EditNodeElement
    
    func render(state: EditNodeWorkflow.State, context: RenderContext<EditNodeWorkflow>) -> Rendering {
        let actionSink = context.makeSink(of: Action.self)
        
        return EditNodeElement(
            name: state.node.name,
            modifyingOutlets: state.node.modifyingOutlets,
            modifyingPresets: state.modifyingPresets,
            onEditCanceled: {
                actionSink.send(.editCanceled)
            },
            onPresetPressed: {
                actionSink.send(.presetChanged($0, $1))
            }
        )
    }
}
