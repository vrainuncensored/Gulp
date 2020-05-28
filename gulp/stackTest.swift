//
//  ViewController.swift
//  StackViewCodeDemo
//
//  Created by Steven Lipton on 11/11/15.
//  Copyright © 2015 MakeAppPie.Com. All rights reserved.
//
 
import UIKit
 
 
 
class testFile : UIViewController {
    //MARK: Properties
    
    let colorDictionary = [
        "Red":UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0),
        "Green":UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0),
        "Blue":UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0),
    ]
     
    //MARK: Instance methods
    func colorButton(withColor color:UIColor, title:String) -> UIButton{
        let newButton = UIButton(type: .system)
        newButton.backgroundColor = color
        newButton.setTitle(title, for: .normal)
        newButton.setTitleColor(UIColor.white, for: .normal)
        return newButton
    }
     
     
    func displayKeyboard(){
                 //generate an array
        
         
        var buttonArray = [UIButton]()
        for (myKey,myValue) in colorDictionary{
            buttonArray += [colorButton(withColor: myValue, title: myKey)]
        }
        /* //Iteration one - singel stack view
        let stackView = UIStackView(arrangedSubviews: buttonArray)
        stackView.axis = .Horizontal
        stackView.distribution = .FillEqually
        stackView.alignment = .Fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        */
         
        //Iteration two - nested stack views
        //set up the stack view
        let subStackView = UIStackView(arrangedSubviews: buttonArray)
        subStackView.axis = .horizontal
        subStackView.distribution = .fillEqually
        subStackView.alignment = .fill
        subStackView.spacing = 5
        //set up a label
        let label = UILabel()
        label.text = "Color Chooser"
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.black
        label.textAlignment = .center
         
        let blackButton = colorButton(withColor: UIColor.black, title: "Black")
         
        let stackView = UIStackView(arrangedSubviews: [label,subStackView,blackButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
 
        view.addSubview(stackView)
     
        //autolayout the stack view - pin 30 up 20 left 20 right 30 down
        let viewsDictionary = ["stackView":stackView]
        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[stackView]-20-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[stackView]-30-|", options: NSLayoutConstraint.FormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
        view.addConstraints(stackView_H)
        view.addConstraints(stackView_V)
    }
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayKeyboard()
}
}
