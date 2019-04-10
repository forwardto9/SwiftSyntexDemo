//
//  main.swift
//  SwiftSyntexDemo
//
//  Created by uwei on 9/29/15.
//  Copyright © 2015 Tencent. All rights reserved.
//

import Foundation

@dynamicCallable // Swift 5 可以调用对象实例就像调用一个可以带有任意数量的函数一样,
struct TelephoneExchange {
    // 参数必须遵循协议： ExpressibleByArrayLiteral
    func dynamicallyCall(withArguments nums:[Int]) {
        if nums == [1,1,0] {
            print("police number")
        } else {
            print("unrecoginzed number")
        }
    }
    
    // 参数必须遵循协议： ExpressibleByDictionaryLiteral， Key必须要遵循协议：ExpressibleByStringLiteral
    func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, Int>) -> String {
        return pairs.map{lable, count in
            repeatElement(lable, count: count).joined(separator: "-")
        }.joined(separator: "|")
    }
    
    // 此方法就不能将实例对象模拟成函数调用，因为不遵循上述要求
    func dynamicallyCall(withArguments nums:Int) {
        print(nums)
    }
}

let telEx = TelephoneExchange()
//telEx([1,1,10]) // error , 参数类型匹配不到
telEx(1,1,10)
telEx(1,1,0)

//telEx("test") // error , 参数类型匹配不到
//telEx(A:1, B:"") // error , 参数类型匹配不到

print(telEx(A:1, B:2))

telEx.dynamicallyCall(withArguments: 1)



let predicateDemo = PredicateDemo()
predicateDemo.testPredicate()


class HTMLElement {
    
    let name: String
    @objc   let text: String?
    
    // 这个地方使用？符号标记，是为了可以在外面进行赋空值操作，从而可以标记为可以释放引用
    //  lazy修饰的属性，可以用来表明这个属性的值是不可知的，是依赖外部条件的，直到在一个实例被创建完成之后；只有被用到的时候才会被创建，这个特性可以用来实现懒加载
    lazy var asHTML: (() -> String)? = { [unowned self] in // 此处使用unowned标记，可以让闭包标中不在强引用self
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}


var heading:HTMLElement? = HTMLElement(name: "h1")
let defaultText = "some default text"
heading!.asHTML = {
    return "<\(heading!.name)>\(heading?.text ?? defaultText)</\(heading!.name)>"
}
print(heading!.asHTML!())

heading = nil


var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML?() ?? "hahaha")
//paragraph!.asHTML = nil (如果asHTML被？符号标记，此处必须要释放，这样才能让paragraph充分释放)
paragraph = nil


class Country {
    let name:String
    var capitalCity:City! // 这样声明，表示这个值默认是nil
    init(name:String, capitalName:String) {
        self.name = name // 到此为止，self实例就创建完毕，可以访问了，如果不是按照！符号的声明方式，下面的代码就会无法编译
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name:String
    unowned let country:Country
    init(name:String, country:Country) {
        self.name = name
        self.country = country
    }
}

let country = Country(name: "zhongguo", capitalName: "beijing")
let city = City(name: "beijing", country: country)



class TestOCClass: NSObject {
    var testVar:NSString? = ""
//    deinit {
//        print("deinit from TestOCClass")
//        testVar = nil
//    }
}

class TestSwiftClass: NSObject {
    var testVar:String? = ""
    deinit {
        print("deinit from TestSwiftClass")
//        testVar = nil
    }
}


var toc:TestOCClass? = TestOCClass()
toc?.testVar = "oc"
toc = nil

var tsc:TestSwiftClass? = TestSwiftClass()
tsc?.testVar = "swift"
tsc = nil



func numberNotation(_ number:Int64) -> String {
    var numberString = ""
    let weight:Int64 = 10000
    if number >= weight {
        let fx1 = Float(number) / Float(weight)
        numberString = NSString(format: "%.2f", fx1).appending("万")
    } else {
        numberString = NSString(format: "%d", number) as String
    }
    return numberString
}

print(numberNotation(11000))


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

var stackString = Stack(items: ["string1", "string2"])
stackString.append("string3")
for string in stackString.items {
    print(string)
}



// MARK: GCD in Swift
let group = DispatchGroup()

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

// MARK:  Enum
//enum Color:Int {
enum Color {
    case red, black
    func colorDescription() -> String {
        switch self {
        case .red:
            return "RED"
        case .black:
            return "BLACK"
        }
    }
}
//print(Color.black.rawValue)
print(Color.black)

enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let sucess = ServerResponse.result("6:00am", "9:00pm")
let failuer = ServerResponse.failure("Out of service")
print(sucess)
switch sucess {
case let .result(sunrise, sunset):
    print("sunrice is at \(sunrise), sunset is at \(sunset)")
case let .failure(reason):
    print("failure reason is \(reason)")
}


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
    
    // 此属性用于提醒编译器，不需要对未使用返回值的调用发出警告
    // @discardableResult
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


// MARK: Error Handling
@discardableResult // 取消返回值未用到的编译警告
func testThrowError(result num:Int?) throws ->String? {
    defer { // defer代码块类似OC中try catch finally块中的finally块，始终是函数中最后执行的，可以用于还原设置、清理现场等场景
        print("this is like exceeded finally")
    }
    guard Int(num!) > 0 else {
    print("num <= 0")
    
    throw ErrorEnum.error1
    }
    print("num = \(String(describing: num))")
    return String(describing: num)
}


// rethrows only for parameters throw error
func testRethrowError(callback:() throws -> Void) rethrows {
    try callback()
}


do {
    try testThrowError(result: -1)
} catch ErrorEnum.error1 {
    print("catch error!")
}

// try?，当方法调用出现throw的时候，方法的返回值是nil，throw出的error会被取消
let testThrowErrorResult = ((try? testThrowError(result: -1)) as String??)
print(testThrowErrorResult as Any )

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
//infix operator +- {associativity right precedence 0} //不再推荐使用
infix operator +-:AdditionPrecedence // 新的方式，需要知道precedence group 参照：https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations
// then complemention
func +-(p1:UPoint, p2:UPoint) -> UPoint {
    return UPoint(x: p2.x! - p1.x!, y: p2.y! + p1.y!)
}



var p1 = UPoint(x: 1, y: 2)
var p2 = UPoint(x: 3, y: -1)

let p3 = p1 +- p2


//#if swift(>=3.0)
//print("3.0")
//#else
//print("low")
//#endif





let gabrielle = Person(name: "Gabrielle")
let jim = Person(name: "Jim")
let yuanyuan = Person(name: "Yuanyuan")
gabrielle.friends = [jim, yuanyuan]
gabrielle.bestFriend = yuanyuan
// 使用let 对一个optional的对象取值的步骤是：1.先询问optional对象是不是空，2如果是空，在不进行赋值，且跳过if；如果不是空，则进行unwrap操作（等同于使用 ! 操作），并进行赋值操作
if let name = gabrielle.bestFriend?.name {
    print(name)
}

//MARK: Runtime in Swift
// #selector
print ( gabrielle.value(forKeyPath: #keyPath(Person.bestFriend.name)) as Any )


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
    @objc let property: String
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

// MARK:- About pointer in swift
var intV = 10
// 申请内存，类似 C 中的 Int *
var mpInt = UnsafeMutablePointer<Int>.allocate(capacity: 1)
// 给内存初始化
mpInt.initialize(to: intV)
print(mpInt.pointee)
intV = mpInt.pointee + 1
//mpInt.deinitialize()
//mpInt.deallocate(capacity: 1)
mpInt.deallocate()

intV = withUnsafeMutablePointer(to: &intV, { (ptr:UnsafeMutablePointer<Int>) -> Int in
    ptr.pointee += 1
    return ptr.pointee
    })

print(intV)

// 类似C中的 void *
var voidPtr = withUnsafeMutablePointer(to: &intV, { (ptr:UnsafeMutablePointer<Int>) -> UnsafeMutableRawPointer in
    return UnsafeMutableRawPointer(ptr)
    })

var intP = voidPtr.assumingMemoryBound(to: Int.self)
print("int p = \(intP.pointee)")


var array = [1111,2222]
var arrPtr = UnsafeBufferPointer<Int>(start: &array, count:array.count)
var basePtr = arrPtr.baseAddress
print(basePtr?.pointee ?? "")
var nextPtr = basePtr?.successor()
print(nextPtr?.pointee ?? "")

var stringParams = "123455656677"
let pStr = UnsafeMutablePointer<Int8>.allocate(capacity: stringParams.count)
pStr.initialize(from: stringParams.cString(using: String.Encoding.utf8)!, count: stringParams.lengthOfBytes(using: .utf8))
print(showInfo(params: pStr) ?? "default value")

//let pRawPtr = UnsafeMutableRawPointer.allocate(bytes: stringParams.count, alignedTo: MemoryLayout<String>.alignment)
let pRawPtr = UnsafeMutableRawPointer.allocate(byteCount: stringParams.count, alignment: MemoryLayout<String>.alignment)
//let tPtr = pRawPtr.initializeMemory(as: String.self, to: stringParams)
let ppStr = UnsafeMutablePointer<String>.allocate(capacity:1)
ppStr.initialize(from: &stringParams, count: 1)
pRawPtr.initializeMemory(as: String.self, from: ppStr, count: 1)
print(pRawPtr.load(as: String.self))

let ttPtr = pRawPtr.initializeMemory(as: Int8.self, from: pStr, count: stringParams.count)
print(showInfo(params: ttPtr) ?? "default value")


struct AAA {
    var value:Int
}
func initRawAA(p:UnsafeMutableRawPointer) -> UnsafeMutablePointer<AAA> {
    return p.initializeMemory(as: AAA.self, repeating: AAA(value: 1111), count: 1)
//     p.initializeMemory(as: AAA.self, to: AAA(value: 1111)) // old API
}

let rawPtr = UnsafeMutableRawPointer.allocate(byteCount: 1 * MemoryLayout<AAA>.stride, alignment: MemoryLayout<AAA>.alignment)
let pa = initRawAA(p: rawPtr)
print(rawPtr.load(as: AAA.self))
print(pa.pointee.value)


let count = 4
// 100 bytes of raw memory are allocated for the pointer bytesPointer, and then the first four bytes are bound to the AAA type.
let bytesPointer = UnsafeMutableRawPointer.allocate( byteCount: 100, alignment: MemoryLayout<AAA>.alignment)
let aaaPointer = bytesPointer.bindMemory(to: AAA.self, capacity: count)
print(aaaPointer.pointee)


//var mpString = UnsafeMutablePointer<String>(allocatingCapacity: 1)
var mpString = UnsafeMutablePointer<String>.allocate(capacity: 1)
mpString.initialize(to: "uwei")
print(mpString.pointee)
mpString.deallocate()




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


@dynamicMemberLookup
struct DynamicStruct {
    let dictionary = ["someDynamicMember": 325,
                      "someOtherMember": 787]
    // must be implementation
    subscript(dynamicMember member: String) -> Int {
        return dictionary[member] ?? 1054
    }
}
let s = DynamicStruct()

// Using dynamic member lookup
let dynamic = s.someOtherMember
print(dynamic)
// Prints "325"

// Calling the underlying subscript directly
let equivalent = s[dynamicMember: "someDynamicMember"]
print(dynamic == equivalent)
