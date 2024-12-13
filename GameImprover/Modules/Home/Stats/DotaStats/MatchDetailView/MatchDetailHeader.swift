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
                BaseText(text: "Hero",
                         font: Fonts.jersey10small,
                         foregroundColor: Colors.ancestralWater
                )
                    .frame(width: 150, alignment: .leading)
                BaseText(text: "Nickname",
                         font: Fonts.jersey10small,
                         foregroundColor: Colors.ancestralWater
                )
                    .frame(width: 150, alignment: .leading)
                BaseText(text: "KDA",
                         font: Fonts.jersey10small,
                         foregroundColor: Colors.ancestralWater
                )
                    .frame(width: 100, alignment: .leading)
                BaseText(text: "LH/DN",
                         font: Fonts.jersey10small,
                         foregroundColor: Colors.ancestralWater
                )
                    .frame(width: 100, alignment: .leading)
                BaseText(text: "XPM",
                         font: Fonts.jersey10small,
                         foregroundColor: Colors.ancestralWater
                )
                    .frame(width: 100, alignment: .leading)
                BaseText(text: "GPM",
                         font: Fonts.jersey10small,
                         foregroundColor: Colors.ancestralWater
                )
                    .frame(width: 100, alignment: .leading)
            }
        }
    }
}
