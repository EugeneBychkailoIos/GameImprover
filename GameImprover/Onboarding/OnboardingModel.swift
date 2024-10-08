//
//  OnboardingModel.swift
//  GameImprover
//
//  Created by jekster on 04.10.2024.
//

import SwiftUI

struct Onboarding: Identifiable {
  var id = UUID()
  var title: String
  var headline: String
  var image: String
  var gradientColors: [Color]
}
