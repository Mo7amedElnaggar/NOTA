//
//  extensions.swift
//  xNota
//
//  Created by Mohamed El-Naggar on 6/25/17.
//  Copyright © 2017 Mohamed El-Naggar. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func roundCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func makeUIViewShadow() {
        //0.0594905 0.216807 0.39227 1)
        //
//        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0.001, alpha: 0.5).cgColor
//        self.layer.shadowOpacity =  0.7
//        self.layer.shadowOffset = .zero
//        self.layer.shadowRadius = 20
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        self.layer.shouldRasterize = true
    }
}


extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}
