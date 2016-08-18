//
//  FTView.swift
//  FTIBInspectable
//
//  Created by liufengting https://github.com/liufengting on 16/8/15.
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


//
//  UIViewController+Extensions.swift
//  Photog
//
//  Created by Andrew Patton on 2015-01-17.
//  Copyright (c) 2015 acusti.ca. All rights reserved.
//

import Foundation

//extension UIViewController: UIPopoverPresentationControllerDelegate {
//    
//
//    
//    // Popover presentation helpers
//    // ----------------------------
//    func presentViewControllerAsPopover(viewController: UIViewController, anchor: UIView) {
//        if let presentedVC = self.presentedViewController {
//            if presentedVC.nibName == viewController.nibName {
//                // The view is already being presented
//                return
//            }
//        }
//        // Specify presentation style first (makes the popoverPresentationController property available)
//        viewController.modalPresentationStyle = .Popover
//        let viewPresentationController = viewController.popoverPresentationController
//        // Prep source rect
//        let sourceRectWidth = anchor.frame.width < 100 ? anchor.frame.width : 100
//        if let presentationController = viewPresentationController {
//            presentationController.delegate                 = self
//            presentationController.sourceView               = anchor
//            presentationController.sourceRect               = CGRectMake(0, 0, sourceRectWidth, anchor.frame.size.height)
//            presentationController.permittedArrowDirections = .Up
//        }
//        viewController.preferredContentSize = CGSize(width: 230, height: 110)
//        
//        self.presentViewController(viewController, animated: true, completion: nil)
//    }
//    
//    // Delegate method to allow popovers to be presented in narrow horizontal contexts not fullscreen
//    public func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
//        return .None
//    }
//}