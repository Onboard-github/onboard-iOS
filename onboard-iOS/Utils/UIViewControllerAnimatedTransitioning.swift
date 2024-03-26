//
//  UIViewControllerAnimatedTransitioning.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/26/24.
//

import UIKit

final class PresentTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var animator: UIViewImplicitlyAnimating?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.32
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        
        if self.animator != nil {
            return self.animator!
        }
        
        let container = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)!
        let fromViewInitFrame = transitionContext.initialFrame(for: fromVC)
        var fromViewFinalFrame = fromViewInitFrame
        fromViewFinalFrame.origin.x = -fromViewFinalFrame.width
        
        let fromView = fromVC.view!
        let toView = transitionContext.view(forKey: .to)!
        
        var toViewInitialFrame = fromViewInitFrame
        toViewInitialFrame.origin.x = toView.frame.size.width
        
        toView.frame = toViewInitialFrame
        container.addSubview(toView)
        
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            toView.frame = fromViewInitFrame
            fromView.frame = fromViewFinalFrame
        }
        
        animator.addCompletion { _ in
            transitionContext.completeTransition(true)
        }
        
        self.animator = animator
        
        return animator
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        self.animator = nil
    }
}

final class DismissTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var animator: UIViewImplicitlyAnimating?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.32
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        
        if self.animator != nil {
            return self.animator!
        }
        
        let fromVC = transitionContext.viewController(forKey: .from)!
        var fromViewInitFrame = transitionContext.initialFrame(for: fromVC)
        fromViewInitFrame.origin.x = 0
        
        var fromViewFinalFrame = fromViewInitFrame
        fromViewFinalFrame.origin.x = fromViewFinalFrame.width
        
        let fromView = fromVC.view!
        let toView = transitionContext.viewController(forKey: .to)!.view!
        
        var toViewInitialFrame = fromViewInitFrame
        toViewInitialFrame.origin.x = -toView.frame.size.width
        toView.frame = toViewInitialFrame
        
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            toView.frame = fromViewInitFrame
            fromView.frame = fromViewFinalFrame
        }
        
        animator.addCompletion { _ in
            transitionContext.completeTransition(true)
        }
        
        self.animator = animator
        
        return animator
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        self.animator = nil
    }
}
