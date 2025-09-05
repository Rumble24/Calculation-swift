//
//  BinaryTree.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/9/5.
//  二叉树

import Foundation

class BinaryTree<T> {
    
    var root:Node<T>?
    internal var count: Int = 0

    func size() -> Int {
        return self.count
    }
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    func clear() {
        
    }
    
    func preorder() {
        preorder(root)
    }
    func inorder() {
        inorder(root)
    }
    func postorder() {
        postorder(root)
    }
    func levelorder() {
        levelorder(root)
    }
    
    /*
            7
          /   \
         4     9
        / \   /  \
       2   5  8  11
      / \   \      \
     1   3  6      12
     */
    
    // 前序便利 7 → 4 → 2 → 3 → 5 → 9 → 8 → 11 → 12
    func preorder(_ node: Node<T>?) {
        guard let node = node else { return }
        print(node.value)
        preorder(node.left)
        preorder(node.right)
    }
    
    // 中序便利 2 3 4 5 7 8 9 11 12
    // 2 3 5
    /*
     inorder(7)
     inorder(7.left) = inorder(4)
     inorder(4.left) = inorder(2)
     print(2)
     inorder(2.right)
     print(3)
     print(4)
     print(5)
     print(7)
     print(8)
     print(9)
     print(11)
     print(12)
     */
    func inorder(_ node: Node<T>?) {
        guard let node = node else { return }
        inorder(node.left)
        print(node.value)
        inorder(node.right)
    }
    
    // 后序遍历
    func postorder(_ node: Node<T>?) {
        guard let node = node else { return }
        postorder(node.left)
        postorder(node.right)
        print(node.value)
    }
    
    // 层序遍历
    func levelorder(_ node: Node<T>?) {
        guard let root = root else { return }
        var queue:[Node<T>] = [root]
        while queue.count != 0 {
            let node = queue.removeFirst()
            debugPrint(node.value)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
    }
    
    // 高度
    func height(_ node: Node<T>?) -> Int {
        guard let node = node else { return 0 }
        return max(height(node.left), height(node.right)) + 1
    }
 
    // 层序遍历 获取高度
    func levelHeight(_ node: Node<T>?) -> Int {
        guard let node = node else { return 0 }
        var queue:[Node<T>] = [node]
        var height = 0
        var tier = 0
        var delete = 0
        while queue.count != 0 {
            if delete == 0 {
                tier = queue.count
            }
            let node = queue.removeFirst()
            delete = delete + 1
            if delete == tier {
                height = height + 1
                delete = 0
            }
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        return height
    }
    
    // 翻转二叉树
    func flipTree(_ node: Node<T>?) {
        guard let node = node else { return }
        
        let temp = node.left
        node.left = node.right
        node.right = temp
        
        flipTree(node.left)
        flipTree(node.right)
    }
    
    // 是否是完全二叉树
    // 从上倒下 从左到右
    // 相差最多是两层 最后一层 必须都在左面 - 如果一个节点是叶子结点那么 后面所有的节点都是叶子结点
    // left == nil right != nil  return false
    // 层序遍历
    func isComplete(_ node: Node<T>?) -> Bool {
        guard let node = node else { return true }
        var queue = [node]
        var leaf = false
        while queue.count != 0 {
            let first = queue.removeFirst()
            
            if leaf && (first.left != nil || first.right != nil) {
                return false
            }
            
            if let left = first.left {
                queue.append(left)
            } else if first.right != nil {
                return false
            }
            if let right = first.right {
                queue.append(right)
            } else {
                leaf = true
            }
        }
        return true
    }
}

