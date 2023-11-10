//
//  JunkDelete.swift
//  Set
//
//  Created by Larry Scherr on 11/7/23.
//

import SwiftUI

struct JunkDelete: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
    JunkDelete()
}
