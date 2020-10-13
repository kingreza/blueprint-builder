//
//  ScrollviewElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/15/20.
//

import BlueprintUI
import BlueprintUICommonControls

class ScrollviewElement: Node {
    
    var children: [Node] = []
    let name: String = "Scroll view"
    let type: NodeType = .wrapper
    let id = UUID()
    
    var contentSize: ScrollView.ContentSize = .fittingContent
    
    var elementRepresentation: Element {
        guard let wrapping = children.first else {
            return Empty()
        }
        
        return ScrollView(
            contentSize,
            wrapping: wrapping,
            configure: {_ in }
        )
    }
    
    var modifyingOutlets: [ModifyingOutlet] {
        return ScrollviewModifyingOutlet.allCases
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        guard let scrollviewModifyingOutlet = outlet as? ScrollviewModifyingOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        
        switch scrollviewModifyingOutlet {
        
        case .contentSize:
            guard let preset = preset as? ScrollviewModifyingPreset.ContentSize else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .fittingWidth:
                self.contentSize = .fittingWidth
            case .fittingHeight:
                self.contentSize = .fittingHeight
            case .fittingContent:
                self.contentSize = .fittingContent
            case .width30height30:
                self.contentSize = .custom(CGSize(width: 30.0, height: 30.0))
            case .width60height60:
                self.contentSize = .custom(CGSize(width: 60.0, height: 60.0))
            case .width120height120:
                self.contentSize = .custom(CGSize(width: 120.0, height: 120.0))
            }
        }
        
        return self
    }
}

fileprivate enum ScrollviewModifyingPreset {
    enum ContentSize: ModifyingPreset, CaseIterable {
        case fittingWidth
        case fittingHeight
        case fittingContent
        case width30height30
        case width60height60
        case width120height120
    }
}

enum ScrollviewModifyingOutlet: ModifyingOutlet, CaseIterable {
    case contentSize
    var options: [ModifyingPreset] {
        return ScrollviewModifyingPreset.ContentSize.allCases
    }
}
