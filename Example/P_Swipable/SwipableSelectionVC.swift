//
//  SwipeableSelectionVC.swift
//  DraggableView
//
//  Created by Vadim Zhydenko on 12.03.2020.
//  Copyright © 2020 Vadim Zhydenko. All rights reserved.
//

import UIKit

class SwipeableSelectionVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemBackground
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.row {
        case 1:
            cell.textLabel?.text = "Swipe from bottom | UINavigationController"
        case 2:
            cell.textLabel?.text = "Swipe from top & bottom | UIView"
        default:
            cell.textLabel?.text = "Swipe from top | UIViewController"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            navigationController?.pushViewController(SwipeableBottomVC(), animated: true)
        case 2:
            navigationController?.pushViewController(SwipeableViewViewController(), animated: true)
        default:
            navigationController?.pushViewController(SwipeableTopVC(), animated: true)
        }
    }
    
}
