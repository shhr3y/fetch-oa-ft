//
//  UIImageView+Extensions.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/1/23.
//

import UIKit

extension UIImageView {
    func load(url: URL, placeholder: UIImage? = nil, cache: URLCache? = nil, completion: ((UIImage?) -> Void)? = nil) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.image = image
                completion?(image)
            }
        } else {
            self.image = placeholder
            
            URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                guard let data = data, let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode, let image = UIImage(data: data) else {
                    completion?(nil)
                    return
                }
                
                let cachedData = CachedURLResponse(response: httpResponse, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                
                DispatchQueue.main.async {
                    self?.image = image
                    completion?(image)
                }
            }.resume()
        }
    }
}

