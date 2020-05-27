//
//  SwipeableViewController.swift
//  DraggableView
//
//  Created by Vadim Zhydenko on 12.03.2020.
//  Copyright © 2020 Vadim Zhydenko. All rights reserved.
//

import UIKit
import P_Swipable

extension SwipeableViewController {
    
    static func make() -> SwipeableViewController {
        return SwipeableViewController()
    }
    
}

final class SwipeableViewController: UIViewController {

    private lazy var heightConstraint = view.heightAnchor.constraint(equalToConstant: minSwipeableViewHeight)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        heightConstraint.isActive = true
        prepareSwipeable()
        
        view.backgroundColor = .secondarySystemBackground

        let label = UILabel()
        label.text = "Swipe me down"
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: minSwipeableViewHeight).isActive = true
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        updateConstraints(animated: false)
    }
    
}
 
// MARK: - P_Swipeable
extension SwipeableViewController: P_Swipeable {
    
    var swipeDirection: SwipeDirection { .down }
    
    func updateConstraints(to height: CGFloat, animated: Bool, _ completion: (() -> ())?) {
        heightConstraint.constant = height
        if animated {
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseInOut,
                animations: { self.swipeableView.superview?.layoutIfNeeded() },
                completion: nil
            )
        } else {
            swipeableView.superview?.layoutIfNeeded()
        }
    }
    
    var endedGestureSwipeableViewHeight: CGFloat {
        let currentHeight = swipeableView.bounds.height
        let max2 = maxSwipeableViewHeight / 2
        
        let accuracy: CGFloat = 50
        
        if currentHeight < (max2 - accuracy) {
            return minSwipeableViewHeight
        } else if (max2 - accuracy...max2 + accuracy).contains(currentHeight) {
            return max2
        } else {
            return maxSwipeableViewHeight
        }
    }

}
