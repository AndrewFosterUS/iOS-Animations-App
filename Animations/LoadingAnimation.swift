//
//  LoadingAnimation.swift
//  Animations
//
//  Created by Andrew Foster on 5/4/17.
//  Copyright © 2017 Andrii Halabuda. All rights reserved.
//

import UIKit
import Foundation
import Spring

public class LoadingView: UIView {
    
    @IBOutlet public weak var indicatorView: SpringView!
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override public func awakeFromNib() {
        setupView()
    }
    
    func setupView() {

                let animation = CABasicAnimation()
                animation.keyPath = "transform.rotation.z"
                animation.fromValue = degreesToRadians(degrees: 0)
                animation.toValue = degreesToRadians(degrees: 360)
                animation.duration = 0.9
                animation.repeatCount = HUGE
                indicatorView.layer.add(animation, forKey: "")
        
    }
    
        class func designCodeLoadingView() -> UIView {
    
            return Bundle(for: self).loadNibNamed("LoadingView", owner: self, options: nil)![0] as! UIView
        }
    }
    
    public extension UIView {
    
        struct LoadingViewConstants {
            static let Tag = 1000
        }
    
        public func showLoading() {
    
            if self.viewWithTag(LoadingViewConstants.Tag) != nil {
                // If loading view is already found in current view hierachy, do nothing
                return
            }
    
            let loadingXibView = LoadingView.designCodeLoadingView()
            loadingXibView.frame = self.bounds
            loadingXibView.tag = LoadingViewConstants.Tag
            self.addSubview(loadingXibView)
    
            loadingXibView.alpha = 0
            SpringAnimation.spring(duration: 0.7, animations: {
                loadingXibView.alpha = 1
            })
        }
    
        public func hideLoading() {
    
            if let loadingXibView = self.viewWithTag(LoadingViewConstants.Tag) {
                loadingXibView.alpha = 1
    
                SpringAnimation.springWithCompletion(duration: 0.7, animations: {
                    loadingXibView.alpha = 0
                    loadingXibView.transform = CGAffineTransform(scaleX: 3, y: 3)
                }, completion: { (completed) -> Void in
                    loadingXibView.removeFromSuperview()
                })
            }
        }
}

//public class LoadingView: UIView {
//    
//    @IBOutlet public weak var indicatorView: SpringView!
//    
//    override public func awakeFromNib() {
//        let animation = CABasicAnimation()
//        animation.keyPath = "transform.rotation.z"
//        animation.fromValue = degreesToRadians(degrees: 0)
//        animation.toValue = degreesToRadians(degrees: 360)
//        animation.duration = 0.9
//        animation.repeatCount = HUGE
//        indicatorView.layer.add(animation, forKey: "")
//    }
//    
//    class func designCodeLoadingView() -> UIView {
//        
//        return Bundle(for: self).loadNibNamed("LoadingView", owner: self, options: nil)![0] as! UIView
//    }
//}
//
//public extension UIView {
//    
//    struct LoadingViewConstants {
//        static let Tag = 1000
//    }
//    
//    public func showLoading() {
//        
//        if self.viewWithTag(LoadingViewConstants.Tag) != nil {
//            // If loading view is already found in current view hierachy, do nothing
//            return
//        }
//        
//        let loadingXibView = LoadingView.designCodeLoadingView()
//        loadingXibView.frame = self.bounds
//        loadingXibView.tag = LoadingViewConstants.Tag
//        self.addSubview(loadingXibView)
//        
//        loadingXibView.alpha = 0
//        SpringAnimation.spring(duration: 0.7, animations: {
//            loadingXibView.alpha = 1
//        })
//    }
//    
//    public func hideLoading() {
//        
//        if let loadingXibView = self.viewWithTag(LoadingViewConstants.Tag) {
//            loadingXibView.alpha = 1
//            
//            SpringAnimation.springWithCompletion(duration: 0.7, animations: {
//                loadingXibView.alpha = 0
//                loadingXibView.transform = CGAffineTransform(scaleX: 3, y: 3)
//            }, completion: { (completed) -> Void in
//                loadingXibView.removeFromSuperview()
//            })
//        }
//    }
//    
//}
