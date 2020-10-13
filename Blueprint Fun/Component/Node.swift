//
//  Node.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/12/20.
//

import BlueprintUI
import BlueprintUICommonControls

enum NodeType: CaseIterable {
    case collection
    case wrapper
    case leaf
    case preset
    
    var name: String {
        switch self {
        case .collection:
            return "Collections"
        case .wrapper:
            return "Wrappers"
        case .leaf:
            return "UI"
        case .preset:
            return "Preset"
        }
    }
}

protocol ModifyingPreset {
    var name: String {get}
}

extension ModifyingPreset {
    var name: String {
        String(describing: self).camelCaseToWords()
    }
}

protocol ModifyingOutlet {
    var name: String {get}
    var options: [ModifyingPreset] {get}
}

extension ModifyingOutlet {
    var name: String {
        String(describing: self).camelCaseToWords()
    }
}

protocol Node: ProxyElement  {
    var id: UUID {get}
    var name: String {get}
    var type: NodeType {get}
    var children: [Node] {set get}
    var modifyingOutlets: [ModifyingOutlet] {get}
    func modify(outlet: ModifyingOutlet,  preset: ModifyingPreset) -> Node
}

extension Node {
    var modifyingOutlets: [ModifyingOutlet] {
        []
    }
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        return self
    }
}

extension Node {
    func removeNode(node: Node) -> Node? {
       
        if node.id == self.id {
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
        
        removeNode(currentNode: self, node: node)
        return self
    }
}

