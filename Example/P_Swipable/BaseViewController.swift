//
//  BaseViewController.swift
//  DraggableView
//
//  Created by Vadim Zhydenko on 12.03.2020.
//  Copyright © 2020 Vadim Zhydenko. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let card0 = UIView()
        view.addSubview(card0)
        card0.frame.size = CGSize(width: 150, height: 200)
        card0.center = CGPoint(x: view.center.x - 100, y: view.center.y)
        card0.backgroundColor = .tertiarySystemBackground
        card0.layer.cornerRadius = 20
        card0.layer.shadowOffset = .zero
        card0.layer.shadowRadius = 15
        card0.layer.shadowOpacity = 0.3
        card0.layer.shadowColor = UIColor.black.cgColor
        card0.isUserInteractionEnabled = true
        card0.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGesture)))
        
        let collapseButton = UIButton(type: .system)
        collapseButton.setTitle("Collapse", for: .normal)
        collapseButton.addTarget(self, action: #selector(collapseBottomController), for: .touchUpInside)
        card0.addSubview(collapseButton)
        collapseButton.translatesAutoresizingMaskIntoConstraints = false
        collapseButton.centerXAnchor.constraint(equalTo: card0.centerXAnchor).isActive = true
        collapseButton.centerYAnchor.constraint(equalTo: card0.centerYAnchor).isActive = true
        
        
        let card1 = UIView()
        view.addSubview(card1)
        card1.frame.size = CGSize(width: 150, height: 200)
        card1.center = CGPoint(x: view.center.x + 100, y: view.center.y)
        card1.backgroundColor = .tertiarySystemBackground
        card1.layer.cornerRadius = 20
        card1.layer.shadowOffset = .zero
        card1.layer.shadowRadius = 15
        card1.layer.shadowOpacity = 0.3
        card1.layer.shadowColor = UIColor.black.cgColor
        card1.isUserInteractionEnabled = true
        card1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGesture)))
        
        let expandButton = UIButton(type: .system)
        expandButton.setTitle("Expand", for: .normal)
        expandButton.addTarget(self, action: #selector(expandBottomController), for: .touchUpInside)
        card1.addSubview(expandButton)
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        expandButton.centerXAnchor.constraint(equalTo: card1.centerXAnchor).isActive = true
        expandButton.centerYAnchor.constraint(equalTo: card1.centerYAnchor).isActive = true
    }
    
    @objc private func panGesture(_ gesture: UIPanGestureRecognizer) {
        guard let targetView = gesture.view else { return }
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: view)
            targetView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        case .ended:
            let frame = targetView.frame
            targetView.transform = .identity
            targetView.frame = frame
        default: break
        }
    }
    
    @objc func collapseBottomController() {
        
    }
    
    @objc func expandBottomController() {
        
    }

}
