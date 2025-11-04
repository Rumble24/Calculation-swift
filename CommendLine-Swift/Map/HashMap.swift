//
//  HashMap.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/9/23.
//

import Cocoa

/*
 本质是一个数组
 根据hash函数 由key计算出下标
 hash值 然后[ 可以使用 & 位运算 数组的个数减一]获取下标 2的倍数 / 如果想要用% 那么最好使用质数作为 数组的个数
 2倍 就是左移
 除2 就是右移
 
 如何解决hash冲突 1. 链表加红黑树 2.在hash法
 
 节点总数量 / 哈希表桶数组长度，也叫做负载因子 大于0.75的时候 我们就需要扩容
 */
class HashMap: NSObject {

}
