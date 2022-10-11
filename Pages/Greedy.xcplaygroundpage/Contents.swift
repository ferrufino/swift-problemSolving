//: [Previous](@previous)

import Foundation


func increasingTriplet(_ nums: [Int]) -> Bool {
    var min1 = Int.max, min2 = Int.max
    for num in nums {
        if num > min2 {
            return true
        } else if num > min1 {
            min2 = min(min2, num)
        } else {
            min1 = min(min1, num)
        }
    }
    return false
}

