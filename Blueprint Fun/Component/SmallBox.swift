//
//  SmallBox.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

class SmallBoxElement: Node {
    let name: String = "Small Box"
    let id = UUID()
    var type: NodeType = .preset
    var children: [Node] = []
    
    
    var elementRepresentation: Element {
        return Box(
            backgroundColor: .systemYellow,
            cornerStyle: .rounded(radius: 2.0)
        )
        .constrainedTo(
            width: .absolute(50.0),
            height: .absolute(50.0)
        )
    }
}
