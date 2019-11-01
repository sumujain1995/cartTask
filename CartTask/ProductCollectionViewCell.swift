//
//  ProductCollectionViewCell.swift
//  CartTask
//
//  Created by Sumeet  Jain on 30/10/19.
//  Copyright © 2019 Sumeet Jain. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell
{
    var productImageView = UIImageView()
    var productNameLabel = UILabel()
    var productPriceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(productImageView)
        productImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        productImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 180).isActive = true
        productImageView.contentMode = .scaleAspectFit

        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(productNameLabel)
        productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5).isActive = true
        productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        productNameLabel.numberOfLines = 0
        
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(productPriceLabel)
        productPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        productPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 5).isActive = true
        productPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
    }
    
    override func layoutSubviews() {
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
