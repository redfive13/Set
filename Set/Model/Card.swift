//
//  Card.swift
//  Set
//
//  Created by Larry Scherr on 11/4/23.
//

import Foundation

extension SetGame {

    struct Card: Identifiable, Equatable, Comparable {

        let feature: [Option]
        var location = Location.drawPile
        
        var id = UUID().uuidString
        
        init(feature1: Option, feature2: Option, feature3: Option, feature4: Option) {
            feature = [feature1, feature2, feature3, feature4]
        }
        
        static func == (lhs: SetGame.Card, rhs: SetGame.Card) -> Bool {
            return lhs.id == rhs.id
        }
        
        static func < (lhs: SetGame.Card, rhs: SetGame.Card) -> Bool {
            return lhs.location == rhs.location
        }
        
    }
    enum Option: Int, CaseIterable {
        case option1 = 1
        case option2 = 2
        case option3 = 3
    }
    
    enum Location: Equatable {
        case drawPile
        case table
        case discardPile
    }
    
    
    
}

extension SetGame.Location {
//    var isTable: Bool {
//        switch self {
//        case .table(_): return true
//        default: return false
//        }
//    }
    
//    var slot: Int? {
//        switch self {
//        case .table(let location): return location
//        default: return nil
//        }
//    }
}


