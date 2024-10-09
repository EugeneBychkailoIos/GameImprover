//
//  SteamAuthView.swift
//  GameImprover
//
//  Created by jekster on 09.10.2024.
//

import Foundation
import SwiftUI
import WebKit


struct SteamAuthView: UIViewRepresentable {
    @ObservedObject var viewModel: SignUpViewModel
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
        let viewModel: SignUpViewModel
        let completion: (URL?) -> Void

        init(viewModel: SignUpViewModel, completion: @escaping (URL?) -> Void) {
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
