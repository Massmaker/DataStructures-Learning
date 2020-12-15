import Foundation

public class AVLNode<Element> {
   
   public var value:Element
   public var leftChild:AVLNode?
   public var rightChild:AVLNode?
   public var height:Int = 0
   
   public var balanceFactor:Int {
      return leftHeight - rightHeight
   }
   
   public var leftHeight:Int {
      return leftChild?.height ?? -1
   }
   
   public var rightHeight:Int {
      return rightChild?.height ?? -1
   }
   
   public init(value:Element) {
      self.value = value
   }
}

extension AVLNode: CustomStringConvertible {
   public var description:String {
      return diagram(for: self)
   }
   
   private func diagram(for node: AVLNode?,
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
extension AVLNode {

   /// Ordered Ascending
   public func traverseInOrder(visit:(Element) -> ()) {
      leftChild?.traverseInOrder(visit: visit)
      visit(value)
      rightChild?.traverseInOrder(visit: visit)
   }
}

// MARK: prefix traversal
extension AVLNode {
   public func traversePreOrder(visit:(Element) -> ()) {
      /// the root node is always visited last
      /// Bottom-Up traversing
      visit(value)
      leftChild?.traversePreOrder(visit: visit)
      rightChild?.traversePreOrder(visit: visit)
   }
}

// MARK: postfix traversal
extension AVLNode {
   /// the root node is always visited last
   /// Top-Down traversing
   public func traversePostOrder(visit:(Element) -> ()) {
      leftChild?.traversePostOrder(visit: visit)
      rightChild?.traversePostOrder(visit: visit)
      visit(value)
   }
}

