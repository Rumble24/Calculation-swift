//
//  File.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/6/10.
//

import Foundation

// MARK: 1. 两数之和
extension Solution {
//    print("两数之和 \(Solution.twoSum([2,7,11,15], 9))")
//    print("两数之和 \(Solution.twoSum1([2,7,11,15], 9))")
    // nums = [2,7,11,15], target = 9
    static func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        func startIndex(_ index: Int) -> [Int]? {
            for i in index + 1..<nums.count {
                if nums[i] + nums[index] == target {
                    return [index, i]
                }
            }
            return nil
        }
        for i in 0..<nums.count - 1 {
            if let result = startIndex(i) {
                return result
            }
        }
        return []
    }
    static func twoSum1(_ nums: [Int], _ target: Int) -> [Int] {
        var dic:[Int: Int] = [:]
        for i in 0..<nums.count {
            if dic.keys.contains(target - nums[i]) {
                return [i,dic[target - nums[i]]!]
            }
            dic[nums[i]] = i
        }
        return []
    }
}


// MARK: 49. 字母异位词分组
extension Solution {
    
    //1.排序后一样 2.包含的个数一样
    static func groupAnagrams(_ strs: [String]) -> [[String]] {
        if strs.count <= 1 {
            return [strs]
        }
        
        var charNums:[String: [String: Int]] = [:]
        var compares: [String] = []
        var results: [[String]] = []

        
        for str in strs {
            var nums:[String: Int] = [:]
            for char in str {
                let charStr = "\(char)"
                if let num = nums[charStr] {
                    nums[charStr] = num + 1
                } else {
                    nums[charStr] = 1
                }
            }
            charNums[str] = nums
        }
        
        func bijiao(_ a: String, _ b: String) -> Bool {
            if a.count == b.count {
                let numsa = charNums[a]
                let numsb = charNums[b]
                for key in numsa!.keys {
                    if let numa = numsa![key], let numb = numsb![key], numa == numb {
                        continue
                    } else {
                        return false
                    }
                }
                return true
            }
            return false
        }
        
        func start(_ index: Int) {
            var result: [String] = [strs[index]]
            for i in index + 1..<strs.count {
                if bijiao(strs[index], strs[i]) {
                    result.append(strs[i])
                    compares.append(strs[i])
                }
            }
            results.append(result)
        }
        
        for i in 0..<strs.count {
            if compares.contains(strs[i]) == false {
                start(i)
            }
        }
        
        return results
    }
    //1.排序后一样 2.包含的个数一样
    static func groupAnagrams1(_ strs: [String]) -> [[String]] {
        if strs.count <= 1 {
            return [strs]
        }
        
        var charNums:[String: String] = [:]
        var compares: [String] = []
        var results: [[String]] = []

        
        for str in strs {
            charNums[str] = "\(str.sorted())"
        }
        
        func bijiao(_ a: String, _ b: String) -> Bool {
            if a.count == b.count {
                let numsa = charNums[a]
                let numsb = charNums[b]
                return numsa == numsb
            }
            return false
        }
        
        func start(_ index: Int) {
            var result: [String] = [strs[index]]
            for i in index + 1..<strs.count {
                if bijiao(strs[index], strs[i]) {
                    result.append(strs[i])
                    compares.append(strs[i])
                }
            }
            results.append(result)
        }
        
        for i in 0..<strs.count {
            if compares.contains(strs[i]) == false {
                start(i)
            }
        }
        
        return results
    }
}





// MARK: 128. 最长连续序列
extension Solution {
    // [100,4,200,1,3,2]
    static func longestConsecutive(_ nums: [Int]) -> Int {
        let numSet = Set(nums)  // 转成 Set 用于 O(1) 查询
        var longestStreak = 0
        
        for num in numSet {
            // 只有当 num 是序列起点时才处理（即 num-1 不在集合中）
            if !numSet.contains(num - 1) {
                var currentNum = num
                var currentStreak = 1
                
                // 持续检查下一个数是否存在
                while numSet.contains(currentNum + 1) {
                    currentNum += 1
                    currentStreak += 1
                }
                
                // 更新最长序列长度
                longestStreak = max(longestStreak, currentStreak)
            }
        }
        
        return longestStreak
    }
}


// MARK: 283. 移动零
//var nums = [0,1,0,3,12]
//Solution.moveZeroes(&nums)
//print(nums)
extension Solution {
    /*
     给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。

     请注意 ，必须在不复制数组的情况下原地对数组进行操作。

     示例 1:

     输入: nums = [0,1,0,3,12]
     输出: [1,3,12,0,0]
     示例 2:

     输入: nums = [0]
     输出: [0]
     */
    static func moveZeroes(_ nums: inout [Int]) {
        var left = 0
        var right = 0
        let count = nums.count
        while right < count {
            if nums[right] != 0 {
                nums.swapAt(left, right)
                left += 1
            }
            right += 1
        }
    }
}


// MARK: 11. 盛最多水的容器
class Solution {
/// 木桶原理，木桶能装多少的水，取决于短的木板，按照本题算面积，应该是拿短的当高，高确定的情况下，长度最长面积就最大，也就是不管怎么移动长的那根（前提是往短的这边移动），面积都会小于最开始的面积，所以需要移动短的那根，再以此往复的寻找最大的面积。

    /*
     输入：[1,8,6,2,5,4,8,3,7]
     输出：49
     解释：图中垂直线代表输入数组 [1,8,6,2,5,4,8,3,7]。在此情况下，容器能够容纳水（表示为蓝色部分）的最大值为 49。
     */
    
    static func maxArea(_ height: [Int]) -> Int {
        if height.count < 2 {
            return 0
        }
        
        var left = 0
        var right = height.count - 1
        var area = 0
        
        while left < right  {
            area = max(area, min(height[left], height[right]) * (right - left))
            if height[left] < height[right] {
                left += 1
            } else {
                right -= 1
            }
        }
        
        return area
    }

}
