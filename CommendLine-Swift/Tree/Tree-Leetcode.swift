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
    
    /*

     */

}

























//◼ 删除二叉搜索树中的节点：https://leetcode-cn.com/problems/delete-node-in-a-bst/
//◼ 二叉搜索树中第K小的元素：https://leetcode-cn.com/problems/kth-smallest-element-in-a-bst/
//◼ 二叉搜索树迭代器：https://leetcode-cn.com/problems/binary-search-tree-iterator/
//◼ 恢复二叉搜索树：https://leetcode-cn.com/problems/recover-binary-search-tree/

