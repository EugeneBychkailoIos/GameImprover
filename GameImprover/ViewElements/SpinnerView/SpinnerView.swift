//
//  SpinnerView.swift
//  GameImprover
//
//  Created by jekster on 10.10.2024.
//

import SwiftUI

struct CustomSpinnerView: View {
    @State private var rotation: Double = 0
    
    private let spinnerColor = Colors.ancestralWater
    private let backgroundColor = Colors.obsidianShard.opacity(0.6)
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(spinnerColor.opacity(0.3))
                .frame(width: 60, height: 60)
            
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(style: StrokeStyle(lineWidth: 5,
                                           lineCap: .round,
                                           lineJoin: .round))
                .foregroundColor(spinnerColor)
                .rotationEffect(Angle(degrees: rotation))
                .frame(width: 60, height: 60)
                .animation(Animation
                    .linear(duration: 1.5)
                    .repeatForever(autoreverses: false),
                           value: rotation
                )
        }
        .onAppear {
            rotation = 360
        }
    }
}
