//  
//  NodeTreeWorkflow.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/13/20.
//

import ReactiveSwift
import Workflow
import WorkflowUI
import BlueprintUI

// MARK: Input and Output

struct NodeTreeWorkflow: Workflow {
    let node: Node?
    let nodeGenerators = BlueprintComponentService().components
    init(node: Node?) {
        self.node = node
    }
    enum Output {
        case newNodeGenerated(parentNode: Node?, newNode: Node)
        case removeNodePressed(node: Node)
        case editNodePressed(Node)
    }
}

// MARK: State and Initialization

extension NodeTreeWorkflow {
    enum NodeTreeState {
        case tree
        case addComponent
        case editComponent
    }
    struct State {
        var currentState: NodeTreeState
        var selectedNode: Node?
    }
    
    func makeInitialState() -> NodeTreeWorkflow.State {
        let currentState: NodeTreeState = node == nil ? .addComponent : .tree
        return State(currentState: currentState, selectedNode: nil)
    }
    
    func workflowDidChange(from previousWorkflow: NodeTreeWorkflow, state: inout State) {
        if node == nil {
            state.currentState = .addComponent
        }
    }
}

// MARK: Actions

extension NodeTreeWorkflow {
    enum Action: WorkflowAction {
        typealias WorkflowType = NodeTreeWorkflow
        case addNodePressed(Node)
        case addNodeCanceled
        case newNodeGenerated(parentNode: Node?, newNode: Node)
        case removeNodePressed(Node)
        case editNodePressed(Node)
        case editNodeCanceled
        func apply(toState state: inout NodeTreeWorkflow.State) -> NodeTreeWorkflow.Output? {
            switch self {
            // Update state and produce an optional output based on which action was received.
            case .addNodePressed(let node):
                state.currentState = .addComponent
                state.selectedNode = node
                return nil
            case .addNodeCanceled:
                state.currentState = .tree
                state.selectedNode = nil
            case .removeNodePressed(let node):
                return .removeNodePressed(node: node)
            case .editNodePressed(let node):
                state.currentState = .editComponent
                state.selectedNode = node
            case .newNodeGenerated(parentNode: let parentNode, newNode: let newNode):
                state.currentState = .tree
                state.selectedNode = nil
                return .newNodeGenerated(parentNode: parentNode, newNode: newNode)
            case .editNodeCanceled:
                state.currentState = .tree
                state.selectedNode = nil
            }
            return nil
        }
    }
}

// MARK: Rendering

extension NodeTreeWorkflow {
    // TODO: Change this to your actual rendering type
    typealias Rendering = Element
    
    func render(state: NodeTreeWorkflow.State, context: RenderContext<NodeTreeWorkflow>) -> Rendering {
        let actionSink = context.makeSink(of: Action.self)
        
        switch state.currentState {
        
        case .tree:
            guard let node = node else {
                fatalError("invalid state..")
            }
            return NodeTreeElement(
                rootNode: node,
                addPressed: { node in
                    actionSink.send(.addNodePressed(node))
                },
                removePressed: {node in
                    actionSink.send(.removeNodePressed(node))
                },
                editPressed: {node in
                    actionSink.send(.editNodePressed(node))
                }
            )
        case .addComponent:

            let onCancel: (() -> ())? = state.selectedNode == nil ? nil : {
                actionSink.send(.addNodeCanceled)
            }
            return NewNodeElement(
                nodeGenerators: nodeGenerators,
                nodeGeneratorTapped: { generator in
                    actionSink.send(.newNodeGenerated(parentNode: state.selectedNode, newNode: generator.generateNode()))
                },
                onCanceled: onCancel
            )
        case .editComponent:
            guard let selectedNode = state.selectedNode else {
                fatalError("no selected node")
            }
            return EditNodeWorkflow(node: selectedNode)
                .mapOutput { output -> Action in
                    switch output {
                    
                    case .editCanceled:
                        return .editNodeCanceled
                    }
                }
                .rendered(with: context)
                
        }

    }
}
