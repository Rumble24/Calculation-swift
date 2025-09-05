//
//  Tree.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/9/4.
//

import Foundation

class Node<T> {
    var left: Node<T>?
    var right: Node<T>?
    var parent: Node<T>?
    var value: T
    init(value: T, parent: Node<T>? = nil) {
        self.parent = parent
        self.value = value
    }
}

