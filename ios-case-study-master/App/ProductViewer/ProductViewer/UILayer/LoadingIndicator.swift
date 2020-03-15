//
//  LoadingIndicator.swift
//  Tempo
//
//  Created by santhosh.kumar on 12/03/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Tempo

final class LoadingIndicator: UIView {

    public var numberOfDot: Int = 3

    public var dotColor: UIColor = HarmonyColor.targetBullseyeRedColor {
        didSet {
            for dot in dots {
                dot.backgroundColor = dotColor.cgColor
            }
        }
    }

    private let dotRadius: CGFloat = 2.0
    private let dotSpacing: CGFloat = 8.0
    private let animationOffset: TimeInterval = 0.2

    lazy var dots: [CALayer] = {
        var layers: [CALayer] = [CALayer]()
        for index in 1...numberOfDot {
            let layer: CALayer = CALayer()
            layer.bounds = CGRect(origin: .zero, size: CGSize(width: 2 * dotRadius, height: 2 * dotRadius))
            layer.cornerRadius = dotRadius
            layer.backgroundColor = dotColor.cgColor
            layer.opacity = Float(0.4)
            layers.append(layer)
        }
        return layers
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        for dot in dots {
            self.layer.addSublayer(dot)
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        let frameCenter: CGPoint = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        let middle: Int = dots.count / 2
        for (index, layer) in dots.enumerated() {
            let loadingDotPositionX: CGFloat = frameCenter.x + CGFloat(index - middle) * ((dotRadius * 2) + dotSpacing)
            layer.frame = CGRect(x: loadingDotPositionX, y: frameCenter.y, width: dotRadius * 2, height: dotRadius * 2)
        }
    }

    public func startAnimating() {
        var offset: TimeInterval = 0.0
        for dot in dots {
            dot.removeAllAnimations()
            dot.add(dotAnimation(offset), forKey: "scaleAndFade")
            offset += animationOffset
        }
    }

    public func stopAnimating() {
        for dot in dots {
            dot.removeAllAnimations()
        }
    }

    private func dotAnimation(_ after: TimeInterval = 0) -> CAAnimationGroup {
        let scaleUp: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleUp.beginTime = after
        scaleUp.fromValue = 1
        scaleUp.toValue = 3
        scaleUp.duration = 0.3
        scaleUp.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let scaleDown: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleDown.beginTime = scaleUp.duration + after
        scaleDown.fromValue = 3
        scaleDown.toValue = 1
        scaleDown.duration = 0.3
        scaleDown.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let fadeIn: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        fadeIn.beginTime = after
        fadeIn.fromValue = Float(0.4)
        fadeIn.toValue = 1.0
        fadeIn.duration = 0.3
        fadeIn.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let fadeOut: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOut.beginTime = fadeIn.duration + after
        fadeOut.fromValue = 1.0
        fadeOut.toValue = Float(0.4)
        fadeOut.duration = 0.3
        fadeOut.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let totalAnimationTimeInterval: TimeInterval = TimeInterval(dots.count) * animationOffset + TimeInterval(0.4)
        let animationGroup: CAAnimationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleUp, scaleDown, fadeIn, fadeOut]
        animationGroup.repeatCount = Float.infinity
        animationGroup.duration = CFTimeInterval(totalAnimationTimeInterval)

        return animationGroup
    }

}

