//
//  day1.swift
//  aoc-2023
//
//  Created by Nino Dafonte on 3/12/23.
//

import Foundation

extension String {
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while let range = range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale) {
            ranges.append(range)
        }
        return ranges
    }
}

func day1Part1(dataFile: String) -> Int {
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let aocDataURL = documentsURL.appendingPathComponent("aoc2023")
    let day1URL = aocDataURL.appendingPathComponent(dataFile)
    var count = 0;
    
    do {
        let data = try Data(contentsOf: day1URL)
        if let contents = String(data: data, encoding: .utf8) {
            let lines = contents.split(separator:"\n")
            for line in lines {
                let intsOnly = line.components(separatedBy: CharacterSet.decimalDigits.inverted).filter({ $0 != ""}).joined().split(separator: "")
                let firstInt = intsOnly.first ?? ""
                let lastInt = intsOnly.last ?? ""
                let lineSum = ((Int(firstInt) ?? 0) * 10) + (Int(lastInt) ?? 0)
                count += lineSum
            }
        }
    } catch {
        print("Error reading file: \(error)")
    }
    
    return count;
}

func day1Part2(dataFile: String) -> Int {
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let aocDataURL = documentsURL.appendingPathComponent("aoc2023")
    let day1URL = aocDataURL.appendingPathComponent(dataFile)
    var count = 0;
    
    do {
        let data = try Data(contentsOf: day1URL)
        if let contents = String(data: data, encoding: .utf8) {
            let lines = contents.split(separator:"\n")
            for line in lines {                
                let lineTranslated = convertToInts(line: String(line))
                let intsOnly = lineTranslated.components(separatedBy: CharacterSet.decimalDigits.inverted).filter({ $0 != ""}).joined().split(separator: "")
                let firstInt = intsOnly.first ?? ""
                let lastInt = intsOnly.last ?? ""
                let lineSum = ((Int(firstInt) ?? 0) * 10) + (Int(lastInt) ?? 0)
                count += lineSum
            }
        }
    } catch {
        print("Error reading file: \(error)")
    }
    
    return count;
}

func convertToInts(line: String) -> String {
    let numbersInText = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    var translation: [Int: String] = [:]
    
    for numberInText in numbersInText {
        let occurences = line.ranges(of: numberInText)
        for wordIndex in occurences {
            let distanceIndex = line.distance(from: line.startIndex, to: wordIndex.lowerBound)
            translation[distanceIndex] = numberInText
        }
    }
        
    var lineTranslated = line
    for (index, text) in translation {
        let numIndex = numbersInText.firstIndex(of: text)!
        lineTranslated = replace(myString: lineTranslated, index, numIndex)
    }
    
    return lineTranslated
}

func replace(myString: String, _ index: Int, _ newChar: Int) -> String {
    var chars = Array(myString)
    let newChar = String(newChar)
    chars[index] = newChar[newChar.startIndex]
    let modifiedString = String(chars)
    
    return modifiedString
}
