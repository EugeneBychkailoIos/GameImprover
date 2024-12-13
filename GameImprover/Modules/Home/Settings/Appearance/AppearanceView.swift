//
//  AppearanceView.swift
//  GameImprover
//
//  Created by jekster on 25.10.2024.
//

import SwiftUI
import Combine

struct AppearanceArray {
    let name: String
}


class AppearanceSettings: ObservableObject {
    @Published var selectedAppearanceIndex: Int {
        didSet {
            userDefaultsService.setSelectedAppearanceIndex(selectedAppearanceIndex)
        }
    }
    
    private let userDefaultsService: UserDefaultsService
    
    init(userDefaultsService: UserDefaultsService = UserDefaultsService()) {
        self.userDefaultsService = userDefaultsService
        self.selectedAppearanceIndex = userDefaultsService.getSelectedAppearanceIndex()
    }
}


struct AppearanceView: View {
    @EnvironmentObject var appearanceSettings: AppearanceSettings
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var appearanceArray: [AppearanceArray] = [
        AppearanceArray(name: "System"),
        AppearanceArray(name: "Dark"),
        AppearanceArray(name: "Light")
    ]
    
    @State private var selectedAppearanceIndex: Int
    private let userDefaultsService = UserDefaultsService()
    
    init() {
        let savedIndex = userDefaultsService.getSelectedAppearanceIndex()
        _selectedAppearanceIndex = State(initialValue: savedIndex)
    }
    
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
            
            List {
                ForEach(0..<appearanceArray.count, id: \.self) { index in
                    AppearanceCell(appearance: appearanceArray[index].name,
                                 isSelected: selectedAppearanceIndex == index,
                                 onSelect: {
                        selectedAppearanceIndex = index
                        userDefaultsService.setSelectedAppearanceIndex(selectedAppearanceIndex)
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

struct AppearanceCell: View {
    var appearance: String
    var isSelected: Bool
    var onSelect: () -> Void
    
    var body: some View {
        HStack {
            Toggle(isOn: Binding<Bool>(
                get: { isSelected },
                set: { _ in onSelect() }
            )) {
                BaseText(text: appearance,
                         font: Fonts.jersey10small,
                         foregroundColor: Colors.ancestralWater)
            }
            .toggleStyle(SwitchToggleStyle(tint: Colors.ancestralWater))
        }
        .padding()
    }
}
