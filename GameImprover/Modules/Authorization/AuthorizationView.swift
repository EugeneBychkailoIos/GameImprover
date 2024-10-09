//
//  AuthorizationView.swift
//  GameImprover
//
//  Created by jekster on 04.10.2024.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct AuthorizationView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()
                    BounceAnimationView()
                    Spacer()
                    NavigationLink(destination: SignInView()) {
                        Text("Sign In")
                            .frame(width: 284, height: 40)
                            .background(Colors.ancestralWater)
                            .foregroundColor(Colors.obsidianShard)
                            .cornerRadius(5)
                            .font(Fonts.jersey10small)
                    }
                    .padding(.bottom, 24)
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .frame(width: 284, height: 40)
                            .background(Colors.ancestralWater)
                            .foregroundColor(Colors.obsidianShard)
                            .cornerRadius(5)
                            .font(Fonts.jersey10small)
                    }
                    .padding(.bottom, 32)
                }
            }
        }
    }
}
