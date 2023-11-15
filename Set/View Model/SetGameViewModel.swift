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
//    @Published private var table = Table<Card>()
    
    var drawPile: Deck    { setGame.drawPile }
    var tablePile: Deck   { setGame.table }
    var discardPile: Deck { setGame.discardPile }
    
    var cardColor: Color {
        return Color(.blue)
    }
    
    
    
    
    
    
    
    // MARK: - Intents
    
        func MoveCardToDrawPile(    _ card: Card) { setGame.moveCardToDrawPile(card) }
//        func MoveCardToTable(       _ card: Card) { setGame.MoveCardToTable(card) }
        func MoveCardToDiscardPile( _ card: Card) { setGame.moveCardToDiscardPile(card) }
    
    func NewGame() {
        setGame.newGame()
    }
    
    func dealCard() -> Card {
        return setGame.dealCard()
    }
    
    func drawThreeCards()    {
//        setGame.dealCard(numberOfCardsToDeal:  3)
    }
    
    func dealStartingTable() {
//        setGame.dealCard(numberOfCardsToDeal: 12)
    }
    
    func SelectCard(_ card: Card) { setGame.selectCard(card) }

//    func flipCardFaceUp(_ card: Card, faceUp: Bool) {
//        setGame.flipCardFaceUp(card, faceUp: faceUp)
//    }
    
}
    







//let locationOccupied = table.compactMap{ $0.location.slot }.sorted()
//
//var location = 0
//while (location < locationOccupied.count) {
//    if locationOccupied[location] != location {
//        break
//    }
//    location += 1
//}
