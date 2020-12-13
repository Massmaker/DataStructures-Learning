// Code taken from:
// https://gist.github.com/loromits/945039733a1da524c82860a48d65fcf6

import Foundation

public struct DoublyLinkedList<Element> {
   
   class Node {
      var value: Element
      weak var next: Node?
      var previous: Node?
      
      init(_ value: Element, next: Node?, previous: Node?) {
         (self.value, self.next, self.previous) = (value, next, previous)
         next?.previous = self
         previous?.next = self
      }
   }
   
   fileprivate var first:Node?
   fileprivate var last:Node?
   private(set) var count = 0
   
   var isEmpty: Bool {
      return count == 0
   }
   
   var peek:Element? {
      return last?.value
   }
   
   init() {
      
   }
   
   init<S:Sequence>(_ s:S) where S.Iterator.Element == Element {
      for entry in s {
         pushLast(entry)
      }
   }
   //MARK: -
   
   @discardableResult
   public mutating func pop() -> Element? {
      let f = first
      
      if let af = f {
         first = af.previous
         first?.next = nil
         count -= 1
         if isEmpty {
            last = nil
         }
      }
      
      return f?.value
   }
   
   public mutating func push(_ v:Element) {
      first = Node(v, next: nil, previous: nil)
      if isEmpty {
         last = first
      }
      count += 1
   }
   //MARK: -
   public mutating func popLast() -> Element? {
      
      let l = last
      
      if let aL = l {
         
         last = aL.next
         last?.previous = nil
         count -= 1
         
         if isEmpty {
            first = nil
         }
      }
      
      return l?.value
   }
   
   public mutating func pushLast(_ v:Element) {
      last = Node(v, next:last, previous: nil)
      if isEmpty {
         first = last
      }
      count += 1
   }
   
   //MARK: - Insert
   
   public mutating func insert(_ v:Element, after succeeds: (Element) -> Bool) {
      var cursor = first
      
      while let value = cursor?.value {
         if succeeds(value) {
            insert(v, after: cursor)
            return
         }
         cursor = cursor?.previous
      }
   }
   
   public mutating func insert(_ v:Element, at index:Int ) {
      let cursor = nodeAt(index:index)
      
      if isEmpty {
         push(v)
      }
      else if cursor != nil {
         insert(v, before: cursor)
      }
      else {
         pushLast(v)
      }
   }
   
   private mutating func insert(_ v:Element, after cursor:Node?) {
      
      let node = Node(v, next: cursor, previous: cursor?.previous)
      
      if cursor === last {
         last = node
      }
      
      count += 1
   }
   
   private mutating func insert(_ v: Element, before cursor: Node?) {
      let node = Node(v, next: cursor?.next, previous: cursor)
      
      if cursor === first {
         first = node
      }
      
      count += 1
   }
   
   //MARK: - Remove
   @discardableResult
   public mutating func removeAt(index:Int) -> Element? {
      return remove(node: nodeAt(index: index))
   }
   
   @discardableResult
   public mutating func remove(where succeeds:(Element) -> Bool) -> Element? {
      var cursor = first
         
      while let value = cursor?.value {
         if succeeds(value) {
            return remove(node: cursor)
         }
         cursor = cursor?.previous
      }
      return nil
   }
   
   private mutating func remove(node:Node?) -> Element? {
      if count < 2 {
         pop()
      }
      else {
         node?.previous?.next = node?.next
         node?.next?.previous = node?.previous
         count -= 1
      }
      
      if node === last {
         last = node?.next
      }
      
      if node === first {
         first = node?.previous
      }
      
      return node?.value
   }
   
   //MARK: -
   fileprivate func nodeAt(index: Int) -> Node? {
      var counter = index
      var cursor = first
      
      while counter > 0 && cursor != nil {
         counter -= 1
         cursor = cursor?.previous
      }
      
      return cursor
   }
   
   //MARK: - Subscript
   
   subscript(index: Int) -> Element? {
      get {
         return nodeAt(index: index)?.value
      }
      set {
         if let new = newValue {
            nodeAt(index: index)?.value = new
         }
      }
   }
}

//MARK: -

//MARK: CustomStringConvertible
extension DoublyLinkedList: CustomStringConvertible {
   public var description: String {
      var elements = [Element]()
      var cursor = first
      while let value = cursor?.value {
         elements.append(value)
         cursor = cursor?.previous
      }
      return elements.map { "\($0)" }.joined(separator: ", ")
   }
}

//MARK: ==
extension DoublyLinkedList where Element: Equatable {
   
   static func ==(lhs: DoublyLinkedList, rhs: DoublyLinkedList) -> Bool {
      var (lhsCursor, rhsCursor) = (lhs.first, rhs.first)
      
      while let lhsValue = lhsCursor?.value,
            let rhsValue = rhsCursor?.value,
            lhsValue == rhsValue {
         
         (lhsCursor, rhsCursor) = (lhsCursor?.previous, rhsCursor?.previous)
      }
      
      return lhsCursor == nil && rhsCursor == nil
   }
}
