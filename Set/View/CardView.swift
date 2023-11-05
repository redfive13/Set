//
//  CardView.swift
//  Set
//
//  Created by Larry Scherr on 11/4/23.
//

import SwiftUI

struct CardView: View {
    typealias Card = SetGameView.Card
    
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
//        let _ = print("cardview \(card)    ")
    }
    
    var body: some View {
        TimelineView(.animation) {timeline in
            cardsContents
                .cardify(isFaceUp: card.isFaceUp)

//            if card.isFaceUp {
//                let content = "\(card)"
//                Text(content)
//                    .opacity(Constants.Pie.opacity)
//                    .overlay(cardsContents.padding(Constants.Pie.inset))
//                    .padding(Constants.inset)
//                    .cardify(isFaceUp: card.isFaceUp)
//                    .transition(.scale)
//            } else {
//                Color.clear
//            }
        }
    }
    var cardsContents: some View {
        let content = "\(card)"
        return Text(content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
//            .rotationEffect(.degrees(card.isMatched ? 360: 0))
//            .animation(.easeIn(duration: 2), value: card.isMatched)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
}



#Preview {
    typealias Card = CardView.Card
    return VStack {
        HStack {
            CardView(Card(feature1: .option1, feature2: .option1, feature3: .option1, feature4: .option1, isFaceUp: true)).aspectRatio(2/3, contentMode: .fit)
            CardView(Card(feature1: .option1, feature2: .option1, feature3: .option1, feature4: .option1, isFaceUp: false)).aspectRatio(2/3, contentMode: .fit)
        }
//        HStack {
//            CardView(Card(isFaceUp: true, isMatched: true, content: "X", id: "test1"))
//            CardView(Card(isMatched: true, content: "X", id: "test1"))
//        }
    }
    .padding()
    .foregroundStyle(.blue)
}
