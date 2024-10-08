//
//  AuthorizationView.swift
//  GameImprover
//
//  Created by jekster on 04.10.2024.
//

//import SwiftUI
//import FirebaseAuth
//import Firebase
//
//struct AuthorizationView: View {
//    var body: some View {
//        ZStack {
//        LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]),
//        startPoint: .top,
//        endPoint: .bottom)
//        .edgesIgnoringSafeArea(.all)
//
//                VStack {
//                    Spacer()
//                    
//                    BaseText(text:"Do you have Game Improver account?", font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
//                        .padding([.leading, .trailing], 24)
//                        .padding(.bottom, 32)
//                    
//                    BaseText(text:"If u have - sign in, if not authorize with steam and continue sign up!", font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
//                        .padding([.leading, .trailing], 32)
//                    
//                    Spacer()
//                    
//                    BaseButton(title: "sign in", backgroundColor: Colors.ancestralWater, textColor:Colors.obsidianShard, width: 284, height: 40, font: Fonts.jersey10small  ) {
//                        print("sign in")
//                    }
//                    .padding(.bottom, 32)
//                    
//                    BaseButton(title: "sign up", backgroundColor: Colors.ancestralWater, textColor:Colors.obsidianShard, width: 284, height: 40, font: Fonts.jersey10small  ) {
//                        print("sign up")
//                    }
//                    .padding(.bottom, 32)
//                }
//            }
//    }
//}

//#Preview {
//    AuthorizationView()
//}






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
                    
                    BaseText(text: "Do you have Game Improver account?", font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
                        .padding([.leading, .trailing], 24)
                        .padding(.bottom, 32)
                    
                    BaseText(text: "If you have - sign in, if not authorize with Steam and continue sign up!", font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
                        .padding([.leading, .trailing], 32)
                    
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
