//
//  Stack.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/9/1.
//

import Foundation

class Stack {
    
    // 有效括号：20 https://leetcode.cn/problems/valid-parentheses/description/
    static func isValid(s: String) -> Bool {
        let left:[Character:Character] = ["]":"[", "}":"{", ")":"("]
        var arr:[Character] = []
        
        for char in s {
            // 如果是右括号
            if let leftCahr = left[char] {
                if arr.isEmpty || arr.removeLast() != leftCahr {
                    return false
                }
            } else {
                arr.append(char)
            }
        }
        
        return arr.isEmpty
    }
    
    // LCR 036. 逆波兰表达式求值： https://leetcode.cn/problems/8Zf90G/description/
    // 前缀表达式 中缀表达式 后缀表达式
    // 实现逆波兰式的算法，难度并不大，但为什么要将看似简单的中缀表达式转换为复杂的逆波兰式？
    // 原因就在于这个简单是相对人类的思维结构来说的，对计算机而言中序表达式是非常复杂的结构。相对的，逆波兰式在计算机看来却是比较简单易懂的结构。因为计算机普遍采用的内存结构是栈式结构，它执行先进后出的顺序。
    // 用来实现数学逻辑运算的
    
    // 输入：tokens = ["4","13","5","/","+"]
    // 输出：9
    // 解释：该算式转化为常见的中缀算术表达式为：((2 + 1) * 3) = 9
    static func evalRPN(_ tokens: [String]) -> Int {
        var stack:[Int] = []
        let symbols:[String] = ["+","-","*","/"]
        var result: Int = 0
        for string in tokens {
            if symbols.contains(string) {
                let last = stack.removeLast()
                let last1 = stack.removeLast()
                if string == "+" {
                    result = last1 + last
                }
                else if string == "-" {
                    result = last1 - last
                }
                else if string == "*" {
                    result = last1 * last
                }
                else if string == "/" {
                    result = last1 / last
                }
                stack.append(result)
            } else {
                guard let int = Int(string) else { return result }
                stack.append(int)
            }
        }
        if stack.count == 1 {
            return stack.removeLast()
        }
        return result
    }
    
    // 224. 基本计算器
    // 输入：s = "(1+(4+5+2)-3)+(6+8)"
    // 输出：23
    // 改为后缀表达式 然后计算
    // 中缀表达式改为后缀表达式的规则是
    /*
     操作数 直接输出 运算符
     弹出优先级更高或相等的运算符
     遇到)弹出所有 直到遇到(
     */
    
    // (0-1+(1+-5+2)-(-3))+(6+-1)
    static func infixToPostfix(_ infix: String) -> [String] {
        var stack = [Character]()
        let symbols:[Character] = ["+","-","*","/","(",")"]
        let precedence: [Character: Int] = ["+": 1, "-": 1, "*": 2, "/": 2]
        var currentNumber = "" // 用于拼接多位数（如1114、11118）
        var result:[String] = []
        for char in infix {
            if char.isNumber {
                currentNumber.append(char)
            } else {
                if symbols.contains(char) {
                    if !currentNumber.isEmpty {
                        result.append(currentNumber)
                        currentNumber = ""
                    }
                }
                switch char {
                case "(":
                    stack.append(char)
                case ")":
                    while stack.last != "(" {
                        result.append("\(stack.removeLast())")
                    }
                    stack.removeLast()
                case "+", "-", "*", "/":
                    // 弹出优先级更高或相等的运算符
                    while let top = stack.last, top != "(", precedence[top]! >= precedence[char]! {
                        result.append(String(stack.removeLast()))
                    }
                    stack.append(char)
                default:
                    break
                }
            }
        }
        if !currentNumber.isEmpty {
            result.append(currentNumber)
        }
        while stack.last != nil {
            result.append("\(stack.removeLast())")
        }
        return result
    }
    
    static func change(_ s: String) -> String {
        let str = s.replacingOccurrences(of: " ", with: "")
        let symbols:[Character] = ["+","-"]
        var result = ""
        if let first = s.first, symbols.contains(first) {
            result.append("0")
        }
        var last: Character = " "
        for char in str {
            if symbols.contains(char), symbols.contains(last) {
                result.append("0")
            }
            if symbols.contains(char), last == "(" {
                result.append("0")
            }
            result.append(char)
            last = char
        }
        return result
    }
    
    static func calculate(_ s: String) -> Int {
        let token = infixToPostfix(s)
        return evalRPN(token)
    }
}
