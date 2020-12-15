
func example(of title: String, execute:()->()) {
   print("----Example Of '\(title)' ----")
   execute()
}

var avlTree:AVLTree<Int> = AVLTree<Int>()

example(of: "repeated insertions in sequence") {
//   valTree = AVLTree<Int>()
   for i in 0..<15 {
      avlTree.insert(i)
   }
   print(avlTree)
}


example(of: "removing a value") {
   //var tree = AVLTree<Int>()
   avlTree.insert(15)
//   tree.insert(10)
   avlTree.insert(16)
   avlTree.insert(18)
   print(avlTree)
   avlTree.remove(10)
   print(avlTree)
}
