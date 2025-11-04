//
//  HeapSort.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/29.
//

import Cocoa

/*
 堆排序 是 对 选择排序的优化 选出最大的一个  nlogn
 不是一个稳定的排序
 */
class HeapSort<E: Comparable>: Sort<E> {
    private var heapSize: Int = 0
    override func sortFunc() {
        heapSize = self.dataSource.count
        // 1.原地建堆
        for index in stride(from: self.dataSource.count, to: 0, by: -1) {
            siftDown(index: index - 1)
        }
        
        while heapSize > 1 {
            // 选出最大的一个交换到后面
            heapSize = heapSize - 1
            self.swapAt(0, heapSize)
            // 堆进行重新排序 第一个下沉
            siftDown(index: 0)
        }
    }
    
    private func siftDown(index: Int) {
        var parentIndex = index
        
        while parentIndex < heapSize - 1 {
            // 左面的下标
            let childLeftIndex = parentIndex << 1 + 1
            let childRightIndex = childLeftIndex + 1
            if childLeftIndex > heapSize - 1 {
                break
            }
            var childIndex = childLeftIndex
            if childRightIndex < heapSize, compare(dataSource[childRightIndex], dataSource[childLeftIndex]) > 0 {
                childIndex = childRightIndex
            }
            if compare(dataSource[childIndex], dataSource[parentIndex]) <= 0 {
                break
            }
            dataSource.swapAt(childIndex, parentIndex)
            parentIndex = childIndex
        }
    }
}

