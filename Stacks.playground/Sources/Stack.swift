import Foundation


// LIFO
public struct Stack<Element> {
   private var storage:[Element] = []
   public init() {
      
   }
   
   public init(_ elements: [Element]) {
      storage = elements
   }
   
   @discardableResult
   public mutating func pop() -> Element? {
      return storage.popLast()
   }
   
   public mutating func push(_ element:Element) {
      storage.append(element)
   }
   
   //MARK: - Nice to have functionality
   public func peek() -> Element? {
      return storage.last
   }
   
   public var isEmpty:Bool {
      return peek() == nil
   }
}

extension Stack: CustomStringConvertible {
   public var description: String {
      let topDivider = "----top----\n"
      let bottomDivider = "\n-----------"

      let stackElements = storage
         .map { (element) -> String in
         return "\(element)"
            
         }.reversed()
         .joined(separator: "\n")
      
      return topDivider + stackElements + bottomDivider
   }
}

//Nice to have
extension Stack: ExpressibleByArrayLiteral {

   public init(arrayLiteral elements: Element...) {
      storage = elements
   }
   
   
}
