//
//  Reuseable.swift
//  Reminders
//
//  Created by 최서경 on 2/14/24.
//

import UIKit
extension UIView: ReuseableProtocol {
    static var identifier: String {
        return description()
    }
}

extension UIViewController: ReuseableProtocol {
    static var identifier: String {
        return description()
    }
}
