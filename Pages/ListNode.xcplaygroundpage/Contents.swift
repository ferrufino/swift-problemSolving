
import Foundation

public class ListNode {
    public var val: Character
    public var next: ListNode?
    public init() {
        self.val = "c"
        self.next = nil
    }
    public init(_ val: Character, _ next: ListNode) {
        self.val = val
        self.next = next
    }
    
    public init(_ val: Character) {
        self.val = val
        self.next = nil
    }
    
}
