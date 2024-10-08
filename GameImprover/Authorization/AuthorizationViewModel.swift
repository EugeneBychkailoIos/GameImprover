//
//  AuthorizationViewModel.swift
//  GameImprover
//
//  Created by jekster on 07.10.2024.
//

import Foundation
import SwiftUI
import WebKit

class AuthorizationViewModel: ObservableObject {
    @Published var steamID: String?
    @Published var errorMessage: String?
    @Published var isAuthenticated: Bool = false

    func startSteamAuth() {
        guard let url = URL(string: "https://us-central1-gameimprover-3babe.cloudfunctions.net/steamAuth") else { return }
        UIApplication.shared.open(url)
    }

    func handleSteamResponse(url: URL) {
        print("Received URL: \(url.absoluteString)")
        
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        print("Query Items: \(queryItems ?? [])")
        
        if let modeValue = queryItems?.first(where: { $0.name == "openid.mode" })?.value {
            
            if modeValue == "id_res" {
                if let steamIDValue = queryItems?.first(where: { $0.name == "openid.claimed_id" })?.value {
                    let steamID = extractSteamID(from: steamIDValue)
                    print("Extracted Steam ID: \(steamID ?? "nil")")
                    self.steamID = steamID
                    self.isAuthenticated = true
                    self.errorMessage = nil
                } else {
                    print("Failed to extract Steam ID from claimed_id")
                    self.isAuthenticated = false
                    self.errorMessage = "Failed to extract Steam ID"
                }
            } else {
                self.isAuthenticated = false
                self.errorMessage = "Steam authentication failed due to invalid mode"
            }
        } else {
            print("No openid.mode found in the response")
            self.isAuthenticated = false
            self.errorMessage = "Steam authentication failed due to missing openid.mode"
        }
    }

    func extractSteamID(from openIDClaimedID: String) -> String? {
        if let range = openIDClaimedID.range(of: "id/") {
            let steamID = String(openIDClaimedID[range.upperBound...])
            return steamID
        }
        return nil
    }
}

struct SteamAuthView: UIViewRepresentable {
    @ObservedObject var viewModel: AuthorizationViewModel
    let completion: (URL?) -> Void

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let steamOpenIDURL = "https://us-central1-gameimprover-3babe.cloudfunctions.net/steamAuth"
        
        if let url = URL(string: steamOpenIDURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel: viewModel, completion: completion)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let viewModel: AuthorizationViewModel
        let completion: (URL?) -> Void

        init(viewModel: AuthorizationViewModel, completion: @escaping (URL?) -> Void) {
            self.viewModel = viewModel
            self.completion = completion
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                print("Navigating to URL: \(url.absoluteString)")
                
                if url.host == "us-central1-gameimprover-3babe.cloudfunctions.net" && url.path == "/steamCallback" {
                    print("Steam Callback URL: \(url.absoluteString)")
                    completion(url)
                    viewModel.handleSteamResponse(url: url)
                    decisionHandler(.cancel)
                    return
                }
            }
            decisionHandler(.allow)
        }
    }
}
