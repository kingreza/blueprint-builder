//
//  EditNodeElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls


struct EditNodeElement: ProxyElement {
    var name: String
    var modifyingOutlets: [ModifyingOutlet]
    var modifyingPresets: [String: ModifyingPreset]
    var onEditCanceled: (() -> ())
    var onPresetPressed: (ModifyingOutlet, ModifyingPreset?) -> ()
    
    var elementRepresentation: Element {
        Column { column in
            column.add(
                child: Label(
                    text: "Edit \(name)")
                    .systemHeadlineLabel()
                    .centered()
                    .constrainedTo(
                        width: .atLeast(UIScreen.main.bounds.width),
                        height: .unconstrained
                    )
            )
            column.add(
                child: Label(
                    text: "Back"
                )
                .systemButtonLabel()
                .constrainedTo(width: .atLeast(UIScreen.main.bounds.width), height: .unconstrained)
                .tappable {
                    self.onEditCanceled()
                }
            )

            for outlet in modifyingOutlets {
                column.add(child: Label(text: outlet.name).systemLabel())
                if let preset = modifyingPresets[outlet.name] {
                    column.add(
                        child: Label(
                            text: preset.name
                        ).systemButtonLabel()
                        .tappable {
                            self.onPresetPressed(outlet, preset)
                        }
                    )
                } else {
                    column.add(
                        child: Label(
                            text: "Tap to change"
                        )
                        .systemLightLabel()
                        .constrainedTo(width: .atLeast(UIScreen.main.bounds.width), height: .unconstrained)
                        .tappable {
                            self.onPresetPressed(outlet, nil)
                        }
                    )
                }
            }
        }
        .inset(uniform: 10.0)
        .scrollable()
    }
}
