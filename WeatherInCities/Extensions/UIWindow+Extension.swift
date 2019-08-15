//
//  UIWindow + Extension.swift
//  WeatherInCities
//
//  Created by Roman Novakov on 8/15/19.
//  Copyright © 2019 novacom. All rights reserved.
//


import UIKit

public extension UIWindow {
    
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}

// MARK: - Window transition

public extension UIWindow {

    struct TransitionOptions {

        public enum Curve {
            case linear
            case easeIn
            case easeOut
            case easeInOut

            internal var function: CAMediaTimingFunction {
                var key: CAMediaTimingFunctionName
                switch self {
                case .linear:
                    key = CAMediaTimingFunctionName.linear
                case .easeIn:
                    key = CAMediaTimingFunctionName.easeIn
                case .easeOut:
                    key = CAMediaTimingFunctionName.easeOut
                case .easeInOut:
                    key = CAMediaTimingFunctionName.easeInEaseOut
                }
                return CAMediaTimingFunction(name: key)
            }
        }

        public enum Direction {
            case fade
            case toTop
            case toBottom
            case toLeft
            case toRight

            internal func transition() -> CATransition {
                let transition = CATransition()
                transition.type = CATransitionType.push
                switch self {
                case .fade:
                    transition.type = CATransitionType.fade
                    transition.subtype = nil
                case .toLeft:
                    transition.subtype = CATransitionSubtype.fromLeft
                case .toRight:
                    transition.subtype = CATransitionSubtype.fromRight
                case .toTop:
                    transition.subtype = CATransitionSubtype.fromTop
                case .toBottom:
                    transition.subtype = CATransitionSubtype.fromBottom
                }
                return transition
            }
        }

        public enum Background {
            case solidColor(_: UIColor)
            case customView(_: UIView)
        }

        /// Duration of the animation (default is 0.20s)
        public var duration: TimeInterval = 0.20

        /// Direction of the transition (default is `toRight`)
        public var direction: TransitionOptions.Direction = .toRight

        /// Style of the transition (default is `linear`)
        public var style: TransitionOptions.Curve = .linear

        /// Background of the transition (default is `nil`)
        public var background: TransitionOptions.Background? = nil

        /// Initialize a new options object with given direction and curve
        ///
        /// - Parameters:
        ///   - direction: direction
        ///   - style: style
        public init(direction: TransitionOptions.Direction = .toRight, style: TransitionOptions.Curve = .linear) {
            self.direction = direction
            self.style = style
        }

        public init() { }

        /// Return the animation to perform for given options object
        internal var animation: CATransition {
            let transition = self.direction.transition()
            transition.duration = self.duration
            transition.timingFunction = self.style.function
            return transition
        }
    }

    /// Change the root view controller of the window
    ///
    /// - Parameters:
    ///   - controller: controller to set
    ///   - options: options of the transition
    func setRootViewController(_ controller: UIViewController, options: TransitionOptions = TransitionOptions()) {

        var transitionWindow: UIWindow? = nil
        if let background = options.background {
            transitionWindow = UIWindow(frame: UIScreen.main.bounds)
            switch background {
            case .customView(let view):
                transitionWindow?.rootViewController = UIViewController.newController(withView: view, frame: transitionWindow!.bounds)
            case .solidColor(let color):
                transitionWindow?.backgroundColor = color
            }
            transitionWindow?.makeKeyAndVisible()
        }

        self.layer.add(options.animation, forKey: kCATransition)
        self.rootViewController = controller
        self.makeKeyAndVisible()

        if let window = transitionWindow {
            DispatchQueue.main.asyncAfter(deadline: (.now() + 1 + options.duration), execute: {
                window.removeFromSuperview()
            })
        }
    }
}

internal extension UIViewController {

    /// Create a new empty controller instance with given view
    ///
    /// - Parameters:
    ///   - view: view
    ///   - frame: frame
    /// - Returns: instance
    fileprivate static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
        view.frame = frame
        let controller = UIViewController()
        controller.view = view
        return controller
    }

}
