//
//  RuleElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

class RuleElement: Node {
    
    let name: String = "Rule"
    let id = UUID()
    var type: NodeType = .leaf
    var children: [Node] = []

    var orientation: Rule.Orientation = .horizontal
    var color: UIColor = .lightGray
    var thickness: Rule.Thickness = .hairline
   
    var elementRepresentation: Element {
        Rule(orientation: orientation, color: color, thickness: thickness)
    }
    
    var modifyingOutlets: [ModifyingOutlet] {
        return RuleModifyingOutlet.allCases
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        guard let ruleModifyingOutlet = outlet as? RuleModifyingOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        
        switch ruleModifyingOutlet {
        
        case .Orientation:
            guard let preset = preset as? RuleModifyingPreset.Orientation else {
                fatalError("wrong preset type for component and outlet")
            }
            
            switch preset {
            
            case .horizontal:
                self.orientation = .horizontal
            case .vertical:
                self.orientation = .vertical
            }
        case .Color:
            guard let preset = preset as? RuleModifyingPreset.Color else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .lightGray:
                self.color = .lightGray
            case .black:
                self.color = .black
            case .blue:
                self.color = .systemBlue
            case .red:
                self.color = .systemRed
            case .yelow:
                self.color = .systemYellow
            }
        case .Thickness:
            guard let preset = preset as? RuleModifyingPreset.Thickness else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .hairline:
                self.thickness = .hairline
            case .thick:
                self.thickness = .points(5.0)
            case .thicker:
                self.thickness = .points(10.0)
            case .thickest:
                self.thickness = .points(25.0)
            }
        }
        return self
    }
}

fileprivate enum RuleModifyingPreset {
    enum Orientation: ModifyingPreset, CaseIterable {
        case horizontal
        case vertical
    }
    
    enum Color: ModifyingPreset, CaseIterable {
        case lightGray
        case black
        case blue
        case red
        case yelow
    }
    
    enum Thickness:  ModifyingPreset, CaseIterable {
        case hairline
        case thick
        case thicker
        case thickest
    }
}

enum RuleModifyingOutlet: ModifyingOutlet, CaseIterable  {
    case Orientation
    case Color
    case Thickness
    
    var options: [ModifyingPreset] {
        switch self {
        
        case .Orientation:
            return RuleModifyingPreset.Orientation.allCases
        case .Color:
            return RuleModifyingPreset.Color.allCases
        case .Thickness:
            return RuleModifyingPreset.Thickness.allCases
        }
    }
}
