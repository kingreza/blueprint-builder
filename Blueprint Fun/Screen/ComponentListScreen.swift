//  
//  ComponentListScreen.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/12/20.
//

import BlueprintUI
import BlueprintUICommonControls
import Workflow
import WorkflowUI

struct ComponentListScreen: Screen {
    // This should contain all data to display in the UI

    // It should also contain callbacks for any UI events, for example:
    // var onButtonTapped: () -> Void
//    var rootNode: Node = {
//        var rowElement = RowElement()
//        rowElement.horizontalOverflow = .condenseUniformly
//        rowElement.horizontalUnderflow = .justifyToCenter
//        rowElement.verticalAlignment = .center
//        rowElement.minimumHorizontalSpacing = 2.0
//        rowElement.children = {
//            var boxes: [Node] = []
//            for _ in 0...5 {
//                var box = BoxElement()
//                box.backgroundColor = .systemGreen
//                boxes.append(box)
//            }
//            return boxes
//        }()
//        return rowElement
//    }()
    
    var canvasElement: Element
    var nodeTreeElement: Element
    
    func viewControllerDescription(environment: ViewEnvironment) -> ViewControllerDescription {
        return ComponentListScreenViewController.description(for: self, environment: environment)
    }
}

final class ComponentListScreenViewController: ScreenViewController<ComponentListScreen> {
    
    private var blueprintView: BlueprintView!
    
    required init(screen: ComponentListScreen, environment: ViewEnvironment) {
        super.init(screen: screen, environment: environment)
        update(screen: screen, environment: environment)
        self.blueprintView = generatedBlueprintView(with: screen)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.blueprintView
    }
    
    override func screenDidChange(from previousScreen: ComponentListScreen, previousEnvironment: ViewEnvironment) {
        update(with: screen, environment: environment)
        // Update UI
    }
    
    private func generatedBlueprintView(with screen: ComponentListScreen) -> BlueprintView {
        return BlueprintView(
            element: SplitContainerElement(
                height: UIScreen.main.bounds.height,
                canvasElement: screen.canvasElement,
                nodeTreeElement: screen.nodeTreeElement
            )
        )
    }
    
    private func update(with screen: ComponentListScreen, environment: ViewEnvironment) {
        self.blueprintView = generatedBlueprintView(with: screen)
        //TODO: understand why I need to do this to trigger a redraw
        self.view = self.blueprintView
    }
}

