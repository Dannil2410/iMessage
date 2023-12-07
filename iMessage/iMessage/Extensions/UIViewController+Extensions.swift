//
//  UIViewController+Extensions.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 30.11.2023.
//

import UIKit

extension UIViewController: Routable {
    func showViewController(_ controller: UIViewController, animated: Bool) {
        if let navVC = self as? UINavigationController {
            navVC.pushViewController(controller, animated: true)
        } else {
            presentViewController(controller, animated: animated)
        }
    }
    
    func presentViewController(_ controller: UIViewController, animated: Bool) {
        present(controller, animated: true)
    }
    
    func fullScreenPresentViewController(_ controller: UIViewController, animated: Bool) {
        controller.modalPresentationStyle = .fullScreen
        presentViewController(controller, animated: animated)
    }
    
    func dismissViewController(animated: Bool) {
        dismiss(animated: true)
    }
    
    func configureCell<T: SelfConfiguringCell, U: Hashable>(_ type: T.Type, collectionView: UICollectionView, forValue value: U, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("DEBUG: Error by trying dequeue cell with identifier \(T.identifier)")
        }
        cell.set(using: value)
        return cell
    }
}
