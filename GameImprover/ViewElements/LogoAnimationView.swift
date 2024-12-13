//
//  LogoAnimationView.swift
//  GameImprover
//
//  Created by jekster on 09.10.2024.
//

import SwiftUI

//struct LogoAnimationView: View {
//    let numberOfRectangles = 7
//    let spacing: CGFloat = 11
//    @State private var opacities: [Double] = Array(repeating: 1.0, count: 7)
//    @State private var showFlippedRectangles = false
//    @State private var rectangleWidths: [CGFloat] = Array(repeating: 14.0, count: 7)
//    @State private var flippedRectangleWidths: [CGFloat] = Array(repeating: 0.0, count: 7)
//    @State private var isAnimating = true
//
//    var body: some View {
//        ZStack {
//            if isAnimating {
//                HStack(alignment: .bottom) {
//                    ForEach(0..<numberOfRectangles, id: \.self) { index in
//                        Rectangle()
//                            .fill(Colors.ancestralWater)
//                            .frame(width: rectangleWidths[index],
//                                   height: 35 + CGFloat(index) * 25
//                            )
//                            .opacity(index == 0 ? 1.0 : (showFlippedRectangles ? 0.0 : opacities[index]))
//                            .rotationEffect(index == 0 && showFlippedRectangles ? .degrees(90) : .degrees(0))
//                    }
//                }
//
//                VStack(alignment: .leading, spacing: spacing) {
//                    if showFlippedRectangles {
//                        Rectangle()
//                            .fill(Colors.ancestralWater)
//                            .frame(width: flippedRectangleWidths[0],
//                                   height: 14
//                            )
//                            .opacity(1.0)
//
//                        ForEach(1..<numberOfRectangles, id: \.self) { index in
//                            Rectangle()
//                                .fill(Colors.ancestralWater)
//                                .frame(width: flippedRectangleWidths[index],
//                                       height: 14
//                                )
//                                .opacity(opacities[index])
//                                .transition(.scale)
//                        }
//                    }
//                }
//                .offset(x: 10, y: 35 + CGFloat(numberOfRectangles - 1) * 19.15)
//            }
//        }
//        .onAppear {
//            startAnimationSequence()
//        }
//    }
//
//    func startAnimationSequence() {
//        for index in 0..<numberOfRectangles {
//            opacities[index] = 1.0
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            for index in (1..<numberOfRectangles).reversed() {
//                withAnimation(.easeOut(duration: 0.5)
//                    .delay(Double(numberOfRectangles - index) * 0.5)) {
//                    opacities[index] = 0.0
//                }
//            }
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + Double(numberOfRectangles) * 0.5 + 1.0) {
//                withAnimation(.easeIn(duration: 0.5)) {
//                    showFlippedRectangles = true
//                }
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    animateFlippedRectangles()
//                }
//            }
//        }
//    }
//
//    func animateFlippedRectangles() {
//        for index in 1..<numberOfRectangles {
//            withAnimation(.easeIn(duration: 0.5)
//                .delay(Double(index - 1) * 0.5)) {
//                opacities[index] = 1.0
//                flippedRectangleWidths[index] = 35 + CGFloat(index) * 25
//                
//            }
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + Double(numberOfRectangles) * 0.5 + 1.5) {
//            let targetWidth: CGFloat = 35 + CGFloat(numberOfRectangles - 1) * 25
//            
//            for index in 1..<numberOfRectangles {
//                withAnimation(.easeInOut(duration: 0.5)
//                    .delay(Double(index - 1) * 0.1)) {
//                    flippedRectangleWidths[index] = targetWidth
//                }
//            }
//
//            withAnimation(.easeOut(duration: 0.5).delay(0.5)) {
//                flippedRectangleWidths[0] = 0.0
//            }
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                withAnimation(.easeOut(duration: 1.0)) {
//                    isAnimating = false
//                }
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                    resetAnimation()
//                }
//            }
//        }
//    }
//
//    func resetAnimation() {
//        showFlippedRectangles = false
//        opacities = Array(repeating: 1.0, count: numberOfRectangles)
//        flippedRectangleWidths = Array(repeating: 0.0, count: numberOfRectangles)
//        isAnimating = true
//        startAnimationSequence()
//    }
//}



//import SwiftUI
//
//struct LogoAnimationView: View {
//    let numberOfRectangles = 7
//    let spacing: CGFloat = 11
//    @State private var opacities: [Double] = Array(repeating: 1.0, count: 7)
//    @State private var showFlippedRectangles = false
//    @State private var rectangleWidths: [CGFloat] = Array(repeating: 14.0, count: 7)
//    @State private var flippedRectangleWidths: [CGFloat] = Array(repeating: 0.0, count: 7)
//    @State private var isAnimating = true
//
//    var body: some View {
//        ZStack {
//            if isAnimating {
//                HStack(alignment: .bottom) {
//                    ForEach(0..<numberOfRectangles, id: \.self) { index in
//                        Rectangle()
//                            .fill(Colors.ancestralWater)
//                            .frame(width: rectangleWidths[index],
//                                   height: 35 + CGFloat(index) * 25
//                            )
//                            .opacity(index == 0 ? 1.0 : (showFlippedRectangles ? 0.0 : opacities[index]))
//                            .rotationEffect(index == 0 && showFlippedRectangles ? .degrees(90) : .degrees(0))
//                    }
//                }
//
//                VStack(alignment: .leading, spacing: spacing) {
//                    if showFlippedRectangles {
//                        Rectangle()
//                            .fill(Colors.ancestralWater)
//                            .frame(width: flippedRectangleWidths[0],
//                                   height: 14
//                            )
//                            .opacity(1.0)
//
//                        ForEach(1..<numberOfRectangles, id: \.self) { index in
//                            Rectangle()
//                                .fill(Colors.ancestralWater)
//                                .frame(width: flippedRectangleWidths[index],
//                                       height: 14
//                                )
//                                .opacity(opacities[index])
//                                .transition(.scale)
//                        }
//                    }
//                }
//                .offset(x: 10, y: 35 + CGFloat(numberOfRectangles - 1) * 19.15)
//            }
//        }
//        .onAppear {
//            startAnimationSequence()
//        }
//    }
//
//    func startAnimationSequence() {
//        for index in 0..<numberOfRectangles {
//            opacities[index] = 1.0
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            for index in (1..<numberOfRectangles).reversed() {
//                withAnimation(.easeOut(duration: 0.5)
//                    .delay(Double(numberOfRectangles - index) * 0.5)) {
//                    opacities[index] = 0.0
//                }
//            }
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + Double(numberOfRectangles) * 0.5 + 1.0) {
//                withAnimation(.easeIn(duration: 0.5)) {
//                    showFlippedRectangles = true
//                }
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    animateFlippedRectangles()
//                }
//            }
//        }
//    }
//
//    func animateFlippedRectangles() {
//        for index in 1..<numberOfRectangles {
//            withAnimation(.easeIn(duration: 0.5)
//                .delay(Double(index - 1) * 0.5)) {
//                opacities[index] = 1.0
//                flippedRectangleWidths[index] = 35 + CGFloat(index) * 25
//            }
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + Double(numberOfRectangles) * 0.5 + 1.5) {
//            let targetWidth: CGFloat = 35 + CGFloat(numberOfRectangles - 1) * 25
//            
//            for index in 0..<numberOfRectangles {
//                withAnimation(.easeInOut(duration: 0.5)
//                    .delay(Double(index - 1) * 0.1)) {
//                    flippedRectangleWidths[index] = targetWidth
//                        
//                }
//            }
//
//          
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                withAnimation(.easeOut(duration: 0.5)) {
//                    flippedRectangleWidths[0] = 0.0
//                }
//            }
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                withAnimation(.easeOut(duration: 1.0)) {
//                    isAnimating = false
//                }
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                    resetAnimation()
//                }
//            }
//        }
//    }
//
//    func resetAnimation() {
//        showFlippedRectangles = false
//        opacities = Array(repeating: 1.0, count: numberOfRectangles)
//        flippedRectangleWidths = Array(repeating: 0.0, count: numberOfRectangles)
//        isAnimating = true
//        startAnimationSequence()
//    }
//}



import SwiftUI

struct LogoAnimationView: View {
    let numberOfRectangles = 7
    let spacing: CGFloat = 11
    @State private var opacities: [Double] = Array(repeating: 1.0, count: 7)
    @State private var showFlippedRectangles = false
    @State private var rectangleWidths: [CGFloat] = Array(repeating: 14.0, count: 7)
    @State private var flippedRectangleWidths: [CGFloat] = Array(repeating: 0.0, count: 7)
    @State private var isAnimating = true

    var body: some View {
        ZStack {
            if isAnimating {
                HStack(alignment: .bottom) {
                    ForEach(0..<numberOfRectangles, id: \.self) { index in
                        Rectangle()
                            .fill(Colors.ancestralWater)
                            .frame(width: rectangleWidths[index],
                                   height: 35 + CGFloat(index) * 25
                            )
                            .opacity(index == 0 ? 1.0 : (showFlippedRectangles ? 0.0 : opacities[index]))
                            .rotationEffect(index == 0 && showFlippedRectangles ? .degrees(90) : .degrees(0))
                    }
                }

                VStack(alignment: .leading, spacing: spacing) {
                    if showFlippedRectangles {
                        Rectangle()
                            .fill(Colors.ancestralWater)
                            .frame(width: flippedRectangleWidths[0],
                                   height: 14
                            )
                            .opacity(1.0)

                        ForEach(1..<numberOfRectangles, id: \.self) { index in
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
                .offset(x: 10, y: 35 + CGFloat(numberOfRectangles - 1) * 19.15)
            }
        }
        .onAppear {
            startAnimationSequence()
        }
    }

    func startAnimationSequence() {
        for index in 0..<numberOfRectangles {
            opacities[index] = 1.0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            for index in (1..<numberOfRectangles).reversed() {
                withAnimation(.easeOut(duration: 0.5)
                    .delay(Double(numberOfRectangles - index) * 0.5)) {
                    opacities[index] = 0.0
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + Double(numberOfRectangles) * 0.5 + 1.0) {
                withAnimation(.easeIn(duration: 0.5)) {
                    showFlippedRectangles = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    animateFlippedRectangles()
                }
            }
        }
    }

    func animateFlippedRectangles() {
        for index in 1..<numberOfRectangles {
            withAnimation(.easeIn(duration: 0.5)
                .delay(Double(index - 1) * 0.5)) {
                opacities[index] = 1.0
                flippedRectangleWidths[index] = 35 + CGFloat(index) * 25
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + Double(numberOfRectangles) * 0.5 + 1.5) {
            let targetWidth: CGFloat = 35 + CGFloat(numberOfRectangles - 1) * 25
            
            for index in 0..<numberOfRectangles {
                withAnimation(.easeInOut(duration: 0.5)
                    .delay(Double(index - 1) * 0.1)) {
                    flippedRectangleWidths[index] = targetWidth
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 1.0)) {
                    isAnimating = false
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    resetAnimation()
                }
            }
        }
    }

    func resetAnimation() {
        showFlippedRectangles = false
        opacities = Array(repeating: 1.0, count: numberOfRectangles)
        flippedRectangleWidths = Array(repeating: 0.0, count: numberOfRectangles)
        isAnimating = true
        startAnimationSequence()
    }
}
