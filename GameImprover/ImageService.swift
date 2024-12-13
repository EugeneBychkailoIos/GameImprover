//
//  ImageService.swift
//  GameImprover
//
//  Created by jekster on 24.10.2024.
//

import UIKit
import CommonCrypto
import SwiftUI
import Combine

class ImageService: ObservableObject {
    @Published var image: Image? = nil
    @Published var errorMessage: String? = nil

    private var cacheDir: URL {
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return documentsDirectory
    }
    
    enum Result {
        case success(Image)
        case failed
    }
    
    
    func downloadImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }
        
        if let cachedImage = self.getImage(name: urlString.md5) {
            self.image = cachedImage
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.downloadTask(with: request) { (url, res, _) in
            
            guard let httpResponse = res as? HTTPURLResponse else { return }
            let imagePlaceholder = Image("image-not-found-icon")
            
            if httpResponse.statusCode != 200 {
                DispatchQueue.main.async {
                    self.image = imagePlaceholder
                }
                return
            }
            
            guard let url = url, let data = try? Data(contentsOf: url), let uiImage = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.image = imagePlaceholder
                }
                return
            }
            self.saveToDisk(fileName: urlString.md5, data: data)
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
        task.resume()
    }
    
    private func saveToDisk(fileName: String, data: Data) {
        let fileURL = self.cacheDir.appendingPathComponent(fileName)
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try data.write(to: fileURL)
            } catch {
                debugPrint("Error saving image: \(error)")
            }
        }
    }
    
    func getImage(name: String) -> Image? {
        let fileURL = self.cacheDir.appendingPathComponent(name)
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return nil
        }
        guard let data = try? Data(contentsOf: fileURL), let uiImage = UIImage(data: data) else {
            return nil
        }
        return Image(uiImage: uiImage) // Конвертація UIImage в Image
    }
}

extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            CC_SHA256(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
