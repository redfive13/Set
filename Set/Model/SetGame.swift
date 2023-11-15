//
//  SetGame.swift
//  Set
//
//  Created by Larry Scherr on 11/4/23.
//

import Foundation

struct SetGame {
    typealias Deck = [Card]
    
    private (set) var deck: Deck = []
    var drawPile: Deck    { deck.filter { $0.location == .drawPile } }
    var table: Deck       { deck.filter { !($0.location == .drawPile) && !($0.location == .discardPile)}}
    var discardPile: Deck { deck.filter { $0.location == .discardPile } }
    
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
    }
    
    mutating func newGame() {
        print("New Game")
        deck.indices.forEach { index in
            deck[index].location = .drawPile
//            deck[index].isFaceUp = false
        }
    }
    
    mutating func MoveCardToDrawPile(_ card: Card) {
        moveCardTo(card, location: .drawPile)
    }
    
    mutating func MoveCardToTable(_ card: Card) {
        moveCardTo(card, location: .table)
    }
    
    mutating func MoveCardToDiscardPile(_ card: Card) {
        moveCardTo(card, location: .discardPile)
    }
    
    mutating func dealCard() -> Card {
        if let card = drawPile.first {
            MoveCardToTable(card)
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
    
    mutating func selectCard(_ card: Card) {
        print("card was selected \(card)")
    }
    
    // MARK: - Helper function
    
    private mutating func moveCardTo( _ card: Card, location: Location ) {
        if let index = deck.firstIndex(where: { $0.id == card.id }) {
            deck[index].location = location
//            if location.isTable {
//                deck[index].isFaceUp = true
//            } else {
//                deck[index].isFaceUp = false
//            }
        }
    }
}
    
