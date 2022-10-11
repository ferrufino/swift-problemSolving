//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

/*
 add to dictionary new/existent chars count of occurence
 if size of dict more than K
    reduce size
 measure window
 
 retunr longest window size measured.
 */

public func longestSubstringMaxKDistinctChars(_ K: Int, _ str: String) -> Int {
    
    var windowS = 0
    var longestSubs: Int = 0
    var dict = [Character : Int]()
    
    for (windowE, value) in str.enumerated() {
        
        if let _ = dict[value] {
            dict[value]! += 1
        } else {
            dict[value] = 1
        }
        
        while dict.count > K {
            let key = str[str.index(str.startIndex, offsetBy: windowS)]
            guard var count = dict[key] else {return -1}
            count -= 1
            
            if count < 1 {
                dict[key] = nil
            } else{
                dict[key] = count
            }
            
            windowS += 1
        }
        
        longestSubs = max(longestSubs,  windowE - windowS + 1)
    }
    
    return longestSubs
}

print(longestSubstringMaxKDistinctChars(2, "araaci"))
print(longestSubstringMaxKDistinctChars(1, "araaci"))
print(longestSubstringMaxKDistinctChars(3, "cbbebi"))
print(longestSubstringMaxKDistinctChars(10, "araaci"))

//T: O(N) S: O(K)
// The time complexity could be seen as N + N, due to the for loop going through all the chars and the while loop going once on all chars possibly. which ends up being just N

/*Longst substring with Distinct chars
 use dict, if char already exists?
 then windowStart becomes current position of existent char found
 and this gets updated also on dict
 */

func longestSubstringDistinctCharacters(_ str: String) -> Int {
    var left = 0
    var dict = [Character : Int]()
    var longestSubstring = 0
    
    for (right, value) in str.enumerated() {
        
        if let _ = dict[value] {
            //reduce window
            dict[value] = right
            left = right
        } else {
            dict[value] = right
        }
        
        longestSubstring = max(longestSubstring, right - left + 1)
    }
    
    return longestSubstring
}

print("result: \(longestSubstringDistinctCharacters("aabccbb"))")
print("result: \(longestSubstringDistinctCharacters("abbbb"))")
print("result: \(longestSubstringDistinctCharacters("abccde"))")

// T= O(N)
// S= O(26) -> O(1)

/*Longest Substring with Same Letters after Replacement*/
/*use the approach of longest substring with 2 distinct characters
 In this approach keep count of extra occurrences of diff char
 
 */

public func longestSubstringWithSameLettersAfterReplacement(_ K: Int, _ str: String) -> Int {
    
    var windowS = 0
    var longestSubs: Int = 0
    var dict = [Character : Int]()
    var maxCharCount = 0
    
    for (windowE, value) in str.enumerated() {
        
        if let _ = dict[value] {
            dict[value]! += 1
        } else {
            dict[value] = 1
        }
        maxCharCount = max(maxCharCount, dict[value]!)
        while windowE - windowS + 1 - maxCharCount > K { // Key evaluation for this problem
            let key = str[str.index(str.startIndex, offsetBy: windowS)]
            guard var count = dict[key] else {return -1}
            count -= 1
            
            if count < 1 {
                dict[key] = nil //erase char
            } else{
                dict[key] = count
            }
            
            windowS += 1
        }
        
        longestSubs = max(longestSubs,  windowE - windowS + 1)
    }
    
    return longestSubs
}

print("\(longestSubstringWithSameLettersAfterReplacement(2, "aabccbb"))")
print("\(longestSubstringWithSameLettersAfterReplacement(2, "abcbc"))")

/*
 Longest Subarray with ones after replacement
 keep count of 1s
 keep count of 0s
 
 if count of 0s > k
 reduce window
 */
public func longestSubarrayWithOnesAfterReplacement(_ K: Int, _ arr: Array<Int>) -> Int {
    
    var windowS = 0
    var longestSubs: Int = 0
    var ones = 0
    var zeros = 0
    var maxCharCount = 0
    
    for (windowE, value) in arr.enumerated() {
        
        if value == 1 {
            ones += 1
        } else {
            zeros += 1
        }
        
        while zeros > K { // Key evaluation for this problem
            
            if arr[windowS] == 1 {
                ones -= 1
            } else {
                zeros -= 1
            }
            
            windowS += 1
        }
        
        longestSubs = max(longestSubs,  windowE - windowS + 1)
    }
    
    return longestSubs
}

print("\(longestSubarrayWithOnesAfterReplacement(2, [0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1]))")
