import Foundation

public struct Heap<Element: Equatable> {
   private var elements: [Element] = []
   private let sort: (Element, Element) -> Bool
   
   public var isEmpty:Bool {
      return elements.isEmpty
   }
   
   public var count:Int {
      return elements.count
   }
   
   public init(elements:[Element] = [], sort: @escaping (Element, Element) -> Bool) {
      self.elements = elements
      self.sort = sort
      
      
      // try to optimize for later search
      if !elements.isEmpty {
         for i in stride(from: elements.count / 2, through: 0, by: -1) {
            siftDown(from: i)
         }
      }
   }
   
   /*
    Given a node at a zero-based index i:
     - The left child of this node can be found at index 2i + 1.
     - The right child of this node can be found at index 2i + 2
   */
   
   /*
    Given a child node at index i, this child’s parent node canbe found at index floor( (i - 1) / 2)
   */

   /*
    Note: Traversing down an actual tree to get the left and right child of a node is a O(log n) operation.
    In an random access data structure such as an array, that same operation is just O(1)
   */
   
   public func peek() -> Element? {
      return elements.first
   }
   
   func leftChildIndex(ofParentAt index:Int) -> Int {
      return (2 * index) + 1
   }
   
   func rightChildIndex(ofParentAt index:Int) -> Int {
      return (2 * index) + 2
   }
   
   func parentIndex(ofChildAt index:Int) -> Int {
      return (index - 1) / 2
   }
   
   //MARK: - Remove
   public mutating func remove() -> Element? {
      guard !isEmpty else {
         return nil
      }
      
      //O(1)
      elements.swapAt(0, count - 1)
      
      defer {
         siftDown(from: 0)
      }
      
      return elements.removeLast()
   }
   
   //O(log n)
   private mutating func siftDown(from index:Int) {
      var parent = index
      
      while true {
         let leftIndex = leftChildIndex(ofParentAt: parent)
         let rightIndex = rightChildIndex(ofParentAt: parent)
         var candidate = parent
         
         if leftIndex < count && sort(elements[leftIndex], elements[candidate]) {
            candidate = leftIndex
         }
         
         if rightIndex < count && sort(elements[rightIndex], elements[candidate]) {
            candidate = rightIndex
         }
         //If candidate is still parent, you have reached the end, and no more sifting is required
         if candidate == parent {
            return
         }
         
         elements.swapAt(parent, candidate)
         parent = candidate
      }
   }
   
   //MARK: - Insert
   
   //O(log n)
   public mutating func insert(_ element:Element) {
      //O(1)
      elements.append(element)
      //O(log n)
      siftUp(from: elements.count - 1)
   }
   
   //O(log n)
   private mutating func siftUp(from index:Int) {
      var childIdx = index
      var parentIdx = parentIndex(ofChildAt: childIdx)
      
      while parentIdx > 0 && sort(elements[childIdx], elements[parentIdx]) {
         
         elements.swapAt(childIdx, parentIdx)
         childIdx = parentIdx
         parentIdx = parentIndex(ofChildAt: childIdx)
         
      }
   }
   
   //MARK: - Remove
   
   public mutating func remove(at index:Int) -> Element? {
      guard index < elements.count else {
         return nil
      }
      
      if index == elements.count - 1 {
         return elements.removeLast()
      }
      else {
         elements.swapAt(index, elements.count - 1)
         
         defer {
            siftDown(from: index)
            siftUp(from: index)
         }
         
         return elements.removeLast()
      }
   }
   
   //MARK: - Search (index Of)
   
   //O(n) - worst case
   public func index(of element:Element, startingAt i:Int) -> Int? {
      if i >= count {
         return nil
      }
      
      //Check to see if the element you are looking for has higher prioritythan the current element at index i. If it does, the element youare looking for cannot possibly be lower in the heap
      if sort(element, elements[i]) {
         return nil
      }
      
      if element == elements[i] {
         return i
      }
      
      if let l = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
         return l
      }
      
      if let r = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
         return r
      }
      
      return nil
   }
}
