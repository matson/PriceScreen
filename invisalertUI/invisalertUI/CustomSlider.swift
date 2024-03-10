//
//  CustomSlider.swift
//  invisalertUI
//
//  Created by Tracy Adams on 3/8/24.
//

import Foundation
import UIKit

class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var customBounds = super.trackRect(forBounds: bounds)
        let trackHeight: CGFloat = 50 // Set the desired height for the slider bar
        
        customBounds.size.height = trackHeight
        return customBounds
    }
}
