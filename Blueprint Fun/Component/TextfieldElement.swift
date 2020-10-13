//
//  TextfieldElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

class TextfieldElement: Node {
    
    let name: String = "Textfield"
    let id = UUID()
    var type: NodeType = .leaf
    var children: [Node] = []

    var text: String = "This is a textfield"
    var configure : ((inout TextField) -> ())?
   
    var elementRepresentation: Element {

        if let configure = configure {
            return TextField(text: text, configure: configure)
        } else {
            return TextField(text: text)
        }
    }
}

