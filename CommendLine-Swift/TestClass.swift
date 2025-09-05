//
//  TestClass.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/9/5.
//

import Foundation


class Person:Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.age < rhs.age
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.age == rhs.age
    }
    
    var age:Int = 0
    var score:Int = 0
    init(age: Int) {
        self.age = age
    }
}


class Car {
    var price:Int = 0
    init(price: Int) {
        self.price = price
    }
}

