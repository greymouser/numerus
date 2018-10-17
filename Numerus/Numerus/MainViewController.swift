//
//  MainViewController.swift
//  Numerus
//
//  Created by Armando Di Cianno on 5/16/16.
//  Copyright © 2016 Armando Di Cianno. All rights reserved.
//

import UIKit
import NumerusKit

/**
 The main view of the application.
 
 The application is a utility-type app, and only has this single, main screen
 that contains all its functionality.
 */
class MainViewController: UIViewController, UITextFieldDelegate {

    // MARK: - properties
    
    fileprivate var titleLabel       = UILabel()
    
    fileprivate var romanTextField   = UITextField()
    fileprivate var decimalTextField = UITextField()
    

    // MARK: - UIViewController overrides
    
    override var edgesForExtendedLayout: UIRectEdge {
        set { }
        get { return UIRectEdge() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = "Numerus"
        self.titleLabel.font = Configuration.Font.titleFont
        self.titleLabel.sizeToFit()
        self.navigationItem.titleView = self.titleLabel
        
        self.view.backgroundColor = Configuration.UI.backgroundColor

        self.romanTextField.font                   = Configuration.Font.defaultFont
        self.romanTextField.placeholder            = "Enter Roman numeral"
        self.romanTextField.textAlignment          = .right
        self.romanTextField.autocapitalizationType = .none
        self.romanTextField.autocorrectionType     = .no
        self.romanTextField.keyboardType           = .asciiCapable
        self.romanTextField.delegate               = self
        self.romanTextField.addTarget(
            self,
            action: #selector(MainViewController.handleTextDidChange(_:)),
            for: .editingChanged)
        
        self.view.addSubview(self.romanTextField)
        
        self.decimalTextField.font                   = Configuration.Font.defaultFont
        self.decimalTextField.placeholder            = "Enter base 10 number"
        self.decimalTextField.textAlignment          = .right
        self.decimalTextField.autocapitalizationType = .none
        self.decimalTextField.autocorrectionType     = .no
        self.decimalTextField.keyboardType           = .numberPad
        self.decimalTextField.delegate               = self
        self.decimalTextField.addTarget(
            self,
            action: #selector(MainViewController.handleTextDidChange(_:)),
            for: .editingChanged)
        
        self.view.addSubview(self.decimalTextField)

        self.createLayoutConstraints()
    }

    
    // MARK: - UITextFieldDelegate callbacks
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentString = textField.text
            else { return false }

        let testString = NSMutableString(string: currentString)
        testString.replaceCharacters(in: range, with: string)
        
        switch textField {
        case self.romanTextField:
            // Do not allow non-roman-numeral characters into the text field
            return testString.isValidRomanNumeral()
        case self.decimalTextField:
            // Do not allow non-decimal-number characters into the text field
            let legalCharacters = CharacterSet.decimalDigits
            let checkedString = testString
                .components(separatedBy: legalCharacters.inverted)
                .joined(separator: "")
            return testString.isEqual(to: checkedString)
        default:
            return false
        }
    }

    
    // MARK: - private & internal functions / helpers
    
    /**
     Create the constraints for the view layout.
     
     This helper function is pulled out from the viewDidLoad setup related code, and should
     only be invoked from there, and only invoked once.
    */
    fileprivate func createLayoutConstraints() {
        // For views we layout manually, set the autoresizing-mask-into-constraints to false,
        //   so that our autolayout code operates correctly.
        self.romanTextField.translatesAutoresizingMaskIntoConstraints = false
        self.decimalTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Store all constraints we create to apply all at once when we are done.
        var constraints = [NSLayoutConstraint]()
        
        // The views that are referenced in our visual format language strings.
        let views: [String:AnyObject]
            = [ "romanTextField"  : self.romanTextField,
                "decimalTextField": self.decimalTextField
                ]

        // Variables used in our visual format language strings.
        let metrics: [String:AnyObject]
            = [ "mainTextFieldsHeight": Configuration.UI.mainTextFieldsHeight as AnyObject,
                "insetTop"            : Configuration.UI.defaultInsets.top as AnyObject,
                "insetLeft"           : Configuration.UI.defaultInsets.left as AnyObject,
                "insetRight"          : Configuration.UI.defaultInsets.right as AnyObject
                ]
        
        // Vertical layout for all the views on the main view.
        let textFieldsConstraintsVertical = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[romanTextField(mainTextFieldsHeight)]-(insetTop)-[decimalTextField(romanTextField)]",
            options: [ .alignAllCenterX ],
            metrics: metrics,
            views: views)
        constraints += textFieldsConstraintsVertical
        
        // Size and position the roman text field at the top of the view.
        let romanTextFieldConstraintsHorizontal = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(insetLeft)-[romanTextField]-(insetRight)-|",
            options: [],
            metrics: metrics,
            views: views)
        constraints += romanTextFieldConstraintsHorizontal
        
        // Size and position the decimal text field offset from the roman text field.
        let decimalTextFieldConstraintsHorizontal = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(insetLeft)-[decimalTextField(romanTextField)]",
            options: [],
            metrics: metrics,
            views: views)
        constraints += decimalTextFieldConstraintsHorizontal
        
        // We are done, so apply all the constraints we created.
        NSLayoutConstraint.activate(constraints)
        romanTextField.topAnchor.constraintEqualToSystemSpacingBelow(self.view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0).isActive = true
    }
    
    /// The callback for both of the textfields; routes to the correct field check.
    @objc func handleTextDidChange(_ sender: AnyObject) {
        let textField = sender as! UITextField
        
        switch textField {
        case self.romanTextField:
            self.updateFromRomanNumeral()
        case self.decimalTextField:
            self.updateFromDecimalNumber()
        default:
            return
        }
    }
    
    fileprivate func updateFromRomanNumeral() {
        guard let romanNumeral: NSString = self.romanTextField.text as NSString?
            else {
                self.decimalTextField.text = nil
                return
        }
    
        if romanNumeral.isValidRomanNumeral() {
            let number = NSNumber.init(romanNumerals: romanNumeral as String)
            self.decimalTextField.text = "\(number!.romanIntValue())"
        } else {
            self.decimalTextField.text = nil
        }
    }
    
    fileprivate func updateFromDecimalNumber() {
        guard let numberString = self.decimalTextField.text
            else { return }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let number = formatter.number(from: numberString)
        self.romanTextField.text = number?.romanNumeralStringValue
    }
}

