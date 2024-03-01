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
    //Include two stackViews to organize
    
    
    @IBOutlet weak var circleImage: UIImageView!
    
    @IBOutlet weak var bigLabel: UILabel!
    
    @IBOutlet weak var midLabel: UILabel!
    
    @IBOutlet weak var midLabel2: UILabel!
    
    @IBOutlet weak var pageViews: UILabel!
    
    @IBOutlet weak var sliderUI: UISlider!
    
    @IBOutlet weak var switchUI: UISwitch!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var check1: UIImageView!
    
    @IBOutlet weak var check2: UIImageView!
    
    @IBOutlet weak var check3: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var monthlyBill: UILabel!
    
    @IBOutlet weak var yearlyBill: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var month: UILabel!
    
    let pageViewsValues: [Float] = [10000, 50000, 100000, 500000, 1000000]
   
    let prices: [Float] = [8, 12, 16, 24, 36]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
        sliderUI.minimumValue = 0
        sliderUI.maximumValue = Float(pageViewsValues.count - 1)
        sliderUI.value = 0
        
        setChecks()
       
        setSlider()
        
        //setBackground()
        
        setCircle()
        
        updateLabels()
        
        setAttributes()
        
        
    }
    
    //slider action
    @IBAction func slideAction(_ sender: UISlider) {
        let roundedValue = round(sender.value)
            sender.value = roundedValue
        updateLabels()

    }
    
    //switch action
    @IBAction func switchAction(_ sender: UISwitch) {
        updateLabels()
    }
    
    @IBAction func pressed(_ sender: UIButton) {
        //action with button?
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
    
    func updateLabels() {
        let index = Int(sliderUI.value)
        let selectedPageViews = pageViewsValues[index]
        var selectedPrice = prices[index]
        
        DispatchQueue.main.async {
              if self.switchUI.isOn {
                  selectedPrice *= 0.75 // Apply 25% discount
              }
              
              self.pageViews.text = "\(Int(selectedPageViews)) PAGEVIEWS"
              self.price.text = "$\(Int(selectedPrice))"
        }
    }
    
    func setCircle(){
        if let circleSVGImage = convert(svgFileName: "pattern-circles", withExtension: "svg") {
            circleImage.image = circleSVGImage
        } else {
            // Handle the case where the SVG file couldn't be loaded or converted
        }
    }
    
    func setBackground(){
        
        //problem with having the pattern black
//        if let svgUIImage = convert(svgFileName: "bg-pattern", withExtension: "svg") {
//            let patternColor = UIColor(patternImage: svgUIImage)
//            //view.backgroundColor = patternColor
//        } else {
//            // Handle the case where the SVG file couldn't be loaded or converted
//        }
        view.backgroundColor = Constants.Colors.backGroundBlue
    }
    
    func formatValue(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        
        let formattedValue = formatter.string(from: NSNumber(value: value))
        return formattedValue ?? ""
    }
    
    func setChecks(){
        if let checkUIImage = convert(svgFileName: "icon-check", withExtension: "svg") {
            check1.image = checkUIImage
            check2.image = checkUIImage
            check3.image = checkUIImage
        } else {
            // Handle the case where the SVG file couldn't be loaded or converted
        }
    }
    
    func setSlider(){
        // Soft Cyan (Full Slider Bar): hsl(174, 77%, 80%)
        let softCyanColor = UIColor(hue: 174/360, saturation: 0.77, brightness: 0.8, alpha: 1.0)
        sliderUI.minimumTrackTintColor = softCyanColor

        // Strong Cyan (Slider Background): hsl(174, 86%, 45%)
        let strongCyanColor = UIColor(hue: 174/360, saturation: 0.86, brightness: 0.45, alpha: 1.0)
        sliderUI.maximumTrackTintColor = strongCyanColor
        
        //problem with the image parsing?
//        if let sliderSVGImage = convert(svgFileName: "icon-slider", withExtension: "svg") {
//            sliderUI.setThumbImage(sliderSVGImage , for: .normal)
//        } else {
//            // Handle the case where the SVG file couldn't be loaded or converted
//        }
        
    }
    
    func setAttributes(){
        
        pageViews.font = UIFont(name: "Manrope-ExtraBold", size: 16)
        pageViews.textColor = Constants.Colors.lightGraytext
        price.font = UIFont(name: "Manrope-ExtraBold", size: 46)
        price.textColor = Constants.Colors.darkDesatBlue
        
        month.attributedText = NSAttributedString(string: Constants.Text.month, attributes: [
            .font: UIFont(name: "Manrope-Bold", size: 12),
            .foregroundColor: Constants.Colors.lightGraytext
        ])
        
        button.titleLabel?.font = UIFont(name: "Manrope-Bold", size: 12)
        button.setTitleColor(Constants.Colors.lightGrayBlue, for: .normal)
        button.backgroundColor = Constants.Colors.darkDesatBlue
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        
        
        monthlyBill.attributedText = NSAttributedString(string: Constants.Text.monthly, attributes: [
            .font: UIFont(name: "Manrope-Bold", size: 12),
            .foregroundColor: Constants.Colors.lightGraytext
        ])
        
        yearlyBill.attributedText = NSAttributedString(string: Constants.Text.yearly, attributes: [
            .font: UIFont(name: "Manrope-Bold", size: 12),
            .foregroundColor: Constants.Colors.lightGraytext
        ])
        
        
        bigLabel.attributedText = NSAttributedString(string: Constants.Text.mainLabel, attributes: [
            .font: UIFont(name: "Manrope-ExtraBold", size: 16),
            .foregroundColor: Constants.Colors.darkDesatBlue
        ])
        
        midLabel.attributedText = NSAttributedString(string: Constants.Text.midLabel1, attributes: [
            .font: UIFont(name: "Manrope-Bold", size: 14),
            .foregroundColor: Constants.Colors.lightGraytext
        ])
        
        midLabel2.attributedText = NSAttributedString(string: Constants.Text.midLabel2, attributes: [
            .font: UIFont(name: "Manrope-Bold", size: 14),
            .foregroundColor: Constants.Colors.lightGraytext
        ])
        
        label1.attributedText = NSAttributedString(string: Constants.Text.label1, attributes: [
            .font: UIFont(name: "Manrope-Bold", size: 14),
            .foregroundColor: Constants.Colors.lightGraytext
        ])
        
        label2.attributedText = NSAttributedString(string: Constants.Text.label2, attributes: [
            .font: UIFont(name: "Manrope-Bold", size: 14),
            .foregroundColor: Constants.Colors.lightGraytext
        ])
        
        label3.attributedText = NSAttributedString(string: Constants.Text.label3, attributes: [
            .font: UIFont(name: "Manrope-Bold", size: 14),
            .foregroundColor: Constants.Colors.lightGraytext
        ])
        
    }
    
    


}

