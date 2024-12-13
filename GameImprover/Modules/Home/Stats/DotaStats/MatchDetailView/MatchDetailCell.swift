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
                
            }
                        else {
                            Image("placeholder")
                                .resizable()
                                .frame(width: 25, height: 20)
                        }
            
            if let heroData = heroesService.getHeroData(for: player.heroID) {
                BaseText(text: heroData.heroName, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                    .frame(width: 150, alignment: .leading)
                    .padding(.leading, 16)
            } else {
                BaseText(text: "unknown", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                    .frame(width: 150, alignment: .leading)
                    .padding(.leading, 16)
            }
            BaseText(text: player.personaname ?? "Unknown player", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                .frame(width: 150, alignment: .leading)
            BaseText(text: "\(player.kills)/\(player.deaths)/\(player.assists)", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                .frame(width: 100, alignment: .leading)
            BaseText(text: "\(player.lastHits)/\(player.denies)", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                .frame(width: 100, alignment: .leading)
            BaseText(text: "\(player.goldPerMin)", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                .frame(width: 100, alignment: .leading)
            BaseText(text: "\(player.xpPerMin)", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                .frame(width: 100, alignment: .leading)
            
            HStack {
                
            }
            
            
    }
        .padding()
        .background(Colors.obsidianShard)
        .onAppear {
            Task {
                await heroesService.downloadHeroData(heroID: player.heroID)
            }
        }
    }
}
