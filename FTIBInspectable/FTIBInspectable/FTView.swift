//
//  FTView.swift
//  FTIBInspectable
//
//  Created by liufengting on 16/8/15.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

@IBDesignable class FTView: UIView {

    @IBInspectable var layerCornerRadius : CGFloat = CGFloat.NaN {
        didSet {
            self.layer.cornerRadius = layerCornerRadius
        }
    }
}
