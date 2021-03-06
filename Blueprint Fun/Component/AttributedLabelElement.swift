//
//  AttributedLabelElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//


import BlueprintUI
import BlueprintUICommonControls

class AttributedLabelElement: Node {
    
    let name: String = "Attributed Label"
    let id = UUID()
    var type: NodeType = .leaf
    var children: [Node] = []

    var attributedText: NSAttributedString = NSAttributedString(string: "This is an attributed label")
    var configure: ((inout AttributedLabel) -> ())? = nil
    
    var elementRepresentation: Element {
        if let configure = configure {
            return AttributedLabel(attributedText: attributedText, configure: configure)
        } else {
            return AttributedLabel(attributedText: attributedText)
        }
    }
    
    var modifyingOutlets: [ModifyingOutlet] {
        return AttributedLabelOutlet.allCases
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        guard let attributedLabelOutlet = outlet as? AttributedLabelOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        
        switch attributedLabelOutlet {
        
        case .text:
            guard let preset = preset as? AttributedLabelPreset else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .simple:
                self.attributedText = NSAttributedString(string: "This is an attributed label")
            case .mediumFormattedText:
                let html = """
                    <p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, <em>tempor sit amet</em>, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.</p>
                """
                self.attributedText = NSAttributedString(string: "This is an attributed label")
                let data = Data(html.utf8)
                
                guard let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
                    fatalError("could not make attributed string from html ")
                }
                self.attributedText = attributedString
            case .longFormattedText:
                let html =  """
                    <h1>HTML Ipsum Presents</h1>

                    <p><strong>Pellentesque habitant morbi tristique</strong> senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. <em>Aenean ultricies mi vitae est.</em> Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, <code>commodo vitae</code>, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. <a href="#">Donec non enim</a> in turpis pulvinar facilisis. Ut felis.</p>

                    <h2>Header Level 2</h2>

                    <ol>
                       <li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li>
                       <li>Aliquam tincidunt mauris eu risus.</li>
                    </ol>

                    <blockquote><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna. Cras in mi at felis aliquet congue. Ut a est eget ligula molestie gravida. Curabitur massa. Donec eleifend, libero at sagittis mollis, tellus est malesuada tellus, at luctus turpis elit sit amet quam. Vivamus pretium ornare est.</p></blockquote>

                    <h3>Header Level 3</h3>

                    <ul>
                       <li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li>
                       <li>Aliquam tincidunt mauris eu risus.</li>
                    </ul>

                    <pre><code>
                    #header h1 a {
                      display: block;
                      width: 300px;
                      height: 80px;
                    }
                    </code></pre>
                """
                let data = Data(html.utf8)
                
                guard let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
                    fatalError("could not make attributed string from html ")
                }
                self.attributedText = attributedString
            }
        }
        
        return self
    }
}

fileprivate enum AttributedLabelPreset: ModifyingPreset, CaseIterable {
    case simple
    case mediumFormattedText
    case longFormattedText
    
}

enum AttributedLabelOutlet: ModifyingOutlet, CaseIterable  {
    case text
    
    var options: [ModifyingPreset] {
        return AttributedLabelPreset.allCases
    }
}
