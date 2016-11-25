//
//  AvatarImage.swift
//  PhotosAnimatedTransition
//
//  Created by Manuel Lopes on 23/10/2016.
//  Copyright © 2016 Manuel Carlos. All rights reserved.
//


import UIKit

/*
 
 MARK:- Object that will hold the image and its info while the transition runs.
 Making this object a struc instead of a class fixed all memory leaks!
 */
struct AvatarImage {
    
    
    /// False if the frameAt property has been swapped, otherwise its True.
    private var flipped = false
    
    /// The UIImageView that will hold the image being animated during the transition.
    var imageView: UIImageView?
    
    /// **frameAt.start** will store the inital frame of the image before the transition, and
    /// **frameAt.end** will hold the frame values for the image once  the transition ends.
    var frameAt: (start: CGRect, end: CGRect) = (.zero, .zero)
    
    
    
    /// The center point of the image view.
    var position: CGPoint?{
        get{
            return imageView?.center
        }
        set{
            imageView?.center = newValue!
        }
    }
    
    /// the size of the image view.
    var size: CGSize?{
        get{
            return imageView?.bounds.size
        }
        set{
            imageView?.bounds.size = newValue!
        }
    }
    
    
    /// Reverse the *frameAt* tuple values.
    mutating func swapFrames(){
        if !flipped{
            frameAt = (frameAt.end, frameAt.start)
            flipped = true
        }
        
    }
    
    
    
}// end

