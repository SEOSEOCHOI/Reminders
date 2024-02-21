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
// MARK: Transition
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
    
    func loadImageToDocument(fileName: String) -> UIImage? {
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpg")
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())

        } else {
            return nil
        }
    }
    func saveImageToDocument(image: UIImage, fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpg")
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }// 압축을 통해 용량을 줄여줌
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
    
}
