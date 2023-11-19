//
//  CardViewModel.swift
//  Set
//
//  Created by Larry Scherr on 11/9/23.
//

import SwiftUI

struct CardViewModel {
    typealias Card = SetGame.Card
    
    // Number of shapes (one, two, or three)
    func number(on card: Card) -> Int {
        switch card.feature[Constants.Feature.number] {
        case .option1:
            return 1
        case .option2:
            return 2
        case .option3:
            return 3
        }
    }
    
    // shape (diamond, squiggle, oval)
    func shape(of card: Card) -> CardShapes {
        switch card.feature[Constants.Feature.shape] {
        case .option1:
            return .diamond
        case .option2:
            return .squiggle
        case .option3:
            return .oval
        }
    }
    
    // shading (solid, striped, or open)
    func shading(of card: Card) -> CardShading {
        switch card.feature[Constants.Feature.shading] {
        case .option1:
            return .solid
        case .option2:
            return .striped
        case .option3:
            return .open
        }
    }
    
    // color (red, green, or purple)
    func color(of card: Card) -> Color {
        switch card.feature[Constants.Feature.color] {
        case .option1:
            return Color(.red)
        case .option2:
            return Color(.green)
        case .option3:
            return Color(.purple)
        }
    }
    
    private struct Constants {
        struct Feature {
            static let number = 0
            static let shape = 1
            static let shading = 2
            static let color = 3
        }
    }
}

enum CardShapes {
    case diamond
    case squiggle
    case oval
}

enum CardShading {
    case solid
    case striped
    case open
}

extension SetGame.Card: CustomDebugStringConvertible {
    var debugDescription: String {
        var description: String = "\(feature[0].rawValue) "
        
        switch feature[1] {
        case .option1:
            description += "diamond "
        case .option2:
            description += "squiggle "
        case .option3:
            description += "oval "
        }
        
        switch feature[2] {
        case .option1:
            description += "solid "
        case .option2:
            description += "striped "
        case .option3:
            description += "open "
        }
        
        switch feature[3] {
        case .option1:
            description += "red "
        case .option2:
            description += "green "
        case .option3:
            description += "purple "
        }
        
        switch location {
        case .discardPile:
            description += "discard "
        case .drawPile:
            description += "draw "
        case .table:
            description += "table "
        }
        
        if selected {
            description += "selected "
        } else {
            description += "unselected "
        }

        return description
    }
}
