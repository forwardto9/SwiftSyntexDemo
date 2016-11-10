//
//  StringDemo.swift
//  SwiftSyntexDemo
//
//  Created by uwei on 10/11/2016.
//  Copyright © 2016 Tencent. All rights reserved.
//

import Foundation
class StringDemo {
    class func demo() -> Void {
        let flag = "🇵🇷"
        print(flag.characters.count)
        // Prints "1"
        print(flag.unicodeScalars.count)
        // Prints "2"
        print(flag.utf16.count)
        // Prints "4"
        print(flag.utf8.count)
        // Prints "8"
        
        var demoString = "we are good boys"
        let results = demoString.components(separatedBy: " ")
        print(results)
        
        var stringView = String.CharacterView(demoString)
        print(stringView.startIndex)
        let hearts = "Hearts <3 ♥︎ 💘"
        if let i = hearts.characters.index(of: " ") {
            // 对于字符串来说，使用的编码方式是不同的, swift 默认是 Unicode的编码
            let j = i.samePosition(in: hearts.unicodeScalars)
            print(Array(hearts.unicodeScalars.prefix(upTo: j)))
        }
        
        print(stringView.count)
        stringView.append("A")
        print(stringView.count)
        print(String(stringView))
        
        let subjectString = String.init(reflecting: String("xxx"))
        print(subjectString)
        print(subjectString.decomposedStringWithCanonicalMapping)
        print(String.init(10, radix: 2))
        print(demoString.capitalized)
        let closeBound = demoString.startIndex...demoString.characters.index(of: "o")!
        let bound1 = 0 ..< 5
        print(bound1)
        demoString.replaceSubrange(closeBound, with: "xxx")
        print(demoString)
        print(demoString.substring(to: demoString.characters.index(of: "b")!))
        demoString.append("123")
        let trimString = "a  b c def".trimmingCharacters(in: CharacterSet.init(charactersIn: "abc"))
        print(trimString)
        print("String Done!")
    }
}
