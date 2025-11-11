//
//  Recursion.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/11.
//

import Cocoa


class RecursionTest {
    static func test() {
//        debugPrint("斐波那契数列:   \(Recursion().fib(9))")
//        debugPrint("斐波那契数列:   \(Recursion().fib1(9))")
//        debugPrint("斐波那契数列:   \(Recursion().fib2(9))")
        Recursion().hanoi(n: 3, p1: "A", p2: "B", p3: "C")
        BackTracking().place(8)
    }
}

/*
 递归
 */
class Recursion {
    
    // 斐波那契数列：1、1、2、3、5、8、13、21、34、……
    func fib(_ n: Int) -> Int {
        if n < 3 { return 1 }
        return fib(n - 1) + fib(n - 2)
    }
    
    func fib1(_ n: Int) -> Int {
        if n < 2 { return 1 }
        var arr:[Int] = [1,1]
        for i in 2..<n {
            arr.append(arr[i - 1] + arr[i - 2])
        }
        return arr[n - 1]
    }
    
    func fib2(_ n: Int) -> Int {
        if n < 2 { return 1 }
        var pre1 = 1
        var pre2 = 1
        var result = 0
        for _ in 2..<n {
            result = pre1 + pre2
            pre1 = pre2
            pre2 = result
        }
        return result
    }
    
    
    // 2.跳台阶问题 从第3个台阶开始。如果一次跳1个 那么就是 前面
    func climbStairs(_ n: Int)-> Int {
        if n == 1 { return 1 }
        if n == 2 { return 2 }
        return fib(n - 1) + fib(n - 2)
    }
    
    
    // 3.汉诺塔（Hanoi）
    /**
     * 将 n 个盘子从 p1 移动到 p3
     */
    func hanoi(n:Int, p1: String, p2: String, p3: String) {
        if n <= 1 {
            move(n: n, from: p1, to: p3)
            return
        }
        hanoi(n: n - 1, p1: p1, p2: p3, p3: p2)
        move(n: n, from: p1, to: p3)
        hanoi(n: n - 1, p1: p2, p2: p1, p3: p3)
    }
    
    func move(n:Int, from: String, to: String) {
        debugPrint("将 \(n)号盘子 从 \(from) 移动到 \(to)")
    }
    
}
