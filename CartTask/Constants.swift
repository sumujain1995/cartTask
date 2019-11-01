//
//  Constants.swift
//  CartTask
//
//  Created by Sumeet  Jain on 30/10/19.
//  Copyright © 2019 Sumeet Jain. All rights reserved.
//

import UIKit
import Kingfisher

extension UIViewController{
    
    func showAlertView(_ title: String?, msg: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension UIImageView{
    public func imageFromUrl(_ urlString: String, placeHolder:String = "demo.jpg")
    {
        let placeHolderImage = UIImage(named: placeHolder)
        if let URL = Foundation.URL(string: urlString)
        {
            let resource = ImageResource(downloadURL: URL)
            kf.setImage(with: resource, placeholder: placeHolderImage)
            
        }
        else
        {
            self.image = placeHolderImage
        }
    }
    func imageFrame()->CGRect{
        let imageViewSize = self.frame.size
        guard let imageSize = self.image?.size else{return CGRect.zero}
        let imageRatio = imageSize.width / imageSize.height
        let imageViewRatio = imageViewSize.width / imageViewSize.height
        if imageRatio < imageViewRatio {
            let scaleFactor = imageViewSize.height / imageSize.height
            let width = imageSize.width * scaleFactor
            let topLeftX = (imageViewSize.width - width) * 0.5
            return CGRect(x: topLeftX, y: 0, width: width, height: imageViewSize.height)
        }else{
            let scalFactor = imageViewSize.width / imageSize.width
            let height = imageSize.height * scalFactor
            let topLeftY = (imageViewSize.height - height) * 0.5
            return CGRect(x: 0, y: topLeftY, width: imageViewSize.width, height: height)
        }
    }
}
