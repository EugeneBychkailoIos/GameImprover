//
//  BounceAnimation.swift
//  GameImprover
//
//  Created by jekster on 09.10.2024.
//

import SwiftUI

struct BounceAnimationView: View {
    let images = ["animation1", "animation2", "animation3", "animation4", "animation5", "animation6", "animation7"]
    
    @State private var currentImageIndex = 0
    @State private var shakeAnimation: [Bool] = Array(repeating: false, count: 7)
    @State private var isReversing = false
    @State private var opacities: [Double] = Array(repeating: 1.0, count: 7)
    
    @State private var isFalling = false
    @State private var flippedImageIndex = 0

    var body: some View {
        ZStack {
            ForEach(0..<images.count, id: \.self) { index in
                Image(images[index])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 164, height: 155)
                    .offset(y: shakeAnimation[index] ? -10 : 0)
                    .opacity(opacities[index])
                    .animation(shakeAnimation[index] ? shakeAnimationEffect : .default, value: shakeAnimation[index])
                    .rotationEffect(isFalling && index == 0 ? .degrees(90) : .degrees(0))
                    .animation(isFalling ? fallingAnimation : .default, value: isFalling)
            }
            
            ForEach(1..<images.count, id: \.self) { index in
                if index <= flippedImageIndex {
                    Image(images[index])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 164, height: 155)
                        .rotationEffect(.degrees(90))
                        .opacity(1)
                        .transition(.scale)
                        .animation(.easeInOut(duration: 0.5), value: flippedImageIndex)
                }
            }
        }
        .onAppear {
            startAnimationSequence()
        }
    }

    var shakeAnimationEffect: Animation {
        Animation.easeInOut(duration: 0.3)
            .repeatCount(3, autoreverses: true)
    }
    
    var fallingAnimation: Animation {
        Animation.easeInOut(duration: 0.5)
            .delay(0.35)
    }

    func triggerShake(for index: Int) {
        shakeAnimation[index] = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            shakeAnimation[index] = false
            moveToNextImage()
        }
    }

    func moveToNextImage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            if isReversing {
                withAnimation {
                    if currentImageIndex >= 0 {
                        opacities[currentImageIndex] = 0
                    }
                }
                currentImageIndex -= 1
                if currentImageIndex < 0 {
                    isReversing = false
                    currentImageIndex = 1
                    opacities[0] = 1
                }
                if currentImageIndex == 0 {
                    print("Stopping animation: only the first image is visible.")
                    isFalling = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        showFlippedImages()
                    }
                    return
                }
            } else {
                currentImageIndex += 1
                if currentImageIndex >= images.count {
                    isReversing = true
                    currentImageIndex = images.count - 1
                }
            }
            triggerShake(for: currentImageIndex)
            if !isReversing {
                withAnimation {
                    opacities[currentImageIndex] = 1
                }
            }
        }
    }

    func showFlippedImages() {
        flippedImageIndex = 0
        for index in 1..<images.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
                withAnimation {
                    flippedImageIndex = index
                }
            }
        }
    }

    func resetAnimation() {
        shakeAnimation = Array(repeating: false, count: images.count)
        currentImageIndex = 0
        opacities = Array(repeating: 1.0, count: images.count)
        isFalling = false
        flippedImageIndex = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            triggerShake(for: currentImageIndex)
        }
    }

    func startAnimationSequence() {
        triggerShake(for: currentImageIndex)
    }
}







//struct BounceAnimationView: View {
//    let numberOfRectangles = 7
//    @State private var currentRectangleIndex = 0
//    @State private var shakeAnimation: [Bool] = Array(repeating: false, count: 7)
//    @State private var isReversing = false
//    @State private var opacities: [Double] = Array(repeating: 1.0, count: 7)
//    
//    @State private var isFalling = false
//    @State private var flippedRectangleIndex = 0
//
//    var body: some View {
//        VStack {
//            ZStack {
//                Color.gray
//                    .ignoresSafeArea()
//                
//                ForEach(0..<numberOfRectangles, id: \.self) { index in
//                    Rectangle()
//                        .fill(Color.blue)
//                        .frame(width: 14, height: 35 + CGFloat(index) * 25)
//                        .offset(x: CGFloat(index) * (14 + 11), y: 35 - CGFloat(index) * 25)
//                        .opacity(opacities[index])
//                        .animation(shakeAnimation[index] ? shakeAnimationEffect : .default, value: shakeAnimation[index])
//                        .rotationEffect(isFalling && index == 0 ? .degrees(90) : .degrees(0))
//                        .animation(isFalling ? fallingAnimation : .default, value: isFalling)
//                }
//                
//                ForEach(1..<numberOfRectangles, id: \.self) { index in
//                    if index <= flippedRectangleIndex {
//                        Rectangle()
//                            .fill(Color.red)
//                            .frame(width: 14, height: 35 + CGFloat(index) * 25)
//                            .rotationEffect(.degrees(90))
//                            .opacity(1)
//                            .transition(.scale)
//                            .animation(.easeInOut(duration: 0.5), value: flippedRectangleIndex)
//                            .offset(x: CGFloat(index) * 25, y: CGFloat(index) * (14 + 11))
//                    }
//                }
//            }
//            .frame(width: 164, height: 155)
//            .onAppear {
//                //            startAnimationSequence()
//            }
//        }
//    }
//
//    var shakeAnimationEffect: Animation {
//        Animation.easeInOut(duration: 0.3)
//            .repeatCount(3, autoreverses: true)
//    }
//    
//    var fallingAnimation: Animation {
//        Animation.easeInOut(duration: 0.5)
//            .delay(0.35)
//    }
//
//    func triggerShake(for index: Int) {
//        shakeAnimation[index] = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//            shakeAnimation[index] = false
//            moveToNextRectangle()
//        }
//    }
//
//    func moveToNextRectangle() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
//            if isReversing {
//                withAnimation {
//                    if currentRectangleIndex >= 0 {
//                        opacities[currentRectangleIndex] = 0
//                    }
//                }
//                currentRectangleIndex -= 1
//                if currentRectangleIndex < 0 {
//                    isReversing = false
//                    currentRectangleIndex = 1
//                    opacities[0] = 1
//                }
//                if currentRectangleIndex == 0 {
//                    print("Stopping animation: only the first rectangle is visible.")
//                    isFalling = true
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                        showFlippedRectangles()
//                    }
//                    return
//                }
//            } else {
//                currentRectangleIndex += 1
//                if currentRectangleIndex >= numberOfRectangles {
//                    isReversing = true
//                    currentRectangleIndex = numberOfRectangles - 1
//                }
//            }
//            triggerShake(for: currentRectangleIndex)
//            if !isReversing {
//                withAnimation {
//                    opacities[currentRectangleIndex] = 1
//                }
//            }
//        }
//    }
//
//    func showFlippedRectangles() {
//        flippedRectangleIndex = 0
//        for index in 1..<numberOfRectangles {
//            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
//                withAnimation {
//                    flippedRectangleIndex = index
//                }
//            }
//        }
//    }
//
//    func resetAnimation() {
//        shakeAnimation = Array(repeating: false, count: numberOfRectangles)
//        currentRectangleIndex = 0
//        opacities = Array(repeating: 1.0, count: numberOfRectangles)
//        isFalling = false
//        flippedRectangleIndex = 0
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            triggerShake(for: currentRectangleIndex)
//        }
//    }
//
//    func startAnimationSequence() {
//        return
//        triggerShake(for: currentRectangleIndex)
//    }
//}
//
//
//



