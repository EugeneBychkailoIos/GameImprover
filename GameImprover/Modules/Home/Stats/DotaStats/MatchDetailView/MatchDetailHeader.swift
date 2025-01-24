//
//  MatchDetailHeader.swift
//  GameImprover
//
//  Created by jekster on 13.12.2024.
//

import SwiftUI

struct DotaStatisticHeaderView: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                BaseText(text: "Hero", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                    .frame(width: 190, alignment: .leading)
                    .padding(.leading, 16)
                    .background(Color.red)
                
                BaseText(text: "Nickname", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                    .frame(width: 150, alignment: .leading)
                    .background(Color.blue)
                
                BaseText(text: "KDA", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                    .frame(width: 150, alignment: .leading)
                    .background(Color.green)
                
                BaseText(text: "LH/DN", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                    .frame(width: 150, alignment: .leading)
                    .background(Color.yellow)
                
                BaseText(text: "XPM", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                    .frame(width: 100, alignment: .leading)
                    .background(Color.brown)
                
                BaseText(text: "GPM", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                    .frame(width: 100, alignment: .leading)
                    .background(Color.pink)

                BaseText(text: "Items", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                    .frame(width: 460, alignment: .leading)
                    .background(Color.gray)
                
                BaseText(text: "Neutrals", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                    .frame(width: 100, alignment: .leading)
                    .background(Color.orange)
                
                BaseText(text: "Backpack", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                    .frame(width: 310, alignment: .leading)
                    .background(Color.cyan)
                
                BaseText(text: "Bufs", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                    .frame(width: 120, alignment: .leading)
                    .background(Color.indigo)
                
                Spacer()
            }
            .background(Color.mint)
        }
    }
}
