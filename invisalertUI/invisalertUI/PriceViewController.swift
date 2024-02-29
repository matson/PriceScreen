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
    
    let pageViewsValues: [Float] = [10000, 50000, 100000, 500000, 1000000]
   
    let prices: [Float] = [8, 12, 16, 24, 36]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
            
        bigLabel.text = Constants.mainLabel
        midLabel.text = Constants.midLabel1
        midLabel2.text = Constants.midLabel2
        
        
        sliderUI.minimumValue = 0
        sliderUI.maximumValue = Float(pageViewsValues.count - 1)
        sliderUI.value = 0
        
       
        //setSlider()
        
        setBackground()
        
        setCircle()
    }
    
   
    //slider action
    @IBAction func slideAction(_ sender: UISlider) {
        let roundedValue = round(sender.value)
            sender.value = roundedValue
        
        updateLabels()

    }
    
    func updateLabels() {
        let index = Int(sliderUI.value)
        let selectedPageViews = pageViewsValues[index]
        let selectedPrice = prices[index]
        
        pageViews.text = "\(Int(selectedPageViews)) pageviews"
        price.text = "$\(Int(selectedPrice)) /month"
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

