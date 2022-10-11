// MARK: - PairWithTargetSum

func pairWithTargetSum(_ arr:[Int], _ target: Int) -> [Int] {
    /*
     Find pair that sum to target
     Array is sorted!
     while loop and use both pointers on extremes
     if sum is too low increase left
     if sum is too high decrease right
     
     T O(N)
     S O(1)
     */
    
    var left = 0
    var right = arr.count - 1
    
    while left < right {
        
        let sum = arr[left] + arr[right]
        
        if sum < target {
            left += 1
        } else if sum > target {
            right -= 1
        } else {
            return [left, right]
        }
    }
    
    return []
}
print("pairWithTargetSum")
print(pairWithTargetSum([1, 2, 3, 4, 6], 6))


/*
 Another approach is to use a dictionary and find target - arr[i]
 if found return positions
 else add arr[i] to dictionary with position
 T O(N)
 S O(N)
 */

// MARK: - Remove Duplicates
func removeDuplicates(_ arr: inout [Int]) -> Int {
    /*Do not use extra space. Return length of subarray with no duplicates*/
    
    var nextNonDuplicatePosition = 1 // with this var we keep track of next available position for a non duplicate to be put on, we assume position 0 is already a unique val as it is the first one to be found.
    
    for num in arr {
        
        if arr[nextNonDuplicatePosition - 1] != num {
            arr[nextNonDuplicatePosition] = Int(num)
            nextNonDuplicatePosition += 1
        }
        
    }
    
    return nextNonDuplicatePosition
}
var input1 = [2, 2, 2, 11]
var input2 = [2, 3, 3, 3, 6, 9, 9]

print("Remove Duplicates")
print(removeDuplicates(&input1))
print(removeDuplicates(&input2))


// MARK: - Squaring sorted array

/*Squaring sorted array
 Given a sorted array, create a new array containing squares of all the numbers of the input array in the sorted order.
 1. test cases:
 -2, -1, 0, 2, 3
 0    1   4  4  9
 l=-2 vs r=3 => 4 vs 9, r--, r=4->3
 l=-2 vs r=2 => 4 vs 4, l++, l=0->1
 l=-1 vs r=2 => 1 vs 4, r--, r=3->2
 l=-1 vs r=0 => 1 vs 0, l++, l=1->2
 
 Approach
 traverse in a new array from back to start
 have two pointers on given array called left and right
 left start at 0
 right starts at end of array
 only assigned the max value between the two pointers in current position of new array
 as it traverses from end to start.
 do this while traversing new array.
 */

func squaringSortedArray(_ arr:[Int]) -> [Int] {
    
    var left = 0
    var right = arr.count - 1
    var ansArr = Array<Int>(repeating: 0, count: arr.count)
    
    for (i, _) in ansArr.enumerated().reversed() {
        // be careful in order of enumerated and reversed
        // enumerated and reversed make it traverse in decreasing form.
        guard left <= right else{ break }
        
        var leftSqr = arr[left] * arr[left]
        var rightSqr = arr[right] * arr[right]
        
        if leftSqr < rightSqr {
            ansArr[i] = rightSqr
            right -= 1
        } else if leftSqr >= rightSqr {
            ansArr[i] = leftSqr
            left += 1
        }
    }
    
    return ansArr
}

print(squaringSortedArray([-2, -1, 0, 2, 3]) )
print(squaringSortedArray([-3, -1, 0, 1, 2]))


// MARK: - Triplet sum to zero
/*
 Given an array of unsorted numbers, find all unique triplets in it that add up to zero.
 
 Input: [-3, 0, 1, 2, -1, 1, -2]
 Output: [-3, 1, 2], [-2, 0, 2], [-2, 1, 1], [-1, 0, 1]
 Explanation: There are four unique triplets whose sum is equal to zero.
 */
/*
 
 Approach 1
 Sort array
 two pointers
 traverse array
 for arr[i] + left = i+ 1 + right compare if it is equal to 0
 if sum > 0
 right --
 if sum < 0
 left ++
 else
 insert to array of arrays of int answer
 */
func tripletSumToZero(_ arr: [Int]) -> [[Int]] {
    
    guard arr.count > 2 else {return [[Int]]() }
    var arr = arr
    arr.sort() // This is a key factor
    var ans = [[Int]]()
    for (i, _) in arr.enumerated() {
        var left = i + 1
        var right = arr.count - 1
        
        while left < right {
            var sum = arr[left] + arr[right] + arr[i]
            if sum > 0 {
                right -= 1
            } else if sum < 0 {
                left += 1
            } else {
                var leftVal = arr[left]
                var rightVal = arr[right]
                ans.append([arr[i],leftVal,rightVal])
                
                while left < right && arr[left] == leftVal { // Make it more efficient by skipping repeating vals.
                    left += 1
                }
                
                while left < right && arr[right] == rightVal { // Skip duplicates
                    right -= 1
                }
            }
        }
    }
    
    return ans
}

print(tripletSumToZero([-3, 0, 1, 2, -1, 1, -2]))
print(tripletSumToZero([-5, 2, -1, -2, 3]))

// T O(N^2) - S O(N) required for sorting

/*Triple Sum close to target
 Given an array of unsorted numbers and a target number,
 find a triplet in the array whose sum is as close to the target number as possible, return the sum of the triplet.
 
 If there are more than one such triplet, return the sum of the triplet with the smallest sum.
 
 Approach:
 
 we need to sort it to better traverse
 
 
 Test it!!
 -2 0 1 2 t=2
 -2 0 1 2 / /sorted
 i=-2, left = 0, right = 2 , sum = 0, ans= 0
 i=-2, left = 1, right = 2, sum = 1, ans = 1
 i=0, left = 1, right = 2, sum = 3, ans = 1
 */

// MARK: - Triplet smallest sum difference to target
func tripletSumToTarget(_ arr: [Int], _ target: Int) -> Int {
    
    guard arr.count > 2 else {return -1 }
    var arr = arr
    arr.sort() // This is a key factor
    var smallestDiff: Int = Int.max
    
    for i in 0...arr.count-2 {
        var left = i + 1
        var right = arr.count - 1
        
        while left < right {
            let sum = arr[left] + arr[right] + arr[i]
            if sum > target {
                right -= 1
            } else if sum < target {
                left += 1
            } else {
                return sum
            }
            
            
            let minDiff = target - sum
            if abs(smallestDiff) > abs(minDiff)  // compare differences, update if lower diff
                || (abs(smallestDiff) == abs(minDiff) && smallestDiff > minDiff){ // if same but minDiff is smaller, update
                
                smallestDiff = minDiff
            }
        }
    }
    
    return target - smallestDiff
}
print("tripletSumToTarget")
print( tripletSumToTarget([-2, 0, 1, 2], 2) )
print( tripletSumToTarget([-3, -1, 1, 2], 1) )
print( tripletSumToTarget([1, 0, 1, 1], 100) )

// MARK: - Triplets wtih Smaller sum
/* Given an array arr of unsorted numbers and a target sum, count all triplets in it such that arr[i] + arr[j] + arr[k] < target where i, j, and k are three different indices. Write a function to return the count of such triplets.

 */

func tripletsWithSmallerSum(_ arr:[Int], _ target: Int) -> Int {
    
    var ans = 0
    var arr = arr
    arr.sort()
    
    for i in 0...arr.count-2 {
        var left = i + 1
        var right = arr.count - 1
        
        while left < right {
            let sum = arr[left] + arr[right] + arr[i]
            
            if sum < target {
                ans += right - left //This is key to understanding the amount of possible solutions there are based on unique positions in the array. If you want the actual values another for loop from left to right would happen here.
                
                let leftVal = arr[left]
                let rightVal = arr[right]
                
                while leftVal == arr[left] { // skip duplicates
                    left += 1
                }
                
                while rightVal == arr[right] { // skip duplicates
                    right -= 1
                }
                
            } else {
                right -= 1
                
            }
            
        }
        
        
    }
    return ans
}
print("Triplets with Smaller sum")
print( tripletsWithSmallerSum([-1, 0, 2, 3], 3) )
print( tripletsWithSmallerSum([-1, 4, 2, 1, 3], 5) )

// T O(N^2) S O(N)


//MARK: - Subarrays with product less than a target
/*
 Given an array with positive numbers and a positive target number, find all of its contiguous subarrays whose product is less than the target number.
 
 Key terms:
 positive numbers and posi target
 
 contiguous subarrays
 
 product less than target - can be individual value
 */

func subsArrayWithProductLessThanSum(_ arr: [Int], _ target: Int) -> [[Int]] {
    var ans: [[Int]] = [[Int]]()
    var product = 1
    var left = 0
    for right in 0...arr.count - 1 {
        product *= arr[right]
        
        while product >= target && left < arr.count {
            product /= arr[left]
            left += 1
        }
        
        // Okay, but due to below it exceeds memory limit
        var tempArray = [Int]()
        for i in stride(from: right, through: left, by: -1) { // key analysis of this problem
            tempArray.append(arr[i])
            ans.append(tempArray)
        }
    }
    
    return ans
}
print("subsArrayWithProductLessThanSum")
print( subsArrayWithProductLessThanSum([2, 5, 3, 10], 30) )
print( subsArrayWithProductLessThanSum([8, 2, 6, 5], 50) )
print( subsArrayWithProductLessThanSum([10,5,2,6], 100) )
print( subsArrayWithProductLessThanSum([1,2,3], 0) )


// Approach #2
// Window slide
class Solution {
    func numSubarrayProductLessThanK(_ nums: [Int], _ k: Int) -> Int{
        if k <= 1 {
            return 0
        }
        var l = 0
        var prod = 1
        var ans = 0
        for r in 0..<nums.count {
            prod *= nums[r]
            while prod >= k {
                prod /= nums[l]
                l += 1
            }
            ans += r - l + 1 // sum windows size!!
        }
        return ans
    }
}


import XCTest

class Tests: XCTestCase {
    
    private let solution = Solution()
    
    /*
     The 8 subarrays that have product less than 100 are:
     [10], [5], [2], [6], [10, 5], [5, 2], [2, 6], [5, 2, 6]
     Note that [10, 5, 2] is not included as the product of 100 is not strictly less than k.
     */
    func test0() {
        let value = solution.numSubarrayProductLessThanK([10,5,2,6], 100)
        XCTAssertEqual(value, 8)
    }
    func test1() {
        let value = solution.numSubarrayProductLessThanK([1,2,3], 0)
        XCTAssertEqual(value, 0)
    }
}

Tests.defaultTestSuite.run()

// MARK: - Dutch flag
// Two pointers
// left is 0, right is 2
// traverse array if arr[i] is 0 swap with left
// " if arr[i] is 2 swap with right
func dutchFlag(_ arr: inout [Int]) {
    guard arr.count > 2 else {return}
    var left = 0
    var right = arr.count - 1
    var i = 0
    while i <= right {
        
        if arr[i] == 0 {
            arr.swapAt(i, left)
            left += 1
            i += 1
        } else if arr[i] == 2 {
            arr.swapAt(i, right)
            right -= 1
            
        } else { // when to sum i here is 1 - key analysis
            i += 1
        }
    }
}

var ductchinput = [1, 0, 2, 1, 0]
dutchFlag(&ductchinput)
print("Dutch flag: \(ductchinput)")

// MARK: - Quadruple sum to target
// a + b + c + d = target
// a = i, b = j = i+1, c = left ( j + 1), d = right (size - 1)

func QuadrupleSumToTarget(_ arr: [Int], _ target: Int) -> [[Int]] {
    guard arr.count > 3 else { // Check size
        return [[Int]]()
    }
    
    var ans = [[Int]]()
    let len = arr.count - 1
    var arr = arr
    arr.sort() // don't forget
    for i in 0...len - 2 { // minus 2, to give valid space for j(+1), left(+2)
        if i > 0 && arr[i] == arr[i - 1] { // skip duplicates
            continue
        }
        for j in i+1...len - 1 {
            if j > i + 1 && arr[j] == arr[j - 1] { // skip duplicates
                continue
            }
            
            var left = j + 1
            var right = len
            
            while left < right {
                let sum = arr[left] + arr[right] + arr[i] + arr[j]
                if sum == target {
                    ans.append([arr[left], arr[right], arr[i], arr[j]])
                    
                    let valLeft = arr[left]
                    let valRight = arr[right]
                    
                    while left < len && valLeft == arr[left] {// skip duplicates
                        left += 1
                    }
                    
                    while right > 0 && valRight == arr[right] {// skip duplicates
                        right -= 1
                    }
                    
                } else if sum < target {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
    }
    
    return ans
}
print("QuadrupleSumToTarget")
print(QuadrupleSumToTarget([4, 1, 2, -1, 1, -3], 1))
print(QuadrupleSumToTarget([2, 0, -1, 1, -2, 2], 2))

// MARK: - Comparing String containing Backspaces

/*
 Two pointers at the end of the strings given - pointerA and pointerB
 count of how many to erase - eraseA and eraseB
 */

func backSpaceCompare(_ s: String, _ t: String) -> Bool {
    var pointerA: Int = s.count - 1
    var pointerB: Int = t.count - 1
    var eraseA = 0
    var eraseB = 0
    
    while pointerA >= 0 && pointerB >= 0 {
        var charA = s[s.index(s.startIndex, offsetBy: pointerA)]
        var charB = t[t.index(t.startIndex, offsetBy: pointerB)]
        
        while charA == "#" {
            if pointerA > 0 {
                pointerA -= 1
            }
            eraseA += 1
            charA = s[s.index(s.startIndex, offsetBy: pointerA)]
        }
        
        while charB == "#" {
            if pointerB > 0 {
                pointerB -= 1
            }
            eraseB += 1
            charB = t[t.index(t.startIndex, offsetBy: pointerB)]
        }
        
        while eraseA > 0 {
            if pointerA > 0 {
                pointerA -= 1
            }
            eraseA -= 1
        }
        
        while eraseB > 0 {
            if pointerB > 0 {
                pointerB -= 1
            }
            
            eraseB -= 1
        }
        
        charA = s[s.index(s.startIndex, offsetBy: pointerA)]
        charB = t[t.index(t.startIndex, offsetBy: pointerB)]
        
        if charA != charB {
            return false
        }
        
        pointerA -= 1
        pointerB -= 1
    }
    
    return (pointerA > 0 || pointerB > 0) ? false : true
}
/// Good approach of two pointers but doesn't work on extreme cases like below:
print("backSpaceCompare")
print(backSpaceCompare("yf#o##f",
                       "y#f#o##f"))

//MARK: - Backspace compare approach 2 - Stack inspired:


func backspaceCompare2(_ S: String, _ T: String) -> Bool {
    return getEditedVersion(of: S) == getEditedVersion(of: T)
}

func getEditedVersion(of text: String) -> String {
    var result: String = ""
    
    for char in text {
        if char == "#" {
            if !result.isEmpty {
                result.removeLast()
            }
        }
        else {
            result.append("\(char)")
        }
    }
    
    print(result)
    return result
}

// MARK: - Minimum Window Sort
/*
 Given an array, find the length of the smallest subarray in it which when sorted will sort the whole array.
 
 Example 1:
 
 Input: [1, 2, 5, 3, 7, 10, 9, 12]
 Output: 5
 Explanation: We need to sort only the subarray [5, 3, 7, 10, 9] to make the whole array sorted
 */

func minWindowSort(_ nums: [Int]) -> Int {
    var left = 0
    var right = nums.count - 1
    
    while left < nums.count - 1 && nums[left] <= nums[left + 1] {
        left += 1
    }
    if left == nums.count - 1 {
        return 0
    }
    while right > 0 && nums[right] >= nums[right - 1] {
        right -= 1
    }
    
    var maxVal = Int.min
    var minVal = Int.max
    
    for i in left...right {
        
        maxVal = max(maxVal, nums[i])
        minVal = min(minVal, nums[i])
    }
    
    while left > 0 && nums[left - 1] > minVal {
        left -= 1
    }
    
    while right < nums.count - 1 && nums[right + 1] < maxVal {
        right += 1
    }
    
    return right - left + 1
}

print("minWindowSort")
print(minWindowSort([1, 2, 5, 3, 7, 10, 9, 12]))
print(minWindowSort([1, 3, 2, 0, -1, 7, 10]))
print(minWindowSort([1, 2, 3]))
print(minWindowSort([3, 2, 1]))
