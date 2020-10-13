//
//  SpacerElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

class SpacerElement: Node {
    
    let name: String = "Spacer"
    let id = UUID()
    var type: NodeType = .leaf
    var children: [Node] = []

    var size: CGSize = CGSize.zero
   
    var elementRepresentation: Element {
        Spacer(size: size)
    }
    
    var modifyingOutlets: [ModifyingOutlet] {
        return SpacerModifyingOutlet.allCases
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        
        guard let spacerModifyingOutlet = outlet as? SpacerModifyingOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        
        switch spacerModifyingOutlet {
        case .size:
            guard let preset = preset as? SpacerModifyingPreset else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .width30Height0:
                self.size = CGSize(width: 30.0, height: 0.0)
            case .width60Height0:
                self.size = CGSize(width: 60.0, height: 0.0)
            case .width0Height30:
                self.size = CGSize(width: 0, height: 30.0)
            case .width0Height60:
                self.size = CGSize(width: 60.0, height: 60.0)
            case .width30Height30:
                self.size = CGSize(width: 30.0, height: 30.0)
            case .width60Height60:
                self.size = CGSize(width: 60.0, height: 60.0)
            }
        }
        
        return self
    }
}

fileprivate enum SpacerModifyingPreset: ModifyingPreset, CaseIterable {
    case width30Height0
    case width60Height0
    case width0Height30
    case width0Height60
    case width30Height30
    case width60Height60
}

enum SpacerModifyingOutlet: ModifyingOutlet, CaseIterable  {
    case size
    
    var options: [ModifyingPreset] {
        return SpacerModifyingPreset.allCases
    }
}
