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
    var highlightMode: HighlightMode
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    @State private var phase = 0.0
    @State private var lineWidth = Constants.Matched.lineWidthSmall

        init(isFaceUp: Bool, highlightMode: HighlightMode = .unselected) {
        rotation = isFaceUp ? 0 : 180
        self.highlightMode = highlightMode
  }
    
    func body(content: Content) -> some View {
         ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
             ZStack {
                 boarder(highlightMode, base: base)
             }
             .background { base.foregroundColor(.white) }
             .overlay { content }
             .opacity(isFaceUp ? 1 : 0)
            base.fill()
                 .overlay { Image(Constants.Background.imageName).resizable().rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0) ).padding(Constants.Background.imageSpacing) }
//                 .opacity(isFaceUp ? 0 : highlightMode == .unselected ? 1 : 0)  // TODO: clean this up? HACK for animation
                 .opacity(isFaceUp ? 0 : 1) 
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0) )
        .foregroundStyle(Constants.Background.color)
    }
    
    private func boarder(_ displayStatus: HighlightMode, base: RoundedRectangle) -> some View {
        Group {
            switch displayStatus {
            case .unselected:
                base
                    .strokeBorder(lineWidth:  Constants.Unselected.lineWidth)
            case .selected:
                base
                    .strokeBorder(lineWidth:  Constants.Selected.lineWidth)
            case .matched:
                base
                    .strokeBorder(style: StrokeStyle(lineWidth: lineWidth))
                    .foregroundColor(Constants.Matched.color)
                    .onAppear {
                        withAnimation(.easeInOut(duration: Constants.Matched.duration).repeatForever(autoreverses: true)) {
                            lineWidth = Constants.Matched.lineWidthLarge
                        }
                    }
            case .mismatched:
                base
                    .strokeBorder(style: StrokeStyle(
                        lineWidth: Constants.Mismatched.lineWidth,
                        dash: Constants.Mismatched.Dash,
                        dashPhase: phase))
                    .foregroundColor(.red)
                    .onAppear {
                        withAnimation(.linear.repeatForever(autoreverses: false)) {
                            phase -= Constants.Mismatched.phase
                        }
                    }
            case .hint:
                base
                    .strokeBorder(lineWidth:  Constants.Unselected.lineWidth * 4)
            }
        }
    }
    
    
    private struct Constants {
        private static let color = Color.blue

        static let cornerRadius: CGFloat = 12

        struct Unselected {
            static let lineWidth: CGFloat = 2
            static let color = Constants.color
        }
        struct Selected {
            static let lineWidth: CGFloat = 5
            static let color = Constants.color
        }
        struct Mismatched {
            static let lineWidth: CGFloat = 5
            static let Dash : [CGFloat] = [20, 5]
            static let phase: CGFloat = 20
            static let color = Color.red
        }
        struct Matched {
            static let duration: CGFloat = 0.75
            static let lineWidthSmall : CGFloat = 2
            static let lineWidthLarge: CGFloat = 6
            static let color = Color.green
        }
        struct Background {
            static let imageName = "Mickey"
            static let imageSpacing: CGFloat = 10
            static let color = Constants.color
        }
    }
}


extension View {
    func cardify(isFaceUp: Bool, highlightMode: HighlightMode) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, highlightMode: highlightMode))
    }
    
    func cardify() -> some View {
        modifier(Cardify(isFaceUp: true, highlightMode: .unselected))
    }
    
}

#Preview {
    typealias Card = SetGameView.Card

    return VStack {
        HStack {
            Text("Hello")
                .cardify(isFaceUp: true, highlightMode: .unselected)
                .aspectRatio(2/3, contentMode: .fit)
            Text("Hello")
                .cardify(isFaceUp: true, highlightMode: .selected)
                .aspectRatio(2/3, contentMode: .fit)
        }
        HStack {
            Text("Hello")
                .cardify(isFaceUp: true, highlightMode: .matched)
                .aspectRatio(2/3, contentMode: .fit)
            Text("Hello")
                .cardify(isFaceUp: true, highlightMode: .mismatched)
                .aspectRatio(2/3, contentMode: .fit)
        }
//        HStack {
//            CardView(Card(feature1: .option3, feature2: .option2, feature3: .option2, feature4: .option2), isFaceUp: true)
//                .aspectRatio(2/3, contentMode: .fit)
//            CardView(Card(feature1: .option3, feature2: .option1, feature3: .option2, feature4: .option3), isFaceUp: false)
//                .aspectRatio(2/3, contentMode: .fit)
//        }
    }
    .padding()

}
