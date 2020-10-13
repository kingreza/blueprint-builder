//  
//  TemplateListScreen.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/15/20.
//

import BlueprintUI
import BlueprintUICommonControls
import Workflow
import WorkflowUI

struct TemplateListScreen: Screen {
    var listElement: Element
    
    func viewControllerDescription(environment: ViewEnvironment) -> ViewControllerDescription {
        return TemplateListScreenViewController.description(for: self, environment: environment)
    }
}

final class TemplateListScreenViewController: ScreenViewController<TemplateListScreen> {
    
    private var blueprintView: BlueprintView!
    
    required init(screen: TemplateListScreen, environment: ViewEnvironment) {
        super.init(screen: screen, environment: environment)
        update(screen: screen, environment: environment)
        self.blueprintView = generatedBlueprintView(with: screen)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.blueprintView
    }
    
    override func screenDidChange(from previousScreen: TemplateListScreen, previousEnvironment: ViewEnvironment) {
        update(with: screen, environment: environment)
        // Update UI
    }
    
    private func generatedBlueprintView(with screen: TemplateListScreen) -> BlueprintView {
        return BlueprintView(element: screen.listElement)
    }
    
    private func update(with screen: TemplateListScreen, environment: ViewEnvironment) {
        self.blueprintView = generatedBlueprintView(with: screen)
        //TODO: understand why I need to do this to trigger a redraw
        self.view = self.blueprintView
    }
}



