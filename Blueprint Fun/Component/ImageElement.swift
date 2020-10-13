//
//  ImageElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

class ImageElement: Node {
    
    let name: String = "Image"
    let id = UUID()
    var type: NodeType = .leaf
    var children: [Node] = []

    var image: UIImage = #imageLiteral(resourceName: "jack2")
    var contentMode: Image.ContentMode = .aspectFit
    var tintColor: UIColor? = nil
   
    var elementRepresentation: Element {
        Image(
            image: image,
            contentMode: contentMode,
            tintColor: tintColor
        )
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        guard let imageOutlet = outlet as? ImageModifyingOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        
        switch imageOutlet {
        
        case .Images:
            guard let preset = preset as? ImageModifyingPreset.Images else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .jack1:
                self.image = #imageLiteral(resourceName: "jack3")
            case .jack2:
                self.image = #imageLiteral(resourceName: "jack2")
            case .jack3:
                self.image = #imageLiteral(resourceName: "jack4")
            case .jack4:
                self.image = #imageLiteral(resourceName: "jack")
            case .icon:
                self.image = #imageLiteral(resourceName: "color")
            case .icon2:
                self.image = #imageLiteral(resourceName: "type-on-path")
            case .icon3:
                self.image = #imageLiteral(resourceName: "square-logo")
            }
        case .ContentMode:
            guard let preset = preset as? ImageModifyingPreset.ContentMode else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .center:
                self.contentMode = .center
            case .stretch:
                self.contentMode = .stretch
            case .aspectFit:
                self.contentMode = .aspectFit
            case .aspectFill:
                self.contentMode = .aspectFill
            }
        case .TintColor:
            guard let preset = preset as? ImageModifyingPreset.TintColor else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .black:
                self.tintColor = UIColor.black
            case .blue:
                self.tintColor = UIColor.blue
            case .red:
                self.tintColor = UIColor.red
            case .yellow:
                self.tintColor = UIColor.yellow
            case .white:
                self.tintColor = UIColor.white
            case .none:
                self.tintColor = nil
            }
        }
        return self
    }
    var modifyingOutlets: [ModifyingOutlet] {
        return ImageModifyingOutlet.allCases
    }
}

enum ImageModifyingPreset {
    public enum Images: ModifyingPreset, CaseIterable {
        case jack1
        case jack2
        case jack3
        case jack4
        case icon
        case icon2
        case icon3
    }
    
    public enum ContentMode: ModifyingPreset, CaseIterable {
        case center
        case stretch
        case aspectFit
        case aspectFill
    }
    
    public enum TintColor: ModifyingPreset, CaseIterable {
        case black
        case blue
        case red
        case yellow
        case white
        case none
    }
}

enum ImageModifyingOutlet: ModifyingOutlet, CaseIterable  {
    case Images
    case ContentMode
    case TintColor
    
    var options: [ModifyingPreset] {
        switch self {
        case .Images:
            return ImageModifyingPreset.Images.allCases
        case .ContentMode:
            return ImageModifyingPreset.ContentMode.allCases
        case .TintColor:
            return ImageModifyingPreset.TintColor.allCases
        }
    }
}
