import Algorithms
import Foundation

struct Day02: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    let MAX_REDS = 12
    let MAX_GREENS = 13
    let MAX_BLUES = 14

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        let lines = data.split(separator: "\n")
        let validGames = lines.map({ (line) in
            // game
            let regex = /Game (\d.*):.*/
            let match = line.firstMatch(of: regex)
            let game = Int(match!.1)!
            // rounds
            let rounds = line.split(separator: ";")
            var drop = false
            for round in rounds {
                if let reds = round.firstMatch(of: /(\d*) red/) {
                    if (Int(reds.1)! > MAX_REDS) {
                        drop = true
                    }
                }
                
                if let greens = round.firstMatch(of: /(\d*) green/) {
                    if (Int(greens.1)! > MAX_GREENS) {
                        drop = true
                    }
                }
                
                if let blues = round.firstMatch(of: /(\d*) blue/) {
                    if (Int(blues.1)! > MAX_BLUES) {
                        drop = true
                    }
                }
            }
            
            return (drop) ? 0 : game
        })
        
        return validGames.reduce(0, {$0 + $1})
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let lines = data.split(separator: "\n")
        let minValuesPerGame = lines.map({ (line) in
            // rounds
            let rounds = line.split(separator: ";")
            var min_red = 1
            var min_green = 1
            var min_blue = 1
                        
            for round in rounds {
                if let reds = round.firstMatch(of: /(\d*) red/) {
                    min_red = max(min_red, Int(reds.1)!)
                }
                
                if let greens = round.firstMatch(of: /(\d*) green/) {
                    min_green = max(min_green, Int(greens.1)!)
                }
                
                if let blues = round.firstMatch(of: /(\d*) blue/) {
                    min_blue = max(min_blue, Int(blues.1)!)
                }
            }
            
            return min_red * min_blue * min_green
        })
        
        return minValuesPerGame.reduce(0, {$0 + $1})
    }
}
