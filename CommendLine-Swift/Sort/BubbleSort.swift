//
//  BubbleSort.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/29.
//

import Cocoa

class BubbleSort<E: Comparable>: Sort<E> {
    override func sortFunc() {
        for end in stride(from: self.dataSource.count, to: 1, by: -1) {
            for index in 1..<end {
                if self.compare(self.dataSource[index - 1], self.dataSource[index]) > 0 {
                    self.swapAt(index, index - 1)
                }
            }
        }
    }
}

/*
 优化版本 防止 排好序的数据 再次排序
 */
class BubbleSort1<E: Comparable>: Sort<E> {
    override func sortFunc() {
        for end in stride(from: self.dataSource.count, to: 1, by: -1) {
            var sorted = true
            for index in 1..<end {
                if self.compare(self.dataSource[index - 1], self.dataSource[index]) > 0 {
                    self.swapAt(index, index - 1)
                    sorted = false
                }
            }
            if sorted { break }
        }
    }
}

/*
 优化版本 防止 排好序的数据 再次排序  一半排好序
 4 3 2 1
 */
class BubbleSort2<E: Comparable>: Sort<E> {
    override func sortFunc() {
        var currentEnd = self.dataSource.count
        let targetEnd = 1

        while currentEnd > targetEnd {
            
            var swapIndex = 0
            for index in 1..<currentEnd {
                if self.compare(self.dataSource[index - 1], self.dataSource[index]) > 0 {
                    self.swapAt(index, index - 1)
                    swapIndex = index
                }
            }
            if swapIndex != currentEnd - 1 {
                currentEnd = swapIndex
            } else {
                currentEnd -= 1
            }
        }
    }
}
