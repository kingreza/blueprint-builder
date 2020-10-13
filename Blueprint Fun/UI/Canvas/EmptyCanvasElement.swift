//
//  EmptyCanvasElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/13/20.
//

import BlueprintUI
import BlueprintUICommonControls


struct EmptyCanvasElement: ProxyElement {
    var elementRepresentation: Element {
        return Label(text: "Add an element to begin").systemHeadlineLabel().centered()
    }
}
