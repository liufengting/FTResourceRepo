//
//  FTTransitionDelegate.swift
//  FTZoomTransition
//
//  Created by liufengting on 30/11/2016.
//  Copyright © 2016 LiuFengting. All rights reserved.
//

import UIKit

struct FTZoomTransitionElement {
    var navigationController : UINavigationController!
    var sourceView : UIView!
    var sourceSnapView : UIView!
    var sourceFrame : CGRect!
    var targetView : UIView!
    var targetFrame : CGRect!
}


class FTZoomTransition: NSObject, UIViewControllerTransitioningDelegate{

    var element : FTZoomTransitionElement! {
        willSet{
            presentAnimator.element = newValue
            dismissAnimator.element = newValue
        }
    }

    private let presentAnimator = FTPresentAnimator()
    private let dismissAnimator = FTDismissAnimator()
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimator
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimator
    }
    
}

class FTNavigationDelegate: NSObject, UINavigationControllerDelegate{
    
    var element : FTZoomTransitionElement! {
        willSet{
            presentAnimator.element = newValue
            dismissAnimator.element = newValue
//            edgeInteractiveTransition.navigationController = newValue.navigationController
        }
    }
    private let presentAnimator = FTPresentAnimator()
    private let dismissAnimator = FTDismissAnimator()
    private let edgeInteractiveTransition = FTEdgePanInteractiveAnimator()
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
        if let gestureRecognizer = navigationController.interactivePopGestureRecognizer,
            gestureRecognizer.delegate !== edgeInteractiveTransition {
            edgeInteractiveTransition.navigationController = navigationController
            gestureRecognizer.delegate = edgeInteractiveTransition
            gestureRecognizer.addTarget(edgeInteractiveTransition, action: #selector(FTEdgePanInteractiveAnimator.handlePanGestureRecognizer(_:)))
        }
        return edgeInteractiveTransition.interactionController
    }

    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return operation == .push ?   presentAnimator : dismissAnimator
    }
    
}
