//
//  CustomTextField.swift
//  GameImprover
//
//  Created by jekster on 09.10.2024.
//

import SwiftUI


struct CustomTextFieldStyle: TextFieldStyle {
    
    var isValid: Bool
    var font: Font
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 10)
            .frame(height: 42)
            .background(Colors.ancestralWater)
            .cornerRadius(5)
            .accentColor(Colors.obsidianShard)
            .font(font)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isValid ? Color.green : Color.red, lineWidth: 2)
            )
    }
}



struct CustomTextField: View {
    
    var text: String
    var font: Font
    var color: Color
    var titleTextField: String
    var validationRules: [ValidationRule]
    @Binding var textfieldText: String
    @State private var isValid = true
    @State private var errorMessage: String? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                BaseText(text: text, font: font, foregroundColor: color)
                Spacer()
            }
            .padding(.bottom, 11)
            
            TextField(titleTextField, text: $textfieldText)
                .onChange(of: textfieldText) { newValue in
                    validateText()
                }
                .textFieldStyle(CustomTextFieldStyle(isValid: isValid, font: font))
                .frame(height: 42)
            
            if let errorMessage = errorMessage {
                HStack {
                    Spacer()
                    Text(errorMessage)
                        .font(Fonts.jersey25small)
                        .foregroundColor(.red)
                        .padding(.top, 8)
                }
            }
        }
        .padding(.leading, 55)
        .padding(.trailing, 52)
    }
    
    private func validateText() {
        isValid = true
        errorMessage = nil

        for rule in validationRules {
            if let error = rule.validate(textfieldText) as? LocalizedError {
                isValid = false
                errorMessage = error.errorDescription
                break
            }
        }
    }

}
