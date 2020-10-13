//  
//  ComponentListWorkflow.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/12/20.
//

import ReactiveSwift
import Workflow
import WorkflowUI

// MARK: Input and Output

struct ComponentListWorkflow: Workflow {
    let node: Node?
    enum Output {}
}

// MARK: State and Initialization

extension ComponentListWorkflow {
    struct State {
        var node: Node?
        var nodeDictionary: [UUID: Node]
    }
    
    func makeInitialState() -> ComponentListWorkflow.State {
        return State(node: node, nodeDictionary: [:])
    }
    
    func workflowDidChange(from previousWorkflow: ComponentListWorkflow, state: inout State) {}
}

// MARK: Actions

extension ComponentListWorkflow {
    enum Action: WorkflowAction {
        typealias WorkflowType = ComponentListWorkflow
        case addNode(parentNode: Node?, newNode: Node)
        case deleteNode(node: Node)
        case editNode(Node)
        func apply(toState state: inout ComponentListWorkflow.State) -> ComponentListWorkflow.Output? {
            switch self {
            // Update state and produce an optional output based on which action was received.
            case .addNode(let parentNode, let node):
                if var parentNode = parentNode {
                    parentNode.children.append(node)
                } else {
                    state.node = node
                }
                state.nodeDictionary[node.id] = node
                return nil
            case .deleteNode(let node):
                state.node = state.node?.removeNode(node: node)
        
                return nil
            case .editNode(let node):
                state.nodeDictionary[node.id] = node
                return nil
            }
        }
    }
}

// MARK: Workers

extension ComponentListWorkflow {
    struct ComponentListWorker: Worker {
        enum Output {}
        
        func run() -> SignalProducer<Output, Never> {
            fatalError()
        }
        
        func isEquivalent(to otherWorker: ComponentListWorker) -> Bool {
            return true
        }
    }
}

// MARK: Rendering

extension ComponentListWorkflow {
    // TODO: Change this to your actual rendering type
    typealias Rendering = ComponentListScreen
    
    func render(state: ComponentListWorkflow.State, context: RenderContext<ComponentListWorkflow>) -> Rendering {
        
        let nodeTree = NodeTreeWorkflow(
            node: state.node
        )
        .mapOutput { output -> Action in
            switch output {
            case .newNodeGenerated(let parentNode, let newNode):
                return .addNode(parentNode: parentNode, newNode: newNode)
            case .removeNodePressed(let node):
                return .deleteNode(node: node)
            case .editNodePressed(let node):
                return .editNode(node)
            }
        }.rendered(with: context)
        
        let canvas = CanvasWorkflow(
            node: state.node
        )
        .mapOutput { output -> Action in
        }.rendered(with: context)
        
        let screen = ComponentListScreen(
            canvasElement: canvas,
            nodeTreeElement: nodeTree
        )
        return screen
    }
}

extension ComponentListWorkflow {
    static func removeNode(rootNode: Node, node: Node) -> Node? {
        if node.id == rootNode.id {
            return nil
        }
        
        @discardableResult func removeNode(currentNode: Node, node: Node) -> Bool {
            var currentNode = currentNode
            if let indexOfNode = currentNode.children.firstIndex(where: {$0.id == node.id}) {
                currentNode.children.remove(at: indexOfNode)
                return true
            }
            
            for childNode in currentNode.children {
                if removeNode(currentNode: childNode, node: node) {
                    return true
                }
            }
            return false
        }
        
        removeNode(currentNode: rootNode, node: node)
        return rootNode
    }
}
