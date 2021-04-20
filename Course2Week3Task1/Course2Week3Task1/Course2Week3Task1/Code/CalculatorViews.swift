//
//  CalculatorViews.swift
//  Course2Week3Task1
//
//  Created by 18774669 on 29.03.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import UIKit

struct CalculatorViews {
    static func createContainerView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func createResultLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = Constants.resultBackground
        label.textColor = Constants.resultTintColor
        label.font = Constants.resultFont
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createFirstOperandTitle() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.textColor
        label.font = Constants.mainFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "First operand"
        return label
    }
    
    static func createFirstOperandValue() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.textColor
        label.font = Constants.mainFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createSecondOperandTitle() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.textColor
        label.font = Constants.mainFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Second operand"
        return label
    }
    
    static func createSecondOperandValue() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.textColor
        label.font = Constants.mainFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createStepper() -> UIStepper {
        let stepper = UIStepper()
        stepper.tintColor = Constants.orangeColor
        stepper.maximumValue = 10
        stepper.minimumValue = 1
        stepper.stepValue = 0.5
        stepper.value = 1
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }
    
    static func createSlider() -> UISlider {
        let slider = UISlider()
        slider.tintColor = Constants.orangeColor
        slider.maximumValue = 100
        slider.minimumValue = 1
        slider.isContinuous = false
        slider.value = 1
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }
    
    static func createCalculateButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Calculate", for: .normal)
        button.backgroundColor = Constants.orangeColor
        button.tintColor = Constants.textColor
        button.titleLabel?.font = Constants.mainFont
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private enum Constants {
        static let mainBackground = UIColor(hexString: "#2D2F31")
        static let resultBackground = UIColor(hexString: "#EEEEEE")
        
        static let orangeColor = UIColor(hexString: "#EC7149")
        static let textColor = UIColor(hexString: "#FFFFFF")
        static let resultTintColor = UIColor(hexString: "#000000")
        
        static let resultFont: UIFont = .systemFont(ofSize: 30, weight: .regular)
        static let mainFont: UIFont = .systemFont(ofSize: 17, weight: .regular)
    }
}
