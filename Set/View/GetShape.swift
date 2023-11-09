//
//  GetShape.swift
//  Set
//
//  Created by Larry Scherr on 11/7/23.
//

import SwiftUI

struct GetShape: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func getShadedShape(shape: CardShapes, shading: CardShading) -> any View {
        let shape = AnyShape(getShape(shape: shape))
        
        let lineWidth: CGFloat = 3
            return ZStack {
                shape
                    .stroke(lineWidth: lineWidth )
                ZStack {
                    switch shading {
                    case .solid:
                        EmptyView()
                        shape
                            .fill(.white)
                    case .striped:
                        StripeShape()
                            .mask(shape)
                    case .open:
                        shape
                            .fill()
                    }

                }
            }
  
         struct StripeShape: Shape {
            func path(in rect: CGRect) -> Path {

                var path = Path()

                for x in stride(from: Int(rect.minX), to: Int(rect.maxX), by: 10) {
                    let _ = print("x..\(x)")
                    path.move(to: CGPoint(x: CGFloat(x), y: rect.minY))
                    path.addLine(to: CGPoint(x: CGFloat(x), y: rect.maxY))
                    path.addLine(to: CGPoint(x: CGFloat(x+1), y: rect.maxY))
                    path.addLine(to: CGPoint(x: CGFloat(x+1), y: rect.minY))
                    path.addLine(to: CGPoint(x: CGFloat(x), y: rect.minY))
                }
                return path
            }
        }

        
    }
    
    func getShape(shape: CardShapes) -> any Shape {
        switch shape {
        case .diamond:
            return diamond()
        case .squiggle:
            return squiggle()
        case .oval:
            return oval()
        }
    }
    
    
    struct diamond: Shape {
            func path(in rect: CGRect) -> Path {
                let apothem = (min(rect.height, rect.width) / 2 ) * 0.65
                let center = CGPoint(x: rect.midX, y: rect.midY)
                let left = center.x - apothem
                let right = center.x + apothem
                let top = center.y - apothem * 0.5
                let bottom = center.y + apothem * 0.5
                
                var path = Path()
                
                path.move(to: CGPoint(x: left, y: center.y))
                path.addLine(to: CGPoint(x: center.x, y: top))
                path.addLine(to: CGPoint(x: right, y: center.y))
                path.addLine(to: CGPoint(x: center.x, y: bottom))
                path.addLine(to: CGPoint(x: left, y: center.y))
                
                return path
            }
        }


    struct squiggle: Shape {
            func path(in rect: CGRect) -> Path {
                let apothem = (min(rect.height, rect.width) / 2 ) * 0.65
                let center = CGPoint(x: rect.midX, y: rect.midY)
                let left = center.x - apothem
                let right = center.x + apothem
                let top = center.y - apothem * 0.5
                let bottom = center.y + apothem * 0.5
                
                var path = Path()
                
                path.move(to: CGPoint(x: left, y: center.y))
                path.addLine(to: CGPoint(x: center.x, y: top))
                path.addLine(to: CGPoint(x: right, y: center.y))
                path.addLine(to: CGPoint(x: center.x, y: bottom))
                path.addLine(to: CGPoint(x: left, y: center.y))
                
                return path
            }
        }

    
    
    struct oval: Shape {
            func path(in rect: CGRect) -> Path {
                let apothem = (min(rect.height, rect.width) / 2 ) * 0.65
                let center = CGPoint(x: rect.midX, y: rect.midY)
                let left = center.x - apothem
                let right = center.x + apothem
                let top = center.y - apothem * 0.5
                let bottom = center.y + apothem * 0.5
                
                var path = Path()
                
                path.move(to: CGPoint(x: left, y: center.y))
                path.addLine(to: CGPoint(x: center.x, y: top))
                path.addLine(to: CGPoint(x: right, y: center.y))
                path.addLine(to: CGPoint(x: center.x, y: bottom))
                path.addLine(to: CGPoint(x: left, y: center.y))
                
                return path
            }
        }

}

#Preview {
    GetShape()
}
