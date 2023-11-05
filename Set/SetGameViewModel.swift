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
}


// Number of shapes (one, two, or three)
// shape (diamond, squiggle, oval)
// shading (solid, striped, or open)
// color (red, green, or purple)

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
        
        description += isFaceUp  ? "up" : "down"

        return description
    }
}
