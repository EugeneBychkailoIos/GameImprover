//
//  KDAView.swift
//  GameImprover
//
//  Created by jekster on 22.10.2024.
//

import SwiftUI

struct KDAView: View {
    var kda: KDA
    let barWidth: CGFloat = 100

    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(Colors.indiaGreen)
                .frame(width: barWidth * kda.killsPercentage)
            
            Rectangle()
                .fill(Colors.artfulRed)
                .frame(width: barWidth * kda.deathsPercentage)
            
            Rectangle()
                .fill(Colors.ancestralWater)
                .frame(width: barWidth * kda.assistsPercentage)
        }
        .frame(width: barWidth, height: 5)
        .cornerRadius(5)
    }
}
