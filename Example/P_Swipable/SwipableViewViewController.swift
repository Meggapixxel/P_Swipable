//
//  SwipeableViewViewController.swift
//  DraggableView
//
//  Created by Vadim Zhydenko on 12.03.2020.
//  Copyright © 2020 Vadim Zhydenko. All rights reserved.
//

import UIKit
import P_Swipable

class SwipeableViewViewController: BaseViewController {

    class ConstraintSwipeableView: UIView, P_Swipeable {
        
        private lazy var heightConstraint = heightAnchor.constraint(equalToConstant: minSwipeableViewHeight)
        
        let swipeDirection: SwipeDirection
        
        required init(swipeDirection: SwipeDirection) {
            self.swipeDirection = swipeDirection
            super.init(frame: .zero)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func commonInit() {
            heightConstraint.isActive = true
            prepareSwipeable()
            
            switch swipeDirection {
            case .down: layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            case .up: layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            layer.cornerRadius = 20
            layer.shadowOffset = .zero
            layer.shadowRadius = 15
            layer.shadowOpacity = 0.3
            layer.shadowColor = UIColor.black.cgColor
        }
        
        override func safeAreaInsetsDidChange() {
            super.safeAreaInsetsDidChange()
            updateConstraints(animated: false)
        }
        
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
    
    class FrameSwipeableView: UIView, P_Swipeable {
        
        let swipeDirection: SwipeDirection
        
        required init(swipeDirection: SwipeDirection) {
            self.swipeDirection = swipeDirection
            super.init(frame: .zero)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func commonInit() {
            prepareSwipeable()
            
            switch swipeDirection {
            case .down: layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            case .up: layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            layer.cornerRadius = 20
            layer.shadowOffset = .zero
            layer.shadowRadius = 15
            layer.shadowOpacity = 0.3
            layer.shadowColor = UIColor.black.cgColor
        }
        
        override func safeAreaInsetsDidChange() {
            super.safeAreaInsetsDidChange()
            updateConstraints(animated: false)
        }
        
        func updateConstraints(to height: CGFloat, animated: Bool) {
            let deltaY = height - bounds.height
            let newFrame = CGRect(
                x: frame.origin.x,
                y: frame.origin.y - deltaY,
                width: bounds.width,
                height: height
            )
            if animated {
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0,
                    options: .curveEaseInOut,
                    animations: { self.frame = newFrame },
                    completion: nil
                )
            } else {
                frame = newFrame
            }
        }
        
    }
    
    private let topSwipeableView = ConstraintSwipeableView(swipeDirection: .down)
    private let bottomSwipeableView = FrameSwipeableView(swipeDirection: .up)
    
    override func viewDidLoad() {
        
        view.addSubview(topSwipeableView)
        topSwipeableView.translatesAutoresizingMaskIntoConstraints = false
        topSwipeableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topSwipeableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topSwipeableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topSwipeableView.backgroundColor = .tertiarySystemBackground

        view.addSubview(bottomSwipeableView)
        bottomSwipeableView.frame = CGRect(
            x: 0,
            y: view.bounds.height - bottomSwipeableView.minSwipeableViewHeight - view.safeAreaInsets.bottom - view.safeAreaInsets.top,
            width: view.bounds.width,
            height: bottomSwipeableView.minSwipeableViewHeight
        )
        bottomSwipeableView.backgroundColor = .tertiarySystemBackground
        
        super.viewDidLoad()
    }
    
    @objc override func collapseBottomController() {
        topSwipeableView.collapse()
        bottomSwipeableView.collapse()
    }
    
    @objc override func expandBottomController() {
        topSwipeableView.expand()
        bottomSwipeableView.expand()
    }

}
