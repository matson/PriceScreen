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
    //the cards would have been UIViews
    
    
    @IBOutlet weak var circleImage: UIImageView!
    
    @IBOutlet weak var bigLabel: UILabel!
    
    @IBOutlet weak var midLabel: UILabel!
    
    @IBOutlet weak var midLabel2: UILabel!
    
    @IBOutlet weak var pageViews: UILabel!
    
    @IBOutlet weak var sliderUI: CustomSlider!
    
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
    
    @IBOutlet weak var button:UIButton!
    
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var month: UILabel!
    
    let pageViewsValues: [Float] = [10000, 50000, 100000, 500000, 1000000] //to store the pageviews
   
    let prices: [Float] = [8, 12, 16, 24, 36] //to store the prices
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
        //why these?
        sliderUI.minimumValue = 0
        sliderUI.maximumValue = Float(pageViewsValues.count - 1)
        sliderUI.value = 0
        
        setChecks()
       
        setSlider()
        
        setBackground()
        
        setCircle()
        
        updateLabels()
        
        setAttributes()
        
        setSwitch()
        
        
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
    
    //convert the given image files to UIImages:
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
              
            //call function to add the suffix
            let formattedPageViews = self.formatPageViews(selectedPageViews)
            self.pageViews.text = "\(formattedPageViews) PAGEVIEWS"
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
    
    //set the background image
    func setBackground(){
    
        if let svgUIImage = convert(svgFileName: "bg-pattern", withExtension: "svg") {
            let backgroundImageView = UIImageView(frame: view.bounds)
            backgroundImageView.image = svgUIImage
            backgroundImageView.contentMode = .topLeft
            backgroundImageView.clipsToBounds = true
            view.addSubview(backgroundImageView)
            view.sendSubviewToBack(backgroundImageView)
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
    
    //give the values the letter concatenation 
    func formatPageViews(_ pageViews: Float) -> String {
        if pageViews >= 1000 {
            let suffixes = ["", "K", "M"]
            var index = 0
            var formattedPageViews = pageViews
            while formattedPageViews >= 1000 {
                formattedPageViews /= 1000
                index += 1
            }
            return "\(Int(formattedPageViews))\(suffixes[index])"
        } else {
            return "\(Int(pageViews))"
        }
    }
    
    //give checks UIImage
    func setChecks(){
        if let checkUIImage = convert(svgFileName: "icon-check", withExtension: "svg") {
            check1.image = checkUIImage
            check2.image = checkUIImage
            check3.image = checkUIImage
        } else {
            // Handle the case where the SVG file couldn't be loaded or converted
        }
    }
    
    //slider
    func setSlider(){
        
        //height should be changed through a custom class
        
        let red: CGFloat = 200.0 / 255.0
        let green: CGFloat = 219.0 / 255.0
        let blue: CGFloat = 243.0 / 255.0
        let alpha: CGFloat = 1.0
        
        let maxTrack = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        sliderUI.minimumTrackTintColor = Constants.Colors.softCyanColor
        sliderUI.maximumTrackTintColor = maxTrack
        
        //find specific background color
        let redValue: CGFloat = 43.0 / 255.0
        let greenValue: CGFloat = 202.0 / 255.0
        let blueValue: CGFloat = 81.0 / 255.0
        let alphaValue: CGFloat = 1.0

        let thumbColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
        
        //sliderUI.thumbTintColor = thumbColor
        // Add a glow effect to the thumb
        sliderUI.layer.shadowColor = thumbColor.cgColor
        sliderUI.layer.shadowRadius = 8.0
        sliderUI.layer.shadowOpacity = 1.0
        sliderUI.layer.shadowOffset = CGSize.zero
        sliderUI.layer.masksToBounds = false
        
        //problem with the image parsing?
        if let sliderSVGImage = convert(svgFileName: "icon-slider", withExtension: "svg") {
            //sliderUI.setThumbImage(sliderSVGImage , for: .normal)
        } else {
            
        }
        
    }
    
    func setAttributes(){
        
        pageViews.font = UIFont(name: "Manrope-Bold", size: 16)
        pageViews.textColor = Constants.Colors.lightGraytext
        price.font = UIFont(name: "Manrope-ExtraBold", size: 46)
        price.textColor = Constants.Colors.darkDesatBlue
        
        month.attributedText = NSAttributedString(string: Constants.Text.month, attributes: [
            .font: UIFont(name: "Manrope-Bold", size: 12),
            .foregroundColor: Constants.Colors.lightGraytext
        ])
        
        let redValue: CGFloat = 11.0 / 255.0
        let greenValue: CGFloat = 11.0 / 255.0
        let blueValue: CGFloat = 44.0 / 255.0
        let alphaValue: CGFloat = 1.0

        let buttonColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
        
        let red: CGFloat = 156.0 / 255.0
        let green: CGFloat = 187.0 / 255.0
        let blue: CGFloat = 243.0 / 255.0
        let alpha: CGFloat = 1.0

        let buttonTextColor = UIColor(red: red, green: green, blue: blue, alpha: alphaValue)
        
        
        button.titleLabel?.font = UIFont(name: "Manrope-Bold", size: 12)
        button.titleLabel?.textColor = buttonTextColor
        button.backgroundColor = buttonColor
        button.layer.cornerRadius = 20
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
        
        //the -25% label
        setDiscountLabel(label: discountLabel)
        
    }
    
    func setSwitch(){
        
        switchUI.onTintColor = Constants.Colors.lightGraytext
        //switchUI.tintColor = Constants.Colors.darkDesatBlue
        switchUI.transform = CGAffineTransform(scaleX: 0.65, y: 0.65) // Adjust the scale to make the circle smaller
        //let newWidth: CGFloat = 500 // Set the desired width for the switch
        //switchUI.bounds.size.width = newWidth
    }
    
    //customize the -25% label
    func setDiscountLabel(label: UILabel){
        
        //find specific background color
        let redValue: CGFloat = 234.0 / 255.0
        let greenValue: CGFloat = 202.0 / 255.0
        let blueValue: CGFloat = 195.0 / 255.0
        let alphaValue: CGFloat = 1.0

        let redBackgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
        
        //set rest of attributes here
        label.textColor = Constants.Colors.discountTextRed
        label.backgroundColor = redBackgroundColor
        label.text = "-25%"
        label.layer.cornerRadius = 10.0 // Adjust the value as per your design
        label.layer.masksToBounds = true
        label.font = UIFont(name: "Manrope-Bold", size: 12)
        
    }
}

