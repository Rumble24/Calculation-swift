//
//  DynamicProgramming.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/12.
//  斐波那契数列
//  跳台阶
//  最少硬币数       - dp(n) = min{ dp{n - 1}, dp{n - 5}, dp{n - 20}, dp{n - 25}} + 1
//  最大连续子序列和  - dp(n) = max{ dp{n - 1} } + dp[n]
//   {-2, 1, -3, 4, -1, 2, 1, -5, 4 }

//  最长上升子序列    -  if (dp(n) > dp(n - 1)) dp(n) = { dp(n - 1) + 1  }
//  比如 [10, 2, 2, 5, 1, 7, 101, 18] 的最长上升子序列是 [2, 5, 7, 101]、[2, 5, 7, 18]，长度是 4

//  最长公共子序列    - nums1[i] == nums2[j]  dp(i,j) = max{ dp{i - 1, j - 1} } + 1
//                  - nums1[i] != nums2[j]  dp(i,j) = dp{i - 1}
//  比如 [1, 3, 5, 9, 10] 和 [1, 4, 9, 10] 的最长公共子序列是 [1, 9, 10]，长度为 3

//  最长字串

import Cocoa

/*
 a b c d
 a a c d
 找到 子问题最优解 然后设置初始值 就好了
 */

//  MARK: - 需要的最少硬币的个数
class DynamicProgramming {
    // 1 5 20 25 凑出 41 找出最小的个数
    /*
     // dp(41) = 凑够41需要的最少硬币数量 = min { dp(40), dp(36), dp(16), dp(21) } + 1
     // dp(41 - 1) = dp(40) = 凑够40需要的最少硬币数量
     // dp(41 - 5) = dp(36) = 凑够36需要的最少硬币数量
     // dp(41 - 25) = dp(16) = 凑够16需要的最少硬币数量
     // dp(41 - 20) = dp(21) = 凑够21需要的最少硬币数量
     // min { dp(40), dp(36), dp(16), dp(21) } + 1
     */
    // 目前的代码有大量重复 计算
    func coin(_ n: Int) -> Int {
        if n == 25 || n == 20 || n == 5 || n == 1 {
            return 1
        }
        if n <= 0 {
            return Int.max
        }
        let min1 = min(coin(n - 25), coin(n - 20))
        let min2 = min(coin(n - 5), coin(n - 1))
        return min(min1, min2) + 1
    }
    
    
    //  - 使用缓存节省大量时间 666
    func cacheCoin(_ n: Int) -> Int {
        var cache:[Int] = Array(repeating: 0, count: n + 1)
        for item in [1,5,20,25] {
            if n > item {
                cache[item] = 1
            }
        }
        return coin1(n, cache: &cache)
    }
    
    private func coin1(_ n: Int, cache: inout [Int]) -> Int {
        if cache[n] == 0 {
            var minValue = Int.max
            if n >= 25 { minValue = min(minValue, coin1(n - 25, cache: &cache)) }
            if n >= 20 { minValue = min(minValue, coin1(n - 20, cache: &cache)) }
            if n >= 5 { minValue = min(minValue, coin1(n - 5, cache: &cache)) }
            if n >= 1 { minValue = min(minValue, coin1(n - 1, cache: &cache)) }
            cache[n] = minValue + 1
        }
        return cache[n]
    }
    
    // - 动态规划
    func coin2(_ n: Int) -> Int {
        if n < 1 { return -1 }
        var dp:[Int] = Array(repeating: 0, count: n + 1)
        for i in 1...n {
            var minValue = dp[i - 1]
            if i >= 5 { minValue = min(minValue, dp[i - 5]) }
            if i >= 20 { minValue = min(minValue, dp[i - 20]) }
            if i >= 25 { minValue = min(minValue, dp[i - 25]) }
            dp[i] = minValue + 1
            debugPrint("i:\(i)  dp:\(dp)")
        }
        return dp[n]
    }
}



//  MARK: - 最大连续子序列和
extension DynamicProgramming {
//    {-2, 1, -3, 4, -1, 2, 1, -5, 4 }
//    -2   1  -2, 4, 3
    func maxSubArray(_ arr: [Int]) -> Int {
        if arr.isEmpty { return 0 }
        var currentMax = arr[0]
        var bestMax = arr[0]
        for idx in 1..<arr.count {
            currentMax = max(arr[idx], arr[idx] + currentMax)
            bestMax = max(bestMax, currentMax)
        }
        return bestMax
    }
}


//  MARK: - 最长上升子序列
//  最长上升子序列    -  if (dp(n) > dp(n - 1)) dp(n) = { dp(n - 1) + 1  }
//  比如 [10, 2, 2, 5, 1, 7, 101, 18] 的最长上升子序列是 [2, 5, 7, 101]、[2, 5, 7, 18]，长度是 4
extension DynamicProgramming {
    func longestIncreasingSubsequence(_ arr: [Int]) -> Int {
        guard !arr.isEmpty else { return 0 }
        
        var best = 1
        var dp = Array(repeating: 1, count: arr.count)
        
        for i in 1..<arr.count {
            var maxLength = 0
            for j in 0..<i {
                if arr[j] < arr[i] {
                    maxLength = max(maxLength, dp[j])
                }
            }
            dp[i] = maxLength + 1
            best = max(best, dp[i])
        }
        
        return best
    }
}



//  MARK: - 最长公共子序列
//  最长公共子序列    - nums1[i] == nums2[j]  dp(i,j) = max{ dp{i - 1, j - 1} } + 1
//                  - nums1[i] != nums2[j]  dp(i,j) = dp{i - 1}
//  比如 [1, 3, 5, 9, 10] 和 [1, 4, 9, 10] 的最长公共子序列是 [1, 9, 10]，长度为 3
extension DynamicProgramming {
    // [1, 3, 5, 9, 10]
    // [1, 4, 9, 10]
    /*
        1, 3, 5, 9, 10
       ---------------
     1｜[1, 1, 1, 1, 1]
     4｜[1, 1, 1, 1, 1]
     9｜[1, 1, 1, 2, 2]
    10｜[1, 1, 1, 2, 3]
     */
    // dp[i][j] 第 i 行 第 j 列
    func lcs(_ text1: [Int], _ text2: [Int]) -> Int {
        guard text1.count > 0, text2.count > 0 else { return 0 }
        var dp:[[Int]] = Array(repeating: Array(repeating: 0, count: text1.count), count: text2.count)
        var maxDpi = 0
        for (i, num1) in text2.enumerated() {
            for (j, num2) in text1.enumerated() {
                if num1 == num2 {
                    if i == 0 || j == 0 {
                        dp[i][j] = 1
                    } else {
                        dp[i][j] = dp[i - 1][j - 1] + 1
                    }
                } else {
                    if i == 0, j == 0 {
                        dp[i][j] = 0
                    } else if i == 0 {
                        dp[i][j] = dp[i][j - 1]
                    } else if j == 0 {
                        dp[i][j] = dp[i - 1][j]
                    } else {
                        dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
                    }
                }
                maxDpi = max(maxDpi, dp[i][j])
            }
        }
        debugPrint("-------------------------------")
        for item in dp {
            debugPrint(item)
        }
        return maxDpi
    }
    
    /*
         [1, 3, 5, 9, 10]
       [0, 0, 0, 0, 0, 0]
     1 [0, 1, 1, 1, 1, 1]
     4 [0, 1, 1, 1, 1, 1]
     9 [0, 1, 1, 1, 2, 2]
     10[0, 1, 1, 1, 2, 3]
     */
    func lcs1(_ text1: [Int], _ text2: [Int]) -> Int {
        guard text1.count > 0, text2.count > 0 else { return 0 }
        var dp:[[(Int,String)]] = Array(repeating: Array(repeating: (0,""), count: text1.count + 1), count: text2.count + 1)
        var maxDpi = (0,"")
        for i in 1...text2.count {
            let num1 = text2[i - 1]
            for j in 1...text1.count {
                let num2 = text1[j - 1]
                if num1 == num2 {
                    dp[i][j] = (dp[i - 1][j - 1].0 + 1, dp[i - 1][j - 1].1 + " \(num2)")
                } else {
                    if dp[i - 1][j].0 > dp[i][j - 1].0 {
                        dp[i][j] = dp[i - 1][j]
                    } else {
                        dp[i][j] = dp[i][j - 1]
                    }
                }
                if maxDpi.0 < dp[i][j].0 {
                    maxDpi = dp[i][j]
                }
            }
        }
//        debugPrint("-------------------------------")
//        for item in dp {
//            debugPrint(item)
//        }
        debugPrint("----------------------------\(maxDpi)")
        return maxDpi.0
    }
    
    
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {

        return 0
    }
}


//  MARK: - 最长公共子串
extension DynamicProgramming {
    // "ABDCBA", "ABBA"
    // 状态 - 转移方程
    /*
     以 i 和 j 结尾的子串
     num1[i] == num2[j]  dp[i][j] = dp[i - 1][j - 1] + 1
     num1[i] != num2[j] = 0
     */
    // [1, 3, 5, 9, 10]
    // [1, 4, 9, 10]
    func lcsub(_ text1: [Int], _ text2: [Int]) -> Int {
        guard text1.count != 0, text2.count != 0 else {
            return 0
        }
        var dp:[[Int]] = Array(repeating: Array(repeating: 0, count: text1.count + 1), count: text2.count + 1)
        var r = 0
        for i in 1...text2.count {
            let num1 = text2[i - 1]
            for j in 1...text1.count {
                let num2 = text1[j - 1]
                if num1 == num2 {
                    dp[i][j] = dp[i - 1][j - 1] + 1
                } else {
                    dp[i][j] = 0
                }
                r = max(r, dp[i][j])
            }
        }
        return r
    }
    
    
    func longestCommonSubstring(_ text1: String, _ text2: String) -> Int {
        guard text1.count != 0, text2.count != 0 else {
            return 0
        }
        var dp:[[Int]] = Array(repeating: Array(repeating: 0, count: text1.count + 1), count: text2.count + 1)
        var r = 0
        for i in 1...text2.count {
            let num1 = text2[i - 1]
            for j in 1...text1.count {
                let num2 = text1[j - 1]
                if num1 == num2 {
                    dp[i][j] = dp[i - 1][j - 1] + 1
                } else {
                    dp[i][j] = 0
                }
                r = max(r, dp[i][j])
            }
        }
        return r
    }
}
extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}



//  MARK: - 01背包问题

extension DynamicProgramming {
    /*
     价值： int[] values = {6, 3, 5, 4, 6};
     重量： int[] weights = {2, 2, 6, 5, 4};
     背包重量： int capacity = 10;
     求能放进背包的最大价值是多少
     dp[i][j] 表示前i个物品，背包容量为j时的最大价值
     
         6, 3, 5, 4, 6
        ---------------
      0｜[0, 0, 0, 0, 0]
      1｜[0, 0, 0, 0, 0]
      2｜[0, 0, 0, 0, 0]
      3｜[0, 1, 0, 0, 3]
      4｜[0, 1, 0, 0, 3]
     */
    func knapsack01(values: [Int], weights:[Int], capacity: Int) -> Int {
        guard values.count != 0, values.count == weights.count, capacity > 0 else {
            return -1
        }
//        var dp:[Int] = Array(repeating: 0, count: capacity)
//        var r = 0
//        for (index, weight) in weights.enumerated() {
//            <#body#>
//        }
//        
        return 0
    }
}
