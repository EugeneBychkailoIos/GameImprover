//
//  SignUpView.swift
//  GameImprover
//
//  Created by jekster on 10.10.2024.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = SignUpViewModel()
    
    @State private var loginTextfieldText = ""
    @State private var passwordTextfieldText = ""
    @State private var confirmPasswordTextfieldText = ""
    @State private var signUpError: String?
    
    var steamId: String
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                CustomTextField(
                    text: "email",
                    font: Fonts.jersey25,
                    color: Color.gray,
                    titleTextField: "email",
                    validationRules: [],
                    textfieldText: $loginTextfieldText
                )
                .padding(.bottom, 15)
                .padding(.top, 15)
                
                CustomTextField(
                    text: "password",
                    font: Fonts.jersey25,
                    color: Color.gray,
                    titleTextField: "password",
                    validationRules: [],
                    textfieldText: $passwordTextfieldText
                )
                .padding(.bottom, 15)
                .padding(.top, 15)
                
                CustomTextField(
                    text: "confirm password",
                    font: Fonts.jersey25,
                    color: Color.gray,
                    titleTextField: "confirm password",
                    validationRules: [],
                    textfieldText: $confirmPasswordTextfieldText
                )
                .padding(.bottom, 15)
                .padding(.top, 15)
                
                BaseButton(title: "continue", backgroundColor: Colors.ancestralWater, textColor: Colors.obsidianShard, width: 284, height: 40, font: Fonts.jersey10small) {
                    if viewModel.validateInputs(email: loginTextfieldText, password: passwordTextfieldText, confirmPassword: confirmPasswordTextfieldText) {
                        viewModel.createUser(email: loginTextfieldText, password: passwordTextfieldText, steamId: steamId) { result in
                            switch result {
                            case .success:
                                print("User created successfully!")
                            case .failure(let error):
                                signUpError = error.localizedDescription
                            }
                        }
                    } else {
                        signUpError = "Validation failed."
                    }
                }
                
                if let error = signUpError {
                    BaseText(text: error,
                             font: Fonts.jersey25,
                             foregroundColor: Colors.ancestralWater
                    )
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
