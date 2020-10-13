//
//  BoxElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/13/20.
//

import BlueprintUI
import BlueprintUICommonControls

class BoxElement: Node {
    let name: String = "Box"
    let id = UUID()
    var type: NodeType = .wrapper
    var children: [Node] = []
    
    var backgroundColor: UIColor?
    var cornerStyle: Box.CornerStyle?
    var borderStyle: Box.BorderStyle?
    var shadowStyle: Box.ShadowStyle?
    var clipsContent: Bool?
    
    var elementRepresentation: Element {
        var box = Box()
        if let backgroundColor = backgroundColor {
            box.backgroundColor = backgroundColor
        }
        if let cornerStyle = cornerStyle {
            box.cornerStyle = cornerStyle
        }
        if let borderStyle = borderStyle {
            box.borderStyle = borderStyle
        }
        if let shadowStyle = shadowStyle {
            box.shadowStyle = shadowStyle
        }
        if let clipsContent = clipsContent {
            box.clipsContent = clipsContent
        }
        if let wrapping = children.first {
            box.wrappedElement = wrapping
        }
        
        return  box
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        guard let boxOutlet = outlet as? BoxModifyingOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        
        switch boxOutlet {
        
        case .backgroundColor:
            guard let preset = preset as? BoxModifyingPreset.BackgroundColor else {
                fatalError("wrong preset type for component and outlet")
            }
            
            switch preset {
            case .orange:
                self.backgroundColor = .systemOrange
            case .green:
                self.backgroundColor = .systemGreen
            case .blue:
                self.backgroundColor = .systemBlue
            case .red:
                self.backgroundColor = .systemRed
            case .gray:
                self.backgroundColor = .systemGray2
            case .lightGray:
                self.backgroundColor = .systemGray5
            }
        case .cornerStyle:
            guard let preset = preset as? BoxModifyingPreset.CornerStyle else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .square:
                self.cornerStyle = .square
            case .capsule:
                self.cornerStyle = .capsule
            case .roundedSmall:
                self.cornerStyle = .rounded(radius: 5.0)
            case .roundMedium:
                self.cornerStyle = .rounded(radius: 15.0)
            case .roundLarge:
                self.cornerStyle = .rounded(radius: 35.0)
            }
        case .borderStyle:
            guard let preset = preset as? BoxModifyingPreset.BorderStyle else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .none:
                self.borderStyle = Box.BorderStyle.none
            case .regular:
                self.borderStyle = .solid(color: .systemGray, width: 3.0)
            case .thickBlack:
                self.borderStyle = .solid(color: .gray, width: 10.0)
            case .hairlineBlue:
                self.borderStyle = .solid(color: .blue, width: 1.0)
            }
        case .shadowStyle:
            guard let preset = preset as? BoxModifyingPreset.ShadowStyle else {
                fatalError("wrong preset type for component and outlet")
            }
            
            switch preset {
            
            case .none:
                self.shadowStyle = Box.ShadowStyle.none
            case .simple:
                self.shadowStyle = .simple(radius: 3.0, opacity: 0.5, offset: CGSize(width: 5.0, height: 5.0), color: .gray)
            }
        case .clipsContent:
            guard let preset = preset as? BoxModifyingPreset.ClipsContent else {
                fatalError("wrong preset type for component and outlet")
            }
            
            switch preset {
            
            case .yes:
                self.clipsContent = true
            case .no:
                self.clipsContent = false
            }
        }
        return self
    }
    
    var modifyingOutlets: [ModifyingOutlet] {
        return BoxModifyingOutlet.allCases
    }
    
}

enum BoxModifyingPreset {
    public enum BackgroundColor: ModifyingPreset, CaseIterable {
        case orange
        case green
        case blue
        case red
        case gray
        case lightGray
    }
    
    public enum CornerStyle: ModifyingPreset, CaseIterable {
        case square
        case capsule
        case roundedSmall
        case roundMedium
        case roundLarge
    }
    
    public enum BorderStyle: ModifyingPreset, CaseIterable {
        case none
        case regular
        case thickBlack
        case hairlineBlue
    }
    
    public enum ShadowStyle: ModifyingPreset, CaseIterable {
        case none
        case simple
    }
    
    public enum ClipsContent: ModifyingPreset, CaseIterable {
        case yes
        case no
    }
}

enum BoxModifyingOutlet: ModifyingOutlet, CaseIterable  {
    case backgroundColor
    case cornerStyle
    case borderStyle
    case shadowStyle
    case clipsContent
    
    var options: [ModifyingPreset] {
        switch self {
        case .backgroundColor:
            return BoxModifyingPreset.BackgroundColor.allCases
        case .cornerStyle:
            return BoxModifyingPreset.CornerStyle.allCases
        case .borderStyle:
            return BoxModifyingPreset.BorderStyle.allCases
        case .shadowStyle:
            return BoxModifyingPreset.ShadowStyle.allCases
        case .clipsContent:
            return BoxModifyingPreset.ClipsContent.allCases
        }
    }
}
