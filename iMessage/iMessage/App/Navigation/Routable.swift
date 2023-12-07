//
//  Routable.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 01.12.2023.
//

import UIKit

protocol Routable {
    func showViewController(_ controller: UIViewController, animated: Bool)
    func presentViewController(_ controller: UIViewController, animated: Bool)
    func fullScreenPresentViewController(_ controller: UIViewController, animated: Bool)
    func dismissViewController(animated: Bool)
}
