//
//  Cardify.swift
//  Set
//
//  Created by Larry Scherr on 11/4/23.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    var isFaceUp: Bool {
        rotation < 90
    }
    var selectedStatus: SelectedStatus
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    @State private var phase = 0.0

    
    init(isFaceUp: Bool, selectedStatus: SelectedStatus) {
        rotation = isFaceUp ? 0 : 180
        self.selectedStatus = selectedStatus
  }
    
    func body(content: Content) -> some View {
         ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
             ZStack {
                 boarder(selectedStatus, base: base)
                 
                 
                 
//                 base
//                 //                .strokeBorder(lineWidth: selected ? Constants.selectedLineWidth : Constants.lineWidth)
//                     .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10], dashPhase: phase))
//                     .foregroundColor(.blue)
//                     .onAppear {
//                         withAnimation(.linear.repeatForever(autoreverses: false)) {
//                             phase -= 20
//                         }
//                     }
//                 
                 
                 
                 
                 
             }
             .background { base.foregroundColor(.white) }
             .overlay { content }
             .opacity(isFaceUp ? 1 : 0)
            base.fill()
                .overlay { Image(Constants.backgroundImageName).resizable().rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0) ).padding(Constants.backgroundImageSpacing) }
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0) )
        .foregroundStyle(Constants.backgroundColor)
    }
    
    private func boarder(_ selectedStatus: SelectedStatus, base:  RoundedRectangle) -> some View {

        Group {
//            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            switch selectedStatus {
            case .unselected:
                base
                    .strokeBorder(lineWidth: Constants.lineWidth)
            case .selected:
                base
                    .strokeBorder(lineWidth:  Constants.selectedLineWidth)
            case .matched:
                base
                    .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10], dashPhase: phase))
                    .foregroundColor(.blue)
                    .onAppear {
                        withAnimation(.linear.repeatForever(autoreverses: false)) {
                            phase -= 20
                        }
                    }
            case .mismatched:
                base
                    .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10], dashPhase: phase))
                    .foregroundColor(.red)
                    .onAppear {
                        withAnimation(.linear.repeatForever(autoreverses: false)) {
                            phase -= 20
                        }
                    }
            }
        }

    }
    
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let selectedLineWidth: CGFloat = 5
        static let backgroundImageName = "Mickey"
        static let backgroundImageSpacing: CGFloat = 10

        static let backgroundColor = Color.blue
    }
}
enum SelectedStatus {
    case unselected
    case selected
    case matched
    case mismatched
}

extension View {
    func cardify(isFaceUp: Bool, selectedStatus: SelectedStatus) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, selectedStatus: selectedStatus))
    }
    
}

#Preview {
    typealias Card = SetGameView.Card

    return VStack {
        HStack {
            Text("Hello")
                .cardify(isFaceUp: true, selectedStatus: .unselected)
                .aspectRatio(2/3, contentMode: .fit)
            Text("Hello")
                .cardify(isFaceUp: true, selectedStatus: .selected)
                .aspectRatio(2/3, contentMode: .fit)
        }
        HStack {
            Text("Hello")
                .cardify(isFaceUp: true, selectedStatus: .matched)
                .aspectRatio(2/3, contentMode: .fit)
            Text("Hello")
                .cardify(isFaceUp: true, selectedStatus: .mismatched)
                .aspectRatio(2/3, contentMode: .fit)                }
//        HStack {
//            CardView(Card(feature1: .option3, feature2: .option2, feature3: .option2, feature4: .option2), isFaceUp: true)
//                .aspectRatio(2/3, contentMode: .fit)
//            CardView(Card(feature1: .option3, feature2: .option1, feature3: .option2, feature4: .option3), isFaceUp: false)
//                .aspectRatio(2/3, contentMode: .fit)
//        }
    }
    .padding()

}
