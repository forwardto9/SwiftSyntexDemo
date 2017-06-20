//
//  Model.swift
//  SwiftSyntexDemo
//
//  Created by uwei on 20/06/2017.
//  Copyright © 2017 Tencent. All rights reserved.
//

import Foundation

class Person: NSObject {
    var name: String
    fileprivate var age:Int = 0
    var friends: [Person] = []
    var bestFriend: Person? = nil
    
    init(name: String) {
        self.name = name
    }
    
    init(name:String!, age:Int = 0) {
        self.name = name
        self.age = age;
    }
    
}
