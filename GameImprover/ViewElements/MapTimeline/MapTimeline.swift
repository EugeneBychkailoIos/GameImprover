//
//  MapTimeline.swift
//  GameImprover
//
//  Created by jekster on 22.10.2024.
//

//import SwiftUI
//
//struct MapTimeline: View {
//    var duration: Int
//    @State private var timelineWidth: CGFloat = 0
//
//    var body: some View {
//        GeometryReader { geometry in
//            
//            ZStack(alignment: .leading) {
//                Rectangle()
//                    .fill(Colors.ancestralWater.opacity(0.7))
//                    .frame(height: 5)
//                    .cornerRadius(5)
//                
//                Rectangle()
//                    .fill(Colors.ancestralWater)
//                    .frame(width: timelineWidth, height: 5)
//                    .cornerRadius(5)
//            }
//            .onAppear {
//                let maxWidth = geometry.size.width
//                timelineWidth = duration >= 55 ? maxWidth : maxWidth * (CGFloat(duration) / 55.0)
//            }
//        }
//        .frame(height: 5)
//    }
//}


import SwiftUI

struct MapTimeline: View {
    var duration: Int
    @State private var timelineWidth: CGFloat = 0
    @State private var timelineColor: Color = Colors.ancestralWater

    var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(timelineColor.opacity(0.7))
                    .frame(height: 5)
                    .cornerRadius(5)
                
                Rectangle()
                    .fill(timelineColor)
                    .frame(width: timelineWidth, height: 5)
                    .cornerRadius(5)
            }
            .onAppear {
                let maxWidth = geometry.size.width
                
                if duration >= 3600 {
                    timelineWidth = maxWidth
                    timelineColor = Colors.ancestralWater
                } else {
                    timelineWidth = maxWidth * (CGFloat(duration) / 3600.0)
                    timelineColor = Colors.ancestralWater.opacity(0.6)
                }
            }
        }
        .frame(height: 5)
    }
}
