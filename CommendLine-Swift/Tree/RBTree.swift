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
        // uncle 是 RED - 4种上溢出的情况需要
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
        
        // uncle 不是 RED 4种需要旋转的颜色
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
    
    // MARK: - 4阶当前节点内容 - 够 ------ 直接染色
    // MARK: - 4阶当前节点内容 - 不够 - 必然导致 下溢 【需要借节点】
    // MARK: - 1.借兄弟 - 需要旋转来借
    // MARK: - 2.借父节点
    // MARK: - 2.1 借父节点 够 那么 染色即可 【4阶的话 需要合并 我们这里需要额外处理】
    // MARK: - 2.2 借父节点 - 不够 - 必然导致 下溢 【需要借节点】需要再次调用 afterRemove 来调整
    // 只会删除最后的节点
    override func afterRemove(_ node: BinaryTreeNode<T>, _ replacement: BinaryTreeNode<T>?) {
        // 1.删除的是红色 不会破坏 返回
        if isRed(node) {
            return
        }
        
        // MARK: - 删除黑色节点的情况 最难的情况
        
        /*
         // 4阶当前节点内容 - 够
         1.当前节点里面内容足够 删除当前节点里面内容
         // 4阶当前节点内容 - 不够
         1.如果兄弟节点数量足够多 可以借一下节点。旋转
         2.如果兄弟节点数量 不够 那么就需要 父节点下移 【父节点和父节点和孩子合并】 【导致 父节点和两个孩子合并】
         */
        
        
        // 当前节点内容 - 够 拥有子节点 ------ 直接染色
        if isRed(replacement) {
            setBlack(replacement)
            return
        }
        
        // 不够 需要借节点的情况
        let parent = node.parent
        let isDeleteLeft = parent?.left == nil
        var sibling = isDeleteLeft ? parent?.right : parent?.left
        
        if isDeleteLeft == false {
            
            // 2.1 - sibling为BLACK
            
            // 2.2 如果 sibling 是 RED - 【父节点够 - 但是需要合并子节点】 - 旋转操作 然后回到 - sibling为BLACK 情况
            //  sibling 染成 BLACK，parent 染成 RED，parent - 进行右旋转 - 更改 sibling
            //  于是又回到 sibling 是 BLACK 的情况
            if isRed(sibling) {
                setBlack(sibling)
                setRed(parent)
                rightSpin(parent)
                sibling = parent?.left
            }
            
            // ◼ 如果 sibling 至少有 1 个 RED 子节点 - 进行旋转操作 - 【借兄弟】 [看最近一个RED节点在父节点哪个位置]
            
            // 旋转之后的中心节点继承 parent 的颜色
            // 旋转之后的左右节点染为 BLACK
            if isRed(sibling?.left) || isRed(sibling?.right) {
                let parentColor = getColor(node.parent)
                if isBlack(sibling?.left) {
                    leftSpin(sibling)
                    sibling = parent?.left
                }
                
                setColor(sibling, color: getColor(sibling?.parent))
                setBlack(sibling?.left)
                setBlack(parent)
                rightSpin(parent)
                
            }
            // ◼ 如果 sibling 没有 1 个 RED 子节点 - 染色 - 必然下溢 - 【借父节点】
            //      如果 parent 是 RED - 【父节点够】 将 sibling 染成 RED parent 染成 BLACK 即可修复红黑树性质
            //      如果 parent 是 BLACK -【父节点不够】 会导致 parent 也下溢 - 这时只需要把 parent 当做被删除的节点处理即可
            else {
                let parentIsBlack = isBlack(node.parent)
                setRed(sibling)
                setBlack(node.parent)
                if parentIsBlack,let parent = node.parent {
                    afterRemove(parent, nil)
                }
            }
        }
        else {
            
        }
        
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
    
    @discardableResult
    func setRed(_ node: BinaryTreeNode<T>?) -> RBNode<T>? {
        return setColor(node, color: .red)
    }
    
    @discardableResult
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
