import UIKit

/// Be able to push
/// Pop deletes top element
/// Top gets latest/top element
/// get size of Stack
public class Stack<T>
{
    private var arr:[T]
    
    init(){
        arr = [T]()
    }
    
    public func push(_ element: T) {
        arr.append(element)
    }
    
    public func top() -> T? {
        guard arr.count > 0 else{ return nil }
        
        return arr.last
    }
    
    public func pop() -> Bool {
        guard arr.count > 0 else{ return false }
        
        arr.removeLast()
        return true
    }
    
    public func size() -> Int {
        return arr.count
    }
}

var stck = Stack<Int>()
stck.push(2)
stck.push(3)
stck.push(4)
stck.top()
stck.pop()
stck.top()
stck.size()
