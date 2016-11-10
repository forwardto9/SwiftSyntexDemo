//
//  File.swift
//  SwiftSyntexDemo
//
//  Created by uwei on 9/20/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

import Foundation



class FileA {
    static var property1:Int {
        set {
            self.property1 = newValue
        }
        get {
            return self.property1
        }
    }
    
    static var property2 = "X"
    class var property3:String {
        return "333"
    }
    
}


class FileB: FileA {
//    override static var property1:Int = 10
//    override static var property2 = "99"
    override class var property3:String {
        return "2222"
    }
}




func displayInfo() -> Void {
    print("This a test message")
    print(FileB.property2)
}

public class TestFileName {
    let acc = AccessClass()
    public func setV() -> Void {
        acc.internalName = "interal"
        acc.openName     = "open"
        acc.publicName   = "public"
    }
}

var testFileName = TestFileName()



