//
//  UIColor+Extensions.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/1/23.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
