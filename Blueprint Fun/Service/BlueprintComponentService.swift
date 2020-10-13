//
//  BlueprintComponentService.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/13/20.
//

import UIKit

protocol NodeGenerator {
    var name: String {get}
    var type: NodeType {get}
    var image: UIImage {get}
    func generateNode() -> Node
}

class BlueprintComponentService {
    var components: Dictionary<NodeType, [NodeGenerator]> = {
        return Dictionary(grouping: BlueprintComponent.allCases, by: {$0.type})
    }()
}

enum BlueprintComponent: CaseIterable {
    case smallBox
    case box
    case scrollView
    case aligned
    case inset
    case constrained
    case opacity
    case centered
    case label
    case attributedLabel
    case texfield
    case button
    case image
    case rule
    case spacer
    case row
    case column
    case equalStack
    case overlay
}

extension BlueprintComponent: NodeGenerator {
    var type: NodeType {
        switch self {
        case .smallBox:
            return .preset
        case .box, .scrollView ,.aligned, .inset, .constrained, .opacity, .button, .centered:
            return .wrapper
        case .label, .attributedLabel, .texfield, .image, .rule, .spacer:
            return .leaf
        case .row, .column, .equalStack, .overlay:
            return .collection
        }
    }
    
    var name: String {
        switch self {
        case .smallBox:
            return "Small Box"
        case .scrollView:
            return "Scroll View"
        case .box:
            return "Box"
        case .aligned:
            return "Aligned"
        case .inset:
            return "Inset"
        case .constrained:
            return "Constrained"
        case .opacity:
            return "Opacity"
        case .centered:
            return "Centered"
        case .label:
            return "Label"
        case .attributedLabel:
            return "Attributed Label"
        case .texfield:
            return "Texfield"
        case .button:
            return "Button"
        case .image:
            return "Image"
        case .rule:
            return "Rule"
        case .spacer:
            return "Spacer"
        case .row:
            return "Row"
        case .column:
            return "Column"
        case .equalStack:
            return "Equal Stack"
        case .overlay:
            return "Overlay"
        }
    }
    
    var image: UIImage {
        switch self {
        
        case .smallBox:
            return #imageLiteral(resourceName: "smallBox")
        case .box:
            return #imageLiteral(resourceName: "square")
        case .aligned:
            return #imageLiteral(resourceName: "align-objects")
        case .inset:
            return #imageLiteral(resourceName: "divide")
        case .constrained:
            return #imageLiteral(resourceName: "artboard")
        case .opacity:
            return #imageLiteral(resourceName: "transparency")
        case .centered:
            return #imageLiteral(resourceName: "focus")
        case .label:
            return #imageLiteral(resourceName: "text")
        case .attributedLabel:
            return #imageLiteral(resourceName: "type-on-path")
        case .texfield:
            return #imageLiteral(resourceName: "type")
        case .button:
            return #imageLiteral(resourceName: "button")
        case .image:
            return #imageLiteral(resourceName: "images")
        case .rule:
            return #imageLiteral(resourceName: "ruler")
        case .spacer:
            return #imageLiteral(resourceName: "text-spacing")
        case .row:
            return #imageLiteral(resourceName: "rows")
        case .column:
            return #imageLiteral(resourceName: "columns")
        case .equalStack:
            return #imageLiteral(resourceName: "dashboard")
        case .overlay:
            return #imageLiteral(resourceName: "layers")
        case .scrollView:
            return #imageLiteral(resourceName: "scroll")
        }
    }
    func generateNode() -> Node {
        switch self {
        case .box:
            return BoxElement()
        case .aligned:
            return AlignedElement()
        case .inset:
            return InsetElement()
        case .constrained:
            return ConstrainedElement()
        case .opacity:
            return OpacityElement()
        case .centered:
            return CenteredElement()
        case .label:
            return LabelElement()
        case .attributedLabel:
            return AttributedLabelElement()
        case .texfield:
            return TextfieldElement()
        case .button:
            return ButtonElement()
        case .image:
            return ImageElement()
        case .rule:
            return RuleElement()
        case .spacer:
            return SpacerElement()
        case .row:
            return RowElement()
        case .column:
            return ColumnElement()
        case .equalStack:
            return EqualStackElement()
        case .overlay:
            return OverlayElement()
        case .smallBox:
            return SmallBoxElement()
        case .scrollView:
            return ScrollviewElement()
        }
    }
}
