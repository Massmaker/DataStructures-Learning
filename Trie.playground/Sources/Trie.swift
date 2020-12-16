import Foundation

public class Trie<CollectionType: Collection> where CollectionType.Element: Hashable {
   
   public typealias Node = TrieNode<CollectionType.Element>
   
   private let root = Node(key:nil, parent:nil)
   
   public init() {}
   
   //MARK: - Insert
   
   //O(k), k = collection.count
   public func insert(_ collection: CollectionType) {
      var current = root

      for element in collection {
         
         if current.children[element] == nil {
            current.children[element] = Node(key:element, parent:current)
         }
         
         current = current.children[element]!
      }
      
      current.isTerminating = true
   }
   
   //MARK: - Contains
   
   //O(k), k = collection.count
   public func contains(_ collection:CollectionType) -> Bool {
      var current = root
      for element in collection {
         guard let child = current.children[element] else {
            return false
         }
         current = child
      }
      
      return current.isTerminating
   }
   
   //MARK: - Remove
   //O(k), k = collection.count
   public func remove(_ collection:CollectionType) {
      var current = root
      
      for element in collection {
         guard let child = current.children[element] else {
            return
         }
         current = child
      }
      
      guard current.isTerminating else {
         return
      }
      
      current.isTerminating = false
      
      /*
       Since nodes can be shared, you don’t wantto carelessly remove elements that belong to another collection.
       If there are no other children in the current node, it means thatother collections do not depend on the current node.
       You also check to see if the current node is a terminating node.
       If it is, then it belongs to another collection.
       As long as current satisfies these conditions, you continually backtrack through theparent property and remove the nodes
       */
      while let parent = current.parent,
            current.children.isEmpty,
            !current.isTerminating {
         parent.children[current.key!] = nil
         current = parent
      }
      
   }
}

//MARK: - Prefix Matching

public extension Trie where CollectionType: RangeReplaceableCollection {
   func collections(startingWith prefix: CollectionType) -> [CollectionType] {
      
      var current = root
      
      for element in prefix {
         guard let child = current.children[element] else {
            return []
         }
         
         current = child
      }
      
      return collections(startingWith: prefix, after: current)
   }
   
   
   //O(k*m), k = longest collection matching the prefix,
   //        m = number of collections that match the prefix
   // far better performance than Array`s prefix matching O(k*n)
   private func collections(startingWith prefix:CollectionType,
                            after node:Node) -> [CollectionType] {
      
      var results = [CollectionType]()
      
      //If the current node is a terminating node, you add it to the results
      if node.isTerminating {
         results.append(prefix)
      }
      
      //For every child node, you recursively call collections(startingWith:after:) to seek out other terminating nodes
      
      for child in node.children.values {
         var aPref = prefix
            aPref.append(child.key!)
            results.append(contentsOf: collections(startingWith: aPref,
                                                   after: child))
         
      }
      
      return results
   }
}



