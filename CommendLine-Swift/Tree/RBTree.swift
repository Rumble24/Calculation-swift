//
//  RBTree.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/9/10.
//

import Foundation

/*
 平衡的二叉树
 什么是红黑树
 定义：
 1.每个节点要么是红色，要么是黑色
 2.根结点必须是黑色
 3.所有的叶子结点必须是黑色
 4.如果一个节点是红色，那么它的两个子节点必须是黑色
   不能有连续的两个红色节点
   红色节点的parsent都是黑色
 5.从任意一个节点到其所有叶子节点的路径中，包含的黑色节点数量必须相等 - 核心平衡规则
 最后一个是保证 平衡二叉搜索树的
 */

// 红黑树颜色常量


class RBTree<T>: BalanceBST<T> {
    
    /*
     默认添加的是红色 那么 直接符合 1 2 3 5 情况 只需要注意第四种情况
     有12种情况
     4种添加在黑色的上面
     */
    override func afterAdd(_ node: BinaryTreeNode<T>) {
        // 只有一个节点
        guard let parent = node.parent else {
            setColor(node, color: .black)
            return
        }
        // 4种添加在黑色的上面 不需要处理
        if isBlack(parent) {
            return
        }
        let grand = parent.parent
        let uncle = parent.sibling()
        // 4种上溢出的情况需要 叔父节点是红色必然上溢出
        // 改变颜色 然后继续修改转换
        if isRed(uncle) {
            setColor(uncle, color: .black)
            setColor(parent, color: .black)
            setColor(grand, color: .red)
            if let grand = grand {
                afterAdd(grand)
            }
            return
        }
        
        // 4种需要旋转的颜色
        if node === grand?.left?.left {
            // LL 情况
            setColor(parent, color: .black)
            setColor(grand, color: .red)
            rightSpin(grand)
        }
        else if node === grand?.right?.right {
            // RR 情况
            setColor(parent, color: .black)
            setColor(grand, color: .red)
            leftSpin(grand)
        }
        else if node === grand?.left?.right {
            // LR 情况
            setColor(node, color: .black)
            setColor(grand, color: .red)
            leftSpin(parent)
            rightSpin(grand)
        }
        else if node === grand?.right?.left {
            // RL 情况
            setColor(node, color: .black)
            setColor(grand, color: .red)
            rightSpin(parent)
            leftSpin(grand)
        }
    }
    
    
    override func remove(_ element: T) -> BinaryTreeNode<T>? {
        let node = super.remove(element)
        
        
        return node
    }
    
    override func createNode(value: T, parent: BinaryTreeNode<T>? = nil) -> BinaryTreeNode<T> {
        RBNode(value: value, parent: parent)
    }
    
    
}


// 防止内存各种强转
extension RBTree {
    @discardableResult
    func setColor(_ node: BinaryTreeNode<T>?, color: RBColor) -> RBNode<T>? {
        guard let node = node as? RBNode<T> else { return nil }
        node.color = color
        return node
    }
    
    func getColor(_ node: BinaryTreeNode<T>?) -> RBColor {
        guard let node = node as? RBNode<T> else { return .black }
        return node.color
    }
    
    func setRed(_ node: BinaryTreeNode<T>?) -> RBNode<T>? {
        return setColor(node, color: .red)
    }
    
    func setBlack(_ node: BinaryTreeNode<T>?) -> RBNode<T>? {
        return setColor(node, color: .black)
    }
    
    func isBlack(_ node: BinaryTreeNode<T>?) -> Bool {
        return getColor(node) == .black
    }

    func isRed(_ node: BinaryTreeNode<T>?) -> Bool {
        return getColor(node) == .red
    }
}
