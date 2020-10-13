//
//  SplitContainerElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/12/20.
//

import BlueprintUI
import BlueprintUICommonControls

struct SplitContainerElement: ProxyElement {
    let height: CGFloat
    var canvasElement: Element
    var nodeTreeElement: Element
    
    var elementRepresentation: Element {
        return Box(
            wrapping: Column { column in
                column.horizontalAlignment = .fill
                column.verticalUnderflow = .justifyToCenter
                column.add(
                    child: canvasElement
                        .constrainedTo(
                            width: .unconstrained,
                            height: .absolute(height / 2.0
                            )
                        )
                )
                column.add(
                    child: Rule(
                        orientation: .horizontal,
                        color: .gray)
                        .constrainedTo(
                            width: .unconstrained,
                            height: .absolute(1.0)
                        )
                )
                column.add(
                    child: nodeTreeElement
                        .constrainedTo(
                            width: .unconstrained,
                            height: .absolute(height / 2.0
                            )
                        )
                )
            }
        )
    }
}

