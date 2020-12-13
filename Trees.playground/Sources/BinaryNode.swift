import Foundation

public class BinaryNode<Element> {
   
   public var value:Element
   public var leftChild:BinaryNode?
   public var rightChild:BinaryNode?
   
   public init(value:Element) {
      self.value = value
   }
}

extension BinaryNode: CustomStringConvertible {
   public var description:String {
      return diagram(for: self)
   }
   
   private func diagram(for node: BinaryNode?,
                        _ top:String = "",
                        _ root:String = "",
                        _ bottom:String = "") -> String {
      
      guard let node = node else {
         return root + "nil\n"
      }
      
      if node.leftChild == nil && node.rightChild == nil {
         return root + "\(node.value)\n"
      }
      
      return diagram(for: node.rightChild, top + " ", top + "┌──", top + "| ")
               + root + "\(node.value)\n"
               + diagram(for: node.leftChild, bottom + "| " , bottom + "└──", bottom + " ")
   }
}

// MARK: - Traversal
// MARK: infix traversal
extension BinaryNode {

   /// Ordered Ascending
   public func traverseInOrder(visit:(Element) -> ()) {
      leftChild?.traverseInOrder(visit: visit)
      visit(value)
      rightChild?.traverseInOrder(visit: visit)
   }
}

// MARK: prefix traversal
extension BinaryNode {
   public func traversePreOrder(visit:(Element) -> ()) {
      /// the root node is always visited last
      /// Bottom-Up traversing
      visit(value)
      leftChild?.traversePreOrder(visit: visit)
      rightChild?.traversePreOrder(visit: visit)
   }
}

// MARK: postfix traversal
extension BinaryNode {
   /// the root node is always visited last
   /// Top-Down traversing
   public func traversePostOrder(visit:(Element) -> ()) {
      leftChild?.traversePostOrder(visit: visit)
      rightChild?.traversePostOrder(visit: visit)
      visit(value)
   }
}

