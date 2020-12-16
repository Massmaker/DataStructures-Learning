import Foundation

public class TrieNode<Key: Hashable> {
   
   public var key: Key? //optional because the root node has no key
   public weak var parent: TrieNode? //simplifies the REMOVE method
   public var children:[Key:TrieNode] = [:]
   public var isTerminating:Bool = false
   
   public init(key:Key?, parent: TrieNode?) {
      self.key = key
      self.parent = parent
   }
}
