import Foundation

public class QueueLinkedList<T>: Queue {
   
   //Space complexity O(n)
   private var list = DoublyLinkedList<T>()
   
   public init() {
      
   }
   
   public var peek:T? {
      return list.peek
   }
   
   public var isEmpty: Bool {
      return list.isEmpty
   }
   
   //O(1)
   public func enqueue(_ element:T) -> Bool {
      list.push(element)
      return true
   }
   
   //O(1)
   public func dequeue() -> T? {
      guard !list.isEmpty else {
         return nil
      }
      
      return list.pop()
   }
}


//MARK: -

extension QueueLinkedList: CustomStringConvertible {
   public var description:String {
      return list.description
   }
}
