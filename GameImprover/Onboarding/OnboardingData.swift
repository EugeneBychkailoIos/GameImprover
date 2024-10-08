//
//  OnboardingData.swift
//  GameImprover
//
//  Created by jekster on 04.10.2024.
//

import Foundation
import SwiftUI

// MARK: - Onboarding data

// Note - now its mocked, but it should came from firebase.
let onboardingData: [Onboarding] = [
    Onboarding(
      title: "Track stats",
      headline: "Track your game statistic for grow your game level",
      image: "onboarding1",
      gradientColors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]
    ),
    Onboarding(
      title: "Share achievments",
      headline: "Show off your achievements to your friends",
      image: "onboarding3",
      gradientColors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]
    ),
    Onboarding(
      title: "Complete chalanges",
      headline: "Complete daily and monthly chalanges for unlock more functions.",
      image: "onboarding2",
      gradientColors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]
    ),
    Onboarding(
      title: "Improve game",
      headline: "Make game better for you and your teammates.",
      image: "onboarding4",
      gradientColors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]
    )
]
