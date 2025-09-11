//
//  AVLTree.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/9/9.
//

import Foundation

/*
 平衡二叉搜索树
 最完美的方案是 - 完全二叉树 但是要是使用完全二叉树的话 计算量比较大
 一般有两种方案
 */

/*
 1.AVL树 - 左右子树的高度 > 1 就需要 开始平衡了
    当我们进行删除 添加操作之后需要进行 平衡检测
    失衡的这个点在祖父节点的
    LL - 祖父节点右旋转
    RR - 祖父节点坐旋转
    LR - 父节点左旋 祖父节点右旋
    RL - 父节点右旋 祖父节点左旋
 */

class AVLTree<T>: BalanceBST<T> {

    static func initAVLTree<E:Comparable>(_ arr: [E]) -> AVLTree<E> {
        let tree = AVLTree<E>()
        for item in arr {
            tree.add(item)
        }
        return tree
    }
    
    override func createNode(value: T, parent: BinaryTreeNode<T>? = nil) -> BinaryTreeNode<T> {
        AVLNode(value: value, parent: parent)
    }
    
    /*
                曾祖父R(1)
              /          \
            G(0)         R1(0)
           /   \        /    \
         P(0) G2(1)  R2(0) R3(0)
         / \   /
        C  P2 G3
     
     C左面添加一个数据 那么失衡的第一个是 曾祖父节点 而不是 祖父节点
     
     插入操作：最多 2 次旋转
     */
    @discardableResult
    override func add(_ element: T) -> BinaryTreeNode<T> {
        let node = super.add(element)
        var currentNode = node.parent
        while currentNode != nil {
            if (currentNode as! AVLNode).isBalance()  {
                (currentNode as! AVLNode).updateHeight()
            } else {
                reBalance(currentNode as? AVLNode<T>)
                break
            }
            currentNode = currentNode?.parent
        }
        return node
    }

    // MARK: - 删除
    @discardableResult
    override func remove(_ element: T) -> BinaryTreeNode<T>? {
        let node = super.remove(element)
        var currentNode = node?.parent
        while currentNode != nil {
            if (currentNode as! AVLNode).isBalance()  {
                (currentNode as! AVLNode).updateHeight()
            } else {
                reBalance(currentNode as? AVLNode<T>)
            }
            currentNode = currentNode?.parent
        }
        return node
    }
    
    /*
     现在必须知道 失衡的节点 不一定是 祖父节点 也有可能是曾祖父节点/更高的节点
     所以我们现在拿到失衡的节点之后[grand]，需要拿到parent和node节点
     
     那么怎么拿到 parent和node节点 呢
     parent 是 grand 高的那个节点
     node 是 parent 高的那个节点
     */
    func reBalance(_ g: AVLNode<T>?) {
        guard let g = g else { return }
        guard let p = g.tallerChild() else { return }
        guard let node = p.tallerChild() else { return }

        if node === g.left?.left { // 右旋转
            rightSpin(g)
            print("LL 右旋转")
        }
        else if node === g.right?.right {
            leftSpin(g)
            print("RR 左旋转")
        }
        else if node === g.left?.right {
            leftSpin(p)
            rightSpin(g)
            print("LR 左旋转 右旋转")
        }
        else if node === g.right?.left {
            rightSpin(p)
            leftSpin(g)
            print("RL 右旋转 左旋转")
        }

    }
    
    override func afterRotate(of grand: BinaryTreeNode<T>, parent: BinaryTreeNode<T>?, with child: BinaryTreeNode<T>?) {
        super.afterRotate(of: grand, parent: parent, with: child)
        // 更新高度：先 g 再 p
        updateHeight(grand)
        updateHeight(parent)
    }

    func updateHeight(_ node: BinaryTreeNode<T>?) {
        guard let node = node as? AVLNode else { return }
        node.updateHeight()
    }
}





























