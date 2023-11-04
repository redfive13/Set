//
//  SetGame.swift
//  Set
//
//  Created by Larry Scherr on 11/4/23.
//

import Foundation

struct SetGame {
    private (set) var deck: [Card] = []
    
    init() {

        createCards()
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
    

 
}
    
