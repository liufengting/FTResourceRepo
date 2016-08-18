//
//  FTViewController.swift
//  FTIBInspectable
//
//  Created by liufengting https://github.com/liufengting on 16/8/17.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

class FTPopoverViewController: UIViewController,UIPopoverPresentationControllerDelegate,UIAdaptivePresentationControllerDelegate {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()

    }

    func setup() {
        self.modalPresentationStyle = .Popover
        self.popoverPresentationController?.delegate = self
        self.automaticallyAdjustsScrollViewInsets = true
    }

    func prepareForPopoverPresentation(popoverPresentationController: UIPopoverPresentationController) {
        self.popoverPresentationController?.passthroughViews = nil
        self.popoverPresentationController?.popoverLayoutMargins = UIEdgeInsetsMake(40, 0, 0, 0)
        self.popoverPresentationController?.backgroundColor = self.view.backgroundColor
        self.popoverPresentationController?.permittedArrowDirections = .Any//[.Up,.Down,.Any]
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad {
            return .FullScreen
        }else{
            return .None
        }
    }
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let nav = UINavigationController.init(rootViewController: controller.presentedViewController)
        
        return nav
    }

}
