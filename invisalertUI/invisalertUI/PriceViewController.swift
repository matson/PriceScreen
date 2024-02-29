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
    
    @IBOutlet weak var midLabel2: UILabel!
    
    @IBOutlet weak var pageViews: UILabel!
    
    @IBOutlet weak var sliderUI: UISlider!
    
    @IBOutlet weak var switchUI: UISwitch!
    
    @IBOutlet weak var price: UILabel!
    
    let minimumValue: Float = 10_000
    let maximumValue: Float = 1_000_000
    let minimumSliderValue: Float = 0
    let maximumSliderValue: Float = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let ratio = (maximumSliderValue - minimumSliderValue) / (maximumValue - minimumValue)
            
        sliderUI.minimumValue = minimumSliderValue
        sliderUI.maximumValue = maximumSliderValue
        sliderUI.value = (500_000 - minimumValue) * ratio + minimumSliderValue
        
        bigLabel.text = Constants.mainLabel
        midLabel.text = Constants.midLabel1
        midLabel2.text = Constants.midLabel2
        
        setBackground()
        
        setCircle()
    }
    
   
    //slider action
    @IBAction func slideAction(_ sender: UISlider) {
        
        let value = (sender.value - minimumSliderValue) / (maximumSliderValue - minimumSliderValue) * (maximumValue - minimumValue) + minimumValue
            // Perform actions based on the slider's value
            print("Slider value: \(value)")
   
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

