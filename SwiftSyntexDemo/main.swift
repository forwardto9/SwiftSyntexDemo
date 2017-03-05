//
//  main.swift
//  SwiftSyntexDemo
//
//  Created by uwei on 9/29/15.
//  Copyright © 2015 Tencent. All rights reserved.
//

import Foundation


@available(iOS 10, *)
func testiOS10() -> Void {
    print("10")
}

@available(macOS, deprecated:10, message:"this is a deprecated protocol")
protocol MyProtocol {
    // protocol definition
}



protocol MyRenamedProtocol {
    // protocol definition
}

@available(iOS, unavailable, renamed: "MyRenamedProtocol")





class protocolTest: MyProtocol {
}


class OverLoading {
    func overload(p1:String) -> Void {
        print(p1)
    }
    
    @discardableResult
    func overload() -> Bool {
        return false
    }
}

let overload1 = OverLoading()
overload1.overload() // no warning
overload1.overload(p1: "overload")

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

struct Stack<Element>:Container {
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
    mutating func push(item:Element) -> Void {
        self.items.append(item)
    }
    
    mutating func pop() -> Void {
        self.items.removeLast()
    }
    
    
    
}


var stackInt = Stack(items: [1,2,4])
print(stackInt.count)
stackInt.append(3)
print(stackInt.count)
print(stackInt[2])
stackInt.pop()
print(stackInt.count)
for it in stackInt.items {
    print(it)
}






let urls = ""

let group = DispatchGroup()

// Loop through the urls array, in parallel


DispatchQueue.concurrentPerform(iterations: 30) { (x) in
    group.enter()
    print("x = \(x)")
    group.leave()
}

let result = group.wait(timeout: DispatchTime.distantFuture)
print("result = \(result)")


// Now all your tasks have finished






// MARK: - String
StringDemo.demo()

// MARK: - OC Enum to Swift
print(EnumDemoX)
OCClass().info(name: "uwei")

func swapTest(al a:inout Int, bl b:inout Int) {
    let temp = a
    a = b
    b = temp
}

var atest = 10
var btest = 11
swapTest(al: &atest, bl: &btest)
print("\(atest), \(btest)")

public class AccessClass {
    open var openName:String = ""
    public var publicName:String = ""
    private var privateName:String = ""
    fileprivate var fileprivateName:String = ""
    internal var internalName:String = ""
}


var ac = AccessClass()
ac.fileprivateName = "filePrivate"
ac.internalName    = "internal"
ac.openName        = "open"
ac.publicName      = "public"

class ClassA {
    var accc = AccessClass()
    var x = 0
    var handlers:[()->Void] = []
    
    required init (x:Int) {
        self.x = x
        
        
        let swiftCallback : @convention(block) (CGFloat, CGFloat) -> CGFloat = {
            (x, y) -> CGFloat in
            return x + y
        }
        print(swiftCallback(10, 19))
        
    }
    
    
    func methodAutoclosure( _ completion: @autoclosure ()->Void) {
        
        completion()
        print("yyyy")
        //       handlers.append(completion)
    }
    
    
    func methodNoEscape( _ completion: ()->Void) {
        
        completion()
        print("yyyy")
        //       handlers.append(completion)
    }
    
    func methodEscape(_ completion: @escaping ()->Void) {
        handlers.append(completion)
    }
    
    
    
    func test() -> Int {
        accc.fileprivateName = ""
        return 0
    }
    
    
//    func test1()->Never {
//        print("test1")
//    }
}


let a = ClassA(x: 0)
let b = ClassA(x: 0)
a.methodNoEscape { 
    print("No Escape")
}
a.methodAutoclosure(
    {
        print("Autoclosure")
    }()
)

if a === b {
    print("===")
} else {
    print("!==")
}

a.test()
if type(of: a) === type(of: b) {
    print("===")
} else {
    print("!==")
}

let metaType:ClassA.Type = ClassA.self
let instance = metaType.init(x: 10)
print(instance.x)

var optionalString:String?

optionalString = String(9089)


print(optionalString!)
if let string = optionalString {
    print(" numer \(string)")
} else {
}

if let lastName = Int("123"), let familyName = Int("456") , lastName < familyName {
    print("\(lastName) + \(familyName)")
}



enum Number {
    case integer(Int)
    case real(Double)
}

let f = Number.integer
let evenInts:[Number] = [2, 10].map(f)
print(evenInts)

enum ErrorEnum:Error {
    case error1
    case error2
}

func neverRetuen() -> Never {
    fatalError("Something very, very bad happened")
}

var weigh = 1
guard weigh > 0 else {
    neverRetuen()
}



func testThrowError(result num:Int?) throws ->String? {
    guard Int(num!) > 0 else {
    print("num <= 0")
    
    throw ErrorEnum.error1
    }
    print("num = \(num)")
    return String(describing: num)
}


// rethrows only for parameters throw error
func testRethrowError(callback:() throws -> Void) rethrows {
    try callback()
}


do {
//    try testThrowError(1)
    let x = try testThrowError(result: -1)
} catch ErrorEnum.error1 {
    print("catch error!")
}

do {
    let x = try testThrowError(result: 1)
} catch ErrorEnum.error1 {
    print("catch error!")
}

var index = 0
label :while index < 10 {
    print("*")
    if index == 8 {
    break label
    }
    index += 1
}


class SubNSObject: NSObject {
    var name:String?
    func  showName(_ prefix:String) -> Void {
    print(prefix+name!)
    }
    
    
}



let tuple1 = (27, "uwei")
let tuple2 = (28, "yuan")
let tuple3 = (1, "X", "12")

if tuple1 < tuple2 {
    print("<")
}


func ==(p1:SubNSObject, p2:SubNSObject) -> Bool {
    var result = false
    if p1.name == p2.name {
        result = true
    }
    
    return result
}


infix operator ====
//infix operator ===={}
func ==== (p1:SubNSObject, p2:SubNSObject) -> Bool {
    var result = false
    if p1.name == p2.name {
    result = true
    }
    
    return result
}
let s1 = SubNSObject()
//p1.name = "vv"
let s2 = SubNSObject()
//p2.name = "vvv"
let sResult = (s1 ==== s2)
print(sResult)


//precompile error
//let result = tuple1 > tuple3

class UPoint {
    var x:Float?
    var y:Float?
    init(x:Float, y:Float){
        self.x = x
        self.y = y
    }
}
// only for file scope
// first declare the override operator
infix operator +- {associativity right precedence 0}
// then complemention
func +-(p1:UPoint, p2:UPoint) -> UPoint {
    return UPoint(x: p2.x! - p1.x!, y: p2.y! + p1.y!)
}



var p1 = UPoint(x: 1, y: 2)
var p2 = UPoint(x: 3, y: -1)

let p3 = p1 +- p2

print("P3 = (\(p3.x!), \(p3.y!))")


//#if swift(>=3.0)
//print("3.0")
//#else
//print("low")
//#endif


class Person: NSObject {
    var name: String
    var friends: [Person] = []
    var bestFriend: Person? = nil
    
    init(name: String) {
        self.name = name
    }
}


let gabrielle = Person(name: "Gabrielle")
let jim = Person(name: "Jim")
let yuanyuan = Person(name: "Yuanyuan")
gabrielle.friends = [jim, yuanyuan]
gabrielle.bestFriend = yuanyuan
print ( gabrielle.value(forKeyPath: #keyPath(Person.bestFriend.name)) )


func functionWithDefaultValue(p:Int  = 100) -> Int {
    return p + 1
}

print( functionWithDefaultValue() )
print(functionWithDefaultValue(p: 2))

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
    total += number
    }
    return total / Double(numbers.count)
}

print(arithmeticMean(1,3,4))

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
var mathFunction: (Int, Int) -> Int = addTwoInts
print("Result: \(mathFunction(2, 3))")

func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

printMathResult(addTwoInts, 3, 5)

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")


func minMax(array: [Int]) -> (min: Int, max: Int)? {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
        currentMin = value
    } else if value > currentMax {
        currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}

class SomeClass: NSObject {
    let property: String
    @objc(xxxx)
    var myProperty:String = ""
    @objc(doSomethingWithInt:)
    func doSomething(xx x: Int) { }
    
    init(property: String) {
        self.property = property
    }
}

let selectorForMethod = #selector(SomeClass.doSomething(xx:))
let selectorForPropertyGetter = #selector(getter: SomeClass.property)
let selectorForPropertySetter = #selector(setter: SomeClass.myProperty)


// MARK:- 高阶函数的使用
let intArray = [1,2,4,8,16]
let sIntArray = intArray.map { $0*$0 }
print(sIntArray)
// sIntArray.map({print($0)})
let fIntArray = sIntArray.filter({$0 > 4})
print(fIntArray)

let addString: (String, Int) -> String = {
        return $0 + String($1) + ","
}

let sumArray = fIntArray.reduce(0, +)
print(sumArray)
let stringArray = fIntArray.reduce("", {return $0 + "," + String($1)})
//let stringArray = fIntArray.reduce("", combine: {return String($0)})
print(stringArray)




// MARK:- 面向函数式编程
let clourse:(Int) -> Int = { x in
    return x + 2
}
func testClourse(str:String, clourse:(Int)->Int) -> String {
    let result = clourse(98)
    var string = ""
    if result > 98 {
    string = str + " " + String(result)
    }
    return string
}

// MARK:- 科里化函数
func curryTestClourse(str:String)->((Int)->Int) -> String {
    return { (intClourse: (Int) -> Int) -> String in
    let result = intClourse(9)
    var string = ""
    if result > 98 {
    string = str + " " + String(result)
} else {
    string = str + " " + "error"
    }
    return string
    }
}

let testClourseResult = testClourse(str: "hello", clourse:clourse)
print(testClourseResult)
let testCurryTestClourseFirst = curryTestClourse(str: "world")
let testCurryTestClourseResult = testCurryTestClourseFirst(clourse)
print(testCurryTestClourseResult)

class DataImporter {
    /*
     DataImporter is a class to import data from an external file.
     The class is assumed to take a non-trivial amount of time to initialize.
     */
    var fileName = "data.txt"
    init() {
        print("DataImporter Inited!")
    }
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
        lazy var importer = DataImporter()
        var data = [String]()
        // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
print(manager.data)
print(manager.importer.fileName)

// MARK:- About point in swift
var intV = 10
var mpInt = UnsafeMutablePointer<Int>.allocate(capacity: 1)
mpInt.initialize(to: intV)
print(mpInt.pointee)
intV = mpInt.pointee + 1
mpInt.deinitialize()
mpInt.deallocate(capacity: 1)


intV = withUnsafeMutablePointer(to: &intV, { (ptr:UnsafeMutablePointer<Int>) -> Int in
    ptr.pointee += 1
    return ptr.pointee
    })

print(intV)


var voidPtr = withUnsafeMutablePointer(to: &intV, { (ptr:UnsafeMutablePointer<Int>) -> UnsafeMutableRawPointer in
    return unsafeBitCast(ptr, to: UnsafeMutableRawPointer.self)
    })

var intP = unsafeBitCast(voidPtr, to: UnsafeMutablePointer<Int>.self)
print("int p = \(intP.pointee)")


var array = [1111,2222]
var arrPtr = UnsafeBufferPointer<Int>(start: &array, count:array.count)
var basePtr = arrPtr.baseAddress
print(basePtr?.pointee ?? "")
var nextPtr = basePtr?.successor()
print(nextPtr?.pointee ?? "")

let stringParams = "123455656677"
let pStr = UnsafeMutablePointer<Int8>.allocate(capacity: stringParams.characters.count)
pStr.initialize(from: stringParams.cString(using: String.Encoding.utf8)!)
print(showInfo(params: pStr))

let pRawPtr = UnsafeMutableRawPointer.allocate(bytes: stringParams.characters.count, alignedTo: MemoryLayout<String>.alignment)
let tPtr = pRawPtr.initializeMemory(as: String.self, to: stringParams)
print(pRawPtr.load(as: String.self))
let ttPtr = pRawPtr.initializeMemory(as: Int8.self, from: pStr, count: stringParams.characters.count)
print(showInfo(params: ttPtr))


struct AAA {
    var value:Int
}
func initRawAA(p:UnsafeMutableRawPointer) -> UnsafeMutablePointer<AAA> {
    return p.initializeMemory(as: AAA.self, to: AAA(value: 1111))
}

let rawPtr = UnsafeMutableRawPointer.allocate(bytes: MemoryLayout<AAA>.stride, alignedTo: MemoryLayout<AAA>.alignment)
let pa = initRawAA(p: rawPtr)
print(rawPtr.load(as: AAA.self))
print(pa.pointee.value)

let rp = UnsafeMutableRawPointer.allocate(bytes: 1, alignedTo: 1)
rp.bindMemory(to: AAA.self, capacity: 2)


//var mpString = UnsafeMutablePointer<String>(allocatingCapacity: 1)
var mpString = UnsafeMutablePointer<String>.allocate(capacity: 1)
mpString.initialize(to: "uwei")
print(mpString.pointee)
mpString.deinitialize()
mpString.deallocate(capacity: 1)




func md5(string: String) -> String {
    var digest:[UInt8] = [UInt8](repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
    let data = string.data(using: String.Encoding.utf8)! as NSData
    CC_MD5(data.bytes, CC_LONG(data.length), &digest)
    
    var digestHex = ""
    for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
        digestHex += String(format: "%02x", digest[index])
    }
    
    return digestHex
}

let md5String = md5(string: "uwei")
print(md5String)
print(md5(string: md5String))



func testFunctionParams1(p1:String, p2:Int) -> Void {
    print("\(p1), \(p2)")
}

func testFunctionParams(label1 p1:String, label2 p2:Int) -> Void {
    print("\(p1), \(p2)")
}



testFunctionParams(label1: "12345", label2: 678)


#sourceLocation(file:"File.swift", line:20)

print(#function)
print(#file)
print(#line)
print(#column)

displayInfo()






#sourceLocation()

#if os(iOS)
    print("iOS")
#elseif os(tvOS)
    print("tv X")
#elseif os(OSX)
    print("OS X")
    #else
    print("unknown")
#endif

#if arch(x86_64)
    print("Mac")
    #else
    print("other")

#endif




