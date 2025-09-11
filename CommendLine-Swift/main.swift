//
//  main.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/6/10.
//

/*
 笔记地址：https://juejin.cn/user/852876756006792/posts
  B站上有视频
  恋上数据结构与算法： https://blog.csdn.net/weixin_43734095/article/details/104847976
 
 课件和代码和测试小工具,需要的自取：
 链接：https://pan.baidu.com/s/1w8-6AVQf4i_pLd9S35nlGQ
 提取码：bnw6
 
 递归  转换为 迭代的时候 我们就需要 转换为栈
 
 数据结构 - https://www.cs.usfca.edu/~galles/visualization/Algorithms.html
 */
/*
 核心诉求    优先选择的数据结构    典型场景举例
 随机查询频繁    数组、哈希表    数据库表的行查询、缓存查询
 插入 / 删除频繁    链表、哈希表    消息队列、LRU 缓存
 有序存储 + 范围查询    B + 树、红黑树、跳表    数据库索引、有序集合（如 Redis 的 ZSet）
 字符串前缀匹配    Trie 树    自动补全、拼写检查
 复杂关联关系（多对多）    图    社交网络、路径规划
 快速获取最大 / 最小值    堆（大顶堆 / 小顶堆）    Top K 问题、优先队列
 */
import Foundation


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
let arr:[Int] = [7,4,11]
let node = BinarySearchTree<Int>.initBinarySearchTree(arr)
node.printTree()
node.remove(7)
node.remove(4)
node.remove(11)
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
*/




// MARK: - 栈
/*
 debugPrint("有效括号： \(Stack.isValid(s: "{{{}}}"))")
 debugPrint("逆波兰表达式求值： \(Stack.evalRPN(["4","13","5","/","+"]))")
 debugPrint("后缀表达式： \(Stack.change("1-(     -2)"))")
 debugPrint("后缀表达式： \(Stack.calculate("1-(     -2)"))")
*/

// MARK: - 排序
/*
 var numbers: Array = [8,7,6,5,4,3,2,1]
 for i in numbers {
     if i == 1 {
         numbers.remove(at: 0)
     }
 }
 quickSort(&numbers, left: 0, right: numbers.count - 1)
 print("快排: \(numbers)")

 print("无序数组的中位数 \(getZhong(&numbers, left: 0, right: numbers.count - 1))")

 print("合并有序数组 \(mergeSortArr(a: [1,3,5,7,9,11,22,33,44], b: [2,4,6,8,66,77,88,99]))")

 print("二分查找 \(binarySearch([1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 22, 33, 44, 66, 77, 88, 99], 99))")

 let head = ListNode();
 let a1 = ListNode(); a1.val = 1
 let a2 = ListNode(); a2.val = 2
 let a3 = ListNode(); a3.val = 3
 let a4 = ListNode(); a4.val = 4
 head.next = a1;
 a1.next = a2;
 a2.next = a3;
 a3.next = a4

 reverse(head)
 printListNode(head)

 let result = reverseList(a1)
 printListNode(result)

 print(isPalindromicLink(node: a1))
 */
