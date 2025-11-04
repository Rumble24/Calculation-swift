//
//  InsertSort.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/29.
//

import Cocoa

/*
 插入排序 和 打扑克牌一样 好的情况下 可以达到On级别
  0 1 2 3 4 5 6 7
 */
class InsertSort<E: Comparable>: Sort<E> {
    override func sortFunc() {
        for i in 1..<self.dataSource.count {
            var end = i
            while end > 0, compareIndex(end, end - 1) < 0 {
                swapAt(end - 1, end)
                end = end - 1
            }
        }
    }
}

/*
 使用二分法进行优化
 对于接近于排好序的数组 更快
 普通的更慢
 */
class BinaryInsertSort<E: Comparable>: Sort<E> {
    override func sortFunc() {
        for i in 1..<self.dataSource.count {
            let insertIndex = getIndex(i)
            let value = self.dataSource[i]
            var current = i
            while current > insertIndex {
                self.dataSource[current] = self.dataSource[current - 1]
                current = current - 1
                swapCount += 1  // 记录交换次数
            }
            self.dataSource[insertIndex] = value
        }
    }

    private func getIndex(_ e: Int) -> Int {
        var beign = 0
        var end = e
        while beign < end {
            let mid = (beign + end) >> 1
            if compare(self.dataSource[e], self.dataSource[mid]) < 0 {
                end = mid
            } else {
                beign = mid + 1
            }
        }
        return beign
    }
}
