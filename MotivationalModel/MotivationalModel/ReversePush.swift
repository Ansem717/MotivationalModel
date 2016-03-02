//
//  ReversePush.swift
//  MotivationalModel
//
//  Created by Andy Malik on 3/1/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import UIKit

class ReversePush: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return 0.5
    }
    
    func animateTransition(context: UIViewControllerContextTransitioning)
    {
        guard let toVC = context.viewControllerForKey(UITransitionContextToViewControllerKey) else {fatalError()}
        guard let containerView = context.containerView() else {return}
        guard let fromVC = context.viewControllerForKey(UITransitionContextFromViewControllerKey) else {fatalError()}
        
        let finalFrame = context.finalFrameForViewController(toVC)
        let screenBounds = UIScreen.mainScreen().bounds
        
        toVC.view.frame = CGRectOffset(finalFrame, 0.0, screenBounds.size.height)
        containerView.addSubview(toVC.view)
        containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
        
        UIView.animateWithDuration(transitionDuration(context), animations: { () -> Void in
            toVC.view.frame = finalFrame
            }) { (finished) -> Void in
                context.completeTransition(true)
        }
    }
    
}