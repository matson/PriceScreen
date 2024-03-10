//
//  Test.swift
//  invisalertUI
//
//  Created by Tracy Adams on 3/8/24.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mySlider = UISlider()
        let trackHeight: CGFloat = 10 // Set the desired height for the slider bar
        
        mySlider.minimumTrackTintColor = .blue // Set the color for the minimum value side of the slider
        mySlider.maximumTrackTintColor = .gray // Set the color for the maximum value side of the slider
        
        // Customize the appearance of the slider bar
        mySlider.setMinimumTrackImage(UIImage(), for: .normal)
        mySlider.setMaximumTrackImage(UIImage(), for: .normal)
        
        let trackRect = mySlider.trackRect(forBounds: mySlider.bounds)
        let customTrack = UIView(frame: CGRect(x: trackRect.origin.x, y: trackRect.origin.y, width: trackRect.size.width, height: trackHeight))
        customTrack.backgroundColor = .blue // Set the desired color for the slider bar
        mySlider.insertSubview(customTrack, at: 1)
        
        view.addSubview(mySlider)
    }
}
