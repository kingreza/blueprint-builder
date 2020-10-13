//
//  ButtonElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

class ButtonElement: Node {
    
    let name: String = "Button"
    let id = UUID()
    var type: NodeType = .wrapper
    var children: [Node] = []

    var isEnabled: Bool = true
    var onTap: (() -> ()) = {}
    
   
    var elementRepresentation: Element {
        guard let wrapping = children.first else {
            return Empty()
        }
        return Button(
            isEnabled: isEnabled,
            onTap: onTap,
            wrapping: wrapping
        )
    }
    var modifyingOutlets: [ModifyingOutlet] {
        return ButtonModifyingOutlet.allCases
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        guard let buttonModifyingOutlet = outlet as? ButtonModifyingOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        
        switch buttonModifyingOutlet {
        
        case .enabled:
            guard let preset = preset as? ButtonModifyingPreset else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            case .enabled:
                self.isEnabled = true
            case .disabled:
                self.isEnabled = false
            }
        }

        return self
    }
}

fileprivate enum ButtonModifyingPreset: ModifyingPreset, CaseIterable {
    case enabled
    case disabled
}

enum ButtonModifyingOutlet: ModifyingOutlet, CaseIterable  {
    case enabled
    var options: [ModifyingPreset] {
        return ButtonModifyingPreset.allCases
    }
}
