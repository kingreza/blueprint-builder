//
//  OpacityElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import Foundation
import BlueprintUI
import BlueprintUICommonControls

class OpacityElement: Node {
    
    let name: String = "Opacity"
    let id = UUID()
    var type: NodeType = .wrapper
    var children: [Node] = []
    
    var opacity: CGFloat = 1
    
    var elementRepresentation: Element {
        guard let wrapping = children.first else {
            return Empty()
        }
        
        return Opacity(opacity: opacity, wrapping: wrapping)
    }
    
    var modifyingOutlets: [ModifyingOutlet] {
        return OpacityModifyingOutlet.allCases
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        guard let opacityModifyingOutlet = outlet as? OpacityModifyingOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        
        switch opacityModifyingOutlet {
        
        case .opacity:
            guard let preset = preset as? OpacityModifyingPreset else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .fullyVisible:
                self.opacity = 1.0
            case .mostlyVisible:
                self.opacity = 0.8
            case .halfVisible:
                self.opacity = 0.5
            case .mostlyInvisible:
                self.opacity = 0.2
            case .fullyInvisible:
                self.opacity = 0.0
            }
        }
        return self
    }
}

fileprivate enum OpacityModifyingPreset: ModifyingPreset, CaseIterable {
    case fullyVisible
    case mostlyVisible
    case halfVisible
    case mostlyInvisible
    case fullyInvisible
}

enum OpacityModifyingOutlet: ModifyingOutlet, CaseIterable  {
    case opacity
    var options: [ModifyingPreset] {
        return OpacityModifyingPreset.allCases
    }
}
