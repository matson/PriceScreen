//
//  ViewController.swift
//  invisalertUI
//
//  Created by Tracy Adams on 2/29/24.
//

import UIKit
import SVGKit

class PriceViewController: UIViewController {

    //To note: 
    //need to convert all images from SVG -> UIimages
    
    @IBOutlet weak var circleImage: UIImageView!
    
    @IBOutlet weak var bigLabel: UILabel!
    
    @IBOutlet weak var midLabel: UILabel!
    
    @IBOutlet weak var pageViews: UILabel!
    
    @IBOutlet weak var sliderUI: UISlider!
    
    @IBOutlet weak var switchUI: UISwitch!
    
    @IBOutlet weak var price: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        setBackground()
        
        setCircle()
    }
    
    @IBAction func pressed(_ sender: UIButton) {
    }
    
    func convert(svgFileName: String, withExtension: String) -> UIImage? {
        if let svgURL = Bundle.main.url(forResource: svgFileName, withExtension: withExtension) {
            let svgData = try? Data(contentsOf: svgURL)
            let svgImage = SVGKImage(data: svgData)
            let svgUIImage = svgImage?.uiImage
            return svgUIImage
        }
        return nil
    }
    
    func setCircle(){
        if let circleSVGImage = convert(svgFileName: "pattern-circles", withExtension: "svg") {
            circleImage.image = circleSVGImage
        } else {
            // Handle the case where the SVG file couldn't be loaded or converted
        }
    }
    
    func setBackground(){
        if let svgUIImage = convert(svgFileName: "bg-pattern", withExtension: "svg") {
            let patternColor = UIColor(patternImage: svgUIImage)
            view.backgroundColor = patternColor
        } else {
            // Handle the case where the SVG file couldn't be loaded or converted
        }
    }


}

