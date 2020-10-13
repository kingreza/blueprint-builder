//
//  RowElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/13/20.
//


import BlueprintUI
import BlueprintUICommonControls

class RowElement: Node {
    
    var children: [Node] = []
    let name: String = "Row"
    let type: NodeType = .collection
    let id = UUID()
    
    var horizontalUnderflow: StackLayout.UnderflowDistribution?
    var horizontalOverflow: StackLayout.OverflowDistribution?
    var verticalAlignment: StackLayout.Alignment? = .center
    var minimumHorizontalSpacing: CGFloat?
    
    var elementRepresentation: Element {
        Row { row in
            if let horizontalOverflow = horizontalOverflow {
                row.horizontalOverflow = horizontalOverflow
            }
            
            if let horizontalUnderflow = horizontalUnderflow {
                row.horizontalUnderflow = horizontalUnderflow
            }
            
            if let minimumHorizontalSpacing = minimumHorizontalSpacing {
                row.minimumHorizontalSpacing = minimumHorizontalSpacing
            }
            
            if let verticalAlignment = verticalAlignment {
                row.verticalAlignment = verticalAlignment
            }
            
            for child in children {
                row.add(child: child)
            }
        }
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        guard let rowOutlet = outlet as? RowModifyingOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        switch rowOutlet {
        
        case .horizontalUnderflow:
            guard let preset = preset as? RowModifyingPreset.HorizontalUnderflow else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            case .spaceEvenly:
                self.horizontalUnderflow = .spaceEvenly
            case .growProportionally:
                self.horizontalUnderflow = .growProportionally
            case .growUniformly:
                self.horizontalUnderflow = .growUniformly
            case .justifyToStart:
                self.horizontalUnderflow = .justifyToStart
            case .justifyToCenter:
                self.horizontalUnderflow = .justifyToCenter
            case .justifyToEnd:
                self.horizontalUnderflow = .justifyToEnd
            }
        case .horizontalOverflow:
            guard let preset = preset as? RowModifyingPreset.HorizontalOverflow else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .condenseProportionally:
                self.horizontalOverflow = .condenseProportionally
            case .condenseUniformly:
                self.horizontalOverflow = .condenseUniformly
            }
        case .verticalAlignment:
            guard let preset = preset as? RowModifyingPreset.VerticalAlignment else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            case .fill:
                self.verticalAlignment = .fill
            case .leading:
                self.verticalAlignment = .leading
            case .center:
                self.verticalAlignment = .center
            case .trailing:
                self.verticalAlignment = .trailing
            }
        case .minimumHorizontalSpacing:
            guard let preset = preset as? RowModifyingPreset.MinimumHorizontalSpacing else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            case .none:
                self.minimumHorizontalSpacing = 0.0
            case .small:
                self.minimumHorizontalSpacing = 10.0
            case .large:
                self.minimumHorizontalSpacing = 35.0
            }
        }

        return self
    }
    
    var modifyingOutlets: [ModifyingOutlet] {
        return RowModifyingOutlet.allCases
    }
    
    static func initialRow() -> RowElement {
        let firstRow = RowElement()
        firstRow.verticalAlignment = .center
        firstRow.horizontalUnderflow = .justifyToCenter
        return firstRow
    }
}

fileprivate enum RowModifyingPreset {
    enum HorizontalUnderflow: ModifyingPreset, CaseIterable {
        case spaceEvenly
        case growProportionally
        case growUniformly
        case justifyToStart
        case justifyToCenter
        case justifyToEnd
    }
    enum HorizontalOverflow: ModifyingPreset, CaseIterable {
        case condenseProportionally
        case condenseUniformly
    }
    
    enum VerticalAlignment: ModifyingPreset, CaseIterable {
        case fill
        case leading
        case center
        case trailing
    }
    
    enum MinimumHorizontalSpacing: ModifyingPreset, CaseIterable {
        case none
        case small
        case large
    }
}

fileprivate enum RowModifyingOutlet: ModifyingOutlet, CaseIterable {
    case horizontalUnderflow
    case horizontalOverflow
    case verticalAlignment
    case minimumHorizontalSpacing
    
    var options: [ModifyingPreset] {
        switch self {
        case .horizontalUnderflow:
            return RowModifyingPreset.HorizontalUnderflow.allCases
        case .horizontalOverflow:
            return RowModifyingPreset.HorizontalOverflow.allCases
        case .verticalAlignment:
            return RowModifyingPreset.VerticalAlignment.allCases
        case .minimumHorizontalSpacing:
            return RowModifyingPreset.MinimumHorizontalSpacing.allCases
        }
    }
}

