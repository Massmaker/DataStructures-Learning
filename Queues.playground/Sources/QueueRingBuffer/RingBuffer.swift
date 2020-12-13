/*
 Code taken from
 https://github.com/raywenderlich/swift-algorithm-club/blob/master/Ring%20Buffer/RingBuffer.playground/Contents.swift
 */

import Foundation

public struct RingBuffer<T> {
   
   fileprivate var array: [T?]
   fileprivate var readIndex = 0
   fileprivate var writeIndex = 0
   
   public init(count:Int) {
      array = [T?](repeating: nil, count: count)
   }
   
   /* Returns false if out of space. */
   @discardableResult
   public mutating func write(_ element: T) -> Bool {
      guard !isFull else { return false }
      
      defer {
         writeIndex += 1
      }
      
      array[wrapped:writeIndex] = element
      
      return true
   }
   
   public mutating func read() -> T? {
      guard !isEmpty else {
         return nil
      }
      
      defer {
         array[wrapped: readIndex] = nil
         readIndex += 1
      }
      
      return array[wrapped: readIndex]
   }
   
   fileprivate var availableSpaceForReading: Int {
      return writeIndex - readIndex
   }
   
   public var isEmpty: Bool {
      return availableSpaceForReading == 0
   }
   
   fileprivate var availableSpaceForWriting: Int {
      return array.count - availableSpaceForReading
   }
   
   public var isFull: Bool {
      return availableSpaceForWriting == 0
   }
   
   public var first:T? {
      return array[wrapped:readIndex]
   }
}

//MARK: - Sequence
extension RingBuffer: Sequence {
   
   public func makeIterator() -> AnyIterator<T> {
      
      var index = readIndex
      
      return AnyIterator {
         
         guard index < self.writeIndex else {
            return nil
         }
         
         defer {
            index += 1
         }
         
         return self.array[wrapped:index]
      }
   }
}


//MARK: Array - Wrapped
private extension Array {
   
   subscript(wrapped index:Int) -> Element {
   
      get {
         return self[index % count]
      }
      
      set {
         self[index % count] = newValue
      }
   }
}

//MARK: -
extension RingBuffer: CustomStringConvertible {
   public var description: String {
      return array.description
   }
}
