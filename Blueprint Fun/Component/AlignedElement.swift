//
//  AlignedElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

class AlignedElement: Node {
    let name: String = "Aligned"
    let id = UUID()
    var type: NodeType = .wrapper
    var children: [Node] = []
    
    var verticalAlignment: Aligned.VerticalAlignment = .center
    var horizontalAlignment: Aligned.HorizontalAlignment = .center
    
    var elementRepresentation: Element {
        guard let wrapping = children.first else {
            return Empty()
        }
        
        return Aligned(
            vertically: verticalAlignment,
            horizontally: horizontalAlignment,
            wrapping: wrapping
        )
    }
    
    var modifyingOutlets: [ModifyingOutlet] {
        return AlignedModifyingOutlet.allCases
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        guard let alignedModifyingOutlet = outlet as? AlignedModifyingOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        
        switch alignedModifyingOutlet {
        
        case .verticalAlignment:
            guard let preset = preset as? AlignedModifyingPreset.VerticalAlignment else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .top:
                self.verticalAlignment = .top
            case .center:
                self.verticalAlignment = .center
            case .bottom:
                self.verticalAlignment = .bottom
            case .fill:
                self.verticalAlignment = .fill
            }
        case .horizontalAlignment:
            guard let preset = preset as? AlignedModifyingPreset.HorizontalAlignment else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .leading:
                self.horizontalAlignment = .leading
            case .center:
                self.horizontalAlignment = .center
            case .trailing:
                self.horizontalAlignment = .trailing
            case .fill:
                self.horizontalAlignment = .fill
            }
        }
        return self
    }
}

fileprivate enum AlignedModifyingPreset {
    
    enum VerticalAlignment: ModifyingPreset, CaseIterable {
        case top
        case center
        case bottom
        case fill
    }
    
    enum HorizontalAlignment: ModifyingPreset, CaseIterable  {
        case leading
        case center
        case trailing
        case fill
    }
}

enum AlignedModifyingOutlet: ModifyingOutlet, CaseIterable  {
    case verticalAlignment
    case horizontalAlignment
    
    var options: [ModifyingPreset] {
        switch self {
        case .verticalAlignment:
            return AlignedModifyingPreset.VerticalAlignment.allCases
        case .horizontalAlignment:
            return AlignedModifyingPreset.HorizontalAlignment.allCases
        }
    }
}
