//
//  SetGameView.swift
//  Set
//
//  Created by Larry Scherr on 11/4/23.
//

import SwiftUI

struct SetGameView: View {
    
    typealias Card = SetGame.Card
    
    @ObservedObject var game: SetGameViewModel
    @Namespace private var dealingNamespace
    @Namespace private var discardNamespace
    @Namespace private var shuffleNamespace

    var body: some View {

        Text("SwiftUI")
            .navigationTitle("Welcome")
            .toolbar {
                Button("About") {
                    print("About tapped!")
                }

                Button("Help") {
                    print("Help tapped!")
                }
            }
            VStack  {
                table
                bottomControls
            }
            .toolbar {
                newGame
            }
        }


    
    private var navigationBar: some View {
        NavigationStack {
            Text("SwiftUI")
                .navigationTitle("Welcome")
                .toolbar {
                    Button("About") {
                        print("About tapped!")
                    }
                    
                    Button("Help") {
                        print("Help tapped!")
                    }
                }
        }
    }
    
    
    private var table: some View {
        AspectVGrid(game.tablePile, aspectRatio: Constants.aspectRatio) { card in
            if isDealt(card) {
                view(for: card, nameSpace: "table-")
                    .foregroundStyle(game.cardColor)
                    .padding(Constants.spacing)
                //                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                //                .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }
        
    private var deck: some View {
        ZStack {
           ForEach(undealtCards) { card in
                view(for: card, nameSpace: "table-")
            }
        }
        .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
        .onAppear() {
            dealCards(Constants.StartingCards)
        }
        .onTapGesture {
            dealCards(Constants.DrawMoreCards)
        }
    }
    
    private var discard: some View {
        ZStack {
            VStack {
                ZStack {
                    ForEach(unDiscadedCards) { card in
                        view(for: card, nameSpace: "discard-")
                    }
                    
                    Text("Discard")
                        .font(.caption2)
                        .rotationEffect(.degrees(45))
                        .cardify(isFaceUp: true)
                        .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
                }
                .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
                Text("\(unDiscadedCards.count)")
            }
        }
// TODO: factor out frame
    }
        
    private var title: some View {
        Text("Set!").font(.largeTitle)
    }


    
    
    
    private var bottomControls: some View {
        HStack {
            deck
            Spacer()
            DrawThree
            Spacer()
            discard
        }
        .padding()
    }


    private func view(for card: Card, nameSpace: String) -> some View {
        CardView(card, isFaceUp: isFaceUp(card))
            .matchedGeometryEffect(id: "dealt-" + card.id, in: dealingNamespace)
            .transition(.asymmetric(insertion: .identity, removal: .identity))
                 }

//    private func Discardview(for card: Card) -> some View {
//        CardView(card, isFaceUp: isFaceUp(card))
//            .matchedGeometryEffect(id: card.id, in: discardNamespace)
//            .transition(.asymmetric(insertion: .identity, removal: .identity))
//    }
    
    
    private func choose(_ card: Card) {
//        moveCardToDiscardPile(card)

        moveCardsToDiscard(cards: [card])
        
//        withAnimation {
//            if isFaceUp(card) {
//                faceUp.remove(card.id)
//            } else {
//                faceUp.insert(card.id)
//            }
//            
//            
////            game.flipCardFaceUp(card, faceUp: true)
//
//            //                    let scoreBeforeChoosing = viewModel.score
//            game.SelectCard(card)
//            //                    let scoreChange = viewModel.score - scoreBeforeChoosing
//            //                    lastScoreChange = (scoreChange, causedByCardID: card.id)
//        }
    }
    

    // MARK: - Dealing from a Deck
    
    @State private var dealt = Set<Card.ID>()
    @State private var faceUp = Set<Card.ID>()
    @State private var discarded = Set<Card.ID>()
    @State private var draw = Set<Card.ID>()

    @State private var timeDelay: TimeInterval = 0

    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    private var undealtCards: [Card] {
        game.drawPile.filter { !isDealt($0) }
    }
    
    private func isFaceUp(_ card: Card) -> Bool {
        faceUp.contains(card.id)
    }
    private var unFaceUpCards: [Card] {
        game.tablePile.filter { !isFaceUp($0) }
    }

    private func isDiscarded(_ card: Card) -> Bool {
        discarded.contains(card.id)
    }
    private var unDiscadedCards: [Card] {
        game.tablePile.filter { !isDiscarded($0) }
    }
    
    private func isDrawn(_ card: Card) -> Bool {
        draw.contains(card.id)
    }
    private var unDrawCards: [Card] {
        game.discardPile.filter { !isDiscarded($0) }
    }
    
    

    
    private func dealCards(_ numberOfCards: Int) {
        var delay: TimeInterval = timeDelay
        var cards = [Card]()

        for _ in 0..<numberOfCards {
            let card = game.dealCard()
            cards.append(card)
            
        }
        cards.forEach{ card in
            withAnimation(Constants.Deal.dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)

            }     
            withAnimation(Constants.Deal.dealAnimation.delay(delay + 0.5)) {
                _ = faceUp.insert(card.id)

            }
            delay += Constants.Deal.dealInterval
        }
    }
    
    private func moveCardsToDiscard(cards: [Card]) {
        var delay: TimeInterval = timeDelay
        //var cards = [Card]()
        cards.forEach { card in
            game.MoveCardToDiscardPile(card)
        }
        cards.forEach{ card in
            withAnimation(Constants.Deal.dealAnimation.delay(delay)) {
                _ = dealt.remove(card.id)
                _ = discarded.insert(card.id)
            }
            delay += Constants.Deal.dealInterval

        }

    }
    
    
    
    
    private var newGame: some View {
            Text("New game")

            .onTapGesture {
                print("try try again")
                moveCardsToDiscard(cards: game.tablePile)
                
                
//                withAnimation {
//                    startNewGame()
//                }
            }
    }
    
    private var DrawThree: some View {
        VStack {
            Text("Deal")
            Text("3 cards")
        }
            .font(.title2)
            .onTapGesture {
                dealCards(Constants.DrawMoreCards)
            }
    }
    
    private func startNewGame() {
        moveCardsToDiscardPile()
        dealt = []
        faceUp = []
//        game.NewGame()
        dealCards(Constants.StartingCards)
        timeDelay = 0
    }
    
    private func moveCardToDiscardPile(_ card: Card, delay: TimeInterval = 0) {
        withAnimation(Constants.Deal.dealAnimation.delay(delay)) {
            _ = dealt.remove(card.id)
//                _ = faceUp.remove(card.id)
            _ = discarded.insert(card.id)

        }
    }
    
    private func moveCardsToDiscardPile() {
        var delay: TimeInterval = 0
        game.tablePile.forEach{ card in
            withAnimation(Constants.Deal.dealAnimation.delay(delay)) {


            }
            
            withAnimation(Constants.Deal.dealAnimation.delay(delay + 0.5 )) {
                _ = dealt.remove(card.id)

            }

            delay += Constants.Deal.dealInterval
        }
        timeDelay = delay
    }
    
    


    private struct Constants {
//        static let StartingCards: Int = 12
        static let StartingCards: Int = 6
        static let DrawMoreCards: Int = 3
        static let aspectRatio: CGFloat = 2/3
        static let spacing: CGFloat = 4
        struct Deal {
            static let dealAnimation: Animation = .easeInOut(duration: 1)
            static let dealInterval: TimeInterval = 0.15
        }
        static let deckWidth: CGFloat = 50
    }
}

#Preview {
    let game = SetGameViewModel()
    return SetGameView(game: game)
}
