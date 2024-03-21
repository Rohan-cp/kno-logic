//
//  Extensions.swift
//  Dials
//
//  Created by Rohan Prashanth on 20/03/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            self.addSubview($0)
        })
    }

}
