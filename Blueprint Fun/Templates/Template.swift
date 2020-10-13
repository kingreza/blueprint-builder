//
//  Template.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/15/20.
//

import UIKit


struct Template {
    let name: String
    let node: Node?
    
    static func defaultList() -> [Template] {
        return [
            Template(name: "Empty", node: nil),
            Template(name: "Row", node: generateRowTemplate()),
            Template(name: "Column", node: generateColumnTemplate()),
            Template(name: "Grid", node: generateGridTemplate()),
            Template(name: "Constraints", node: generateConstraintsTemplate()),
            Template(name: "Insets", node: generateInsetTemplate()),
            Template(name: "Cart Sample", node: generateCartTemplate())
        ]
    }
    
    private static func generateRowTemplate() -> Node {
        let rowElement = RowElement()
        rowElement.horizontalUnderflow = .justifyToCenter
        rowElement.minimumHorizontalSpacing = 5.0
        rowElement.verticalAlignment = .center
        rowElement.children = [SmallBoxElement(), SmallBoxElement(), SmallBoxElement(), SmallBoxElement()]
        return rowElement
    }
    
    private static func generateColumnTemplate() -> Node {
        let columnElement = ColumnElement()
        columnElement.verticalUnderflow = .justifyToCenter
        columnElement.minimumVerticalSpacing = 5.0
        columnElement.horizontalAlignment = .center
        columnElement.children = [SmallBoxElement(), SmallBoxElement(), SmallBoxElement(),SmallBoxElement()]
        return columnElement
    }
    
    private static func generateGridTemplate() -> Node {
        let rowElement = RowElement()
        rowElement.minimumHorizontalSpacing = 5.0
        rowElement.horizontalUnderflow = .justifyToCenter
        rowElement.verticalAlignment = .center
        for _ in 0...3 {
            rowElement.children.append(generateColumnTemplate())
        }
        return rowElement
    }
    
    private static func generateConstraintsTemplate() -> Node {
        let image = ImageElement()
        image.image = #imageLiteral(resourceName: "square-logo")
        image.contentMode = .aspectFit
        
        let imageConstraint = ConstrainedElement()
        imageConstraint.width = .absolute(150.0)
        imageConstraint.height = .absolute(150.0)
        imageConstraint.children = [image]
        
        let box = BoxElement()
        box.backgroundColor = .systemGreen
        box.children = [imageConstraint]
        
        let row = RowElement()
        row.horizontalUnderflow = .justifyToCenter
        row.children = [box]
        
        return row
        
    }
    private static func generateInsetTemplate() -> Node {
        let image = ImageElement()
        image.image = #imageLiteral(resourceName: "square-logo")
        image.contentMode = .aspectFit

        
        let imageInset = InsetElement()
        imageInset.top = 5.0
        imageInset.bottom = 5.0
        imageInset.left = 5.0
        imageInset.right = 5.0
        imageInset.children = [image]
        
        let box = BoxElement()
        box.backgroundColor = .systemGreen
        box.children = [imageInset]
        
        let boxConstraint = ConstrainedElement()
        boxConstraint.width = .absolute(200.0)
        boxConstraint.height = .absolute(200.0)
        boxConstraint.children = [box]
                
        let row = RowElement()
        row.horizontalUnderflow = .justifyToCenter
        row.children = [boxConstraint]
        
        return row
    }
    
    private static func generateCartTemplate() -> Node {
        
        let logo = ImageElement()
        logo.image = #imageLiteral(resourceName: "square-logo")
        logo.contentMode = .aspectFit
        
        let imageConstraint = ConstrainedElement()
        imageConstraint.height = .absolute(50.0)
        imageConstraint.children = [logo]
        
        let imageInset = InsetElement()
        imageInset.bottom = 10.0
        imageInset.children = [imageConstraint]
        
        let insetElement = InsetElement()
        insetElement.top = 10
        insetElement.right = 10
        insetElement.bottom = 10
        insetElement.left = 10
        
        let itemLabel = LabelElement()
        itemLabel.text = "Fresh Brewed Coffee"
        let priceLabel = LabelElement()
        priceLabel.text = "$2.99"
        
        let itemLabel1 = LabelElement()
        itemLabel1.text = "Croissant"
        let priceLabel1 = LabelElement()
        priceLabel1.text = "$3.25"
        
        let itemLabel2 = LabelElement()
        itemLabel2.text = "BLT Sandwich"
        let priceLabel2 = LabelElement()
        priceLabel2.text = "$5.99"
        
        let itemRow = RowElement()
        itemRow.children = [itemLabel, priceLabel]
        
        let itemRow1 = RowElement()
        itemRow1.children = [itemLabel1, priceLabel1]
        
        let itemRow2 = RowElement()
        itemRow2.children = [itemLabel2, priceLabel2]
        
        let columnElement = ColumnElement()
        columnElement.horizontalAlignment = .fill
        columnElement.verticalUnderflow = .justifyToStart
        
        let spacer = SpacerElement()
        spacer.size = .init(width: .zero, height: 10.0)
        
        let ruler = ConstrainedElement()
        ruler.height = .absolute(1.0)
        ruler.width = .unconstrained
        
        let rulerBox = BoxElement()
        rulerBox.backgroundColor = .systemGray2
        ruler.children = [rulerBox]
        
        
        let taxLabel = LabelElement()
        taxLabel.text = "Tax"

        let taxPriceLabel = LabelElement()
        taxPriceLabel.text = "$0.86"
        
        let taxRow = RowElement()
        taxRow.children = [taxLabel, taxPriceLabel]
        
        let taxInset = InsetElement()
        taxInset.top = 10.0
        taxInset.children = [taxRow]
        
        let totalLabel = LabelElement()
        totalLabel.text = "Total"
        totalLabel.configure = {label in
            label.font = UIFont(
                name: "AvenirNext-Bold",
                size: 11)!
        }
        
        let totalPriceLabel = LabelElement()
        totalPriceLabel.configure = {label in
            label.font = UIFont(
                name: "AvenirNext-Bold",
                size: 11)!
        }
        totalPriceLabel.text = "$13.09"
        
        let totalRow = RowElement()
        totalRow.children = [totalLabel, totalPriceLabel]
        
        let spacer2 = SpacerElement()
        spacer2.size = .init(width: .zero, height: 5.0)
        
        columnElement.children = [imageInset, itemRow, itemRow1, itemRow2, spacer, ruler, taxInset, spacer2, totalRow]
        insetElement.children = [columnElement]
        
        let box = BoxElement()
        box.backgroundColor = .white
        box.cornerStyle = .rounded(radius: 5.0)
        box.borderStyle = .solid(color: .systemGray2, width: 1.0)
        box.shadowStyle = .simple(radius: 3.0, opacity: 0.2, offset: CGSize(width: 5.0, height: 5.0), color: .gray)
        box.children = [insetElement]
        
        let constraint = ConstrainedElement()
        constraint.width = .absolute(180.0)
        constraint.height = .unconstrained
        constraint.children = [box]
        
        let row = RowElement()
        row.horizontalUnderflow = .justifyToCenter
        row.children = [constraint]
        return row
    }
}


