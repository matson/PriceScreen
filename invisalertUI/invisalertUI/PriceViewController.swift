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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let minimumValue: Float = 10000
        let maximumValue: Float = 1000000
        let minimumSliderValue: Float = 0
        let maximumSliderValue: Float = 4
        
        sliderUI.minimumValue = minimumSliderValue
        sliderUI.maximumValue = maximumSliderValue
            
        bigLabel.text = Constants.mainLabel
        midLabel.text = Constants.midLabel1
        midLabel2.text = Constants.midLabel2
        
       
        //setSlider()
        
        setBackground()
        
        setCircle()
    }
    
   
    //slider action
    @IBAction func slideAction(_ sender: UISlider) {
        let value = Int(sender.value)
        let formattedValue = formatValue(value)
        pageViews.text = formattedValue + "PageViews"
        let priceValue = calculatePrice(value)
        price.text = String(priceValue)

    }
   
    
    @IBAction func pressed(_ sender: UIButton) {
        
    }
    
    //to calculate price:
    func calculatePrice(_ value: Int) -> Int {
        switch value {
        case 10000:
            return 8
        case 50000:
            return 12
        case 100000:
            return 16
        case 500000:
            return 24
        case 1000000:
            return 36
        default:
            return 0
        }
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
    
    func setSlider(){
        //this does not work for now
        if let sliderSVGImage = convert(svgFileName: "icon-slider", withExtension: "svg") {
            sliderUI.setThumbImage(sliderSVGImage , for: .normal)
        } else {
            // Handle the case where the SVG file couldn't be loaded or converted
        }
    }
    
    func formatValue(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        
        let formattedValue = formatter.string(from: NSNumber(value: value))
        return formattedValue ?? ""
    }


}

