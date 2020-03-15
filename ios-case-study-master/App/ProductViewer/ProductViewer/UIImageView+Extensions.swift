//
//  UIImageView+Extensions.swift
//  ProductViewer
//
//  Created by santhosh.kumar on 14/03/20.
//  Copyright © 2020 Target. All rights reserved.
//

import SDWebImage
import Tempo
import UIKit

/// This is not the best way to do it but for now we can use this method because as of now we are having all urls same.
var imageCache: NSCache<AnyObject, AnyObject> = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    
    /// It will first show the shimmering, loads the image and fallback to placeholder Image if it fails to load the image.
    /// - Parameters:
    ///   - urlString: url of the Image
    ///   - placeholderImageName: placeholder image for fallback.
    func loadImageWithShimmeringLoading(at index: Int = 0, with urlString: String,
                                        placeholderImageName: String? = nil) {
        
        if let cacheImage = imageCache.object(forKey: (urlString + "\(index)") as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        let placeholderImage: UIImage?

        if let placeholderImageName: String = placeholderImageName, let image: UIImage = UIImage(named: placeholderImageName) {
            placeholderImage = image
        }
        else {
            placeholderImage = UIImage.clearImage
        }

        let loadingShimmerView: LoadingShimmerView = LoadingShimmerView()

        loadingShimmerView.translatesAutoresizingMaskIntoConstraints = false
        loadingShimmerView.startAnimation()

        addAndPinSubview(loadingShimmerView)

        if let url: URL = URL(string: urlString) {
//            sd_setImage(with: url, placeholderImage: placeholderImage) { [weak self] (image, _, _, _) in
//                       guard let `self`: UIImageView = self else { return }
//
//                       // becuase loadingShimmerView not a global property, we can't use loadingShimmerView.removeFromSupertview() because ARC.
//                       for subview in self.subviews where subview is LoadingShimmerView {
//                           subview.removeFromSuperview()
//                       }
//
//                       if let image: UIImage = image {
//                           self.image = image
//                       }
//                   }

            load(index: index, url: url, placeholder: placeholderImage) { [weak self] (image) in
                guard let self: UIImageView = self else { return }
                DispatchQueue.main.async {
                    // becuase loadingShimmerView not a global property, we can't use loadingShimmerView.removeFromSupertview()
                    for subview in self.subviews where subview is LoadingShimmerView {
                        subview.removeFromSuperview()
                    }
                    if let image: UIImage = image {
                        self.image = image
                    }
                }
            }
        }
    }
    
    
   private func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil, completion: @escaping (UIImage?) -> Void) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
            completion(image)
        }
        else {
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    completion(image)
                }
                else {
                    completion(UIImage.clearImage)
                }

            }).resume()
        }
    }
    
    
    /// This method will try to reload the image each time when you scroll because we ignoring local and remote cahche
    private func load(index: Int, url: URL, placeholder: UIImage?, completion: @escaping (UIImage?) -> Void) {
      let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData) // default time interval 60.0
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: (url.absoluteString + "\(index)") as AnyObject)
                    completion(image)
                }
                else {
                    imageCache.setObject(UIImage.fromColor(HarmonyColor.targetBullseyeRedColor),
                                         forKey: (url.absoluteString + "\(index)") as AnyObject)
                    completion(UIImage.fromColor(HarmonyColor.targetBullseyeRedColor))
                }
            }).resume()
    }


}
