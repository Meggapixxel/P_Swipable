//
//  SwipeableNavigationController.swift
//  DraggableView
//
//  Created by Vadim Zhydenko on 12.03.2020.
//  Copyright © 2020 Vadim Zhydenko. All rights reserved.
//

import UIKit
import P_Swipable

class SwipeableNavigationController: UINavigationController, P_Swipeable {
    
    static func make() -> SwipeableNavigationController {
        let rootViewController = SwipeableNavigationControllerChild()
        let navigationController = SwipeableNavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.shadowImage = UIImage()
        return navigationController
    }
    
    class SwipeableNavigationControllerChild: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .secondarySystemBackground
            navigationItem.title = "Swipe me up"
            
            let button = UIButton(type: .system)
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            button.addTarget(self, action: #selector(moveNext), for: .touchUpInside)
            button.setTitle("Next", for: .normal)
        }
        
        @objc private func moveNext() {
            navigationController?.pushViewController(SwipeableNavigationControllerChild(), animated: true)
        }
        
    }
    
    private lazy var heightConstraint = view.heightAnchor.constraint(equalToConstant: minSwipeableViewHeight)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        heightConstraint.isActive = true
        prepareSwipeable()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        updateConstraints(animated: false)
    }
    
    // MARK: - P_Swipeable
    var swipeDirection: SwipeDirection { .up }
    var minSwipeableViewHeight: CGFloat { navigationBar.frame.height + 44 + view.safeAreaInsets.bottom }
    var endedGestureSwipeableViewHeight: CGFloat { view.bounds.height > maxSwipeableViewHeight - minSwipeableViewHeight ? maxSwipeableViewHeight : minSwipeableViewHeight }
    
    func updateConstraints(to height: CGFloat, animated: Bool) {
        if animated {
            heightConstraint.constant = height
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseInOut,
                animations: { self.swipeableView.superview?.layoutIfNeeded() },
                completion: nil
            )
        } else {
            heightConstraint.constant = height
        }
    }
    
}
