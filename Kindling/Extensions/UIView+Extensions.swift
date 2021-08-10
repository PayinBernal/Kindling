//
//  UIView+Extensions.swift
//  Kindling
//
//  Created by Eduardo Bernal on 04/08/21.
//

import Foundation
import UIKit

//MARK: - Auto layout
extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat = 0,
                height: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        anchor(top: top, left: left, bottom: bottom, right: right, paddingTop: paddingTop, paddingLeft: paddingLeft, paddingBottom: paddingBottom, paddingRight: paddingRight)
        
        if width > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: width))
        }
        if height > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: height))
        }
        
        anchors.forEach { $0.isActive = true }
        
        return anchors
    }
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: paddingTop))
        }
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: paddingLeft))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom))
        }
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -paddingRight))
        }
        
        anchors.forEach { $0.isActive = true }
        
        return anchors
    }
    
    @discardableResult
    func anchorToSuperview() -> [NSLayoutConstraint] {
        return anchor(top: superview?.topAnchor,
                      left: superview?.leftAnchor,
                      bottom: superview?.bottomAnchor,
                      right: superview?.rightAnchor)
    }
}

//MARK: - Shadow

extension UIView {
    func applyShadow(radius: CGFloat,
                     opacity: Float,
                     offset: CGSize,
                     color: UIColor = .black) {
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
}

//MARK: - Corner radius

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
}

//MARK: - Loading view

extension UIView {
    func showLoadingView() {
        let view = UIView(frame: bounds)
        view.backgroundColor = .clear
        view.tag = 10000
        
        let loadingIndicatorView = UIActivityIndicatorView(style: .medium)
        loadingIndicatorView.tintColor = .white
        loadingIndicatorView.center = view.center
        loadingIndicatorView.startAnimating()
        loadingIndicatorView.hidesWhenStopped = true
        view.addSubview(loadingIndicatorView)
        
        addSubview(view)
    }
    
    func removeLoadingView() {
        let loaderView = viewWithTag(10000)
        loaderView?.removeFromSuperview()
    }
}

//MARK: - Background gradient

extension UIView {
    func configureBackgroundGradient() {
        let backgroundGray = Constants.Color.backgroundGray
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, backgroundGray.cgColor]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
