//
//  aoc_2023_FrameworkTests.swift
//  aoc_2023_FrameworkTests
//
//  Created by Nino Dafonte on 1/12/23.
//

import XCTest
@testable import aoc_2023_Framework

final class aoc_2023_FrameworkTests: XCTestCase {
    
    func testIsPalindrome() {

            let s0 = ""; //false
            let s1 = "a"; // true
            let s2 = "aa"; // true
            let s3 = "abba"; // true
            let s4 = "abcba"; // true
            let s5 = "abc"; // false
            let s6 = "abcd"; // false
            let s7 = "öooooö"; //true
            let s8 = "öooooø"; //false

            XCTAssert(isPalindrome(s0) == false, "Test of \"\(s0)\" is wrong")
            XCTAssert(isPalindrome(s1) == true, "Test of \"\(s1)\" is wrong")
            XCTAssert(isPalindrome(s2) == true, "Test of \"\(s2)\" is wrong")
            XCTAssert(isPalindrome(s3) == true, "Test of \"\(s3)\" is wrong")
            XCTAssert(isPalindrome(s4) == true, "Test of \"\(s4)\" is wrong")
            XCTAssert(isPalindrome(s5) == false, "Test of \"\(s5)\" is wrong")
            XCTAssert(isPalindrome(s6) == false, "Test of \"\(s6)\" is wrong")
            XCTAssert(isPalindrome(s7) == true, "Test of \"\(s7)\" is wrong")
            XCTAssert(isPalindrome(s8) == false, "Test of \"\(s8)\" is wrong")
        }

}
