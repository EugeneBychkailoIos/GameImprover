//
//  MapStatisticView.swift
//  GameImprover
//
//  Created by jekster on 22.10.2024.
//

import SwiftUI

struct MapStatisticView: View {
    var heroID: Int
    var heroName: String
    var winOrLose: Bool
    var kills: Int
    var deaths: Int
    var assists: Int
    var duration: Int
    var heroImage: Image
    
    @StateObject private var heroesService = HeroesService()
    
    var formattedDuration: String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        let seconds = duration % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                heroImage
                    .resizable()
                    .frame(width: 55, height: 45)
                    .cornerRadius(5)
//                    .background(Color.blue)
                
                Text(heroName)
                    .font(Fonts.jersey10small)
                    .foregroundColor(Colors.ancestralWater)
                    .frame(width: 100, alignment: .leading)
//                    .background(Color.red)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(Color.mint)
                    
                    Text(winOrLose ? WinCondition.win.rawValue : WinCondition.lose.rawValue)
                        .font(Fonts.jersey10small)
                        .foregroundColor(winOrLose ? Colors.indiaGreen : Colors.artfulRed)
                        .frame(width: 60, alignment: .leading)
//                        .background(Color.green)
            
                VStack(alignment: .leading) {
                    Text(formattedDuration)
                        .font(Fonts.jersey10small)
                        .foregroundColor(Colors.ancestralWater)
                        .padding(.trailing, 12)
                        .frame(width: 80, alignment: .leading)
                    
                    MapTimeline(duration: duration)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
//                .background(Color.yellow)
            
            VStack(alignment: .leading) {
                Text("\(kills)/\(deaths)/\(assists)")
                    .font(Fonts.jersey10small)
                    .foregroundColor(Colors.ancestralWater)
                    .padding(.trailing, 12)
                    .frame(width: 80, alignment: .leading)
                
                KDAView(kda: KDA(kills: kills, deaths: deaths, assists: assists))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(Color.orange)
        }
//        .background(Color.purple)
        .padding()
    }
}
