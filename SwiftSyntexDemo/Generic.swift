//
//  Generic.swift
//  SwiftSyntexDemo
//
//  Created by uwei on 2021/1/15.
//  Copyright © 2021 Tencent. All rights reserved.
//

import Foundation

extension Stack where Element:Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}


// MARK: Generic Type
struct Stack<Element>:Container {// 泛型支持是通过<>符号
    typealias Item = Element
    
    internal subscript(i: Int) -> Element {
        return self.items[i];
    }

    mutating internal func append(_ item: Element) {
        self.items.append(item)
    }

    internal var count: Int {
        return self.items.count
    }

    var items = [Element]()
    // 结构体中，如果某个方法想要改变这个结构体，必须要添加mutating关键字
    mutating func push(item:Element) -> Void {
        self.items.append(item)
    }
    
    mutating func pop() -> Void {
        self.items.removeLast()
    }
    
    
    
}
