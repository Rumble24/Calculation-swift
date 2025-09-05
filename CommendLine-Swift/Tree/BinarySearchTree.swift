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
    func add(_ element:T) {
        guard let root = root else {
            root = Node(value: element)
            self.count += 1
            return
        }
        var node: Node<T>?
        var parent: Node<T>?
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
                return
            }
        }

        let newNode = Node(value: element, parent: parent)
        self.count += 1
        if result == -1 {
            parent?.left = newNode
        } else {
            parent?.right = newNode
        }
    }
    
    func contains(_ element:T) -> Node<T>? {
        var node: Node<T>?
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
    
    func remove(_ element:T) {
        guard let node = contains(element) else { return }
        self.count -= 1
        // 分情况 1.根结点 2.分支节点 3.叶子结点
        if node.left == nil && node.right == nil {
            if let value = node.parent?.left?.value, compare(value, element) == 0 {
                node.parent?.left = nil
            } else {
                node.parent?.right = nil
            }
        }
        else if node.left == nil {
            if let value = node.parent?.left?.value, compare(value, element) == 0 {
                node.parent?.left = node.right
            } else {
                node.parent?.right = node.right
            }
        } else if node.right == nil {
            if let value = node.parent?.left?.value, compare(value, element) == 0 {
                node.parent?.left = node.left
            } else {
                node.parent?.right = node.left
            }
        } else {
            /// 删除的这个节点有两个子节点
            if let value = node.parent?.left?.value, compare(value, element) == 0 {
            } else {
            }
        }
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
