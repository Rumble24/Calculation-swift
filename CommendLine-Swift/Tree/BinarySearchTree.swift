//
//  BinarySearchTree.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/9/4.
//

import Foundation

class BinarySearchTree<T> : BinaryTree<T> {
    
    static func initBinarySearchTree<E:Comparable>(_ arr: [E]) -> BinarySearchTree<E> {
        let tree = BinarySearchTree<E>()
        for item in arr {
            tree.add(item)
        }
        return tree
    }
    
    // 存储比较闭包：(T, T) -> Int 表示 a < b 返回负数，a == b 返回0，a > b 返回正数
    private let compare: (T, T) -> Int
    
    // 1. 通过闭包初始化（适用于所有类型）
    init(compare: @escaping (T, T) -> Int) {
        self.compare = compare
    }
    
    // 2. 便捷初始化：对于遵循Comparable的类型，自动生成比较闭包
    convenience init() where T: Comparable {
        self.init(compare: {
            if $0 < $1 { return -1 }
            else if $0 > $1 { return 1 }
            else { return 0 }
        })
    }
    
    // 二叉搜索树插入操作中，新节点必然是插入到叶子结点的子节点位置，也就是最终成为叶子结点（或者说插入的位置是基于叶子结点的空分支）。
    @discardableResult
    func add(_ element:T) -> BinaryTreeNode<T> {
        guard let root = root else {
            root = createNode(value: element)
            self.count += 1
            afterAdd(root!)
            return root!
        }
        var node: BinaryTreeNode<T>?
        var parent: BinaryTreeNode<T>?
        var result: Int = 0
        
        node = root
        
        while let tmp = node {
            parent = tmp
            result = self.compare(element, tmp.value)
            if result < 0 {
                node = node?.left
            }
            else if result > 0 {
                node = node?.right
            }
            else {
                node?.value = element
                return tmp
            }
        }

        let newNode = createNode(value: element, parent: parent)
        self.count += 1
        if result == -1 {
            parent?.left = newNode
        } else {
            parent?.right = newNode
        }
        afterAdd(newNode)
        return newNode
    }
    
    func afterAdd(_ node: BinaryTreeNode<T>) {
        
    }
    
    
    // MARK: - 删除永远删除的是叶子结点
    /*
     4
      11
     */
    @discardableResult
    func remove(_ element:T) -> BinaryTreeNode<T>? {
        guard let n = contains(element) else { return nil }
        
        self.count -= 1

        var node: BinaryTreeNode<T> = n
        //： 删除的这个节点有两个子节点
        //： 1.找到前驱节点/后继节点 替换 原来节点的值
        //： 2.删除 之前的节点
        // 度为 2
        if node.left != nil && node.right != nil {
            guard let p = predecessor(node) else { return nil }
            let nodeValue = node.value
            node.value = p.value
            p.value = nodeValue
            node = p
        }
        
        // 统一处理：node 的度 ≤ 1
        let replacement = node.left ?? node.right
        if let replacement = replacement {
            // 度为 1：用子节点替换自己
            if node.isLeftChild() {
                node.parent?.left = replacement
            } else if node.isRightChild() {
                node.parent?.right = replacement
            } else {
                // node 是根结点
                root = replacement
            }
            replacement.parent = node.parent
            afterRemove(node, replacement)
        } else {
            // 度为 0：叶子结点，直接删除
            if node.isLeftChild() {
                node.parent?.left = nil
            } else if node.isRightChild() {
                node.parent?.right = nil
            } else {
                // node 是根结点
                root = nil
            }
            afterRemove(node, nil)
        }
        
        print("删除节点： \(node.value)  \(inorderTraversal(node)) size:\(size()) ")

        return node
    }
    
    func afterRemove(_ node: BinaryTreeNode<T>, _ replacement: BinaryTreeNode<T>?) {
        
    }
    
    
    func contains(_ element:T) -> BinaryTreeNode<T>? {
        var node: BinaryTreeNode<T>?
        node = root
        while let tmp = node {
            let result = self.compare(element, tmp.value)
            if result < 0 {
                node = node?.left
            }
            else if result > 0 {
                node = node?.right
            }
            else {
                return node
            }
        }
        return nil
    }
}

extension BinarySearchTree {
    // 没有优化前的代码
    func remove0(_ element:T) -> BinaryTreeNode<T>? {
        guard let n = contains(element) else { return nil }
        
        self.count -= 1

        var node: BinaryTreeNode<T> = n
        //： 删除的这个节点有两个子节点
        //： 1.找到前驱节点/后继节点 替换 原来节点的值
        //： 2.删除 之前的节点
        // 度为 2
        if node.left != nil && node.right != nil {
            guard let p = predecessor(node) else { return nil }
            let nodeValue = node.value
            node.value = p.value
            p.value = nodeValue
            node = p
        }
        
        // 分情况 1.根结点 2.分支节点 3.叶子结点
        // 度为0
        if node.left == nil && node.right == nil {
            if node.isLeftChild() {
                node.parent?.left = nil
            } else if node.isRightChild() {
                node.parent?.right = nil
            } else {
                node.parent = nil
                root = nil
            }
        }
        // 度为1
        else if node.left == nil {
            if node.isLeftChild() {
                node.parent?.left = node.right
            } else if node.isRightChild() {
                node.parent?.right = node.right
            } else {
                node.right?.parent = nil
                root = node.right
            }
        }
        // 度为1
        else if node.right == nil {
            if node.isLeftChild() {
                node.parent?.left = node.left
            } else if node.isRightChild() {
                node.parent?.right = node.left
            } else {
                node.left?.parent = nil
                root = node.left
            }
        }
        afterRemove(node)
        return node
    }
    
}

extension BinarySearchTree {
    // 二叉搜索树（BST）的最近公共祖先（LCA）求解思路与代码
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?)  -> TreeNode? {
        guard let root = root, let p = p, let q = q else {
            return nil
        }
        
        // 当前节点值大于p和q的值，递归左子树
        if root.val > p.val && root.val > q.val {
            return lowestCommonAncestor(root.left, p, q)
        }
        // 当前节点值小于p和q的值，递归右子树
        else if root.val < p.val && root.val < q.val {
            return lowestCommonAncestor(root.right, p, q)
        }
        // 否则当前节点就是最近公共祖先
        else {
            return root
        }
    }
    
    //◼ 恢复二叉搜索树 知道这个搜索二叉树的 前序遍历和 中序遍历 恢复这个二叉树
}
