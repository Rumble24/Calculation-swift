//
//  Trie.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/28.
//

import Cocoa

/*
 字典树 用来查找是否包含某个单词  a d c
   a
 b  c

 */
class Trie<V> {
    var root:TrieNode?
    var size:Int = 0
    
    func count() -> Int { size }
    
    func isEmpty() -> Bool { size == 0 }
    
    func clear() {
        size = 0
        root = nil
    }
    
    func add(word:String, value: V) {
        if root == nil {
            root = TrieNode(char: nil, parent: nil)
        }
        var temp = root
        for char in word {
            if temp?.map[char] == nil {
                temp?.map[char] = TrieNode(char: char, parent: temp)
            }
            temp = temp?.map[char]
        }
        
        if temp?.value == nil {
            size = size + 1
        }
        temp?.value = value
    }
    
    func remove(word:String) {
        guard let node = node(word: word) else { return }
        if node.value == nil { return }
        // 1.删除的的是中间节点
        if !node.map.isEmpty { return }
        // 2.删除的是尾部节点
        node.value = nil
        var tmp:TrieNode? = node
        while tmp != nil, tmp!.map.isEmpty, tmp!.value == nil {
            guard let char = tmp!.char else { return }
            tmp!.parent?.map.removeValue(forKey: char)
            tmp = tmp!.parent
        }
    }
    
    
    func contains(word:String) -> Bool {
        node(word: word)?.value != nil
    }
    
    func starsWith(prefix:String) -> Bool {
        node(word: prefix) != nil
    }
    
    private func node(word: String) -> TrieNode? {
        var temp = root
        for char in word {
            if let child = temp?.map[char] {
                temp = child
            } else {
                return nil
            }
        }
        return temp
    }
}


class TrieNode {
    var map:[Character: TrieNode] = [:]
    var value:Any?
    var char: Character?
    var parent: TrieNode?
    init(char: Character?, parent: TrieNode?) {
        self.char = char
        self.parent = parent
    }
}
