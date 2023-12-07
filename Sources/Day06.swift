import Foundation

struct Day06: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        let lines = data.split(separator: "\n")
        let times = lines[0].components(separatedBy: CharacterSet.decimalDigits.inverted).filter({ $0 != ""}).map({Int($0)!})
        let distances = lines[1].components(separatedBy: CharacterSet.decimalDigits.inverted).filter({ $0 != ""}).map({Int($0)!})
        
        var options = [Int]()
        for raceIndex in 0..<times.count {
            options.append(calculateOptions(seconds: times[raceIndex], distanceToBeat: distances[raceIndex]))
        }
        
        return options.reduce(1, *)
    }
    
    func calculateOptions(seconds: Int, distanceToBeat: Int) -> Int {
        var validOptions = 0
        for i in 1...seconds {
            let option = i * (seconds - i)
            if (option > distanceToBeat) { validOptions += 1 }
        }
        
        return validOptions
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let lines = data.split(separator: "\n")
        let times = lines[0].components(separatedBy: CharacterSet.decimalDigits.inverted).filter({ $0 != ""}).joined()
        let distances = lines[1].components(separatedBy: CharacterSet.decimalDigits.inverted).filter({ $0 != ""}).joined()
        
        return calculateOptions(seconds: Int(times)!, distanceToBeat: Int(distances)!)
    }
}
