//
//  ViewController.swift
//  FTZoomTransition
//
//  Created by liufengting on 29/11/2016.
//  Copyright © 2016 LiuFengting. All rights reserved.
//

import UIKit




class ViewController: UIViewController {

    @IBOutlet weak var sourceButton: UIButton!
    
    let transitionDelegate = FTZoomTransition()

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    // ********************************************//
    // change iWannaTryPresent to see present/push //
    //*********************************************//
    
    private let iWannaTryPresent = false
    
    // ********************************************//
    // change iWannaTryPresent to see present/push //
    //*********************************************//
    


    @IBAction func handleButtonTap(_ sender: UIButton) {
        
        
        if iWannaTryPresent {
            
            // present
            
            let detial = self.storyboard?.instantiateViewController(withIdentifier: "DetialNavigationController") as! UINavigationController
            let detialVC = detial.viewControllers[0] as! DetialViewController
            let element = FTZoomTransitionElement(sourceView: sender,
                                                  sourceSnapView: sender.snapshotView(afterScreenUpdates: true),
                                                  sourceFrame: sender.frame,
                                                  targetFrame: detialVC.targetImageView.frame)
            transitionDelegate.element = element
            detial.modalPresentationStyle = .custom
            detial.transitioningDelegate = transitionDelegate
            self.present(detial, animated: true, completion: {})
        }else{
            
             //try push !!! basically the same !!!
            
            let detial = self.storyboard?.instantiateViewController(withIdentifier: "DetialViewController") as! DetialViewController
            let element = FTZoomTransitionElement(sourceView: sender,
                                                  sourceSnapView: sender.snapshotView(afterScreenUpdates: true),
                                                  sourceFrame: sender.frame,
                                                  targetFrame: detial.targetImageView.frame)
            transitionDelegate.element = element
            detial.modalPresentationStyle = .custom
            detial.transitioningDelegate = transitionDelegate
            self.present(detial, animated: true, completion: {})
            navigationController?.delegate = FTNavigationDelegate()
            navigationController?.pushViewController(detial, animated: true)
            
        }
        
        
        


        
        
        
        


        
        
    }
    
}

