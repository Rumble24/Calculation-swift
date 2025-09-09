//
//  BinaryTree.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/9/5.
//  二叉树

import Foundation

class BinaryTree<T> {
    
    var root:Node<T>?
    var count: Int = 0

    func size() -> Int {
        self.count
    }
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    func clear() {
        
    }
    
    func createNode(value: T, parent: Node<T>? = nil) -> Node<T> {
        Node(value: value, parent: parent)
    }
}


// MARK: - 遍历
/*
              7
          /        \
         4         11
        / \       /  \
        2   6    9    13
       / \  /   / \   / \
      1   3 5  8  10 12 14
                          \
                           15
 */

extension BinaryTree {
    
    // 前 [7, 4, 2, 1, 3, 6, 5, 11, 9, 8, 10, 13, 12, 14, 15]
    func preorder(_ node: Node<T>?) {
        guard let node = node else { return }
        print(node.value)
        preorder(node.left)
        preorder(node.right)
    }
    func inorder(_ node: Node<T>?) {
        guard let node = node else { return }
        inorder(node.left)
        print(node.value)
        inorder(node.right)
    }
    // 后序 [1, 3, 2, 5, 6, 4, 8, 10, 9, 12, 15, 14, 13, 11, 7]
    func postorder(_ node: Node<T>?) {
        guard let node = node else { return }
        postorder(node.left)
        postorder(node.right)
        print(node.value)
    }
    
    
    func preorderTraversal(_ node: Node<T>?) -> [T] {
        var result: [T] = []
        guard let root = root else { return result }
        
        var stack: [(node: Node<T>, visited: Bool)] = []
        stack.append((root, false))
        
        while !stack.isEmpty {
            let (node, visited) = stack.removeLast()
            
            if !visited {
                // 未访问过：先访问，再按右→左顺序入栈（标记未访问）
                if let right = node.right {
                    stack.append((right, false))
                }
                if let left = node.left {
                    stack.append((left, false))
                }
                stack.append((node, true))
            } else {
                result.append(node.value)
            }
        }
        return result
    }
    func inorderTraversal(_ node: Node<T>?) -> [T] {
        var result: [T] = []
        guard let root = root else { return result }
        
        var stack: [(node: Node<T>, visited: Bool)] = []
        stack.append((root, false))
        
        while !stack.isEmpty {
            let (node, visited) = stack.removeLast()
            
            if !visited {
                // 未访问过：先入栈右子树，再入栈当前节点（标记已访问），最后入栈左子树
                if let right = node.right {
                    stack.append((right, false))
                }
                stack.append((node, true))  // 标记为已访问，等待左子树处理完
                if let left = node.left {
                    stack.append((left, false))
                }
            } else {
                // 已访问过：左子树已处理完，访问当前节点
                result.append(node.value)  // 中序：左子树处理后访问
            }
        }
        return result
    }
    func postorderTraversal(_ node: Node<T>?) -> [T] {
        var result: [T] = []
        guard let root = root else { return result }
        
        var stack: [(node: Node<T>, visited: Bool)] = []
        stack.append((root, false))
        
        while !stack.isEmpty {
            let (node, visited) = stack.removeLast()
            
            if !visited {
                // 未访问过：先入栈当前节点（标记已访问），再入栈右子树，最后入栈左子树
                stack.append((node, true))  // 标记为已访问，等待右子树处理完
                if let right = node.right {
                    stack.append((right, false))
                }
                if let left = node.left {
                    stack.append((left, false))
                }
            } else {
                // 已访问过：右子树已处理完，访问当前节点
                result.append(node.value)  // 后序：右子树处理后访问
            }
        }
        return result
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
    
    // MARK: - 前驱节点 中序遍历的前一个节点
    /*
     1.node.left != null 在 node.left.right.right....
     2.node.left == nil && node.parent != nil 在node.parent.parent.....
       一直到node.parent 在 右子树中
     */
    func predecessor(_ n: Node<T>?) -> Node<T>? {
        var node: Node<T>? = n
        
        if node == nil {
            return nil
        }
        
        if let left = node?.left {
            var r:Node<T>? = left
            while r?.right != nil {
                r = r?.right
            }
            return r
        }
        
        while node?.parent != nil && node === node?.parent?.left {
            node = node?.parent
        }
        return node?.parent
    }
    
    // MARK: - 后继节点 中序遍历时的后一个节点
    func successor(_ n: Node<T>?) -> Node<T>? {
        var node: Node<T>? = n
        
        if node == nil {
            return nil
        }
        
        if let left = node?.right {
            var r:Node<T>? = left
            while r?.left != nil {
                r = r?.left
            }
            return r
        }
        
        while node?.parent != nil && node === node?.parent?.right {
            node = node?.parent
        }
        return node?.parent
    }
}


// MARK: - 翻转/判断是否是完全二叉树
extension BinaryTree {
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
