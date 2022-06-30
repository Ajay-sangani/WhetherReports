//
//  View+Extension.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import UIKit

enum AIEdge:Int {
    case
    Top,
    Left,
    Bottom,
    Right,
    Top_Left,
    Top_Right,
    Bottom_Left,
    Bottom_Right,
    All,
    None
}

extension UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func addRoundShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0,
                   cornerRadius: CGFloat = 10) {
        layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6).cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 0.5
    }
    
    func setupCardView(_ radius: CGFloat = 10.0, shadowRadius: CGFloat = 10.0) {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 0.1
        self.layer.cornerRadius = radius
        self.layer.shadowRadius = shadowRadius
    }
    
    func circularView(isBorderless: Bool = true, color: UIColor = UIColor.white.withAlphaComponent(0.9), borderWidth: CGFloat = 1.5) {
        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true
        if isBorderless {
            layer.borderWidth = borderWidth
            layer.borderColor = color.cgColor
        }
    }
    
    func cornerRadius(cornerRadius: CGFloat = 5) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    func applyBorder(_ borderWidth: CGFloat = 1.0, color: UIColor = UIColor.lightGray, cornerRadius: CGFloat = 5) {
        layer.borderWidth = borderWidth
        layer.borderColor = color.cgColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func applyRoundedBorder(color: UIColor = .black, width: CGFloat = 0.0) {
        layer.cornerRadius = frame.height / 2
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func applyBorder(color: UIColor = .black, width: CGFloat = 0.0) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func roundCorner() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    func shadow(radius: CGFloat = 10.0, color: UIColor = .lightGray) {
        layer.cornerRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 2.0
    }
    
    func cardView(_ radius: CGFloat = 10.0, shadowRadius: CGFloat = 10.0) {
        layer.cornerRadius = radius
        layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = 0.5
    }
    
    func applyNavShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 4.0)
        layer.shadowRadius = 4
    }
    
    func applyShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 6.0, height: 4.0)
        layer.shadowRadius = 6
    }
    
    func applyDashedBorder(color: UIColor = UIColor.black) {
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [4,2]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        shapeLayer.cornerRadius = 5.0
        layer.addSublayer(shapeLayer)
    }
    
    func animShow(_ duration: CGFloat = 1.0){
        self.alpha = 0.0
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
                        self.alpha = 1.0
                       }, completion: nil)
        self.isHidden = false
    }
    
    func animHide(_ duration: CGFloat = 1.0){
        self.alpha = 1.0
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()
                        self.alpha = 0.0
                        
                       },  completion: {(_ completed: Bool) -> Void in
                        self.isHidden = true
                       })
    }
    
    func applyShadowWithCornerRadius(color:UIColor, opacity:Float, radius: CGFloat, edge:AIEdge, shadowSpace:CGFloat, cornerRadius: CGFloat)    {

        var sizeOffset:CGSize = CGSize.zero
        
        switch edge {
        case .Top:
            sizeOffset = CGSize(width: 0, height: -shadowSpace)
        case .Left:
            sizeOffset = CGSize(width: -shadowSpace, height: 0)
        case .Bottom:
            sizeOffset = CGSize(width: 0, height: shadowSpace)
        case .Right:
            sizeOffset = CGSize(width: shadowSpace, height: 0)
            
            
        case .Top_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: -shadowSpace)
        case .Top_Right:
            sizeOffset = CGSize(width: shadowSpace, height: -shadowSpace)
        case .Bottom_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: shadowSpace)
        case .Bottom_Right:
            sizeOffset = CGSize(width: shadowSpace, height: shadowSpace)
            
            
        case .All:
            sizeOffset = CGSize(width: 0, height: 0)
        case .None:
            sizeOffset = CGSize.zero
        }

        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true

        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = sizeOffset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false

        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath
    }
}
