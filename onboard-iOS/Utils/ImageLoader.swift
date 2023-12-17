//
//  ImageLoader.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/3/23.
//

import UIKit

import Kingfisher

class ImageLoader {
    
    static func loadImage(
        from urlString: String,
        completion: @escaping (UIImage?) -> Void) {
            
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            KingfisherManager
                .shared
                .retrieveImage(with: url) { result in
                    switch result {
                    case .success(let value):
                        DispatchQueue.main.async {
                            completion(value.image)
                        }
                        
                    case .failure(_):
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                }
        }
}
