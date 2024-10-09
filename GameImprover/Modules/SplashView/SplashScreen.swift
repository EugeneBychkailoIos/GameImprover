//
//  SplashScreen.swift
//  GameImprover
//
//  Created by jekster on 04.10.2024.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var isOnboarding: Bool
    @State private var isActive = false
    @State private var index = 0
    @State private var opacityValues: [Double] = Array(repeating: 0.0, count: 7)
    @State private var showText = false
    @State private var textOpacity = 0.0
    
    private let images = (1...7).map { Image("animation\($0)") }
    
    var body: some View {
        if isActive {
            if isOnboarding {
                OnBoardingView()
            } else {
                AuthorizationView()
            }
        } else {
            ZStack {
                Colors.obsidianShard
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    Spacer()
                    ZStack {
                        ForEach(0..<images.count, id: \.self) { i in
                            images[i]
                                .opacity(opacityValues[i])
                                .animation(.easeInOut(duration: 1.0), value: opacityValues[i])
                        }
                    }
                    .frame(width: 164, height: 155)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            startAnimation()
                        }
                    }
                    if showText {
                        Text("Game Improver")
                            .font(Fonts.jersey25)
                            .foregroundColor(Colors.ancestralWater)
                            .padding(.top, 14)
                            .opacity(textOpacity)
                            .animation(.easeInOut(duration: 1.0), value: textOpacity)
                    } else {
                        Color.clear
                            .frame(height: 40)
                    }
                    Spacer(minLength: 30)
                }
                .frame(maxHeight: .infinity)
            }
        }
    }
    
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            if self.index < self.images.count {
                self.opacityValues[self.index] = 1.0
                self.index += 1
            } else {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    self.showText = true
                    withAnimation {
                        self.textOpacity = 1.0
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen(isOnboarding: .constant(true))
}
