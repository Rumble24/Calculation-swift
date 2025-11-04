//
//  BinaryHeap.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/28.
//

import Cocoa

/*
 是完全二叉堆 一般使用数组实现
 主要解决topK的问题
 
              100
           /        \
          80         90
         / \        /
        60 70      30
 [90 80 30 60 70]

 */
class BinaryHeap<E>: AbstractHeap<E> {
    override func clear() {
        super.clear()
        elements.removeAll()
    }
    
    /*
     添加 一般是添加的数组的最后面 然后进行 上移操作
     */
    override func add(var1: E) {
        elements.append(var1)
        siftUp(index: elements.count - 1)
    }
    
    /*
     1.使用最后一个元素覆盖第一个元素
     2.删除最后一个元素
     */
    @discardableResult
    override func remove() -> E? {
        guard elements.count > 2 else {
            return elements.first
        }
        let element = elements.first
        elements.swapAt(0, elements.count - 1)
        elements.removeLast()
        siftDown(index: 0)
        return element
    }
    
    // 删除堆顶的元素 同时插入一个新的元素
    @discardableResult
    override func replace(var1: E) -> E {
        if elements.isEmpty {
            elements.append(var1)
        } else {
            elements[0] = var1
            siftDown(index: 0)
        }
        return elements[0]
    }
}


extension BinaryHeap {
    private func siftUp(index: Int) {
        var childIndex = index
        
        while childIndex > 0 {
            let parentIndex = (childIndex - 1) / 2
            if compare(elements[childIndex], elements[parentIndex]) <= 0 {
                break
            }
            elements.swapAt(childIndex, parentIndex)
            childIndex = parentIndex
        }
    }
    
    private func siftDown(index: Int) {
        var parentIndex = index
        
        while parentIndex < elements.count - 1 {
            // 左面的下标
            let childLeftIndex = parentIndex << 1 + 1
            let childRightIndex = childLeftIndex + 1
            if childLeftIndex > elements.count - 1 {
                break
            }
            var childIndex = childLeftIndex
            if childRightIndex < elements.count, compare(elements[childRightIndex], elements[childLeftIndex]) > 0 {
                childIndex = childRightIndex
            }
            if compare(elements[childIndex], elements[parentIndex]) <= 0 {
                break
            }
            elements.swapAt(childIndex, parentIndex)
            parentIndex = childIndex
        }
    }
    
    func print() {
        debugPrint(elements)
    }
}
