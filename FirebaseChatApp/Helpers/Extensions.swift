//
//  Extensions.swift
//  FirebaseChatApp
//
//  Created by Felipe Amorim Bastos on 02/04/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
//    func loadImageUsingCacheWithUrlString(urlString: String) {
//
//        //check cache for image first
//        if let cachedImage = imageCache.object(forKey: urlString as NSString){
//            self.image = cachedImage
//            return
//        }
//
//        //otherwise fire off a new download
//        let url = URL(string: urlString)!
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            //download hit an error
//            if error != nil {
//                print(error)
//                return
//            }
//
//            DispatchQueue.main.async {
//
//                if let downloadedImage = UIImage(data: data!) {
//                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
//                }
//
//                self.image = UIImage(data: data!)
//            }
//        }
//    }
}
