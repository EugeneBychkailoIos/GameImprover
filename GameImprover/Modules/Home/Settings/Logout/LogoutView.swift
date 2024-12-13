//
//  LogoutView.swift
//  GameImprover
//
//  Created by jekster on 25.10.2024.
//

import SwiftUI
import FirebaseAuth

struct LogoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var errorMessage: String = ""
    @State private var isLoggedOut: Bool = false

    var body: some View {
        VStack {
            Text("Logging out...")
                .font(.largeTitle)
                .foregroundColor(.white)
                .onAppear {
                    performLogout()
                }
        }
        .alert(isPresented: .constant(!errorMessage.isEmpty)) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")) {
                errorMessage = ""
            })
        }
        .navigationBarTitle("Logout", displayMode: .inline)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .fullScreenCover(isPresented: $isLoggedOut) {
            AuthorizationView()
        }
    }
    
    private func performLogout() {
        do {
            try Auth.auth().signOut()
            isLoggedOut = true
        } catch let signOutError {
            errorMessage = signOutError.localizedDescription
        }
    }
}
