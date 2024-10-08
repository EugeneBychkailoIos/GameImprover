//
//  BaseText.swift
//  GameImprover
//
//  Created by jekster on 08.10.2024.
//

import SwiftUI

struct BaseText: View {
    var text: String
    var font: Font
    var foregroundColor: Color
    
    var body: some View {
        Text(text)
            .foregroundColor(foregroundColor)
            .font(font)
    }
    
}
