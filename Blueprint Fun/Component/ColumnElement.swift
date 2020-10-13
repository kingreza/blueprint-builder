//
//  ColumnElement.swift
//  Blueprint Fun
//
//  Created by Reza Shirazian on 10/14/20.
//

import BlueprintUI
import BlueprintUICommonControls


class ColumnElement: Node {
    var children: [Node] = []
    let name: String = "Column"
    let type: NodeType = .collection
    let id = UUID()
    
    var verticalUnderflow: StackLayout.UnderflowDistribution?
    var verticalOverflow: StackLayout.OverflowDistribution?
    var horizontalAlignment: StackLayout.Alignment?
    var minimumVerticalSpacing: CGFloat?
    
    var elementRepresentation: Element {
        Column { column in
            
            if let verticalUnderflow = verticalUnderflow {
                column.verticalUnderflow = verticalUnderflow
            }
            
            if let verticalOverflow = verticalOverflow {
                column.verticalOverflow = verticalOverflow
            }
            
            if let horizontalAlignment = horizontalAlignment {
                column.horizontalAlignment = horizontalAlignment
            }

            if let minimumVerticalSpacing = minimumVerticalSpacing {
                column.minimumVerticalSpacing = minimumVerticalSpacing
            }
            
            for child in children {
                column.add(child: child)
            }
        }
    }
    
    func modify(outlet: ModifyingOutlet, preset: ModifyingPreset) -> Node {
        guard let columnOutlet = outlet as? ColumnModifyingOutlet else {
            fatalError("wrong outlet and preset passed to component")
        }
        switch columnOutlet {
        
        case .verticalUnderflow:
            guard let preset = preset as? ColumnModifyingPreset.VerticalUnderflow else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            case .spaceEvenly:
                self.verticalUnderflow = .spaceEvenly
            case .growProportionally:
                self.verticalUnderflow = .growProportionally
            case .growUniformly:
                self.verticalUnderflow = .growUniformly
            case .justifyToStart:
                self.verticalUnderflow = .justifyToStart
            case .justifyToCenter:
                self.verticalUnderflow = .justifyToCenter
            case .justifyToEnd:
                self.verticalUnderflow = .justifyToEnd
            }
        case .verticalOverflow:
            guard let preset = preset as? ColumnModifyingPreset.VerticalOverflow else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            
            case .condenseProportionally:
                self.verticalOverflow = .condenseProportionally
            case .condenseUniformly:
                self.verticalOverflow = .condenseUniformly
            }
        case .horizontalAlignment:
            guard let preset = preset as? ColumnModifyingPreset.HorizontalAlignment else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            case .fill:
                self.horizontalAlignment = .fill
            case .leading:
                self.horizontalAlignment = .leading
            case .center:
                self.horizontalAlignment = .center
            case .trailing:
                self.horizontalAlignment = .trailing
            }
        case .minimumVerticalSpacing:
            guard let preset = preset as? ColumnModifyingPreset.MinimumVerticalSpacing else {
                fatalError("wrong preset type for component and outlet")
            }
            switch preset {
            case .none:
                self.minimumVerticalSpacing = 0.0
            case .small:
                self.minimumVerticalSpacing = 10.0
            case .large:
                self.minimumVerticalSpacing = 35.0
            }
        }

        return self
    }
    
    var modifyingOutlets: [ModifyingOutlet] {
        return ColumnModifyingOutlet.allCases
    }
}

enum ColumnModifyingPreset {
    public enum VerticalUnderflow: ModifyingPreset, CaseIterable {
        case spaceEvenly
        case growProportionally
        case growUniformly
        case justifyToStart
        case justifyToCenter
        case justifyToEnd
        
    }
    public enum VerticalOverflow: ModifyingPreset, CaseIterable {
        case condenseProportionally
        case condenseUniformly
    }
    
    public enum HorizontalAlignment: ModifyingPreset, CaseIterable {
        case fill
        case leading
        case center
        case trailing
    }
    
    public enum MinimumVerticalSpacing: ModifyingPreset, CaseIterable {
        case none
        case small
        case large
    }
}

enum ColumnModifyingOutlet: ModifyingOutlet, CaseIterable {
    case verticalUnderflow
    case verticalOverflow
    case horizontalAlignment
    case minimumVerticalSpacing
    
    var options: [ModifyingPreset] {
        switch self {
        case .verticalUnderflow:
            return ColumnModifyingPreset.VerticalUnderflow.allCases
        case .verticalOverflow:
            return ColumnModifyingPreset.VerticalOverflow.allCases
        case .horizontalAlignment:
            return ColumnModifyingPreset.HorizontalAlignment.allCases
        case .minimumVerticalSpacing:
            return ColumnModifyingPreset.MinimumVerticalSpacing.allCases
        }
    }
}
