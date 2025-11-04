//
//  MergeSort.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/30.
//

import Cocoa

/*
 归并排序
 合并有序数组
 */
class MergeSort<E: Comparable>: Sort<E> {
    override func sortFunc() {
        mergeSort(start: 0, end: self.dataSource.count)
    }
    
    private func mergeSort(start: Int, end: Int) {
        if end - start < 2 { return }
        let mid = (start + end) / 2
        mergeSort(start: start, end: mid)
        mergeSort(start: mid, end: end)
        merge(start: start, mid: mid, end: end)
    }

    // 合并有序数组 mid 在右面的数组里面
    private func merge(start: Int, mid: Int, end: Int) {
        let a = self.dataSource[start..<mid]
        
        var leftIndex:Int = start
        var rightIndex:Int = mid
        var index:Int = start
        
        while leftIndex < mid, rightIndex < end {
            if a[leftIndex] <= self.dataSource[rightIndex] {
                self.dataSource[index] = a[leftIndex]
                leftIndex = leftIndex + 1
                index = index + 1
            }
            
            if leftIndex < mid, a[leftIndex] > self.dataSource[rightIndex] {
                self.dataSource[index] = self.dataSource[rightIndex]
                index = index + 1
                rightIndex = rightIndex + 1
            }
        }

        for i in leftIndex..<mid {
            self.dataSource[index] = a[i]
            index = index + 1
        }
    }
}


class MergeSortMJ<E: Comparable>: Sort<E> {
    private var leftArray: [E] = []
    
    override func sortFunc() {
        leftArray = Array(repeating: self.dataSource[0], count: self.dataSource.count >> 1)
        sort(0, self.dataSource.count)
    }
    
    /**
     * 对 [begin, end) 范围的数据进行归并排序
     */
    private func sort(_ begin: Int, _ end: Int) {
        if end - begin < 2 { return } // 至少要2个元素
        
        let mid = (begin + end) >> 1
        sort(begin, mid) // 归并排序左半子序列
        sort(mid, end)   // 归并排序右半子序列
        merge(begin, mid, end) // 合并整个序列
    }
    
    /**
     * 将 [begin, mid) 和 [mid, end) 范围的序列合并成一个有序序列
     */
    private func merge(_ begin: Int, _ mid: Int, _ end: Int) {
        var li = 0, le = mid - begin // 左边数组(基于leftArray)
        var ri = mid, re = end       // 右边数组(dataSource)
        var ai = begin               // dataSource的索引
        
        // 备份左边数组到leftArray
        for i in li..<le {
            leftArray[i] = self.dataSource[begin + i]
        }
        
        // 如果左边还没有结束
        while li < le { // li == le 左边结束, 则直接结束归并
            if ri < re && self.dataSource[ri] < leftArray[li] {
                // 右边 < 左边, 拷贝右边数组到dataSource
                self.dataSource[ai] = self.dataSource[ri]
                ai += 1
                ri += 1
            } else {
                // 左边 <= 右边, 拷贝左边数组到dataSource
                self.dataSource[ai] = leftArray[li]
                ai += 1
                li += 1
            }
            swapCount += 1 // 记录交换次数
        }
    }
}
