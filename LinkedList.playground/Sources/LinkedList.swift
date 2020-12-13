import Foundation

public struct LinkedList<Value> {
   
   public var head:Node<Value>?
   
   public var tail:Node<Value>?
   
   public init() {}
   
   public var isEmpty:Bool {
      return head == nil
   }
   
   //MARK: - Inserting
   //O(1)
   public mutating func push(_ value:Value) {
      
      copyNodes()
      
      head = Node(value:value, next:head)
      if tail == nil {
         tail = head
      }
   }
   
   //O(1)
   public mutating func append(_ value:Value) {
      copyNodes()
      guard !isEmpty else {
         push(value)
         return
      }
      
      assert(tail != nil, "No Tail found during APPEND")
      
      tail!.next = Node(value:value)
      
      tail = tail!.next
   }
   
   //O(i) where i -> given index
   public func node(at index:Int) -> Node<Value>? {
      var currentNode = head
      var currentIndex = 0
      
      while currentNode != nil && currentIndex < index {
         currentNode = currentNode!.next
         currentIndex += 1
      }
      
      return currentNode
   }
   
   //O(1)
   @discardableResult
   public mutating func insert(_ value:Value, after node:Node<Value>) -> Node<Value> {
      
      copyNodes()
      guard tail !== node else {
         append(value)
         return tail!
      }
      
      node.next = Node(value:value, next:node.next)
      return node.next!
   }
   
   //MARK: - Removal
   @discardableResult
   //O(1)
   public mutating func pop() -> Value? {
      copyNodes()
      defer {
         head = head?.next
         if isEmpty {
            tail = nil
         }
      }
      
      return head?.value
   }
   
   @discardableResult
   //O(n)
   public mutating func remopveLast() -> Value? {
      
      copyNodes()
      
      guard let head = head else {
         return nil
      }
      
      guard head.next != nil else {
         return pop()
      }
      
      var previous = head
      var current = head
      
      while let next = current.next {
         previous = current
         current = next
      }
      
      //disconnect last node
      previous.next = nil
      // and update the tail reference
      tail = previous
      
      return current.value
   }
   
   @discardableResult
   //O(1)
   public mutating func remove(after node:Node<Value>) -> Value? {
      
      copyNodes()
      
      defer {
         if node.next === tail {
            tail = node
         }
         node.next = node.next?.next
      }
      
      return node.next?.value
   }
   
   //MARK: -
   private mutating func copyNodes() {
      //to not introduce the O(n) overhead
      guard !isKnownUniquelyReferenced(&head) else {
         return
      }
      
      guard var oldNode = head else {
         return
      }
      
      head = Node(value:oldNode.value)
      var newNode = head
      
      while let nextOldNode = oldNode.next {
         newNode!.next = Node(value:nextOldNode.value)
         newNode = newNode!.next
         
         oldNode = nextOldNode
      }
      
      tail = newNode
   }
}


extension LinkedList: CustomStringConvertible {
   public var description:String {
      guard let head = head else {
         return "Emply List"
      }
      
      return String(describing: head)
   }
}

extension LinkedList: Collection {
   
   public struct Index:Comparable {
  
      public var node:Node<Value>?
      
      static public func ==(lhs: Index, rhs: Index) -> Bool {
         switch (lhs.node, rhs.node) {
         case let (left?, right?) :
            return left.next === right.next
         case (nil, nil):
            return true
         default:
            return false
         }
      }
      
      public static func <(lhs: Index, rhs: Index) -> Bool {
         guard lhs != rhs else {
            return false
         }
         
         let nodes = sequence(first: lhs.node) { $0?.next }
         return nodes.contains {$0 === rhs.node }
      }
      
   }
   
   
   public var startIndex: Index {
      return Index(node: head)
   }
   
   public var endIndex: Index {
      return Index(node: tail?.next)
   }
   
   public func index(after i:Index) -> Index {
      return Index(node:i.node?.next)
   }
   
   public subscript(position: Index) -> Value {
      return position.node!.value
   }
}
