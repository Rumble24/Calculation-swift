//
//  LeetCode.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/11.
//

import Cocoa

protocol HomeworkProtocal {

    // ◼ 移除链表元素  https://leetcode-cn.com/problems/remove-linked-list-elements/
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode?
    
    // ◼ 删除排序链表中的重复元素 https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list/
    
    // ◼ 链表的中间结点 https://leetcode-cn.com/problems/middle-of-the-linked-list/solution/
    
    // ◼ 括号的分数 https://leetcode-cn.com/problems/score-of-parentheses
    
    // ◼ 逆波兰表达式求值  https://leetcode-cn.com/problems/evaluate-reverse-polish-notation/
    
    // ◼ 基本计算器 https://leetcode.cn/problems/basic-calculator/description/


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
    
    
    /*
     ◼ 删除二叉搜索树中的节点：https://leetcode-cn.com/problems/delete-node-in-a-bst/
     ◼ 二叉搜索树中的搜索：https://leetcode-cn.com/problems/search-in-a-binary-search-tree/
     ◼ 二叉搜索树中的插入操作：https://leetcode-cn.com/problems/insert-into-a-binary-search-tree/
     ◼ 验证二叉搜索树：https://leetcode-cn.com/problems/validate-binary-search-tree/comments/
     ◼ 二叉搜索树的最小绝对差：https://leetcode-cn.com/problems/minimum-absolute-difference-in-
     ◼ 二叉搜索树结点最小距离：https://leetcode-cn.com/problems/minimum-distance-between-bst-

     ◼ 将有序数组转换为二叉搜索树：https://leetcode-cn.com/problems/convert-sorted-array-to-binary-search-

     ◼ 二叉搜索树的范围和：https://leetcode-cn.com/problems/range-sum-of-bst/
     ◼ 二叉搜索树的最近公共祖先：https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-
     ◼ 二叉搜索树中第K小的元素：https://leetcode-cn.com/problems/kth-smallest-element-in-a-bst/
     ◼ 二叉搜索树迭代器：https://leetcode-cn.com/problems/binary-search-tree-iterator/
     ◼ 恢复二叉搜索树：https://leetcode-cn.com/problems/recover-binary-search-tree/
     */
    
    /*
     ◼ 平衡二叉树：https://leetcode-cn.com/problems/balanced-binary-tree/
     ◼ 两个数组的交集：https://leetcode-cn.com/problems/intersection-of-two-arrays/
     */
    
    /*
     ◼ 数组中的第K个最大元素：https://leetcode-cn.com/problems/kth-largest-element-in-an-array/
     ◼ 根据字符出现频率排序：https://leetcode-cn.com/problems/sort-characters-by-frequency/
     ◼ 数据流中的第K大元素：https://leetcode-cn.com/problems/kth-largest-element-in-a-stream/
     ◼ 有序矩阵中第K小的元素：https://leetcode-cn.com/problems/kth-smallest-element-in-a-sorted-matrix/
     ◼ 前K个高频元素：https://leetcode-cn.com/problems/top-k-frequent-elements/
     ◼ 前K个高频单词：https://leetcode-cn.com/problems/top-k-frequent-words/
     ◼ 查找和最小的K对数字：https://leetcode-cn.com/problems/find-k-pairs-with-smallest-sums/
     ◼ 23. 合并 K 个升序链表 https://leetcode.cn/problems/merge-k-sorted-lists/description/
     */
}
