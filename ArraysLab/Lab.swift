//
//  Lab.swift
//  ArraysLab
//
//  Created by Kevin McQuown on 1/29/21.
//

import Foundation

struct Lab {
    // Return the largest 3 numbers in the supplied array. If the array has less than 3 values, just return those values.
    // Return an empty array if you are supplied an empty array.
    func largestThree(input: [Int]) -> [Int] {
        // ----  Your code here ----
        let sorted = input.sorted(by: >)
        let finalIndex = min(3, sorted.count)
        return Array(sorted[0 ..< finalIndex])
        // -------------------------
    }
    
    // Return an array of all odd numbers provided in the input array in ascending order
    func oddNumber(input: [Int]) -> [Int] {
        // ----  Your code here ----
        let sorted = input.sorted(by: <)
        var result = [Int]()
        for number in sorted {
            if number % 2 == 1 {
                result.append(number)
            }
        }
        return result
        // -------------------------
    }

    // Is Int number supplied a prime number?  If so, return true, otherwise false.
    func isPrime(input: Int) -> Bool {
        // ----  Your code here ----
        if input < 4 {
            if input % 2 == 0 {
                return false
            } else {
                return true
            }
        }
        for divisor in 2 ... input/2 {
            if input % divisor == 0 {
                return false
            }
        }
        return true
        // -------------------------
    }

    // Return the first 20 prime numbers in an array from greatest to smallest
    // You can reuse other functions that you have written to help solve this if you like.
    func first20PrimeNumbers() -> [Int] {
        // ----  Your code here ----
        var result = [Int]()
        var value = 0
        while result.count < 20 {
            if isPrime(input: value) {
                result.append(value)
            }
            value += 1
        }
        return result.sorted(by: >)
        // -------------------------
    }

    // Swap the two number supplied.  For example, if you are given "a" as 5 and "b" as 8 you should set "a" to 8 and "b" to 5.
    func swap(a: inout Int, b: inout Int) {
        // ----  Your code here ----
        let temp = a
        a = b
        b = temp
        // -------------------------
    }
    
    // Generate n random integers where each integer is a random number between lowerBound and upperBound with no repeating numbers. if you cannot accomplish this, return nil.
    // Use guard statements to protect against situations where no solution is possible
    func randomNumbers(numberOfRandoms: Int, lowerBound: Int, upperBound: Int) -> [Int]? {
        // ----  Your code here ----
        guard upperBound > lowerBound else { return nil}
        let range = lowerBound ... upperBound
        guard range.count >= numberOfRandoms else {return nil}
        
        if range.count < numberOfRandoms {
            return nil
        }
        var numbers = [Int]()
        for _ in 0 ..< numberOfRandoms {
            numbers.append(Int.random(in: range))
        }
        while hasDuplicateAtIndex(input: numbers) != nil {
            let idx = hasDuplicateAtIndex(input: numbers)!
            numbers[idx] = Int.random(in: range)
        }
        return numbers
        // -------------------------
    }
    
    func hasDuplicateAtIndex(input: [Int]) -> Int? {
        var dict = [Int: Bool]()
        for i in 0 ..< input.count {
            if let _ = dict[input[i]] {
                // we found a duplicate
                return i
            } else {
                // not currently in dictionary so lets add for next iteration
                dict[input[i]] = true
            }
        }
        return nil
    }
}
