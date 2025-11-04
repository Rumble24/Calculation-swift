//
//  QuickSort.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/30.
//

import Cocoa

/*
 最快的排序找出一个数 把小于的放左面 大于的放右面
 9 6 4 2
 */
class QuickSort<E: Comparable>: Sort<E> {
    override func sortFunc() {
        quickSort(begin: 0, end: self.dataSource.count)
    }
    
    // 左开右闭  [begin, end)
    private func quickSort(begin: Int, end: Int) {
        if end - begin < 2 { return }
        let pivotIndex = sort(begin: begin, end: end)
        quickSort(begin: begin, end: pivotIndex)
        quickSort(begin: pivotIndex + 1, end: end)
    }
    
    // 一般是从右面开始比较 [9,8,7,6,5,4] -  [4,8,7,6,5,4]
    // 从右往左，找到小于 pivot 的元素，然后放到左边。
    // 从左往右，找到大于 pivot 的元素，然后放到右边。
    private func sort(begin: Int, end: Int) -> Int {
        let pivot = self.dataSource[begin]
        
        var left:Int = begin
        var right:Int = end - 1

        while left < right {
            while left < right {
                if self.dataSource[right] > pivot {
                    right -= 1
                } else {
                    self.dataSource[left] = self.dataSource[right]
                    left += 1
                    break
                }
            }
            while left < right {
                if self.dataSource[left] < pivot {
                    left += 1
                } else {
                    self.dataSource[right] = self.dataSource[left]
                    right -= 1
                    break
                }
            }
        }
        
        self.dataSource[left] = pivot
        
        return left
    }
    
    //MARK: 为什么这种比上面的那种效率差呢 因为 我们等于的时候不移动 会导致左右分布不均匀
    private func sort1(begin: Int, end: Int) -> Int {
        var l = begin
        var r = end - 1
        let temp = self.dataSource[begin]
        
        while l < r {
            while self.dataSource[r] >= temp && l < r {
                r = r - 1
            }
            self.dataSource[l] = self.dataSource[r]
            while self.dataSource[l] <= temp && l < r {
                l = l + 1
            }
            self.dataSource[r] = self.dataSource[l]
        }
        self.dataSource[l] = temp
        return l
    }
}
