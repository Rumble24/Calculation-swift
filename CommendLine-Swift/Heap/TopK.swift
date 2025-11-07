//
//  TopK.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/27.
//

/*
 可以使用二叉堆 - nlongk
 
 */

// MARK: - 最大的前几个数 - 使用小顶堆

func testBinaryHeap() {
//    let heap = BinaryHeap<Int>()
//    heap.add(var1: 90)
//    heap.add(var1: 80)
//
//    heap.add(var1: 30)
//    heap.add(var1: 60)
//
//    heap.add(var1: 70)
//    heap.add(var1: 100)
//
//    debugPrint("-----")
//
//    heap.remove()
//    heap.remove()
//    heap.remove()
//    heap.remove()
//    heap.remove()
//    heap.remove()
    
    let arr:[Int] = [51, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48, 100]
    let heap = BinaryHeap.create(arr: arr) { a, b in
        a - b
    }
    debugPrint(heap.elements)
}

func testTopK() {
    // 使用小顶堆
    let heap = BinaryHeap<Int> { a, b in
        b - a
    }

    let arr:[Int] = [51, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48, 100]
    let k = 8
    for (index, item) in arr.enumerated() {
        if index < k {
            heap.add(var1: item)
        } else if let top = heap.get(), item > top {
            heap.replace(var1: item)
        }
    }
    
    heap.print()
}
