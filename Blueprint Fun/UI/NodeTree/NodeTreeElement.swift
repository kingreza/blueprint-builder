//
//  NodeTreeElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/12/20.
//

import BlueprintUI
import BlueprintUICommonControls


struct NodeTreeElement: ProxyElement {
    
    var rootNode: Node
    var addPressed: (Node) -> ()
    var removePressed: (Node) -> ()
    var editPressed: (Node) -> ()
    var elementRepresentation: Element {
        
        return Column { column in
            for rowPresentation in self.rowsPresentation {
                column.add(
                    child: NodeRowElement(
                        onAdd: rowPresentation.isAddEnabled ? {
                            self.addPressed(rowPresentation.node)
                        } : nil,
                        onRemove: {
                            self.removePressed(rowPresentation.node)
                        },
                        onEdit: {
                            self.editPressed(rowPresentation.node)
                        },
                        rowPresentation: rowPresentation)
                )
            }
        }
        .scrollable()
        .inset(horizontal: 5.0, vertical: 5.0)
    }
    
    var rowsPresentation: [NodeRow] {
        var result: [NodeRow] = []
        
        func traverse(result: inout [NodeRow], currentNode: Node, currentIndet: Int) {
            result.append(NodeRow(node: currentNode, indent: currentIndet))
            for child in currentNode.children {
                traverse(result: &result, currentNode: child, currentIndet: currentIndet + 1)
            }
        }
        
        traverse(result: &result, currentNode: rootNode, currentIndet: 0)
        
        return result
    }
    
}

enum ActionType {
    case addElement
}

struct NodeRow {
    var indent: Int
    var node: Node
    
    var isAddEnabled: Bool {
        switch node.type {
        
        case .collection:
            return true
        case .wrapper:
            return node.children.count == 0
        case .leaf:
            return false
        case .preset:
            return false
        }
    }
    
    init(node: Node, indent: Int) {
        self.node = node
        self.indent = indent
    }
}
