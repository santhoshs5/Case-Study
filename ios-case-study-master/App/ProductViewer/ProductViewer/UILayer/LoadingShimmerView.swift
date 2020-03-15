//
//  LoadingShimmerView.swift
//  ProductViewer
//
//  Created by santhosh.kumar on 14/03/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo
import UIKit

final class LoadingShimmerView: UIView {
    // MARK: - Properties
    
    private lazy var gradientView: UIView = {
        let gradientView: UIView = UIView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.backgroundColor = .clear
        
        return gradientView
    }()
    
    private lazy var animation: CABasicAnimation = {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -gradientView.frame.size.width
        animation.toValue = gradientView.frame.size.width
        animation.duration = 1.5
        animation.repeatCount = .infinity
        
        return animation
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let angle: CGFloat = 90.0 * .pi / 180.0
        let transform: CATransform3D = CATransform3DIdentity
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [HarmonyColor.targetNeutralGrayColor.cgColor,
                                HarmonyColor.targetFadeAwayGrayColor.cgColor,  HarmonyColor.targetNeutralGrayColor.cgColor]
        gradientLayer.frame = gradientView.frame
        gradientLayer.transform = CATransform3DRotate(transform, angle, 0.0, 0.0, 1.0)
        gradientLayer.add(animation, forKey: "sliding")
        
        return gradientLayer
    }()
    
    private var isAnimating: Bool = false
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = gradientView.frame
        animation.fromValue = -gradientView.frame.size.width
        animation.toValue = gradientView.frame.size.width
        
        if isAnimating {
            startAnimation()
        }
    }
    
    // MARK: - Public Methods
    
    func startAnimation() {
        isAnimating = true
        gradientView.isHidden = false
        gradientLayer.removeAnimation(forKey: "sliding")
        gradientLayer.add(animation, forKey: "sliding")
    }
    
    func stopAnimation() {
        isAnimating = false
        gradientView.isHidden = true
        gradientLayer.removeAnimation(forKey: "sliding")
    }
    
    // MARK: - Private Methods
    
    private func initComponents() {
        backgroundColor = HarmonyColor.targetNeutralGrayColor
        clipsToBounds = true
        
        addSubview(gradientView)
        gradientView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        gradientView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        gradientView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }

}
