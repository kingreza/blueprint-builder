//
//  ConstrainedElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

class ConstrainedElement: Node {
    
    let name: String = "Constrained"
    let id = UUID()
    var type: NodeType = .wrapper
    var children: [Node] = []
    
    var width: ConstrainedSize.Constraint = .unconstrained
    var height: ConstrainedSize.Constraint = .unconstrained
    
    var elementRepresentation: Element {
        guard let wrapping = children.first else {
            return Empty()
        }
        
        return ConstrainedSize(width: width, height: height, wrapping: wrapping)
    }
    
    var modifyingOutlets: [ModifyingOutlet] {
        return ConstrainedModifyingOutlet.allCases
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        guard let constraintOutlet = outlet as? ConstrainedModifyingOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        
        switch constraintOutlet {
        
        case .width:
            guard let width = preset as? ConstrainedModifyingPreset.Width else {
                fatalError("wrong preset type for component and outlet")
            }
            switch width {
            
            case .atLeast30:
                self.width = .atLeast(30.0)
            case .atLeast60:
                self.width = .atLeast(60.0)
            case .atMost30:
                self.width = .atMost(30.0)
            case .atMost60:
                self.width = .atMost(60.0)
            case .absolute30:
                self.width = .absolute(30.0)
            case .absolute60:
                self.width = .absolute(60.0)
            case .between30And60:
                self.width = .within(30.0...60.0)
            case .unconstrained:
                self.width = .unconstrained
            case .absolute150:
                self.width = .absolute(150.0)
            case .absolute300:
                self.width = .absolute(300.0)
            }
        case .height:
            guard let height = preset as? ConstrainedModifyingPreset.Height else {
                fatalError("wrong preset type for component and outlet")
            }
            
            switch height{
            case .atLeast30:
                self.height = .atLeast(30.0)
            case .atLeast60:
                self.height = .atLeast(60.0)
            case .atMost30:
                self.height = .atMost(30.0)
            case .atMost60:
                self.height = .atMost(60.0)
            case .absolute30:
                self.height = .absolute(30.0)
            case .absolute60:
                self.height = .absolute(60.0)
            case .between30And60:
                self.height = .within(30.0...60.0)
            case .unconstrained:
                self.height = .unconstrained
            case .absolute150:
                self.height = .absolute(150.0)
            case .absolute300:
                self.height = .absolute(300.0)
            }
        }
        
        return self
    }
    
}

fileprivate enum ConstrainedModifyingPreset {
    enum Width: ModifyingPreset, CaseIterable {
        case atLeast30
        case atLeast60
        case atMost30
        case atMost60
        case absolute30
        case absolute60
        case absolute150
        case absolute300
        case between30And60
        case unconstrained
    }
    enum Height: ModifyingPreset, CaseIterable {
        case atLeast30
        case atLeast60
        case atMost30
        case atMost60
        case absolute30
        case absolute60
        case absolute150
        case absolute300
        case between30And60
        case unconstrained
    }
}

fileprivate enum ConstrainedModifyingOutlet: ModifyingOutlet, CaseIterable {
    case width
    case height
    
    var options: [ModifyingPreset] {
        switch self {
        case .width:
            return ConstrainedModifyingPreset.Width.allCases
        case .height:
            return ConstrainedModifyingPreset.Height.allCases
        }
    }
}
