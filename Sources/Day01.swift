import Algorithms
import Foundation

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
      let lines = data.split(separator: "\n")
      var count = 0;
                
      for line in lines {
          let intsOnly = line.components(separatedBy: CharacterSet.decimalDigits.inverted).filter({ $0 != ""}).joined().split(separator: "")
          let firstInt = intsOnly.first ?? ""
          let lastInt = intsOnly.last ?? ""
          let lineSum = ((Int(firstInt) ?? 0) * 10) + (Int(lastInt) ?? 0)
          count += lineSum
      }
            
      return count
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
      let lines = data.split(separator: "\n")
      var count = 0;
      
      for line in lines {
          let lineTranslated = convertToInts(line: String(line))
          let intsOnly = lineTranslated.components(separatedBy: CharacterSet.decimalDigits.inverted).filter({ $0 != ""}).joined().split(separator: "")
          let firstInt = intsOnly.first ?? ""
          let lastInt = intsOnly.last ?? ""
          let lineSum = ((Int(firstInt) ?? 0) * 10) + (Int(lastInt) ?? 0)
          count += lineSum
      }
      
      return count
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
}
