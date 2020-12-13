import Foundation


/**
 The idea behind using two stacks is simple.
 Whenever you enqueue an element, it goes in the right stack.
 When you need to dequeue an element, you reverse the right stack and place it in the left stack so you can retrieve the elements using FIFO order.
 
 
 Compared to the array-based implementation, by leveraging two stacks, you were able to transform dequeue(_:) into an amortized O(1) operation.
 Moreover, your two stack implementation is fully dynamic and doesn’t have the fixed size restriction that your ring-buffer-based queue implementation has.
 Finally, it beats the linked list in terms of spacial locality.
 This is because array elements are next to each other in memory blocks.
 So a large number of elements will be loaded in a cache on first access.
 
 Compare this to a linked list where the elements aren’t in contiguous blocks of memory.
 This could lead to more cache misses which will increase access time.
 */
public struct QueueStack<T>: Queue {
   
   private var leftStack: [T] = []
   private var rightStack: [T] = []
   public init () {}
   
   //MARK: - Queue conformance
   
   // O(1)
   public mutating func enqueue(_ element: T) -> Bool {
      rightStack.append(element)
      return true
   }
   
   // amortized O(1)
   public mutating func dequeue() -> T? {
      
      if leftStack.isEmpty {
         //O(n)
         leftStack = rightStack.reversed()
         rightStack.removeAll()
      }
      
      return leftStack.popLast()
   }
   
   // O(1)
   public var isEmpty: Bool {
      return leftStack.isEmpty && rightStack.isEmpty
   }
   
   // O(1)
   public var peek: T? {
      return !leftStack.isEmpty ? leftStack.last : rightStack.first
   }
   
}

//MARK: - CustomStringConvertible
extension QueueStack: CustomStringConvertible {
   
   public var description: String {
      
      let printList = leftStack + rightStack.reversed()
      
      return printList.description
   }
}
