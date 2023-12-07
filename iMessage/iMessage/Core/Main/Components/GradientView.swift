//
//  GradientView.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 03.12.2023.
//

import UIKit

final class GradientView: UIView {
    private lazy var gradientLayer = CAGradientLayer()
    
    enum Point {
        case topLeading
        case leading
        case bottomLeading
        case top
        case center
        case bottom
        case topTrailing
        case trailing
        case bottomTrailing

        var point: CGPoint {
            switch self {
            case .topLeading:
                return CGPoint(x: 0, y: 0)
            case .leading:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeading:
                return CGPoint(x: 0, y: 1.0)
            case .top:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottom:
                return CGPoint(x: 0.5, y: 1.0)
            case .topTrailing:
                return CGPoint(x: 1.0, y: 0.0)
            case .trailing:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomTrailing:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }

    init(startColor: UIColor, endColor: UIColor, from startPoint: Point, to endPoint: Point) {
        super.init(frame: .zero)
        
        setupGradient(startColor: startColor, endColor: endColor, from: startPoint, to: endPoint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    private func setupGradient(startColor: UIColor, endColor: UIColor, from startPoint: Point, to endPoint: Point) {
        self.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
    }
}
