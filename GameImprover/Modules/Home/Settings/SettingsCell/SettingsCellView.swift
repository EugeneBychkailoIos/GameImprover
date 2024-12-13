//
//  SettingsCellView.swift
//  GameImprover
//
//  Created by jekster on 25.10.2024.
//

import SwiftUI

struct SettingsCellView: View {
    var title: String

    var body: some View {
        VStack {
            BaseText(text: title,
                     font: Fonts.jersey25,
                     foregroundColor: Colors.obsidianShard
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colors.ancestralWater)
    }
}
