//
//  Label.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls

extension Label {
    func systemSmallLabel() -> Label {
        Label(text: self.text) { label in
            label.font = UIFont(
                name: "AvenirNext-Medium",
                size: 8)!
            label.color = .darkGray
        }
    }
    
    func systemLabel() -> Label {
        Label(text: self.text) { label in
            label.font = UIFont(
                name: "AvenirNext-Medium",
                size: 14)!
            label.color = .darkGray
        }
    }
    func systemButtonLabel() -> Label {
        Label(text: self.text) { label in
            label.font = UIFont(
                name: "AvenirNext-Medium",
                size: 14)!
            label.color = .systemBlue
        }
    }
    
    func systemHeadlineLabel() -> Label {
        Label(text: self.text) { label in
            label.font = UIFont(
                name: "AvenirNext-Bold",
                size: 16)!
            label.color = .darkGray
        }
    }
    
    func systemLightLabel() -> Label {
        Label(text: self.text) { label in
            label.font = UIFont(
                name: "AvenirNext-Medium",
                size: 14)!
            label.color = .lightGray
        }
    }
    

}
