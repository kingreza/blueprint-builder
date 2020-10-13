//
//  InsetElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

class InsetElement: Node {
    
    let name: String = "Inset"
    let id = UUID()
    var type: NodeType = .wrapper
    var children: [Node] = []
    
    var top: CGFloat = 0
    var bottom: CGFloat = 0
    var left: CGFloat = 0
    var right: CGFloat = 0
    
    var elementRepresentation: Element {
        guard let wrapping = children.first else {
            return Empty()
        }
        return Inset(
            top: top,
            bottom: bottom,
            left: left,
            right: right,
            wrapping: wrapping
        )
    }
    
    private func uniform(_ value: CGFloat) {
        self.top = value
        self.bottom = value
        self.left = value
        self.right = value
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        
        guard let insetOutlet = outlet as? InsetModifyingOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        
        switch insetOutlet {
        
        case .presets:
            guard let preset = preset as? InsetModifyingPreset.Presets else {
                fatalError("wrong preset type for component and outlet")
            }
            self.uniform(0.0)
            switch preset {
            
            case .tinyUniform:
                self.uniform(3.0)
            case .smallUniform:
                self.uniform(10.0)
            case .smallHorizontal:
                self.left = 10.0
                self.right = 10.0
            case .smallVertical:
                self.top = 10.0
                self.bottom = 10.0
            case .largeUniform:
                self.uniform(35.0)
            case .largeHorizontal:
                self.left = 35.0
                self.right = 35.0
            case .largeVertical:
                self.top = 35.0
                self.bottom = 35.0
            case .none:
                self.uniform(0.0)
            }
            
        case .top:
            guard let top = preset as? InsetModifyingPreset.Top else {
                fatalError("wrong preset type for component and outlet")
            }
            switch top {
            case .none:
                self.uniform(0.0)
            case .small:
                self.top = 10.0
            case .medium:
                self.top = 15.0
            case .large:
                self.top = 35.0
            }
        case .bottom:
            guard let bottom = preset as? InsetModifyingPreset.Bottom else {
                fatalError("wrong preset type for component and outlet")
            }
            switch bottom {
            case .none:
                self.uniform(0.0)
            case .small:
                self.bottom = 10.0
            case .medium:
                self.bottom = 15.0
            case .large:
                self.bottom = 35.0
            }
        case .left:
            guard let left = preset as? InsetModifyingPreset.Left else {
                fatalError("wrong preset type for component and outlet")
            }
            switch left {
            case .none:
                self.uniform(0.0)
            case .small:
                self.left = 10.0
            case .medium:
                self.left = 15.0
            case .large:
                self.left = 35.0
            }
        case .right:
            guard let right = preset as? InsetModifyingPreset.Right else {
                fatalError("wrong preset type for component and outlet")
            }
            switch right {
            case .none:
                self.uniform(0.0)
            case .small:
                self.right = 10.0
            case .medium:
                self.right = 15.0
            case .large:
                self.right = 35.0
            }
        }
        return self
    }
    var modifyingOutlets: [ModifyingOutlet] {
        return InsetModifyingOutlet.allCases
    }
}

fileprivate enum InsetModifyingPreset {
    enum Presets: ModifyingPreset, CaseIterable {
        case none
        case tinyUniform
        case smallUniform
        case smallHorizontal
        case smallVertical
        case largeUniform
        case largeHorizontal
        case largeVertical
    }
    enum Top: ModifyingPreset, CaseIterable {
        case none
        case small
        case medium
        case large
    }
    
    enum Bottom: ModifyingPreset, CaseIterable {
        case none
        case small
        case medium
        case large
    }
    
    enum Left: ModifyingPreset, CaseIterable {
        case none
        case small
        case medium
        case large
    }
    
    enum Right: ModifyingPreset, CaseIterable {
        case none
        case small
        case medium
        case large
    }
}

enum InsetModifyingOutlet: ModifyingOutlet, CaseIterable {
    case presets
    case top
    case bottom
    case left
    case right
    
    var options: [ModifyingPreset] {
        switch self {
        case .presets:
            return InsetModifyingPreset.Presets.allCases
        case .top:
            return InsetModifyingPreset.Top.allCases
        case .bottom:
            return InsetModifyingPreset.Bottom.allCases
        case .left:
            return InsetModifyingPreset.Left.allCases
        case .right:
            return InsetModifyingPreset.Right.allCases
        }
    }
}

