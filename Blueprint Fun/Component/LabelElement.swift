//
//  LabelElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

class LabelElement: Node {
    
    let name: String = "Label"
    let id = UUID()
    var type: NodeType = .leaf
    var children: [Node] = []
    
    var text: String = "This is a label"
    var configure: ((inout Label) -> ())? = nil
    
    var elementRepresentation: Element {
        if let configure = configure {
            return Label(text: text) { label in
                label.font = UIFont(
                    name: "AvenirNext-Medium",
                    size: 10)!
                configure(&label)
            }
        } else {
            return Label(text: text) { label in
                label.font = UIFont(
                    name: "AvenirNext-Medium",
                    size: 10)!
            }
        }
    }
    
    var modifyingOutlets: [ModifyingOutlet] {
        return LabelModifyingOutlet.allCases
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        guard let modifyingOutlet = outlet as? LabelModifyingOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        
        switch modifyingOutlet {
        
        case .text:
            guard let preset = preset as? LabelModifyingPreset.Text else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            case .shortText:
                self.text = "short"
            case .mediumText:
                self.text = "this is medium in length"
            case .longText:
                self.text = "this is a long text with lots of words. It even has quite a few sentences. It doesn't really say much but at the end of the day it provides a long string that can be used for getting a feel on how a Label with a long text value would behave in various blueprint enviornments"
            }
        case .presets:
            guard let preset = preset as? LabelModifyingPreset.Presets else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .bold:
                self.configure = { label in
                    label.font = UIFont(
                        name: "AvenirNext-Bold",
                        size: 10)!
                }
            case .largeFont:
                self.configure = { label in
                    label.font = UIFont(
                        name: "AvenirNext-Bold",
                        size: 25)!
                }
            case .lightColor:
                self.configure = { label in
                    label.color = .lightGray
                    
                }
            case .comicSans:
                self.configure = { label in
                    label.font = UIFont(
                        name: "ChalkboardSE-Bold",
                        size: 10)!
                }
            case .none:
                self.configure = nil
            }
        }
        return self
    }
}


public enum LabelModifyingPreset {
    enum Text: ModifyingPreset, CaseIterable{
        case shortText
        case mediumText
        case longText
    }
    
    enum Presets: ModifyingPreset, CaseIterable {
        case bold
        case largeFont
        case lightColor
        case comicSans
        case none
    }
}

enum LabelModifyingOutlet: ModifyingOutlet, CaseIterable  {
    case text
    case presets
    var options: [ModifyingPreset] {
        switch self {
        
        case .text:
            return LabelModifyingPreset.Text.allCases
        case .presets:
            return LabelModifyingPreset.Presets.allCases
        }
    }
}
