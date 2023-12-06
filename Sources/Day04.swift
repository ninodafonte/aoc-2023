import Foundation

struct Day04: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        let lines = data.split(separator: "\n")
        var total: Decimal = 0
        
        for line in lines {
            let winningNumbersString = line.firstMatch(of: /.*:(.*)\|/)
            let winningNumbers = Set(String(winningNumbersString!.1).split(separator: " ").map({ Int($0)! }))
            
            let myNumbersString = line.firstMatch(of: /.*\|(.*)/)
            let myNumbers = Set(String(myNumbersString!.1).split(separator: " ").map({ Int($0)! }))
            
            let intersection = myNumbers.intersection(winningNumbers)
            
            if (intersection.count > 0) {
                total += pow(2, intersection.count - 1)
            }
        }
        
        return total
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let lines = data.split(separator: "\n")
        var scratchPads = [Int]()
        
        for lineIndex in 0..<lines.count {
            let winningNumbersString = lines[lineIndex].firstMatch(of: /.*:(.*)\|/)
            let winningNumbers = Set(String(winningNumbersString!.1).split(separator: " ").map({ Int($0)! }))
            
            let myNumbersString = lines[lineIndex].firstMatch(of: /.*\|(.*)/)
            let myNumbers = Set(String(myNumbersString!.1).split(separator: " ").map({ Int($0)! }))
            
            let points = myNumbers.intersection(winningNumbers).count
            let previouslyWon = scratchPads.filter({$0 == lineIndex + 1 }).count
            let timesWon = (previouslyWon == 0) ? 1 : previouslyWon + 1
            
            for _ in 0..<timesWon {
                for i in 0..<points {
                    scratchPads.append(lineIndex + i + 2)
                }
            }
        }
        
        return lines.count + scratchPads.count
    }
}
