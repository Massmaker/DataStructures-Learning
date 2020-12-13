import Foundation

public class TreeNode<T> {
   public var value: T
   public var children:[TreeNode] = []
   
   public init(_ value:T) {
      self.value = value
   }
   
   public func add(_ child:TreeNode) {
      children.append(child)
   }
}


extension TreeNode {
   public func forEachDepthFirst(visit: (TreeNode) -> ()) {
      visit(self)
      children.forEach {$0.forEachDepthFirst(visit: visit)}
   }
}

extension TreeNode {
   public func forEachLevelOrder(visit:(TreeNode) -> ()) {
      
      visit(self)
      
      var queue = QueueStack<TreeNode>()
      
      children.forEach { queue.enqueue($0) }
      
      while let node = queue.dequeue() {
         visit(node)
         node.children.forEach {  queue.enqueue($0) }
      }
   }
}

extension TreeNode where T: Equatable {
   public func search(_ value:T) -> TreeNode? {
      var result:TreeNode?
      
      forEachLevelOrder { node in
         if node.value == value {
            result = node
         }
      }
      
      return result
   }
}
