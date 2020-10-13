//
//  OverlayElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

class OverlayElement: Node {
    
    let name: String = "Overylay"
    let id = UUID()
    var type: NodeType = .collection
    var children: [Node] = []

    var elementRepresentation: Element {
        Overlay(elements: children)
    }
}
