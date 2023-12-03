//
//  aoc_2023_FrameworkTests.swift
//  aoc_2023_FrameworkTests
//
//  Created by Nino Dafonte on 1/12/23.
//

import XCTest
@testable import aoc_2023_Framework

final class aoc_2023_FrameworkTests: XCTestCase {
    func testDay1Part1() {
            XCTAssert(day1Part1(dataFile: "day1test.txt") == 142, "Looks good with the example")
    }
}
