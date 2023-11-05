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
    var table: Deck       { deck.filter { $0.location == .table } }
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
            deck[index].isFaceUp = false
        }
//        deck.shuffle()
        deck[0].location = .table
        deck[1].location = .table
        deck[2].location = .table    }
    
    mutating func MoveCardToDrawPile(_ card: Card) {
        moveCardTo(card, location: .drawPile)
    }

    mutating func MoveCardToTable(_ card: Card) {
        moveCardTo(card, location: .table)
    }
    
    mutating func MoveCardToDiscardPile(_ card: Card) {
        moveCardTo(card, location: .discardPile)
    }
    
    mutating func dealCard(numberOfCardsToDeal: Int) {
        drawPile.prefix(numberOfCardsToDeal).indices.forEach { index in
            deck[index].location = .table
        }
    }
    
    mutating func selectCard(_ card: Card) {
        print("card was selected \(card)")
    }
    
    // MARK: - Helper function
    
    private mutating func moveCardTo( _ card: Card, location: Location ) {
        if let index = deck.firstIndex(where: { $0.id == card.id }) {
            deck[index].location = location
        }
    }
    
}
    
