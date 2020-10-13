//
//  NodeRowElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/13/20.
//

import BlueprintUI
import BlueprintUICommonControls

struct NodeRowElement: ProxyElement {
    
    var onAdd:(() -> ())?
    var onRemove: (() -> ())?
    var onEdit:(() -> ())?
    var rowPresentation: NodeRow
    
    private let iconSize: CGFloat = 15.0
    private let iconSpacing: CGFloat = 2.0
    
    var elementRepresentation: Element {
        Row { row in
            row.horizontalUnderflow = .justifyToEnd
            row.horizontalOverflow = .condenseProportionally
            row.verticalAlignment = .leading
            for _ in 0...rowPresentation.indent {
                row.add(child: Spacer(10.0))
            }
            
            row.add(
                child: Image(
                    image: #imageLiteral(resourceName: "plus"),
                    contentMode: .aspectFit)
                    .constrainedTo(width: .absolute(iconSize), height: .absolute(iconSize))
                    .tappable {
                        self.onAdd?()
                    }.inset(horizontal: iconSpacing, vertical: 0)
                    .opacity(onAdd == nil ? 0.5 : 1)
            )
            
            
            
            row.add(
                child: Image(image: #imageLiteral(resourceName: "minus"))
                    .constrainedTo(width: .absolute(iconSize), height: .absolute(iconSize))
                    .tappable {
                        self.onRemove?()
                    }.inset(horizontal: iconSpacing, vertical: 0)
                    .opacity(onRemove == nil ? 0.5 : 1)
            )
            
            row.add(
                child: Image(image: #imageLiteral(resourceName: "cogwheel"))
                    .constrainedTo(width: .absolute(iconSize), height: .absolute(iconSize))
                    .tappable {
                        self.onEdit?()
                    }.inset(horizontal: iconSpacing, vertical: 0)
                    .opacity(onEdit == nil ? 0.5 : 1)
            )
            row.add(child: Spacer(5.0))
            row.add(
                child: Label(text: rowPresentation.node.name) { label in
                    switch rowPresentation.node.type {
                    case .collection:
                        label.color = .systemRed
                    case .leaf:
                        label.color = .systemBlue
                    case .wrapper:
                        label.color = .systemGreen
                    case .preset:
                        label.color = .systemBlue
                    }
                }
            )
            
        }
        
    }
}
