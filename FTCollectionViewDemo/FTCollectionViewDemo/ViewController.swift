//
//  ViewController.swift
//  FTCollectionViewDemo
//
//  Created by liufengting https://github.com/liufengting on 16/8/15.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

private let DemoCollectionCellIdentifier = "DemoCollectionCellIdentifier"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    var dataArray : NSMutableArray! = NSMutableArray()
    var longPressGesture: UILongPressGestureRecognizer!
    private let assetTransitionController = AssetTransitionController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0 ..< 100  {
            dataArray.add(i+1)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
        
        
        navigationController?.delegate = assetTransitionController

    }
    
    func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
        
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource -
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : DemoCollectionCell! = collectionView.dequeueReusableCell(withReuseIdentifier: DemoCollectionCellIdentifier, for: indexPath) as! DemoCollectionCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = dataArray.object(at: sourceIndexPath.item)
        dataArray.removeObject(at: sourceIndexPath.item)
        dataArray.insert(temp, at: destinationIndexPath.item)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DemoCollectionCell else { return }
//        selecteCell = cell
//        cell.isHidden = true
        
        var pic = AvatarImage()
        pic.imageView = UIImageView(frame: cell.frame)
        pic.imageView?.image = cell.imageView.image
        pic.frameAt.start =  view.convert(cell.imageView.bounds, from: cell.imageView)
        let picSize: CGFloat = 300
        let picRadius = picSize / 2
        let size = CGSize(width: picSize, height: picSize)
        pic.frameAt.end = CGRect(origin: CGPoint(x: view.center.x - picRadius , y:  view.center.y - picRadius) , size: size )
        
        assetTransitionController.avatarImage = pic
        assetTransitionController.startInteractive = false
        
        
        let detial = self.storyboard?.instantiateViewController(withIdentifier: "DetialViewController") as! DetialViewController
        detial.image = cell.imageView.image!
        navigationController?.pushViewController( detial, animated: true)
    }

}

