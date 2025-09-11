//
//  Node.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/9/4.
//

import Foundation

class BinaryTreeNode<T> {
    var left: BinaryTreeNode<T>?
    var right: BinaryTreeNode<T>?
    var parent: BinaryTreeNode<T>?
    var value: T
    init(value: T, parent: BinaryTreeNode<T>? = nil) {
        self.parent = parent
        self.value = value
    }
    
    func isLeaf() -> Bool {
        return self.left == nil && self.right == nil;
    }
    
    func hasTwoChildren() -> Bool {
        return self.left != nil && self.right != nil;
    }
    
    func isLeftChild() -> Bool {
        return self.parent != nil && self === self.parent!.left;
    }
    
    func isRightChild() -> Bool {
        return self.parent != nil && self === self.parent!.right;
    }
    
    // 自己的兄弟节点
    func sibling() -> BinaryTreeNode<T>? {
        if self.isLeftChild() {
            return self.parent?.right;
        } else {
            return self.isRightChild() ? self.parent?.left : nil;
        }
    }
    
    var description: String {
        return "\(value)"
    }
}



class AVLNode<T>: BinaryTreeNode<T> {
    var height: Int = 1
    
    func isBalance() -> Bool {
        let left = (self.left as? AVLNode)?.height ?? 0
        let right = (self.right as? AVLNode)?.height ?? 0
        return abs(left - right) <= 1
    }
    
    func updateHeight() {
        let left = (self.left as? AVLNode)?.height ?? 0
        let right = (self.right as? AVLNode)?.height ?? 0
        height = max(left, right) + 1
        //debugPrint("updateHeight: \(height)  value: \(value)")
    }
    
    func tallerChild() -> AVLNode<T>? {
        let left = (self.left as? AVLNode)
        let right = (self.right as? AVLNode)
        let leftHeight = left?.height ?? 0
        let rightHeight = right?.height ?? 0
        if leftHeight > rightHeight { return left }
        if leftHeight < rightHeight { return right }
        if let p = self.parent {
            return (self === p.left) ? left : right
        }
        return left
    }
}



enum RBColor {
    case red
    case black
}

class RBNode<T>: BinaryTreeNode<T> {
    var color: RBColor = .red
    
    override var description: String {
        switch color {
        case .red:
            return "\(value)-r"
        case .black:
            return "\(value)"
        }
    }
}
