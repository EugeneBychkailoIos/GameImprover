//
//  SignInView.swift
//  GameImprover
//
//  Created by jekster on 08.10.2024.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var loginTextfieldText = ""
    @State private var passwordTextfieldText = ""
    
    var btnBack: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                BaseText(text: "Go Back", font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
            }
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                CustomTextField(
                            text: "login",
                            font: Fonts.jersey25,
                            color: Color.gray,
                            titleTextField: "login",
                            validationRules: [ValidateMinimumLength(minimumLength: 6, emptyStringError: "Empty text"), ValidateMaximumLenght(maximumLenght: 12)],
                            textfieldText: $loginTextfieldText
                        )
                    .padding(.bottom, 43)
                    .padding(.top, 15)
                
            CustomTextField(
                        text: "password",
                        font: Fonts.jersey25,
                        color: Color.gray,
                        titleTextField: "password",
                        validationRules: [ValidateMinimumLength(minimumLength: 6, emptyStringError: "Empty tect"), ValidateMaximumLenght(maximumLenght: 12)],
                        textfieldText: $passwordTextfieldText
                    )
                    .padding(.bottom, 50)
                
                BaseButton(title: "continue",backgroundColor: Colors.ancestralWater, textColor: Colors.obsidianShard, width: 284, height: 40, font: Fonts.jersey10small) {
                    print("")
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}
