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
    
    @State var debug:Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                            Text("Set!")
                    .font(.title)
                //                .navigationTitle("Welcome")
                    .toolbar {
                        Button("Hint") {
                            print("About tapped!")
                        }
                        
                        Button("New Game") {
                            print("Help tapped!")
                            newGame()
                        }
                    }
                VStack  {
                    table
                    bottomControls
                }
            }
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
    
    // MARK: - Piles
    
    
    
    private func allCardsLocated(on location: SetGame.Location) -> [Card] {
        return game.deck.filter({
            if let cardLocation = cardAnimationLocation[$0.id] {
                return cardLocation == location ? true : false
            } else {
                // if card not in cardAnimationLocation, it is on the drawpile
                return location == .drawPile ? true : false
            }
        })
    }
    
    private func isCard(_ card: Card, on wantedLocation: SetGame.Location) -> Bool{
        var animationLocation: SetGame.Location = .drawPile
        if card.feature.isEmpty {
            return true
        }
        if let location = cardAnimationLocation[card.id] {
            animationLocation = location
        }
//        var cardLocation = card.location
        
        
        if animationLocation == wantedLocation {
            return true
        }
        return false
    }
    
    
    
    private var table: some View {
        return AspectVGrid(game.tableLayout, aspectRatio: Constants.aspectRatio) { card in
            if isCard(card, on: .table) {
                view(for: card)
                    .foregroundStyle(game.cardColor)
                    .padding(Constants.spacing)
                //                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                //                .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {

                        selectCard(card)
                    }
            } else {
                    RoundedRectangle(cornerRadius: 0)
                .opacity(0)
            }
        }
    }
    
    // TODO: deals from bottom of the deck
    private var drawPile: some View {
         VStack{
            ZStack {
                ZStack {
                    ForEach(game.drawPile) { card in
                        view(for: card)
                    }
                }
                .zIndex(10)
                Text("Draw")
                    .font(.caption2)
                    .rotationEffect(.degrees(45))
                    .cardify()
                    .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
                    .zIndex(-100)
//                    .opacity(game.drawPile.count > 0 ? 0 : 1)
            }
            .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
            .onAppear() { dealCards(Constants.startingCards) }
            .onTapGesture {  dealCards(Constants.drawMoreCards) }
             if debug {
                 Text("\(game.drawPile.count)")
             }
        }
    }
    
    private var discard: some View {
        VStack {
            ZStack {
                //cardAnimationLocation
                ForEach(game.discardPile) { card in
                    if isDiscarded(card) {
                        view(for: card)
                    }
                }
                
                Text("Discard")
                    .font(.caption2)
                    .rotationEffect(.degrees(45))
                    .cardify()
                    .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
                    .zIndex(-100)
//                    .opacity(game.discardPile.count > 0 ? 0 : 1)

            }
            .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
            if debug {
                Text("\(game.discardPile.count)")
            }
        }
// TODO: factor out frame
    }
    
    
    
    // MARK: - screen views
        
    private var title: some View {
        Text("Set!").font(.largeTitle)
    }
        
    private var bottomControls: some View {
        HStack {
            drawPile
            Spacer()
            DrawThree
            Spacer()
            discard
        }
        .padding()
    }


    private func view(for card: Card) -> some View {

        //        let _ = print("view \(card)")
//        return CardViewxxx(card: card, isFaceUp: isFaceUp(card), game: game)
        return CardView(card, isFaceUp: isFaceUp(card), game: game)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .transition(.asymmetric(insertion: .identity, removal: .identity))
    }

//    private func Discardview(for card: Card) -> some View {
//        CardView(card, isFaceUp: isFaceUp(card))
//            .matchedGeometryEffect(id: card.id, in: discardNamespace)
//            .transition(.asymmetric(insertion: .identity, removal: .identity))
//    }
    
    // MARK: - Actions

    
    private func selectCard(_ card: Card) {
        game.SelectCard(card)
        discardCards()

    }
    

    // MARK: - Dealing from a Deck
    
    @State private var faceUp = Set<Card.ID>()

    private func isFaceUp(_ card: Card) -> Bool {
        faceUp.contains(card.id)
    }
    private var unFaceUpCards: [Card] {
        game.tablePile.filter { !isFaceUp($0) }
    }


    
    // MARK: - Card location function

    
    @State private var cardAnimationLocation = [Card.ID: SetGame.Location]()
    
//    @State private var dealt = Set<Card.ID>()
    @State private var discarded = Set<Card.ID>()
    @State private var draw = Set<Card.ID>()

    //@State private var timeDelay: TimeInterval = 0
    
    
    private func cardNeedsToMove(_ card: Card, location wantedLocation: SetGame.Location) -> Bool {
        if let cardAnimationLocation = cardAnimationLocation[card.id] {
            if game.cardLocation(card) == wantedLocation && cardAnimationLocation != wantedLocation {
                // maybe only need card.location
                return true
            }
        }
        return false
    }

    private func isDealt(_ card: Card) -> Bool {
        if let location = cardAnimationLocation[card.id] {
            if location == .table {
                return true
            }
        }
        return false
    }


    
    
    
    
    
    
//    private var undealtCards: [Card] {
//        return game.drawPile.filter { cardNeedsToMove($0, location: .table) }
//    }
    
    private func isDiscarded(_ card: Card) -> Bool {
        if let location = cardAnimationLocation[card.id] {
            if location == .discardPile {
                return true
            }
        }
        return false

    }
    private var unDiscadedCards: [Card] {
        return game.discardPile.filter { cardNeedsToMove($0, location: .discardPile) }
    }
    
    private func isDrawn(_ card: Card) -> Bool {
        draw.contains(card.id)
    }
    private var unDrawCards: [Card] {
        game.discardPile.filter { !isDiscarded($0) }
    }
    
//    private func addCardToTable(_ card: Card) {
//        if let openSlot = tableArrangement.firstIndex( where: { $0 == nil } ){
//            tableArrangement[openSlot] = card.id
//        } else {
//            tableArrangement.append(card.id)
//        }
//    }
//    
//    private func removeCardFromTable(_ card: Card) {
//        if let openSlot = tableArrangement.firstIndex( where: { $0 == nil } ){
//            tableArrangement[openSlot] = nil
//        }
//        if game.drawPile.count == 0 {
//            tableArrangement = tableArrangement.filter { $0 != nil }
//        }
//    }

    //MARK: Move Cards
    
    private func dealCards(_ numberOfCards: Int, initialDelay: TimeInterval = 0) {
        var delay = initialDelay
        var cards = [Card]()

        if game.drawPile.isEmpty {
            return
        }
        for _ in 0..<numberOfCards {
            let card = game.dealCard()
            game.addCardToTable(card)
            cards.append(card)
        }
        cards.forEach{ card in
            withAnimation(Constants.Deal.animation.delay(delay)) {
                cardAnimationLocation[card.id] = .table
            }
            withAnimation(Constants.Deal.animation.delay(delay + Constants.Deal.faceUpDelay)) {
                _ = faceUp.insert(card.id)

            }
            delay += Constants.Deal.interval
        }
    }
//========================================================================
    // MARK: DISCARD!!!!
    
    private func discardCards() {
        var delay: TimeInterval = 0
        let cards = unDrawCards.reversed()
        
        if cards.isEmpty {
            return
        }
        
        cards.forEach { card in
            withAnimation(Constants.Discard.animation.delay(delay)) {
                _ = faceUp.remove(card.id)
            } completion: { moveCardToDiscardPile(card) }
            delay += Constants.Deal.interval
        }
        
        func moveCardToDiscardPile(_ card: Card) {
            withAnimation(Constants.Discard.animation.delay(Constants.Discard.faceDownDelay)) {
                cardAnimationLocation[card.id] = .discardPile
                game.removeCardFromTable(card)
            } completion: { dealCards(1, initialDelay: delay)}
        }
    }

    private func newGameResetCards(cards: [Card]) {
        var delay: TimeInterval = 0

        game.drawPile.forEach{ card in
            withAnimation(Constants.NewGame.animation.delay(delay)) {
                moveCardToDiscardPile(card)
            }
            delay += Constants.NewGame.interval
        }
        
        game.tablePile.forEach { card in
            withAnimation(Constants.Discard.animation.delay(delay)) {
                _ = faceUp.remove(card.id)
            } completion: { moveCardToDiscardPile(card) }
            delay += Constants.Deal.interval
        }
        
        func moveCardToDiscardPile(_ card: Card) {
            withAnimation(Constants.Discard.animation.delay(Constants.Discard.faceDownDelay)) {
                cardAnimationLocation[card.id] = .discardPile
                game.MoveCardToDiscardPile(card)
                game.removeCardFromTable(card)
            } completion: { moveCardsToDrawPile() }
        }

        func moveCardsToDrawPile() {
            game.discardPile.forEach{ card in
                withAnimation(Constants.Discard.animation.delay(Constants.Discard.faceDownDelay + 4)) {
                    game.moveCardToDrawPile(card)
                    
                }
            }
        }
        
    }
    
    func junk() {
        var cards: [Card] = []
        var delay:TimeInterval = 0

        cards.forEach { card in
            game.MoveCardToDiscardPile(card)
        }
        cards.forEach{ card in
            withAnimation(Constants.Discard.animation.delay(delay)) {
//                _ = dealt.remove(card.id)
//                _ = discarded.insert(card.id)
            }
            delay += Constants.Discard.interval

        }

    }
    
    
    
    
    func newGame()  {
        newGameResetCards(cards: game.tablePile)
    }
    
    @State var hintMode = false

    private var DrawThree: some View {
        VStack {
            VStack {
//                Text("Deal")
                Text("Deal 3 cards")
            }
            .font(.title2)
            .onTapGesture {
                dealCards(Constants.drawMoreCards)
            }
            .padding()
            Group {
                if hintMode {
                    HStack {
                        Image(systemName: "arrow.backward.square")
                            .onTapGesture {
                                game.nextHint()
                            }
                        Text(" \(game.currentHint + 1) of \(game.availableMatches()) matches ")
                            .onTapGesture {
                                hintMode = false
                                game.setMode(mode: true)
                            }
                        Image(systemName: "arrow.right.square")
                            .onTapGesture {
                                game.nextHint(forward: false)
                            }
                    }
                } else {
                    Text("Hints")
                        .onTapGesture {
                            hintMode = true
                            game.setMode(mode: true)
                        }
                    
                    
                }
                
            }
//TODO: add animation to tex change
            
        }

    }
    
    private func startNewGame() {
        moveCardsToDiscardPile()
        cardAnimationLocation.removeAll()
        faceUp = []
//        game.NewGame()
        dealCards(Constants.startingCards)
    }
    
    private func moveCardToDiscardPile(_ card: Card, delay: TimeInterval = 0) {
        withAnimation(Constants.Deal.animation.delay(delay)) {
//            _ = dealt.remove(card.id)
//                _ = faceUp.remove(card.id)
            _ = discarded.insert(card.id)

        }
    }
    
    private func moveCardsToDiscardPile() {
        var delay: TimeInterval = 0
        game.tablePile.forEach{ card in
            withAnimation(Constants.Deal.animation.delay(delay)) {


            }
            
            withAnimation(Constants.Deal.animation.delay(delay + 0.5 )) {
//                _ = dealt.remove(card.id)

            }

            delay += Constants.Deal.interval
        }
    }
    
    
    
    



    private struct Constants {
//        static let startingCards: Int = 12
        static let startingCards: Int = 6
        static let drawMoreCards: Int = 3
        static let aspectRatio: CGFloat = 2/3
        static let spacing: CGFloat = 4
        struct Deal {
            private static let debug = false
            static let animation: Animation = .easeInOut(duration: debug ? 0 : 1)
            static let interval: TimeInterval = 0.15 * 0.01
            static let faceUpDelay: TimeInterval = 0.5 * 0.01
        }
        struct Discard {
            static let animation: Animation = .bouncy(duration: 1)
            static let interval: TimeInterval = 0.15
            static let faceDownDelay: TimeInterval = 0.25
        }
        struct NewGame {
            static let animation: Animation = .spring(duration: 1, bounce: 0.9)
            static let interval: TimeInterval = 0.5
            static let faceUpDelay: TimeInterval = 0.25
        }
        
        
        static let deckWidth: CGFloat = 50
    }
}

#Preview {
    let game = SetGameViewModel()
    return SetGameView(game: game)
}
