//
//  P_Swipeable.swift
//  DraggableView
//
//  Created by Vadim Zhydenko on 12.03.2020.
//  Copyright © 2020 Vadim Zhydenko. All rights reserved.
//

import UIKit

/// Enumeration that specifies swipe direction
public enum SwipeDirection {
    case up, down
}

public class PanGestureRecognizer: UIPanGestureRecognizer {
    
    var prevTranslation: CGPoint?
    
    override public func translation(in view: UIView?) -> CGPoint {
        let superTranslation = super.translation(in: view)
        prevTranslation = superTranslation
        return superTranslation
    }
    
}

/// Type which can be used to animate swipe action to change height of view.
public protocol P_Swipeable {
    
    /// The minimum value of height for `swipeableView`
    var minSwipeableViewHeight: CGFloat { get }
    
    /// The maximum value of height for `swipeableView`
    var maxSwipeableViewHeight: CGFloat { get }
    
    /// The value of height for `swipeableView` when `PanGestureRecognizer` state equals "UIGestureRecognizer.State.ended".
    /// Place where you can change value of height for `swipeableView` depends on its current position
    var endedGestureSwipeableViewHeight: CGFloat { get }
    
    /// View that is able to change its height
    var swipeableView: UIView { get }
    
    /// The value thats determine where `swipeableView` must be swipe
    var swipeDirection: SwipeDirection { get }
    
    /// Called when the `swipeableView` must change its height
    ///
    /// - Parameters:
    ///   - height: value of height that must be set for `swipeableView`
    ///   - animated: is the chage of height must be animated
    ///   - completion: callback for the end of animation
    func updateConstraints(to height: CGFloat, animated: Bool, _ completion: (() -> ())?)
    
}
/// Default implementations
public extension P_Swipeable {
    
    var minSwipeableViewHeight: CGFloat { 44 + swipeableView.safeAreaInsets.bottom }

    func updateConstraints(to height: CGFloat, animated: Bool) {
        updateConstraints(to: height, animated: animated, nil)
    }
    
}

public extension P_Swipeable {
    
    var isMaximized: Bool { swipeableView.bounds.height == maxSwipeableViewHeight }
    
    var isMinimized: Bool { swipeableView.bounds.height == minSwipeableViewHeight }
    
    /// Change height of `swipeableView` to `minSwipeableViewHeight`
    func collapse(animated: Bool = true, _ completion: (() -> ())? = nil) {
        updateConstraints(to: minSwipeableViewHeight, animated: animated, completion)
    }
    
    /// Change height of `swipeableView` to `maxSwipeableViewHeight`
    func expand(animated: Bool = true, _ completion: (() -> ())? = nil) {
        updateConstraints(to: maxSwipeableViewHeight, animated: animated, completion)
    }
    
    /// Method to update current height of `swipeableView`
    func updateConstraints(animated: Bool, _ completion: (() -> ())? = nil) {
        swipeableView.layoutIfNeeded()
        let newHeight = max(minSwipeableViewHeight, min(maxSwipeableViewHeight, swipeableView.bounds.height))
        updateConstraints(to: newHeight, animated: animated, completion)
    }
    
    /// Default implementation of `endedGestureSwipeableViewHeight` of `P_Swipeable`.
    var endedGestureSwipeableViewHeight: CGFloat {
        if swipeableView.bounds.height >= maxSwipeableViewHeight / 2 {
            return maxSwipeableViewHeight
        } else {
            return minSwipeableViewHeight
        }
    }
    
    /// Handle swipe gesture
    func handlePanGesture(_ gesture: PanGestureRecognizer) {
        switch gesture.state {
        case .changed: panGestureChanged(gesture: gesture)
        case .ended: panGestureEnded()
        default: break
        }
    }
    
    /// Method to prepare `swipeableView` to respond swipe gesture action.
    func prepareSwipeable(panGestureRecognizer: PanGestureRecognizer) {
        swipeableView.addGestureRecognizer(panGestureRecognizer)
        updateConstraints(to: minSwipeableViewHeight, animated: false)
    }
    
}

private extension P_Swipeable {
    
    /// Handle swipe gesture when `state` of `PanGestureRecognizer` equals "UIGestureRecognizer.State.changed".
    func panGestureChanged(gesture: PanGestureRecognizer) {
        let prevTranslation = gesture.prevTranslation ?? gesture.translation(in: nil)
        let translation = gesture.translation(in: nil)
        
        let translationDelta = translation.y - prevTranslation.y
//        print(translationDelta)
        let desiredHeight: CGFloat
        switch swipeDirection {
        case .up: desiredHeight = swipeableView.bounds.height - translationDelta
        case .down: desiredHeight = swipeableView.bounds.height + translationDelta
        }

        let newHeight = max(minSwipeableViewHeight, min(maxSwipeableViewHeight, desiredHeight))
        updateConstraints(to: newHeight, animated: false)
    }
    
    /// Handle swipe gesture when `state` of `PanGestureRecognizer` equals "UIGestureRecognizer.State.ended".
    func panGestureEnded() {
        let newHeight = max(minSwipeableViewHeight, min(maxSwipeableViewHeight, endedGestureSwipeableViewHeight))
        updateConstraints(to: newHeight, animated: true)
    }
    
}


// MARK: - Default implementations for UIViewController
public extension P_Swipeable where Self: UIViewController {
    
    /// Default implementation of `swipeableView` of `P_Swipeable`. The default value is `view`, means that root view of current
    /// subclass of UIViewController is able to change its height.
    var swipeableView: UIView { view }
    
    /// Default implementation of `maxSwipeableViewHeight` of `P_Swipeable`.
    var maxSwipeableViewHeight: CGFloat {
        guard let parentView = swipeableView.superview else { return minSwipeableViewHeight }
        return parentView.bounds.height / 2
    }
    
    /// Default implementation of `prepareSwipeable(panGestureRecognizer:)` of `P_Swipeable`.
    func prepareSwipeable() {
        let panGestureRecognizer = PanGestureRecognizer(target: self, action: #selector(swipeablePanGesture))
        prepareSwipeable(panGestureRecognizer: panGestureRecognizer)
    }
    
}

// MARK: - Default implementations for UIView
public extension P_Swipeable where Self: UIView {
    
    /// Default implementation of `swipeableView` of `P_Swipeable`. The default value is `self`, means that current
    /// subclass of UIView is able to change its height.
    var swipeableView: UIView { self }
    
    /// Default implementation of `maxSwipeableViewHeight` of `P_Swipeable`.
    var maxSwipeableViewHeight: CGFloat {
        guard let parentView = superview else { return minSwipeableViewHeight }
        return parentView.bounds.height / 2
    }
    
    /// Default implementation of `prepareSwipeable(panGestureRecognizer:)` of `P_Swipeable`.
    func prepareSwipeable() {
        let panGestureRecognizer = PanGestureRecognizer(target: self, action: #selector(swipeablePanGesture))
        prepareSwipeable(panGestureRecognizer: panGestureRecognizer)
    }
    
}

private extension NSObject {
    
    @objc func swipeablePanGesture(_ gesture: PanGestureRecognizer) {
        guard let expandable = self as? P_Swipeable else { return }
        expandable.handlePanGesture(gesture)
    }
    
}
