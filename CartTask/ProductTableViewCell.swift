//
//  ProductTableViewCell.swift
//  CartTask
//
//  Created by Sumeet  Jain on 30/10/19.
//  Copyright © 2019 Sumeet Jain. All rights reserved.
//

import UIKit

protocol ShowFullImageProtocol {
    func fullImage(_ section: Int, row: Int, image: UIImage?)
}

protocol DragDropChageModel {
    func changeProductPosition(_ source: Int, destination: Int, section: Int)
}

class ProductTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate
{
    var productCollectionView: UICollectionView?
    var section: Int = -1
    var products: [Products] = []
    var showFullImageDelegate: ShowFullImageProtocol?
    var dragDropChageModelDelegate: DragDropChageModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        if reuseIdentifier == "simpleGrid"{
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
            productCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
            productCollectionView?.translatesAutoresizingMaskIntoConstraints = false
            productCollectionView?.backgroundColor = UIColor.white
            productCollectionView?.showsHorizontalScrollIndicator = false
            addSubview(productCollectionView!)
            productCollectionView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
            productCollectionView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            productCollectionView?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            productCollectionView?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            productCollectionView?.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "gridCell")
            
            productCollectionView?.delegate = self
            productCollectionView?.dataSource = self
            productCollectionView?.dragDelegate = self
            productCollectionView?.dropDelegate = self
            productCollectionView?.dragInteractionEnabled = true
        }
    }
    
    
    //COLLECTIONVIEW DATASOURCE METHODS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! ProductCollectionViewCell
        if let cgImage = products[indexPath.row].image{
            cell.productImageView.image = UIImage(cgImage: cgImage)
        }else if let url =  products[indexPath.row].imageUrl{
            cell.productImageView.imageFromUrl(url)
        }else{
            cell.productImageView.imageFromUrl(imgArr[indexPath.row])
        }
        cell.productNameLabel.text = products[indexPath.row].name.capitalized
        cell.productPriceLabel.text = "₹" + String(describing: products[indexPath.row].cost)
        return cell
    }
    
    //COLLECTIONVIEW DelegateFlowLayout METHODS
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout{
            let maxCellInRow = 3
            let maxCellInColumn = 2
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(maxCellInRow - 1))
            
            let width = Int((collectionView.bounds.width - totalSpace) / CGFloat(maxCellInRow))
            
            let totalSpaceHeight = flowLayout.sectionInset.top
                + flowLayout.sectionInset.bottom
                + (flowLayout.minimumInteritemSpacing * CGFloat(maxCellInColumn - 1))
            
            let height = Int((collectionView.bounds.height - totalSpaceHeight) / CGFloat(maxCellInColumn))
            return CGSize(width: width, height: height)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if section != -1, let cell = collectionView.cellForItem(at: indexPath) as? ProductCollectionViewCell{
            showFullImageDelegate?.fullImage(section, row: indexPath.row, image: cell.productImageView.image)
        }
    }
    
    //COLLECTIONVIEW DRAG METHOD
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider()
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
    //COLLECTIONVIEW DROP METHOD
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag && session.items.count == 1{
            return UICollectionViewDropProposal(operation: .move)
        }
        return UICollectionViewDropProposal(operation: .cancel)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath{
            destinationIndexPath = indexPath
        }else{
            let section = collectionView.numberOfSections - 1
            let rows = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: rows, section: section)
        }
        
        for item in coordinator.items{
            if let sourceIndexPath = item.sourceIndexPath{
                let product = products[sourceIndexPath.row]
                products.remove(at: sourceIndexPath.row)
                products.insert(product, at: destinationIndexPath.row)
                collectionView.performBatchUpdates({
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                }) { (success) in
                    if success{
                        self.dragDropChageModelDelegate?.changeProductPosition(sourceIndexPath.row, destination: destinationIndexPath.row, section: self.section)
                    }
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init(coder:) has not been implemented")
    }
}
