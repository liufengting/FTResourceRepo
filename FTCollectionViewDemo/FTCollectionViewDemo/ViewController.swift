//
//  ViewController.swift
//  FTCollectionViewDemo
//
//  Created by liufengting on 16/8/15.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

private let DemoCollectionCellIdentifier = "DemoCollectionCellIdentifier"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    var dataArray : NSMutableArray! = NSMutableArray()
    var longPressGesture: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0 ..< 100  {
            dataArray.addObject(i+1)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.Began:
            guard let selectedIndexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
        case UIGestureRecognizerState.Changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
        case UIGestureRecognizerState.Ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
        
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource -
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : DemoCollectionCell! = collectionView.dequeueReusableCellWithReuseIdentifier(DemoCollectionCellIdentifier, forIndexPath: indexPath) as! DemoCollectionCell
        cell.nameLabel.text = "\(dataArray[indexPath.row])"
        return cell
    }
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let temp = dataArray.objectAtIndex(sourceIndexPath.item)
        dataArray.removeObjectAtIndex(sourceIndexPath.item)
        dataArray.insertObject(temp, atIndex: destinationIndexPath.item)
    }


}

