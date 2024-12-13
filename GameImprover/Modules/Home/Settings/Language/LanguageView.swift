//
//  LanguageView.swift
//  GameImprover
//
//  Created by jekster on 25.10.2024.
//

import SwiftUI
import Combine

struct LanguageModel {
    let name: String
}


class LanguageSettings: ObservableObject {
    @Published var selectedLanguageIndex: Int {
        didSet {
            userDefaultsService.setSelectedLanguageIndex(selectedLanguageIndex)
        }
    }
    
    private let userDefaultsService: UserDefaultsService
    
    init(userDefaultsService: UserDefaultsService = UserDefaultsService()) {
        self.userDefaultsService = userDefaultsService
        self.selectedLanguageIndex = userDefaultsService.getSelectedLanguageIndex()
    }
}


struct LanguageView: View {
    @EnvironmentObject var languageSettings: LanguageSettings
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var languagesArray: [LanguageModel] = [
        LanguageModel(name: "English"),
        LanguageModel(name: "Ukrainian"),
        LanguageModel(name: "Spanish"),
        LanguageModel(name: "Italian"),
        LanguageModel(name: "French"),
        LanguageModel(name: "Deutsch")
    ]
    
    var btnBack: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                BaseText(text: "Go Back",
                         font: Fonts.jersey25,
                         foregroundColor: Colors.ancestralWater)
            }
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8),
                                                       Colors.obsidianShard]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            List {
                ForEach(0..<languagesArray.count, id: \.self) { index in
                    LanguageCell(language: languagesArray[index].name,
                                 isSelected: languageSettings.selectedLanguageIndex == index,
                                 onSelect: {
                                     languageSettings.selectedLanguageIndex = index
                                 })
                    .listRowInsets(EdgeInsets())
                    .background(Colors.obsidianShard.opacity(0.8))
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
    }
}

struct LanguageCell: View {
    var language: String
    var isSelected: Bool
    var onSelect: () -> Void
    
    var body: some View {
        HStack {
            Toggle(isOn: Binding<Bool>(
                get: { isSelected },
                set: { _ in onSelect() }
            )) {
                BaseText(text: language,
                         font: Fonts.jersey10small,
                         foregroundColor: Colors.ancestralWater)
            }
            .toggleStyle(SwitchToggleStyle(tint: Colors.ancestralWater))
        }
        .padding()
    }
}
