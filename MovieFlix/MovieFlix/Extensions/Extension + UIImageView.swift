//
//  Extension + UIImageView.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 07/12/22.
//

import UIKit

//MARK: - Image Cache helper
class ImageCache {

    private init() {}
    static let shared = NSCache<NSString, UIImage>()
}

extension UIImageView {
    
    func downloadImage(from link: String,
                       contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    private func downloaded(from url: URL,
                            contentMode mode: ContentMode = .scaleAspectFill) {
        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                
                ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString)
                self?.image = image
            }
        }.resume()
    }
    
    
}
