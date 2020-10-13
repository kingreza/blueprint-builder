//
//  NewNodeElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/13/20.
//

import BlueprintUI
import BlueprintUICommonControls

struct NewNodeElement: ProxyElement {
    let nodeGenerators: Dictionary<NodeType, [NodeGenerator]>
    let nodeGeneratorTapped: (NodeGenerator) -> ()
    let onCanceled: (() -> ())?
    var elementRepresentation: Element {
        Column { column in
            if let onCanceled = onCanceled {
                column.add(
                    child: Button(
                        isEnabled: true,
                        onTap: {
                            onCanceled()
                        },
                        wrapping: Label(text: "Back")
                            .systemButtonLabel()
                            .inset(
                                horizontal: 15.0,
                                vertical: 5.0
                            )
                    )
                )
            }
            
            let keys: [NodeType] = [.collection, .wrapper, .leaf, .preset]
            for key in keys {
                column.add(
                    child: Label(text: key.name)
                        .systemHeadlineLabel()
                        .inset(
                            horizontal: 15.0,
                            vertical: 5.0
                        )
                )
                let componentFactory : (NodeGenerator) -> Element = { nodeGenerator in
                    Button(
                        isEnabled: true,
                        onTap: {
                            self.nodeGeneratorTapped(nodeGenerator)
                        },
                        wrapping: Box (
                            backgroundColor: .white,
                            cornerStyle: .rounded(radius: 5.0),
                            borderStyle: .solid(color: .lightGray, width: 1.0),
                            shadowStyle: .simple(
                                radius: 2.0,
                                opacity: 0.5,
                                offset: CGSize(
                                    width: 1.0,
                                    height: 1.0
                                ),
                                color: .gray
                            ),
                            clipsContent: true,
                            wrapping: Column { column in
                                column.horizontalAlignment = .center
                                column.add(
                                    child: Image(
                                        image: nodeGenerator.image,
                                        contentMode: .aspectFit,
                                        tintColor: .gray
                                    )
                                    .constrainedTo(
                                        width: .absolute(50),
                                        height: .absolute(50)
                                    )
                                    .inset(horizontal: 10.0, vertical: 5.0)
                                )
                                column.add(
                                    child: Label(
                                        text: nodeGenerator.name
                                    )
                                    .systemSmallLabel()
                                    .inset(uniform: 5.0)
                                    .centered()
                                )
                            }
                        )
                    )
                }
                
                
                column.add(
                    child: ScrollView(
                        .fittingWidth,
                        wrapping: Row { row in
                            row.minimumHorizontalSpacing = 5.0
                            for nodeGenerator in nodeGenerators[key] ?? [] {
                                let component = componentFactory(nodeGenerator)
                                row.add(child: component)
                            }
                        }
                    ).inset(horizontal: 15.0, vertical: 0.0)
                )
            }
        }.scrollable()
    }
}
