//
//  TemplateListElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/15/20.
//

import BlueprintUI
import BlueprintUICommonControls


struct TemplateListElement: ProxyElement {
    let templates: [Template]
    let onTemplateTapped: (Template) -> ()
    var elementRepresentation: Element {
        Column { column in
            column.verticalUnderflow = .justifyToStart
            column.minimumVerticalSpacing = 5.0
            column.add(
                child: Label(
                    text: "Select a template to begin")
                    .systemSmallLabel()
                    .constrainedTo(
                        width: .atLeast(UIScreen.main.bounds.width),
                        height: .unconstrained
                    )
                    .centered()
                    .inset(uniform: 5.0)
                
            )
            
            for template in templates {
                column.add(
                    child: Row { row in
                        row.add(
                            child: Button(
                                isEnabled: true,
                                onTap: {
                                    self.onTemplateTapped(template)
                                },
                                wrapping: Label(
                                    text: template.name
                                )
                                .systemButtonLabel()
                                .inset(uniform: 5.0)
                            )
                        )
                    }
                )
            }
        }.inset(horizontal: 15.0, vertical: 10.0)
    }
}
