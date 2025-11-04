//
//  SelectionSort.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/29.
//

import Cocoa

/*
 选出 最大的一个进行交换到最后面
 */
class SelectionSort<E: Comparable>: Sort<E> {
    override func sortFunc() {
        for end in stride(from: self.dataSource.count, to: 1, by: -1) {
            var maxIndex = end - 1
            for index in 0..<end {
                if self.compare(self.dataSource[index], self.dataSource[maxIndex]) > 0 {
                    maxIndex = index
                }
            }
            self.swapAt(maxIndex, end - 1)
        }
    }
}
