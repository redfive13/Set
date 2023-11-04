//
//  Card.swift
//  Set
//
//  Created by Larry Scherr on 11/4/23.
//

import Foundation


extension SetGame {
    
    struct Card: Identifiable {
        let feature: [Option]
        var isFaceUp = false
        var location = Location.drawPile
        
        var id = UUID().uuidString
        
        init(feature1: Option, feature2: Option, feature3: Option, feature4: Option) {
            feature = [feature1, feature2, feature3, feature4]
        }
        
        init(feature1: Option, feature2: Option, feature3: Option, feature4: Option, isFaceUp: Bool) {
            feature = [feature1, feature2, feature3, feature4]
            self.isFaceUp = isFaceUp
        }
        
    }
    enum Option: Int, CaseIterable {
        case option1 = 1
        case option2 = 2
        case option3 = 3
    }
    
    enum Location {
        case drawPile
        case table
        case discardPile
    }
    
    
    
}



