//
//  BinaryTreeTest.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/29.
//

import Cocoa

/*
             55
        /         \
       38         80
      /  \        /  \
     25   46     76    88
    / \    \     /
   17  33  50   72
 
 */
//
//let arr = Array(1...20)
//let rbt = RBTree<Int>()
//for item in arr {
//    rbt.add(item)
//}
//rbt.printTree()


// MARK: - avl
/*
               7
            /     \
           4       11
          / \     /  \
         2   6   9    13
        / \
       1   3




let arr:[Int] = [7,4,11,2,6,9,13,1,3]
let avl = AVLTree<Int>.initAVLTree(arr)
avl.printTree()

avl.add(0)
avl.add(-1)
avl.add(-2)

print("中序便利： \(avl.inorderTraversal(avl.root)) 跟：\(avl.root?.value) 跟的高度：\((avl.root as? AVLNode)?.height)")
avl.remove(-2)
avl.remove(-1)
avl.remove(0)
print("中序便利： \(avl.inorderTraversal(avl.root)) 跟：\(avl.root?.value) 跟的高度：\((avl.root as? AVLNode)?.height)")

avl.printTree()
 */

// MARK: - 搜索二叉树

/*
            7
         /     \
        4       11
       / \     /  \
      2   6    9    13
     / \  /   / \   / \
    1   3 5  8  10 12 14
                        \
                         15

 let arr:[Int] = [7,4,11,2,6,9,13,1,3,5,8,10,12,14,15]
 let node = BinarySearchTree<Int>.initBinarySearchTree(arr)
 
 
 let personNode = BinarySearchTree<Person>.initBinarySearchTree([Person(age: 1),Person(age: 2)])
 print(personNode)

 let carNode = BinarySearchTree<Car>(compare: { $1.price - $0.price })
 for item in arr {
     carNode.add(Car(price: item))
 }
 print(carNode)
 
 node.levelorder()
 debugPrint("height: \(node.height(node.root))")
 debugPrint("height: \(node.levelHeight(node.root))")
 // 翻转二叉树
 node.flipTree(node.root)
 debugPrint("是否是完全二叉树 \(node.isComplete(node.root))")
 
 print("前驱节点：\(node.predecessor(node.root?.right?.left)?.value)")
 
 node.remove(9)
 print("删除节点： \(node.inorder())")

 print("前序便利： \(node.preorder(node.root))")
 print("中序便利： \(node.inorder(node.root))")
 print("后序便利： \(node.postorder(node.root))")

 print("前序便利： \(node.preorderTraversal(node.root))")
 print("中序便利： \(node.inorderTraversal(node.root))")
 print("后序便利： \(node.postorderTraversal(node.root))")
 
 let arr:[Int] = [7,4,11]
 let node = BinarySearchTree<Int>.initBinarySearchTree(arr)
 node.printTree()
 node.remove(7)
 node.remove(4)
 node.remove(11)
*/
