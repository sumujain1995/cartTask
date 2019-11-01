//
//  FullImageViewController.swift
//  CartTask
//
//  Created by Sumeet  Jain on 31/10/19.
//  Copyright © 2019 Sumeet Jain. All rights reserved.
//

import UIKit

protocol UpDateCroppedImage {
    func updateImage(indexPath: IndexPath, image: CGImage?)
}

class FullImageViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView = UIScrollView()
    var imageView = UIImageView()
    var cropAreaView = UIView()
    var upDateCroppedImageDelegate: UpDateCroppedImage?
    var showCropRect = false
    var imageIndexPath: IndexPath!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.contentSize = view.bounds.size
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.isUserInteractionEnabled = true
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView))
        doubleTapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGesture)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "CROP", style: .done, target: self, action: #selector(createCropRect))
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @objc func dragView(_ sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        if (translation.x + cropAreaView.frame.minX >= imageView.frame.minX) && (translation.x + cropAreaView.frame.maxX <= imageView.frame.maxX) && (translation.y + cropAreaView.frame.minY >= imageView.frame.minY) && (translation.y + cropAreaView.frame.maxY <= imageView.frame.maxY){
            cropAreaView.center = CGPoint(x: cropAreaView.center.x + translation.x, y: cropAreaView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    @objc func createCropRect(){
        showCropRect = !showCropRect
        if showCropRect{
            cropAreaView.frame = CGRect(x: 0, y: 0, width: 320, height: 320)
            cropAreaView.center = view.center
            scrollView.addSubview(cropAreaView)
            cropAreaView.layer.borderColor = UIColor.black.cgColor
            cropAreaView.layer.borderWidth = 3.0
            cropAreaView.isUserInteractionEnabled = true
            cropAreaView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView(_:))))
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "DONE", style: .done, target: self, action: #selector(cropImage))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "CANCEL", style: .done, target: self, action: #selector(createCropRect))
        }else{
            cropAreaView.removeFromSuperview()
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "CROP", style: .done, target: self, action: #selector(createCropRect))
        }
    }
    
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        }
        else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width  / scale
        let newCenter = imageView.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    @objc func cropImage(){
        if imageIndexPath != nil {

            let factor = imageView.image!.size.width/view.frame.width
            let scale = 1/scrollView.zoomScale
            let imageFrame = imageView.imageFrame()
            let x = (scrollView.contentOffset.x + cropAreaView.frame.origin.x - imageFrame.origin.x) * scale * factor
            let y = (scrollView.contentOffset.y + cropAreaView.frame.origin.y - imageFrame.origin.y) * scale * factor
            let width = cropAreaView.frame.size.width * scale * factor
            let height = cropAreaView.frame.size.height * scale * factor
            cropAreaView.frame = CGRect(x: x, y: y, width: width, height: height)
            
            let croppedCGImage = imageView.image?.cgImage?.cropping(to: cropAreaView.frame)
            upDateCroppedImageDelegate?.updateImage(indexPath: imageIndexPath, image: croppedCGImage)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

