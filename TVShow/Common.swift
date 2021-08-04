//
//  Common.swift
//  TVShow
//
//  Created by Arunraj on 04/08/21.
//

import Foundation
import UIKit


extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
              (data, response, error) -> Void in
              DispatchQueue.main.async {
                 if let data = data {
                    self.image = UIImage(data: data)
                 }
              }
           }).resume()
    }
}
