//
//  WidgetType.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 04/01/2024.
//

import Foundation

enum WidgetType: String {
    case squareMini = "square_mini"
    case squareMedium = "square_medium"
    case squareRegular = "square_regular"
    case rectangleMedium = "rectangle_medium"
    case rectangleRegular = "rectangle_regular"
    case large
    
    var size: (height: CGFloat, width: CGFloat) {
        switch self {
        case .squareMini:
            return (height: PADDING97, width: SCREENWIDTH/4)
        case .squareMedium:
            return (height: PADDING118, width: SCREENWIDTH/3)
        case .squareRegular:
            return (height: PADDING194, width: SCREENWIDTH/2)
        case .rectangleMedium:
            return (height: PADDING135, width: SCREENWIDTH)
        case .rectangleRegular:
            return (height: PADDING191, width: SCREENWIDTH)
        case .large:
            return (height: PADDING382, width: SCREENWIDTH)
        }
    }
}
