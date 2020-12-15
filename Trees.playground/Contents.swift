
func example(of title: String, execute:()->()) {
   print("----Example Of '\(title)' ----")
   execute()
}

//example(of: "creating a tree") {
//   let beverages = TreeNode("Beverages")
//   let hot = TreeNode("Hot")
//   let cold = TreeNode("Cold")
//   beverages.add(hot)
//   beverages.add(cold)
//   print(beverages)
//}

//MARK: - TreeNode
//func makeBeverageTree() -> TreeNode<String> {
//   let tree = TreeNode("Beverages")
//
//   let hot = TreeNode("hot")
//   let cold = TreeNode("cold")
//   let tea = TreeNode("tea")
//   let coffee = TreeNode("coffee")
//   let chocolate = TreeNode("cocoa")
//   let blackTea = TreeNode("black")
//   let greenTea = TreeNode("green")
//   let chaiTea = TreeNode("chai")
//   let soda = TreeNode("soda")
//   let milk = TreeNode("milk")
//   let gingerAle = TreeNode("ginger ale")
//   let bitterLemon = TreeNode("bitter lemon")
//
//   tree.add(hot)
//   tree.add(cold)
//
//   hot.add(tea)
//   hot.add(coffee)
//   hot.add(chocolate)
//
//   cold.add(soda)
//   cold.add(milk)
//
//   tea.add(blackTea)
//   tea.add(greenTea)
//   tea.add(chaiTea)
//
//   soda.add(gingerAle)
//   soda.add(bitterLemon)
//
//   return tree
//}

//
//example(of: "depth-first traversal") {
//   let tree = makeBeverageTree()
//
//   tree.forEachDepthFirst { (aNode) in
//      print(aNode.value)
//   }
//}
//
//
//example(of: "level-order traversal") {
//   let tree = makeBeverageTree()
//   tree.forEachLevelOrder { print($0.value) }
//}

//example(of: "searching for a node") {
//   let tree = makeBeverageTree()
//
//   if let searchResult1 = tree.search("ginger ale") {
//      print("Found node: \(searchResult1.value)")
//   }
//   if let searchResult2 = tree.search("WKD Blue") { print(searchResult2.value)
//   } else {
//      print("Couldn't find WKD Blue")
//   }
//}


//MARK: - BinaryNode

//var tree: BinaryNode<Int> {
//   let zero = BinaryNode(value: 0)
//   let one = BinaryNode(value: 1)
//   let five = BinaryNode(value: 5)
//   let seven = BinaryNode(value: 7)
//   let eight = BinaryNode(value: 8)
//   let nine = BinaryNode(value: 9)
//   seven.leftChild = one
//   seven.rightChild = nine
//   one.leftChild = zero
//   one.rightChild = five
//   nine.leftChild = eight
//
//   return seven
//}
//
//
//print(tree.description)

//example(of: "in-order traversal") {
//   tree.traverseInOrder { print($0) }
//}
//
//example(of: "pre-order traversal") {
//   tree.traversePreOrder { print($0) }
//}
//
//example(of: "post-order traversal") {
//   tree.traversePostOrder { print($0) }
//}


//example(of: "building a BST") {
//   var bst = BinarySearchTree<Int>()
//   for i in 0..<5 {
//      bst.insert(i)
//   }
//   print(bst)
//}

var exampleTree: BinarySearchTree<Int> {
   var bst = BinarySearchTree<Int>()
   bst.insert(3)
   bst.insert(1)
   bst.insert(4)
   bst.insert(0)
   bst.insert(2)
   bst.insert(5)
   return bst
}

//print(exampleTree)


//example(of: "finding a node") { if exampleTree.contains(5) {
//    print("Found 5!")
//  } else {
//    print("Couldn't find 5")
//  }
//}


example(of: "removing a node") {
  var tree = exampleTree
  print("Tree before removal:")
  print(tree)
   tree.remove(3)
   print("Tree after removing root:")
   print(tree)
}
