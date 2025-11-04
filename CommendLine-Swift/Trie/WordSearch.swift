//
//  WordSearch.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/28.
//

import Cocoa

func testWordSearch() {
    let trie = Trie<Int>()
    trie.add(word: "WordSearch", value: 1)
    trie.add(word: "CommendLine", value: 1)
    trie.add(word: "Swift", value: 1)
    trie.add(word: "Created", value: 1)
    trie.add(word: "ji", value: 1)
    trie.add(word: "j", value: 1)
    trie.remove(word: "ji")
    debugPrint(trie)
    
    debugPrint("contains WordSearch : \(trie.contains(word: "WordSearch"))")
    debugPrint("contains Word : \(trie.contains(word: "Word"))")
    debugPrint("contains Swift : \(trie.contains(word: "Swift"))")

    debugPrint("starsWith WordSearch : \(trie.starsWith(prefix: "WordSearch"))")
    debugPrint("starsWith Word : \(trie.starsWith(prefix: "Word"))")
    debugPrint("starsWith wei : \(trie.starsWith(prefix: "wei"))")
    debugPrint("starsWith S : \(trie.starsWith(prefix: "S"))")
    
    debugPrint("contains j : \(trie.contains(word: "j"))")
    debugPrint("starsWith j : \(trie.starsWith(prefix: "j"))")

}
