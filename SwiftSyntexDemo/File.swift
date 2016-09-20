//
//  File.swift
//  SwiftSyntexDemo
//
//  Created by uwei on 9/20/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

import Foundation


func displayInfo() -> Void {
    print("This a test message")
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



