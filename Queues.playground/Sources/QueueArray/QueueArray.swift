import Foundation

public struct QueueArray<T>: Queue {
   
   
   private var array:[T] = []
   public init() {}
   
   //O(1)
   public var isEmpty: Bool {
      return array.isEmpty
   }
   
   //O(1)
   public var peek: T? {
      return array.first
   }
   
   //ammortized O(1) - the array is doubled in capacity each time it is full
   public mutating func enqueue(_ element: T) -> Bool {
      array.append(element)
      return true
   }
   
   //O(n)
   public mutating func dequeue() -> T? {
      return isEmpty ? nil : array.removeFirst()
   }
}


extension QueueArray : CustomStringConvertible {
   public var description: String {
      return array.description
   }
}
