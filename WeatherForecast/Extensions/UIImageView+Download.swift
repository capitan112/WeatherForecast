//
//  UIImageView+Download.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 28/02/2021.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImage(icon: String) {
        if let imageFromCache = imageCache.object(forKey: icon as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }

        let dataFetcher = NetworkDataFetcher()
        dataFetcher.loadImage(icon: icon, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):

                guard let imageToCache = UIImage(data: data)?.withRenderingMode(.alwaysTemplate) else { return }
                imageCache.setObject(imageToCache, forKey: icon as AnyObject)
                performUIUpdatesOnMain {
                    self.image = imageToCache
                }
            case .failure:
                performUIUpdatesOnMain {
                    self.image = UIImage(named: "noImage")
                }
            }
        })
    }
}
