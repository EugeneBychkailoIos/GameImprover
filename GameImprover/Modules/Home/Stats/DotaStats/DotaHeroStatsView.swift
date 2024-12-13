//
//  DotaHeroStatsView.swift
//  GameImprover
//
//  Created by jekster on 24.10.2024.
//

import SwiftUI

struct HeroStatistic {
    var heroImage: String  
    var heroName: String
    var winOrLose: Bool
    var kills: Int
    var deaths: Int
    var assists: Int
    var duration: Int
}

struct DotaHeroStatsView: View {
    var hero: HeroStatistic

    var body: some View {
        VStack {
            Image(hero.heroImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            Text(hero.heroName)
                .font(.largeTitle)

            Text("Kills: \(hero.kills), Deaths: \(hero.deaths), Assists: \(hero.assists)")
            Text("Duration: \(hero.duration) minutes")
        }
        .padding()
    }
}
