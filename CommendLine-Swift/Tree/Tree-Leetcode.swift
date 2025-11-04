//
//  Tree-Leetcode.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/9/5.
//

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}


// MARK: - 二叉树的题
/*
 ◼ 二叉树的前序遍历： https://leetcode-cn.com/problems/binary-tree-preorder-traversal/ （递归+迭代）
 ◼ 二叉树的中序遍历： https://leetcode-cn.com/problems/binary-tree-inorder-traversal/ （递归+迭代）
 ◼ 二叉树的后序遍历： https://leetcode-cn.com/problems/binary-tree-postorder-traversal/ （递归+迭代）
 ◼ 二叉树的层次遍历： https://leetcode-cn.com/problems/binary-tree-level-order-traversal/ （迭代）
 ◼ 二叉树的最大深度： https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/ （递归+迭代）
 ◼ 二叉树的层次遍历II： https://leetcode-cn.com/problems/binary-tree-level-order-traversal-ii/
 ◼ 二叉树最大宽度：https://leetcode-cn.com/problems/maximum-width-of-binary-tree/
 ◼ N叉树的前序遍历： https://leetcode-cn.com/problems/n-ary-tree-preorder-traversal/
 ◼ N叉树的后序遍历： https://leetcode-cn.com/problems/n-ary-tree-postorder-traversal/
 ◼ N叉树的最大深度： https://leetcode-cn.com/problems/maximum-depth-of-n-ary-tree/
 
 ◼ 二叉树展开为链表：https://leetcode-cn.com/problems/flatten-binary-tree-to-linked-list/
 ◼ 从中序与后序遍历序列构造二叉树：https://leetcode-cn.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal/
 ◼ 从前序与中序遍历序列构造二叉树：https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/
 ◼ 根据前序和后序遍历构造二叉树：https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-postorder-traversal/
 ◼ 对称二叉树：https://leetcode-cn.com/problems/symmetric-tree/
 */
extension Solution {
    // 数组转完全二叉树
//    static func arrayToTree(_ array: [Int]) -> TreeNode? {
//        
//    }
}







// MARK: - 二叉搜索树的题
/*
 ◼ 删除二叉搜索树中的节点：https://leetcode-cn.com/problems/delete-node-in-a-bst/
 ◼ 二叉搜索树中第K小的元素：https://leetcode-cn.com/problems/kth-smallest-element-in-a-bst/
 ◼ 二叉搜索树迭代器：https://leetcode-cn.com/problems/binary-search-tree-iterator/
 ◼ 恢复二叉搜索树：https://leetcode-cn.com/problems/recover-binary-search-tree/
 */
extension Solution {
    /*
     ◼ 二叉搜索树中的搜索：https://leetcode-cn.com/problems/search-in-a-binary-search-tree/
     给定二叉搜索树（BST）的根节点 root 和一个整数值 val。
     你需要在 BST 中找到节点值等于 val 的节点。 返回以该节点为根的子树。 如果节点不存在，则返回 null 。
     */
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let root = root else { return root }
        if root.val == val {
            return root
        }
        var temp: TreeNode? = root
        while let t = temp {
            if val == t.val {
                return t
            }
            else if val < t.val {
                temp = t.left
            } else {
                temp = t.right
            }
        }
        return nil
    }
    
    /*
     搜索二叉树的插入操作：https://leetcode-cn.com/problems/insert-into-a-binary-search-tree/
            4
          2   20
         1 3    30
                  40
      插入操作都是在叶子结点
     */
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        let newNode = TreeNode(val)
        guard let root = root else { return newNode }
        
        var temp: TreeNode?
        var parent: TreeNode?
        temp = root
        while let n = temp {
            parent = n
            if val < n.val {
                temp = n.left
            }
            else if val > n.val {
                temp = n.right
            } else {
                return root
            }
        }
        if let parent = parent {
            if val < parent.val {
                parent.left = newNode
            } else {
                parent.right = newNode
            }
        }
        return root
    }
    
    /*
     ◼ 验证二叉搜索树：https://leetcode-cn.com/problems/validate-binary-search-tree/comments/
     给你一个二叉树的根节点 root ，判断其是否是一个有效的二叉搜索树。 左面小 右面大
     */
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        var value = true
        var temp:Int?

        func inorder(_ node: TreeNode?) {
            guard let node = node else { return }
            if value == false { return }
            inorder(node.left)
            if let temp = temp, node.val <= temp {
                value = false
                return
            }
            temp = node.val
            inorder(node.right)
            if value == false { return }
        }
        
        inorder(root)
        
        return value
    }
    
    /*
     //◼ 二叉搜索树的最小绝对差：https://leetcode.cn/problems/minimum-absolute-difference-in-bst/
     层序遍历
     */
    func getMinimumDifference(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var value: Int?
        var temp:Int?

        func inorder(_ node: TreeNode?) {
            guard let node = node else { return }
            inorder(node.left)
            if let temp = temp {
                let cha = node.val - temp
                if let va = value {
                    value = min(cha, va)
                } else {
                    value = cha
                }
            }
            temp = node.val
            inorder(node.right)
        }
        
        inorder(root)
        
        return value ?? 0
    }
    
    /*
     //◼ 二叉搜索树的范围和：https://leetcode-cn.com/problems/range-sum-of-bst/
     给定二叉搜索树的根结点 root，返回值位于范围 [low, high] 之间的所有结点的值的和。
     */
    func rangeSumBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> Int {
        guard let root = root else { return 0 }
        var result: Int = 0
        var end = false
        func inorder(_ node: TreeNode?) {
            guard let node = node else { return }
            if end { return }
            inorder(node.left)
            if node.val >= low && node.val <= high {
                result = result + node.val
            }
            if node.val > high {
                end = true
            }
            if end { return }
            inorder(node.right)
            if end { return }
        }
        
        inorder(root)
        return result
    }
}





















