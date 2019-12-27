//
//  CircularTransition.swift
//  albms
//
//  Created by Armand Raynor on 10/14/19.
//  Copyright © 2019 Armand Raynor. All rights reserved.
//

import UIKit

class CircularTransition: NSObject {
    enum CircularTransitionMode: Int {
        case present, dismiss, pop
    }

    var circle = UIView()
    var circleColor = UIColor.white
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    var duration = 0.3
    var transitionMode: CircularTransitionMode = .present
}

extension CircularTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size

                circle = UIView()

                circle.frame = frameForCircle(withViewCenter: viewCenter, viewSize: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.width / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)

                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)

                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                }) { (didComplete) in
                    transitionContext.completeTransition(didComplete)
                }
            }
        } else {
            let transitionModeKey = transitionMode == .pop ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size

                circle.frame = frameForCircle(withViewCenter: viewCenter, viewSize: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.width / 2
                circle.center = startingPoint

                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0

                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                }) { (didComplete) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(didComplete)
                }
            }
        }
    }

    func frameForCircle(withViewCenter viewCenter: CGPoint, viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = max(startPoint.x, viewSize.width - startPoint.x)
        let yLength = max(startPoint.y, viewSize.height - startPoint.y)
        let offset = sqrt(xLength * xLength + yLength * yLength) * 2
        return CGRect(origin: .zero, size: CGSize(width: offset, height: offset))
    }
}
