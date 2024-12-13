//
//  CS2StatsView.swift
//  GameImprover
//
//  Created by jekster on 24.10.2024.
//

//import SwiftUI
//
//struct CS2StatsView: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    
//    var btnBack: some View {
//        Button(action: {
//            self.presentationMode.wrappedValue.dismiss()
//        }) {
//            HStack {
//                BaseText(text: "Go Back",
//                         font: Fonts.jersey25,
//                         foregroundColor: Colors.ancestralWater
//                )
//            }
//        }
//    }
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8),
//                                                           Colors.obsidianShard]),
//                               startPoint: .top, endPoint: .bottom)
//                .edgesIgnoringSafeArea(.all)
//                
//                BaseText(text: "CS2 STATS",
//                         font: Fonts.jersey25,
//                         foregroundColor: Colors.ancestralWater
//                )
//            }
//            .navigationBarItems(leading: btnBack)
//            .navigationBarBackButtonHidden(true)
//        }
//        .navigationBarBackButtonHidden(true)
//        .onAppear {
//            Task {
//               await getAllHeroImages()
//            }
//        }
//    }
//}



import SwiftUI

struct CS2StatsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var heroesService = HeroesService()
    @State private var showModal = false
    @State private var selectedHeroData: (image: Image, heroName: String, imageURL: String)? = nil

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
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    BaseText(text: "CS2 STATS", font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
                    
                    ScrollView {
                        LazyVStack {
                            ForEach(heroesService.images.sorted(by: { $0.key < $1.key }), id: \.key) { heroID, heroData in
                                HStack {
                                    heroData.image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()

                                    VStack(alignment: .leading) {
                                        Text("ID: \(heroID)")
                                            .font(.headline)
                                            .foregroundColor(Colors.ancestralWater)

                                        Text(heroData.heroName)
                                            .font(.subheadline)
                                            .foregroundColor(Colors.ancestralWater)
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showModal.toggle()
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Colors.ancestralWater)
                                .padding()
                        }
                    }
                }
            }
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                Task {
                    await heroesService.loadAllHeroImages()
                }
            }
            .sheet(isPresented: $showModal) {
                ModalView(heroData: $selectedHeroData, heroesService: heroesService)
            }
        }
    }
}



import SwiftUI

struct ModalView: View {
    @Binding var heroData: (image: Image, heroName: String, imageURL: String)?
    @State private var heroIDInput: String = ""
    @ObservedObject var heroesService: HeroesService
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Enter Hero ID")
                    .font(.headline)
                    .padding(.top)
                
                TextField("Hero ID", text: $heroIDInput)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    if let heroID = Int(heroIDInput) {
                        if let data = heroesService.getHeroData(for: heroID) {
                            heroData = data
                        } else {
                       
                            if let heroName = heroesService.images[heroID]?.heroName,
                               let imageURL = heroesService.images[heroID]?.imageURL {
                                Task {
                                    await heroesService.downloadHeroData(heroID: heroID)
                                  
                                    heroData = heroesService.getHeroData(for: heroID)
                                }
                            } else {
                                print("Hero with ID \(heroID) not found in images.")
                            }
                        }
                    } else {
                        heroData = nil
                    }
                }) {
                    Text("Get Hero Data")
                        .padding()
                        .background(Colors.obsidianShard)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                if let hero = heroData {
                    VStack {
                        hero.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding()

                        Text("ID: \(hero.heroName)")
                            .font(.headline)
                            .padding()

                        Text(hero.heroName)
                            .font(.subheadline)
                            .padding()
                    }
                } else if !heroIDInput.isEmpty {
                    Text("No data found for ID \(heroIDInput).")
                        .foregroundColor(.red)
                        .padding()
                }
                
                Spacer()
                
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            .navigationTitle("Hero Details")
            .onAppear {
                if heroesService.images.isEmpty {
                    print("No heroes loaded yet.")
                }
            }
        }
    }
}
