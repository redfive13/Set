//
//  CardFace.swift
//  Set
//
//  Created by Larry Scherr on 11/9/23.
//

import SwiftUI

struct CardFace: View {
    typealias Card = CardView.Card

    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {

        GetShape()
    }
    
    private func numberOfShapes(shape: any View, numberOnCard number: Int) -> any View {
            ZStack {
                switch number {
                case 1:
                    shape
                        .position(x: halfWidth, y: height / 2)
                case 2:
                    shape
                        .position(x: halfWidth, y: height * ( 0.5 - 0.2))
                    shape
                        .position(x: halfWidth, y: height * ( 0.5 + 0.2))
                default:
                    shape
                        .position(x: halfWidth, y: height * ( 0.5 - 0.28))
                    shape
                        .position(x: halfWidth, y: height / 2)
                    shape
                        .position(x: halfWidth, y: height * ( 0.5 + 0.28))
    
                }
            }
        }
    
    
    
}

#Preview {
    typealias Card = CardView.Card

    return VStack {
        HStack {
            CardFace(Card(feature1: .option1, feature2: .option1, feature3: .option1, feature4: .option1, isFaceUp: true)).aspectRatio(2/3, contentMode: .fit)
                .cardify(isFaceUp: true)
                .aspectRatio(2/3, contentMode: .fit)
            CardFace(Card(feature1: .option1, feature2: .option1, feature3: .option1, feature4: .option1, isFaceUp: false)).aspectRatio(2/3, contentMode: .fit)
                .cardify(isFaceUp: true)
                .aspectRatio(2/3, contentMode: .fit)
        }
//        HStack {
//            CardView(Card(isFaceUp: true, isMatched: true, content: "X", id: "test1"))
//            CardView(Card(isMatched: true, content: "X", id: "test1"))
//        }
    }
    .padding()

    
    
    
    
}
