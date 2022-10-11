
import Foundation

//Two Sum IV - Input is a BST

/*
 Approach:
 Search all tree - inorder/postorder/preorder
 have a set of where target - node val is appended
 while traverse all, if an existing val in set is found return true
 else false
 */

extension Solution {
    var set = Set<Int>()
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        guard let cur = root else {
            return false
        }
        if set.contains(k - cur.val) {
            return true
        }
        set.insert(cur.val)
        return findTarget(cur.left, k) || findTarget(cur.right, k)
    }
}
