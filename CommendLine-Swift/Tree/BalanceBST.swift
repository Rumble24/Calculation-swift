//
//  BalanceBST.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/9/11.
//  平衡的二叉搜索树

import Foundation

class BalanceBST<T>: BinarySearchTree<T> {

    /*
     对某个节点进行左旋
     g.right = p.left
     p.left = g
     */
    func leftSpin(_ grand: BinaryTreeNode<T>?) {
        guard let grand = grand else { return }
        let parent = grand.right
        let child = parent?.left
        grand.right = child
        parent?.left = grand
        afterRotate(of: grand, parent: parent, with: child)
        debugPrint("leftSpin: \(grand.value)")
    }

    
    /*
     对某个节点进行右旋
     grand.left = child
     parent.right = grand
     */
    func rightSpin(_ grand: BinaryTreeNode<T>?) {
        guard let grand = grand else { return }
        let parent = grand.left
        let child = parent?.right
        grand.left = child
        parent?.right = grand
        afterRotate(of: grand, parent: parent, with: child)
        debugPrint("rightSpin: \(grand.value)")
    }

    func afterRotate(of grand: BinaryTreeNode<T>, parent: BinaryTreeNode<T>?, with child: BinaryTreeNode<T>?) {
        
        // parent 成为新的父节点
        parent?.parent = grand.parent
        
        // 修复 之前 grand 父节点的做节点/右节点
        if grand.isLeftChild() {
            grand.parent?.left = parent
        } else if grand.isRightChild() {
            grand.parent?.right = parent
        } else {
            root = parent
        }
        
        child?.parent = grand
        
        // 修复 grand 的 parent
        grand.parent = parent
    }
}
