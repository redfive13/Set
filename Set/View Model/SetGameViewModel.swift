//
//  SetGameViewModel.swift
//  Set
//
//  Created by Larry Scherr on 11/4/23.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGame.Card
    typealias Deck = [Card]
    
    @Published private var setGame = SetGame()
    
    var drawPile: Deck    { setGame.drawPile }
    var table: Deck       { setGame.table }
    var discardPile: Deck { setGame.discardPile }
    
    var cardColor: Color {
        return Color(.blue)
    }
    
    
    
    
    
    
    
    // MARK: - Intents
    
    //    func MoveCardToDrawPile(    _ card: Card) { setGame.MoveCardToDrawPile(card) }
    //    func MoveCardToTable(       _ card: Card) { setGame.MoveCardToTable(card) }
    //    func MoveCardToDiscardPile( _ card: Card) { setGame.MoveCardToDiscardPile(card) }
    
    func NewGame() { setGame.newGame() }
    
    func drawThreeCards()    { setGame.dealCard(numberOfCardsToDeal:  3) }
    func dealStartingTable() { setGame.dealCard(numberOfCardsToDeal: 12) }
    
    func SelectCard(_ card: Card) { setGame.selectCard(card) }
    
    
    
    //    func number(on card: Card) -> Int {
    //        switch card.feature[Constants.Feature.number] {
    //        case .option1:
    //            return 1
    //        case .option2:
    //            return 2
    //        case .option3:
    //            return 3
    //        }
    //    }
    //    
    //    func shape(of card: Card) -> CardShapes {
    //        switch card.feature[Constants.Feature.shape] {
    //        case .option1:
    //            return .diamond
    //        case .option2:
    //            return .squiggle
    //        case .option3:
    //            return .oval
    //        }
    //    }
    //    
    //    func shading(of card: Card) -> CardShading {
    //        switch card.feature[Constants.Feature.shading] {
    //        case .option1:
    //            return .solid
    //        case .option2:
    //            return .striped
    //        case .option3:
    //            return .open
    //        }
    //    }
    //    
    //    func color(of card: Card) -> Color {
    //        switch card.feature[Constants.Feature.color] {
    //        case .option1:
    //            return Color(.red)
    //        case .option2:
    //            return Color(.green)
    //        case .option3:
    //            return Color(.purple)
    //        }
    //    }
    //    
    //    private struct Constants {
    //        struct Feature {
    //            static let number = 0
    //            static let shape = 1
    //            static let shading = 2
    //            static let color = 3
    //        }
    
    
}



// Number of shapes (one, two, or three)
// shape (diamond, squiggle, oval)
// shading (solid, striped, or open)
// color (red, green, or purple)
//
//extension SetGame.Card: CustomDebugStringConvertible {
//    var debugDescription: String {
//        var description: String = "\(feature[0].rawValue) "
//
//        switch feature[1] {
//        case .option1:
//            description += "diamond "
//        case .option2:
//            description += "squiggle "
//        case .option3:
//            description += "oval "
//        }
//
//        switch feature[2] {
//        case .option1:
//            description += "solid "
//        case .option2:
//            description += "striped "
//        case .option3:
//            description += "open "
//        }
//        
//        switch feature[3] {
//        case .option1:
//            description += "red "
//        case .option2:
//            description += "green "
//        case .option3:
//            description += "purple "
//        }
//        
//        switch location {
//        case .discardPile:
//            description += "discard "
//        case .drawPile:
//            description += "draw "
//        case .table:
//            description += "table "
//        }
//        
//        description += isFaceUp  ? "up" : "down"
//
//        return description
//    }
//}
