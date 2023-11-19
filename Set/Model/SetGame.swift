//
//  SetGame.swift
//  Set
//
//  Created by Larry Scherr on 11/4/23.
//

import Foundation

struct SetGame: Observable {
    typealias Deck = [Card]
    
    private (set) var deck: Deck = []
    var drawPile: Deck    { deck.filter { $0.location == .drawPile } }
    var table: Deck       { deck.filter { $0.location == .table } }
    var discardPile: Deck { deck.filter { $0.location == .discardPile } }
    
    var selectedCards: Deck {table.filter{ $0.selected }}
    var areSelectedCardsASet:Bool {areCardsASet(selectedCards)}
    
    init() {
        createCards()
        newGame()
    }
    
    mutating func createCards() {
        for feature1 in Option.allCases {
            for feature2 in Option.allCases {
                for feature3 in Option.allCases {
                    for feature4 in Option.allCases {
                        deck.append(Card(feature1: feature1, feature2: feature2, feature3: feature3, feature4: feature4))
                    }
                }
            }
        }
        deck.removeLast(81 - 27)
    }
    
    mutating func newGame() {
        print("New Game")
        deck.indices.forEach { index in
            deck[index].location = .drawPile
            //            deck[index].isFaceUp = false
        }
    }
    
    mutating func selectCard(_ card: Card) {
        
        if selectedCards.count == 3 {
            if areSelectedCardsASet {
                selectedCards.forEach{ card in
                    moveCardToDiscardPile(card)
                }
            } else {
                selectedCards.forEach{ card in
                    if let index = deck.firstIndex(where: { $0.id == card.id }) {
                        deck[index].selected = false
                    }
                }
            }
        }
        
        
        
        if let index = deck.firstIndex(where: { $0.id == card.id }) {
            if deck[index].selected {
                deck[index].selected = false
            } else {
                deck[index].selected = true
                
            }
            
        }
        
    }
    
    func isCardSelected(_ card: Card) -> Bool {
        if let index = deck.firstIndex(where: { $0.id == card.id }) {
            return deck[index].selected
        }
        return false
    }
    
    
    //        if let index = deck.firstIndex(where: { $0.id == card.id }) {
    //            if deck[index].selectedStatus == .unselected {
    //                deck[index].selectedStatus = .selected
    //
    //                if selectedCards.count == 3 {
    //                    if areSelectedCardsASet {
    //                        setSelectedCardsStatus(.matched)
    //                    } else {
    //                        setSelectedCardsStatus(.mismatched)
    //                    }
    //                }
    //            } else {
    //                deck[index].selectedStatus = .unselected
    //                table.filter{ $0.selectedStatus == .matched || $0.selectedStatus == .mismatched }.forEach { card in
    //                    changeSelectStatus(card, status: .selected)
    //                }
    //            }
    //        }
    //    }
    
    mutating func moveCardToDrawPile(_ card: Card) {
        moveCardTo(card, location: .drawPile)
    }
    
    mutating func moveCardToTable(_ card: Card) {
        moveCardTo(card, location: .table)
    }
    
    mutating func moveCardToDiscardPile(_ card: Card) {
        moveCardTo(card, location: .discardPile)
    }
    
    mutating func dealCard() -> Card {
        if let card = drawPile.first {
            moveCardToTable(card)
            return card
        }
        fatalError("dealCard: draw pile is empty")
    }
    
    //    mutating func flipCardFaceUp(_ card: Card, faceUp: Bool) {
    //        if let index = deck.firstIndex(where: { $0.id == card.id }) {
    //            print("was \(deck[index])")
    //            deck[index].isFaceUp = faceUp
    //            print("is \(deck[index])")
    //        }
    //    }
    
    // MARK: - Helper function
    
    private func areCardsASet(_ cards: [Card]) -> Bool {
        if cards.count != 3 { return false }
        
        if featureMatch(0) && featureMatch(1) && featureMatch(2) && featureMatch(3) {
            return true
        } else {
            print("card don't match")
            return false
        }
        
        func featureMatch(_ feature: Int) -> Bool {
            if feature < 0 || feature > 3 { return false }
            if (
                // The three features are all the same
                cards[0].feature[feature] == cards[1].feature[feature] &&
                cards[1].feature[feature] == cards[2].feature[feature]
            ) || (
                // The three features are all different
                cards[0].feature[feature] != cards[1].feature[feature] &&
                cards[1].feature[feature] != cards[2].feature[feature] &&
                cards[0].feature[feature] != cards[2].feature[feature]
            ) {
                return true
            } else {
                return false
            }
        }
    }
    
    private mutating func moveCardTo( _ card: Card, location: Location ) {
        if let index = deck.firstIndex(where: { $0.id == card.id }) {
            deck[index].location = location
        }
    }
}
