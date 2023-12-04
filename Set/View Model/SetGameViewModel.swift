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
    var tablePile: Deck   { setGame.table }
    var discardPile: Deck { setGame.discardPile }
    var deck: Deck        { setGame.deck }
    
    private(set) var hintMode = false
    private var hintCards = [[Card]]()
    private(set) var currentHint = 0
    //    var selectedCardsSave = [Card]()
    
    //    var displayStatus = [Card.ID: HighlightMode]()
    private var tableArrangement = [UUID?]()
    
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
        setMode(mode: false)
        return setGame.dealCard()
    }
    
    func drawThreeCards()    {
        //        setGame.dealCard(numberOfCardsToDeal:  3)
    }
    
    func dealStartingTable() {
        //        setGame.dealCard(numberOfCardsToDeal: 12)
    }
    
    func SelectCard(_ card: Card) {
        setMode(mode: false)
        setGame.selectCard(card)
    }
    
    func highlightMode(_ card: Card) -> HighlightMode {
        if hintMode {
            if currentHint >= 0 && currentHint < hintCards.count {
                let cards = hintCards[currentHint]
                if let _ = cards.firstIndex(where: { $0.id == card.id }) {
                    return .hint
                }
            }
            return .unselected
        }
        if setGame.isCardSelected(card) == false {
            return .unselected
        }
        if setGame.selectedCards.count != 3 {
            return .selected
        }
        if setGame.areSelectedCardsASet {
            return .matched
        } else {
            return .mismatched
        }
    }
    
    func cardLocation(_ card: Card) -> SetGame.Location {
        return setGame.cardLocation(card)
    }
    
    // MARK: - Intents table
    
    func addCardToTable(_ card: Card) {
        if let openSlot = tableArrangement.firstIndex( where: { $0 == nil } ){
            tableArrangement[openSlot] = card.id
        } else {
            tableArrangement.append(card.id)
        }
    }
    
    func removeCardFromTable(_ card: Card) {
        if let cardIndex = tableArrangement.firstIndex( where: { $0 == card.id } ){
            if drawPile.isEmpty {
                tableArrangement.remove(at: cardIndex)
            } else {
                tableArrangement[cardIndex] = nil
            }
        }
    }
    
    func moveCardToDiscardPile(_ card:Card) {
        setGame.moveCardToDiscardPile(card)
    }
    
    func moveCardToDrawPile(_ card:Card) {
        setGame.moveCardToDrawPile(card)
    }
    
    var tableLayout: [Card] {
        var cards = [Card]()
        tableArrangement.forEach { uuid in
            if let uuid = uuid {
                if let card = setGame.getCardByUUID(uuid) {
                    cards.append(card)
                }
            } else {
                cards.append(Card())
            }
        }
        return cards
    }
    
    func isCardOnTable(_ card: Card) -> Bool {
        return tableArrangement.firstIndex( where: { $0 == card.id } ) == nil ? false : true
    }
    
    func availableMatches() -> Int {
        return hintCards.count
    }
    
    func setMode(mode: Bool) {
        print("hint mode \(mode)")
        hintMode = mode
        if hintMode {
            hintCards = setGame.getAllMatches().reversed()
            
            print("hintCards = \(hintCards)")
        } else {
            hintCards = []
        }
        currentHint = 0
    }
    
    func nextHint(forward: Bool = true) {
        if forward {
            currentHint = currentHint + 1 >= hintCards.count ? 0 : currentHint + 1
        } else {
            currentHint = currentHint <= 0 ? hintCards.count - 1 : currentHint - 1
        }
    }
}
    
enum HighlightMode: String {
    case unselected = "unselected"
    case selected = "selected"
    case matched = "matched"
    case mismatched = "mismatched"
    case hint = "hint"
}
