//
//  SwipeableTopVC.swift
//  DraggableView
//
//  Created by Vadim Zhydenko on 12.03.2020.
//  Copyright © 2020 Vadim Zhydenko. All rights reserved.
//

import UIKit
import P_Swipable

class SwipeableTopVC: BaseViewController {

    private let swipeableController = SwipeableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(swipeableController)
        view.addSubview(swipeableController.view)
        swipeableController.didMove(toParent: self)
        swipeableController.view.translatesAutoresizingMaskIntoConstraints = false
        swipeableController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        swipeableController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        swipeableController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        swipeableController.view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        swipeableController.view.layer.cornerRadius = 20
        swipeableController.view.layer.shadowOffset = .zero
        swipeableController.view.layer.shadowRadius = 15
        swipeableController.view.layer.shadowOpacity = 0.3
        swipeableController.view.layer.shadowColor = UIColor.black.cgColor
    }
    
    @objc override func collapseBottomController() {
        swipeableController.collapse()
    }
    
    @objc override func expandBottomController() {
        swipeableController.expand()
    }

}
