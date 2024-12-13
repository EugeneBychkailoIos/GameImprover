//
//  DotaItemView.swift
//  GameImprover
//
//  Created by jekster on 12.12.2024.
//

import SwiftUI


struct DotaItemView: View {
    
    var itemImage: Image?
    var itemName: String
    
    var body: some View {
        VStack {
            if itemImage != nil {
                if let image = itemImage {
                    image
                        .resizable()
                        .frame(width: 30 , height: 20)
                    
                    BaseText(text: itemName,
                             font: Fonts.jersey10small,
                             foregroundColor: Colors.ancestralWater
                    )
                }
            } else {
                Image("EmptyItem")
                    .resizable()
                    .frame(width: 30 , height: 20)
            }
        }
    }
}
