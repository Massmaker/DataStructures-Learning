import Foundation


public struct BinarySearchTree<Element : Comparable> {
   public private(set) var root:BinaryNode<Element>?
   public init() {}
}

extension BinarySearchTree: CustomStringConvertible {
   public var description:String {
      return root?.description ?? "Empty Tree"
   }
}


//MARK: - insert
extension BinarySearchTree {
   /**
    In accordance with the rules of the BST, nodes of the left child must contain values less than the current node. Nodes of the right child must contain values greater than or equal to the current node.
    */
   
   public mutating func insert(_ value:Element) {
      root = insert(from: root, value:value)
   }
   
   private mutating func insert(from node:BinaryNode<Element>?, value:Element) -> BinaryNode<Element> {
      
      guard let node = node else {
         return BinaryNode(value:value)
      }
      
      if value < node.value {
         node.leftChild = insert(from: node.leftChild, value: value)
      }
      else {
         node.rightChild = insert(from: node.rightChild, value: value)
      }
      
      return node
   }
}

//MARK: - contains
extension BinarySearchTree {
//   //O(n)
//   public func contains(_ value:Element) -> Bool {
//
//      guard let root = root else {
//         return false
//      }
//
//      var found = false
//
//      root.traverseInOrder {
//         if $0 == value {
//            found = true
//         }
//      }
//
//      return found
//   }
   
   //O(log n)
   public func contains(_ value:Element) -> Bool {
      
      var contains = false
      
      var currentNode = root
      
      while let node = currentNode {
         if node.value == value {
            contains = true
            break
         }
         
         if value < node.value {
            currentNode = node.leftChild
         }
         else {
            currentNode = node.rightChild
         }
      }
      
      return contains
   }
}

//MARK: - min
private extension BinaryNode {
   var min: BinaryNode {
      return leftChild?.min ?? self
   }
}

//MARK: - remove
extension BinarySearchTree {
   public mutating func remove(_ value:Element) {
      root = remove(node:root, value:value)
   }
   
   private func remove(node:BinaryNode<Element>?, value value:Element) -> BinaryNode<Element>? {
      guard let node = node else {
         return nil
      }
      
      if value == node.value {
         //In the case where the node is a leaf node, simply return nil, thereby removing the current node.
         if node.leftChild == nil && node.rightChild == nil {
            return nil
         }
         
         //If the node has no leftchild, return node.rightChild to reconnect the right subtree
         if node.leftChild == nil {
            return node.rightChild
         }
         
         //If the node has no rightchild, return node.leftChild to reconnect the left subtree
         if node.rightChild == nil {
            return node.leftChild
         }
         
         /*
            This is the case where the node to be removed has both a left and right child. You replace the node’s value with the smallest value from the right subtree. You then call remove on the right child to remove this swapped value.
          */
         
         node.value = node.rightChild!.min.value
         
         node.rightChild = remove(node: node.rightChild, value: node.value)
      }
      else if value < node.value {
         node.leftChild = remove(node: node.leftChild, value: value)
      }
      else {
         node.rightChild = remove(node: node.rightChild, value: value)
      }
      
      return node
   }
}
