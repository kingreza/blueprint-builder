//
//  EqualStackElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

class EqualStackElement: Node {
    
    let name: String = "Equal Stack"
    let id = UUID()
    var type: NodeType = .collection
    var children: [Node] = []

    var direction: EqualStack.Direction = .horizontal
    var configure: ((inout EqualStack) -> ())? = nil
    
    var elementRepresentation: Element {
        var equalStack: EqualStack
        if let configure = configure {
            equalStack = EqualStack(direction: direction, configure: configure)
        } else {
            equalStack = EqualStack(direction: direction)
        }
        
        for child in children {
            equalStack.add(child: child)
        }
        return equalStack
    }
}
