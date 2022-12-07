//
//  Extension + UIView.swift
//  MovieFlix
//
//  Created by Pranay Jadhav  on 29/11/22.
//

import UIKit

//MARK: - Extensions for UIViews
extension UIView {
    
    /// Adds drop shadow to the view
    func dropShadow(scale: Bool = true, opacity: Float = 0.5) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = .zero
        layer.shadowRadius = 15
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    @IBInspectable
    var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func gradientView() {
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.frame.size
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.withAlphaComponent(1).cgColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

