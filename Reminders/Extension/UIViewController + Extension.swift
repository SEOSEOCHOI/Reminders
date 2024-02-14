//
//  UIViewController + Extension.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit
enum TransitionStyle {
    case present
    case presentNavigation
    case presentFullNavigation
    case push
}

extension UIViewController {
    func transition<T: UIViewController>(style: TransitionStyle, viewController: T) {
        let vc = viewController
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension UIViewController {
    func setBackgroundColor() {
        view.backgroundColor = .white
    }
}
