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
        GeometryReader { geometry in
            let feature = CardViewModel()

            let width = min(geometry.size.height, geometry.size.width)
            let height = max(geometry.size.height, geometry.size.width)
            let halfWidth = width / 2
            
            let shape = AnyView(getShadedShape(
                shape: feature.shape(of: card),
                shading: feature.shading(of: card)
            ))
            
            Group {
                switch feature.number(on: card) {
                case 1:
                    shape.position(x: halfWidth, y: height * Constants.Card.One.first)
                case 2:
                    shape.position(x: halfWidth, y: height * Constants.Card.Two.first)
                    shape.position(x: halfWidth, y: height * Constants.Card.Two.second)
                case 3:
                    shape.position(x: halfWidth, y: height * Constants.Card.Three.first)
                    shape.position(x: halfWidth, y: height * Constants.Card.Three.second)
                    shape.position(x: halfWidth, y: height * Constants.Card.Three.third)
                default:
                    Text("🚫").font(.largeTitle)
                }
            }
            .foregroundStyle(feature.color(of: card))
        }
    }
        
    private func getShadedShape(shape: CardShapes, shading: CardShading) -> any View {
        let shape = AnyShape(getShape(shape: shape))
        
        return Group {
            shape.stroke(lineWidth: Constants.LineWidth )
            Group {
                switch shading {
                case .solid:
                    shape.fill()
                case .striped:
                    StripeShape().mask(shape)
                case .open:
                    shape.fill(.white)
                }
            }
        }
    }
    
    private struct StripeShape: Shape {
        func path(in rect: CGRect) -> Path {
            
            var path = Path()
            for x in stride(from: Int(rect.minX), to: Int(rect.maxX), by: Constants.stripeNumber) {
                path.move(to: CGPoint(x: CGFloat(x), y: rect.minY))
                path.addLine(to: CGPoint(x: CGFloat(x), y: rect.maxY))
                path.addLine(to: CGPoint(x: CGFloat(x+1), y: rect.maxY))
                path.addLine(to: CGPoint(x: CGFloat(x+1), y: rect.minY))
                path.addLine(to: CGPoint(x: CGFloat(x), y: rect.minY))
            }
            return path
        }
    }
    
    private func getShape(shape: CardShapes) -> any Shape {
        switch shape {
        case .diamond:
            return diamond()
        case .squiggle:
            return squiggle()
        case .oval:
            return oval()
        }
    }
    
    private struct diamond: Shape {
        func path(in rect: CGRect) -> Path {
            let apothem = (min(rect.height, rect.width) / 2 ) * Constants.Diamond.apothemScale
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let left = center.x - apothem
            let right = center.x + apothem
            let top = center.y - apothem *  Constants.Diamond.scale
            let bottom = center.y + apothem * Constants.Diamond.scale
            
            var path = Path()
            
            path.move(to: CGPoint(x: left, y: center.y))
            path.addLine(to: CGPoint(x: center.x, y: top))
            path.addLine(to: CGPoint(x: right, y: center.y))
            path.addLine(to: CGPoint(x: center.x, y: bottom))
            path.addLine(to: CGPoint(x: left, y: center.y))
            
            return path
        }
    }
    
    
    private struct squiggle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            // Code for squiggle is from Joshua Olson
            // https://stackoverflow.com/questions/25387940/how-to-draw-a-perfect-squiggle-in-set-card-game-with-objective-c
            path.move(to: CGPoint(x: 104.0, y: 15.0))
            path.addCurve(to: CGPoint(x: 63.0, y: 54.0),
                          control1: CGPoint(x: 112.4, y: 36.9),
                          control2: CGPoint(x: 89.7, y: 60.8))
            path.addCurve(to: CGPoint(x: 27.0, y: 53.0),
                          control1: CGPoint(x: 52.3, y: 51.3),
                          control2: CGPoint(x: 42.2, y: 42.0))
            path.addCurve(to: CGPoint(x: 5.0, y: 40.0),
                          control1: CGPoint(x: 9.6, y: 65.6),
                          control2: CGPoint(x: 5.4, y: 58.3))
            path.addCurve(to: CGPoint(x: 36.0, y: 12.0),
                          control1: CGPoint(x: 4.6, y: 22.0),
                          control2: CGPoint(x: 19.1, y: 9.7))
            path.addCurve(to: CGPoint(x: 89.0, y: 14.0),
                          control1: CGPoint(x: 59.2, y: 15.2),
                          control2: CGPoint(x: 61.9, y: 31.5))
            path.addCurve(to: CGPoint(x: 104.0, y: 15.0),
                          control1: CGPoint(x: 95.3, y: 10.0),
                          control2: CGPoint(x: 100.9, y: 6.9))
            
            let pathRect = path.boundingRect
            path = path.offsetBy(dx: rect.minX - pathRect.minX, dy: rect.minY - pathRect.minY)
            let scale: CGFloat = rect.width / pathRect.width * Constants.Squiggle.scale
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            path = path.applying(transform)
           
            let offsetX = rect.minX - path.boundingRect.minX + (rect.width - path.boundingRect.width) / 2
            let offsetY = rect.minY - path.boundingRect.minY + (rect.height - path.boundingRect.height) / 2
            return path
                .offsetBy(dx:offsetX, dy: offsetY)
        }
    }
    
    private struct oval: Shape {
        func path(in rect: CGRect) -> Path {
            let apothem = (min(rect.height, rect.width) / 2 ) * Constants.Oval.apothemScale
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let left = center.x - apothem
            let right = center.x + apothem
            let top = center.y - apothem *  Constants.Oval.scale
            let bottom = center.y + apothem * Constants.Oval.scale
            
            var path = Path()
            
            path.move(to: CGPoint(x: left, y: top))
            path.addLine(to: CGPoint(x: right, y: top))
            path.addArc(
                center: CGPoint(x: right, y: rect.midY),
                radius: (bottom - top) / 2,
                startAngle: Angle(degrees: 270),
                endAngle: Angle(degrees: 90),
                clockwise: false)
            path.addLine(to: CGPoint(x: right, y: bottom))
            path.addArc(
                center: CGPoint(x: left, y: rect.midY),
                radius: (bottom - top) / 2,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 270),
                clockwise: false)
            return path
        }
    }
    
    private struct Constants {
        static let LineWidth: CGFloat = 3
        static let stripeNumber: Int = 4

        struct Diamond {
            static let apothemScale: CGFloat = 0.65
            static let scale: CGFloat = 0.55
        }
        struct Squiggle {
            static let scale:CGFloat = 0.75
        }
        struct Oval {
            static let scale: CGFloat = 0.60
            static let apothemScale: CGFloat = 0.45
        }
        struct Card {
            struct One {
                static let first: CGFloat = 0.5
            }
            struct Two {
                private static let spacing: CGFloat = 0.15
                static let first: CGFloat = 0.5 - spacing
                static let second: CGFloat = 0.5 + spacing
            }
            struct Three {
                private static let spacing: CGFloat = 0.28
                static let first: CGFloat = 0.5 - spacing
                static let second: CGFloat = 0.5
                static let third: CGFloat = 0.5 + spacing
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
            CardFace(Card(feature1: .option2, feature2: .option2, feature3: .option2, feature4: .option2, isFaceUp: false)).aspectRatio(2/3, contentMode: .fit)
                .cardify(isFaceUp: true)
                .aspectRatio(2/3, contentMode: .fit)
        }
        HStack {
            CardFace(Card(feature1: .option3, feature2: .option3, feature3: .option3, feature4: .option3, isFaceUp: true)).aspectRatio(2/3, contentMode: .fit)
                .cardify(isFaceUp: true)
                .aspectRatio(2/3, contentMode: .fit)
            CardFace(Card(feature1: .option1, feature2: .option2, feature3: .option3, feature4: .option1, isFaceUp: false)).aspectRatio(2/3, contentMode: .fit)
                .cardify(isFaceUp: true)
                .aspectRatio(2/3, contentMode: .fit)
        }
        HStack {
            CardFace(Card(feature1: .option2, feature2: .option3, feature3: .option1, feature4: .option2, isFaceUp: true)).aspectRatio(2/3, contentMode: .fit)
                .cardify(isFaceUp: true)
                .aspectRatio(2/3, contentMode: .fit)
            CardFace(Card(feature1: .option3, feature2: .option1, feature3: .option2, feature4: .option3, isFaceUp: false)).aspectRatio(2/3, contentMode: .fit)
                .cardify(isFaceUp: true)
                .aspectRatio(2/3, contentMode: .fit)
        }
    }
    .padding()
}
