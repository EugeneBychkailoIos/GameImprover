//
//  MatchDetailCell.swift
//  GameImprover
//
//  Created by jekster on 13.12.2024.
//

import Foundation
import SwiftUI

struct MatchDetailCell: View {
    @ObservedObject var heroesService: HeroesService
    
    var player: MatchDetailPlayer

    var body: some View {
        HStack(spacing: 0) {
            if let heroData = heroesService.getHeroData(for: player.heroID) {
                heroData.image
                    .resizable()
                    .frame(width: 35, height: 25)
            } else {
                Image("placeholder")
                    .resizable()
                    .frame(width: 25, height: 20)
            }
            
            if let heroData = heroesService.getHeroData(for: player.heroID) {
                           BaseText(text: heroData.heroName, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                                .frame(width: 150, alignment: .leading)                   .padding(.leading, 16)
            } else {
                BaseText(text: "unknown", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                    .frame(width: 150, alignment: .leading)
                    .padding(.leading, 16)
            }
            
            BaseText(text: player.personaname ?? "Unknown player", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                .frame(width: 150 , alignment: .leading)
                .padding(.trailing, 16)
            
            BaseText(text: "\(player.kills)/\(player.deaths)/\(player.assists)", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                .frame(width: 150, alignment: .leading)
            
            BaseText(text: "\(player.lastHits)/\(player.denies)", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                .frame(width: 150, alignment: .leading)
            
            BaseText(text: "\(player.goldPerMin)", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                .frame(width: 100, alignment: .leading)
            
            BaseText(text: "\(player.xpPerMin)", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                .frame(width: 100, alignment: .leading)
            
            HStack {
                ItemCellView(image: player.item0)
                    .frame(alignment: .leading)
                ItemCellView(image: player.item1)
                    .frame(alignment: .leading)
                ItemCellView(image: player.item2)
                    .frame(alignment: .leading)
                ItemCellView(image: player.item3)
                    .frame(alignment: .leading)
                ItemCellView(image: player.item4)
                    .frame(alignment: .leading)
                ItemCellView(image: player.item5)
                    .frame(alignment: .leading)
            }
            .frame(width: 360, alignment: .leading)
            .padding(.leading, 50)
            
            HStack {
                ItemCellView(image: player.itemNeutral)
                    .frame(alignment: .leading)
                
            }
            .frame(width: 60, alignment: .leading)
            .padding(.leading, 100)
            
            HStack {
                ItemCellView(image: player.backpack0)
                    .frame(alignment: .leading)
                ItemCellView(image: player.backpack1)
                    .frame(alignment: .leading)
                ItemCellView(image: player.backpack2)
                    .frame(alignment: .leading)
            }
            .frame(width: 180, alignment: .leading)
            .padding(.leading, 50)
            
            HStack {
                ItemCellView(image: player.aghanimsShard)
                    .frame(alignment: .leading)
                ItemCellView(image: player.aghanimsScepter)
                    .frame(alignment: .leading)
            }
            .frame(width: 120, alignment: .leading)
            .padding(.leading, 50)
            
        }
        .padding()
        .background(Colors.obsidianShard)
        .onAppear {
            Task {
                await heroesService.downloadHeroData(heroID: player.heroID)
            }
            
            print("*********************************************************************************")
            print("PLAYER ID: \(player.heroID)")
            print("PLAYER ITEMS AND NEUTRAL: \(player.item0), \(player.item1), \(player.item2), \(player.item3), \(player.item4), \(player.item5), \(player.itemNeutral)")
            
            print("PLAYER BACKPACK: \(player.backpack0), \(player.backpack1), \(player.backpack2),")
            
            print("PLAYER AGHANIM SHARD AND SCEPTER: \(player.aghanimsShard), \(player.aghanimsScepter)")
            print("*********************************************************************************")
        }
    }
}


struct ItemCellView: View {
    
    var image: Int?
    
    var body: some View {
        
        HStack {
            if let image = image {
//                image
//                    .resizable()
//                    .frame(width: 55, height: 35)
                Text("\(image)")
                    .foregroundColor(Colors.ancestralWater)
                    .frame(width: 55, height: 35)
            } else {
                EmptyView()
            }
        }
        .frame(width: 60, height: 40)
    }
    
}
