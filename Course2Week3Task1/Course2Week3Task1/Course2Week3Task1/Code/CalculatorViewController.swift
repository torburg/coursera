//
//  CalculatorViewController.swift
//  Course2Week3Task1
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private lazy var containerView = { CalculatorViews.createContainerView() }()
    private lazy var resultLabel = { CalculatorViews.createResultLabel() }()
    private lazy var firstOperandTitle = { CalculatorViews.createFirstOperandTitle() }()
    private lazy var firstOperandValue = { CalculatorViews.createFirstOperandValue() }()
    private lazy var secondOperandTitle = { CalculatorViews.createSecondOperandTitle() }()
    private lazy var secondOperandValue = { CalculatorViews.createSecondOperandValue() }()
    private lazy var stepper = { CalculatorViews.createStepper() }()
    private lazy var slider = { CalculatorViews.createSlider() }()
    private lazy var calculateButton = { CalculatorViews.createCalculateButton() }()
    
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 4
        formatter.maximumFractionDigits = 4
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.mainBackground
        
        addSubviews()
        setNeedsConstraints()
        setInitialValues()
        addActionTargets()
    }
    
    private func addSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(resultLabel)
        containerView.addSubview(firstOperandTitle)
        containerView.addSubview(firstOperandValue)
        containerView.addSubview(secondOperandTitle)
        containerView.addSubview(secondOperandValue)
        containerView.addSubview(stepper)
        containerView.addSubview(slider)
        containerView.addSubview(calculateButton)
    }
    
    private func setNeedsConstraints() {
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.inset16).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.inset32).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.inset16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.inset16).isActive = true
        
        resultLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        resultLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        resultLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        resultLabel.heightAnchor.constraint(equalToConstant: Constants.inset60).isActive = true
        
        firstOperandTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        firstOperandTitle.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: Constants.inset32).isActive = true
        firstOperandTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        stepper.topAnchor.constraint(equalTo: firstOperandTitle.bottomAnchor, constant: Constants.inset16).isActive = true
        stepper.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        firstOperandValue.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        firstOperandValue.centerYAnchor.constraint(equalTo: stepper.centerYAnchor).isActive = true

        secondOperandTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        secondOperandTitle.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: Constants.inset32).isActive = true
        secondOperandTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        slider.topAnchor.constraint(equalTo: secondOperandTitle.bottomAnchor, constant: Constants.inset16).isActive = true
        slider.leadingAnchor.constraint(equalTo: stepper.leadingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: stepper.trailingAnchor).isActive = true
        
        secondOperandValue.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        secondOperandValue.centerYAnchor.constraint(equalTo: slider.centerYAnchor).isActive = true
        
        calculateButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        calculateButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        calculateButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        calculateButton.heightAnchor.constraint(equalToConstant: Constants.inset60).isActive = true
    }
    
    private func setInitialValues() {
        firstOperandValue.text = formatter.string(for: stepper.value)
        secondOperandValue.text = formatter.string(for: slider.value)
    }
    
    private func addActionTargets() {
        stepper.addTarget(self, action: #selector(stepperDidChange(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderDidMove(_:)), for: .valueChanged)
        calculateButton.addTarget(self, action: #selector(calculatePressed(_:)), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func stepperDidChange(_ sender: UIStepper) {
        firstOperandValue.text = formatter.string(for: sender.value)
    }
    
    @objc private func sliderDidMove(_ sender: UISlider) {
        secondOperandValue.text = formatter.string(for: sender.value)
    }
    
    @objc private func calculatePressed(_ sender: UIButton) {
        guard
            let firstValue = firstOperandValue.text,
            let firstNumber = Double(firstValue),
            let secondValue = secondOperandValue.text,
            let secondNumber = Double(secondValue)
        else { return }
        let multiplication = firstNumber * secondNumber
        guard let result = formatter.string(for: multiplication) else { return }
        resultLabel.text = result.replacingOccurrences(of: "0*$", with: "", options: .regularExpression)
    }
}

// MARK: - Constants
extension CalculatorViewController {
    private enum Constants {
        static let mainBackground = UIColor(hexString: "#2D2F31")
        static let resultBackground = UIColor(hexString: "#EEEEEE")
        
        static let inset16: CGFloat = 16
        static let inset32: CGFloat = 32
        static let inset60: CGFloat = 60
    }
}
