//
//  main.swift
//  FirstCourseSecondTask
//
//  Copyright © 2017 E-Legion. All rights reserved.
//

import Foundation
import FirstCourseSecondTaskChecker


let checker = Checker()

checker.checkFirstFunction { collection -> (Int, Int) in
    var evenElementsCounter = 0
    var oddElementsCounter = 0
    collection.forEach { (element) in
        (element % 2 == 0) ? (evenElementsCounter += 1) : (oddElementsCounter += 1)
    }
    return (evenElementsCounter, oddElementsCounter)
}


checker.checkSecondFunction { (circles) -> [Checker.Circle] in
    let whiteCircles = circles.filter { $0.color == .white }
    let blueAndGreenCircles = circles.filter { $0.color == .blue || $0.color == .green }.map{ Checker.Circle(radius: $0.radius, color: .blue) }
    let blackCircles = circles.filter{ $0.color == .black }.map{ Checker.Circle(radius: ($0.radius * 2), color: $0.color) }
    return whiteCircles + blackCircles + blueAndGreenCircles
}


checker.checkThirdFunction { (data) -> [Checker.Employee] in
    var result = [Checker.Employee]()
    data.forEach { (employeeData) in
        let filtredData = employeeData.filter{ $0.key != "salary" && $0.key != "company" && $0.key != "fullName" }
        guard filtredData.isEmpty,
            let fullName = employeeData["fullName"],
            let salary = employeeData["salary"],
            let company = employeeData["company"]
        else {
            return
        }
        let employee = Checker.Employee(fullName: fullName, salary: salary, company: company)
        result.append(employee)
    }
    return result
}


checker.checkFourthFunction { (names) -> [String : [String]] in
    let firstLetters: Set<String> = Set(names.compactMap{
        if let first = $0.first {
            return String(first)
        }
        return nil
    })
    var result = [String : [String]]()
    firstLetters.forEach { (letter) in
        result[letter] = [String]()
    }
    let sortedNames = names.sorted{ $0 > $1 }
    sortedNames.forEach { (name) in
        let firstLetter = String(name.first!)
        result[firstLetter]?.append(name)
    }
    return result.filter{ $0.1.count >= 2 }
}
