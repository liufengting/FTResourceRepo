//
//  DetialViewController.swift
//  FTCollectionViewDemo
//
//  Created by liufengting on 2016/11/10.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

class DetialViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = image

    }
    
    var image : UIImage = UIImage()
    

}
