//
//  OnboardingView.swift
//  GameImprover
//
//  Created by jekster on 04.10.2024.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - PROPERTIES
    
    var onboarding: Onboarding
    
    @State private var isAnimating: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
      ZStack {
        VStack(spacing: 20) {
         Spacer()
         Text(onboarding.title)
                .foregroundColor(Colors.ancestralWater)
            .font(Fonts.jersey10)
            .fontWeight(.heavy)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
         Spacer()
         Image(onboarding.image)
              .resizable()
              .renderingMode(.template)
              .foregroundColor(Colors.ancestralWater)
              .scaledToFit()
              .frame(width: 150 ,height: 150)
              .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
              .scaleEffect(isAnimating ? 1.0 : 0.6)
          Spacer()
          Text(onboarding.headline)
            .foregroundColor(Colors.ancestralWater)
            .font(Fonts.jersey10small)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 25)
            .frame(maxWidth: 480)
          Spacer()
        }
      }
      .onAppear {
        withAnimation(.easeOut(duration: 0.5)) {
          isAnimating = true
        }
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
      .background(LinearGradient(gradient: Gradient(colors: onboarding.gradientColors), startPoint: .top, endPoint: .bottom))
      .ignoresSafeArea()
    }
}


//#Preview {
//    OnboardingView(onboarding: onboardingData[0])
//}



struct OnBoardingView: View {
    // MARK: - PROPERTIES
    
    var onboarding: [Onboarding] = onboardingData
    @State private var currentPage: Int = 0  

    // MARK: - BODY
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(onboarding.indices, id: \.self) { index in
                OnboardingView(onboarding: onboarding[index])
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .overlay(
            BaseButton(title: currentPage < onboarding.count - 1 ? "next" : "get started",
                       backgroundColor: Colors.ancestralWater,
                       textColor: Colors.obsidianShard,
                       width: 284,
                       height: 40,
                       font: Fonts.jersey10small,
                       action: {
                if currentPage < onboarding.count - 1 {
                    currentPage += 1
                } else {
                    withAnimation {
                        UserDefaults.standard.set(false, 
                                                  forKey: "isOnboarding"
                        )
                    }
                }
            })
            
            .padding()
            .padding(.bottom, 50), alignment: .bottom
        )
        .ignoresSafeArea()
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
