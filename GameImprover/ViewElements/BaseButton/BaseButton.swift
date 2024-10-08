//
//  BaseButton.swift
//  GameImprover
//
//  Created by jekster on 04.10.2024.
//

import SwiftUI

struct BaseButton: View {
    var title: String?
    var image: Image?
    var backgroundColor: Color?
    var textColor: Color?
    var width: CGFloat
    var height: CGFloat
    var font: Font?
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                // Якщо є зображення, показати його
                if let image = image {
                    image
                }
                // Якщо є текст, показати його
                if let title = title {
                    Text(title)
                        .font(font)
                        .foregroundColor(textColor)
                }
            }
            .frame(width: width, height: height)
            .background(backgroundColor)
            .cornerRadius(5)
        }
    }
}


#Preview {
    BaseButton(title: "example", backgroundColor: Colors.ancestralWater, textColor: Colors.obsidianShard, width: 284, height: 40, font: Fonts.jersey10small, action: {})
}
