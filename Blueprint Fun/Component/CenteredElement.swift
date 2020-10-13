//
//  CenteredElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

class CenteredElement: Node {
    
    let name: String = "Centered"
    let id = UUID()
    var type: NodeType = .wrapper
    var children: [Node] = []
    
    var elementRepresentation: Element {
        guard let wrapping = children.first else {
            return Empty()
        }
        
        return Centered(wrapping)
    }
}
