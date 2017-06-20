//
//  PredicateDemo.swift
//  SwiftSyntexDemo
//
//  Created by uwei on 20/06/2017.
//  Copyright © 2017 Tencent. All rights reserved.
//

import Foundation


class PersonDemo: NSObject {
    var firstName: NSString
    var lastName: NSString
    var age: NSNumber
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName as NSString
        self.lastName = lastName as NSString
        self.age = NSNumber(value: age)
    }
    
    override var description: String {
        return "\(firstName) \(lastName)"
   }
    
    override func value(forUndefinedKey key: String) -> Any? {
        print(key)
        return "age"
    }
}

let alice = PersonDemo(firstName: "Alice", lastName: "Smith", age: 24)
let bob = PersonDemo(firstName: "Bob", lastName: "Jones", age: 27)
let charlie = PersonDemo(firstName: "Charlie", lastName: "Smith", age: 33)
let quentin = PersonDemo(firstName: "Quentin", lastName: "Alberts", age: 31)
let people:NSArray = ([alice, bob, charlie, quentin] as NSArray)

class PredicateDemo:NSObject {
    
    let numbersArray = [1,2,3,6,79, -23];
    let namesArray = ["jack", "jacky", "winson", "will", "uweiyuan", "UweiX"]
    
    func testPredicate() -> Void {
        
        //MARK:- compare
        let numPredicate1 = NSPredicate(format: "SELF < 10", argumentArray:nil);
        let r1 = (numbersArray as NSArray).filtered(using: numPredicate1)
        print(r1)
        let numPredicate2 = NSPredicate(format: "SELF BETWEEN {0, 10}", argumentArray:nil);
        print((numbersArray as NSArray).filtered(using: numPredicate2))
        
        //MARK:- Logic
        let p3 = NSPredicate(format: "SELF > 2 && SELF < 7", argumentArray: nil)
        for n in numbersArray {
           print("n is \(n) result is \(p3.evaluate(with: n))")
        }
        
        //MARK:- Strings
        let p4 = NSPredicate(format: "SELF LIKE[cd] '?wei*'", argumentArray: nil)
        print((namesArray as NSArray).filtered(using: p4))

        let p5 = NSPredicate(format: "SELF MATCHES[cd] 'WINSON'", argumentArray: nil)
        print((namesArray as NSArray).filtered(using: p5))
        
        //MARK:- Set
        print(alice.value(forKeyPath: "age") ?? "xxx")
        let p6 = NSPredicate(format: "all age>20", argumentArray: nil)
        print((people as NSArray).filtered(using: p6))
    }
    
}
