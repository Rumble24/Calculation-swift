//
//  main.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/6/10.
//

/*
 笔记地址：https://juejin.cn/user/852876756006792/posts
  B站上有视频
  恋上数据结构与算法： https://blog.csdn.net/weixin_43734095/article/details/104847976
 
 课件和代码和测试小工具,需要的自取：
 链接：https://pan.baidu.com/s/1w8-6AVQf4i_pLd9S35nlGQ
 提取码：bnw6
 
 递归  转换为 迭代的时候 我们就需要 转换为栈
 
 数据结构 - https://www.cs.usfca.edu/~galles/visualization/Algorithms.html
 */
/*
 核心诉求    优先选择的数据结构    典型场景举例
 随机查询频繁    数组、哈希表    数据库表的行查询、缓存查询
 插入 / 删除频繁    链表、哈希表    消息队列、LRU 缓存
 有序存储 + 范围查询    B + 树、红黑树、跳表    数据库索引、有序集合（如 Redis 的 ZSet）
 字符串前缀匹配    Trie 树    自动补全、拼写检查
 复杂关联关系（多对多）    图    社交网络、路径规划
 快速获取最大 / 最小值    堆（大顶堆 / 小顶堆）    Top K 问题、优先队列
 */
import Foundation

// MARK: - 堆
//testBinaryHeap()

// MARK: - 栈
//debugPrint("有效括号： \(Stack.isValid(s: "{{{}}}"))")
//debugPrint("逆波兰表达式求值： \(Stack.evalRPN(["4","13","5","/","+"]))")
//debugPrint("后缀表达式： \(Stack.change("1-(     -2)"))")
//debugPrint("后缀表达式： \(Stack.calculate("1-(     -2)"))")

// MARK: - 排序
//SortTest.bubbleSortTest()


// MARK: - TopK
//testTopK()

// MARK: - 单词搜索
//testWordSearch()

// MARK: - 并查集
//UnionFindTest.test()

// MARK: - 图
GraphTest.test()
