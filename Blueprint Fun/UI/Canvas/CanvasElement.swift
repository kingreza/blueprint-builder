//
//  CanvasElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/12/20.
//

import BlueprintUI
import BlueprintUICommonControls

struct CanvasElement: ProxyElement {
    var node: Node?
    
    var elementRepresentation: Element {
        
        if let node = node {
            return Column { canvasColumn in
                canvasColumn.verticalUnderflow = .justifyToCenter
                canvasColumn.verticalOverflow = .condenseUniformly
                canvasColumn.horizontalAlignment = .fill
                canvasColumn.add(
                    child: Label(
                        text: "Preview")
                        .systemHeadlineLabel()
                        .centered()
                        .constrainedTo(
                            width: .unconstrained,
                            height: .absolute(15.0)
                        )
                )
                canvasColumn.add(
                    child: node
                        .elementRepresentation
                        .box(
                            borders: .solid(
                                color: .lightGray,
                                width: 1.0)
                        ).inset(uniform: 5.0)
                        .constrainedTo(
                            width: .unconstrained,
                            height: .atLeast(
                                ((UIScreen.main.bounds.height / 2.0) - 80.0))
                        )
                        .scrollable()
                    
                )
            }.inset(horizontal: 10.0, vertical: 0.0)
        } else {
            return EmptyCanvasElement()
        }
    }
    
}
