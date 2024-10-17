//
//  LogoAnimationView.swift
//  GameImprover
//
//  Created by jekster on 09.10.2024.
//

import SwiftUI

struct LogoAnimationView: View {
    let numberOfRectangles = 7
    @State private var opacities: [Double] = Array(repeating: 0.0, count: 7)
    @State private var flippedRectangleIndex = -1
    @State private var showFlippedRectangles = false
    @State private var isAnimating = false
    @State private var rectangleWidths: [CGFloat] = Array(repeating: 14.0, count: 7)
    @State private var flippedRectangleWidths: [CGFloat] = Array(repeating: 0.0, count: 7)
    
    var body: some View {
        ZStack {
            if !showFlippedRectangles {
                HStack(alignment: .bottom) {
                    ForEach(0..<numberOfRectangles, id: \.self) { index in
                        Rectangle()
                            .fill(Colors.ancestralWater)
                            .frame(width: rectangleWidths[index],
                                   height: 35 + CGFloat(index) * 25
                            )
                            .opacity(opacities[index])
                            .rotationEffect(isAnimating ?
                                .degrees(90) :
                                    .degrees(0)
                            )
                    }
                }
            } else {
                VStack(alignment: .leading,
                       spacing: 11
                ) {
                    ForEach(0..<numberOfRectangles, id: \.self) { index in
                        if index <= flippedRectangleIndex {
                            Rectangle()
                                .fill(Colors.ancestralWater)
                                .frame(width: flippedRectangleWidths[index],
                                       height: 14
                                )
                                .opacity(opacities[index])
                                .transition(.scale)
                        }
                    }
                }
            }
        }
        .frame(width: 164, height: 164)
        .onAppear {
            startAnimationSequence()
        }
    }
    
    func startAnimationSequence() {
        for index in 0..<numberOfRectangles {
            opacities[index] = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            for index in (0..<numberOfRectangles).reversed() {
                withAnimation(.easeOut(duration: 0.5)
                    .delay(Double(numberOfRectangles - index) * 0.5)) {
                        opacities[index] = 0.0
                    }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(numberOfRectangles) * 0.5 + 1.0) {
                withAnimation(.easeIn(duration: 0.5)) {
                    opacities[0] = 1.0
                    isAnimating = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        flippedRectangleIndex = numberOfRectangles - 1
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showFlippedRectangles = true
                        animateFlippedRectangles()
                    }
                }
            }
        }
    }
    
    func animateFlippedRectangles() {
        for index in 0..<numberOfRectangles {
            withAnimation(.easeIn(duration: 0.5)
                .delay(Double(index) * 0.5)) {
                    opacities[index] = 1.0
                    flippedRectangleWidths[index] = 35 + CGFloat(index) * 25
                }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(numberOfRectangles) * 0.5 + 1.5) {
            let targetWidth: CGFloat = 35 + CGFloat(numberOfRectangles - 1) * 25
            
            for index in 0..<numberOfRectangles {
                if index <= flippedRectangleIndex {
                    withAnimation(.easeInOut(duration: 0.5).delay(Double(index) * 0.1)) {
                        flippedRectangleWidths[index] = targetWidth
                    }
                }
            }
        }
    }
}
