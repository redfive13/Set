//
//  SetGameView.swift
//  Set
//
//  Created by Larry Scherr on 11/4/23.
//

import SwiftUI

import SwiftUI

struct SetGameView: View {
    
    typealias Card = SetGame.Card
    
    @ObservedObject var game: SetGameViewModel

    var body: some View {
        VStack  {
            title
            table
            bottomControls
        }
    }

    var table: some View {
        
        AspectVGrid(game.drawPile, aspectRatio: Constants.aspectRatio) { card in
            view(for: card)
                .foregroundStyle(game.cardColor)
                .padding(Constants.spacing)
//                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
//                .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                .onTapGesture {
                    choose(card)
                }
        }
    }
        
        
        @Namespace private var dealingNamespace


    private func view(for card: Card) -> some View {
        CardView(card)
            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            .transition(.asymmetric(insertion: .identity, removal: .identity))
        
    }
            private func choose(_ card: Card) {
                withAnimation {
//                    let scoreBeforeChoosing = viewModel.score
//                    game.choose(card)
//                    let scoreChange = viewModel.score - scoreBeforeChoosing
//                    lastScoreChange = (scoreChange, causedByCardID: card.id)
                }
            }
        


    
    func drawCard(card: Card) {
        CardView(card)
            .cardify(isFaceUp: true)
    }

    var title: some View {
        Text("Set!").font(.largeTitle)
    }

    var bottomControls: some View {
        HStack {
            newGame
            Spacer()
            Text("Draw 3")
        }
        .padding()
    }
    
    var newGame: some View {
        Text("New Game")
            .onTapGesture {
                withAnimation {
                    game.NewGame()
                }
            }
    }
    
    var DrawThree: some View {
        Text("Draw 3")
            .onTapGesture {
                withAnimation {
                    game.drawThreeCards()
                }
            }
    }
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2/3
        static let spacing: CGFloat = 4
//        struct Deal {
//            static let dealAnimation: Animation = .easeInOut(duration: 1)
//            static let dealInterval: TimeInterval = 0.15
//        }
        static let deckWidth: CGFloat = 50
    }

    
    
}

#Preview {
    SetGameView(game: SetGameViewModel())
}
