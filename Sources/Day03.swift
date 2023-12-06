import Algorithms
import Foundation

extension String {
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
}

struct Day03: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String    

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        let lines = data.split(separator: "\n")
        var matrix = [[String.SubSequence]]()
        for line in lines {
            matrix.append(line.split(separator: ""))
        }
        
        // Create a map/layer with the protected positions on the array
        var blastArea = Array(repeating: Array(repeating: "N", count: matrix.count), count: matrix[0].count)
        
        for x in 0..<matrix.count {
            for y in 0..<matrix[x].count {
                let tempChar = String(matrix[x][y])
                if (!tempChar.isNumber && tempChar != ".") {
                    let value = "Y"
                    blastArea[x][y] = value
                    
                    // Up
                    if (((x - 1) >= 0)) {
                        blastArea[x - 1][y] = value
                    }
                    // Down
                    if (((x + 1) < matrix.count)) {
                        blastArea[x + 1][y] = value
                    }
                    // Left
                    if (((y - 1) >= 0)) {
                        blastArea[x][y - 1] = value
                    }
                    // Right
                    if (((y + 1) < matrix[x].count)) {
                        blastArea[x][y + 1] = value
                    }
                    // Up-left
                    if (((x - 1) >= 0) && (y - 1 >= 0)) {
                        blastArea[x - 1][y - 1] = value
                    }
                    // Up-right
                    if (((x + 1) < matrix.count) && (y - 1 >= 0)) {
                        blastArea[x + 1][y - 1] = value
                    }
                    // Down-left
                    if (((x - 1) >= 0) && (y + 1 < matrix[x].count)) {
                        blastArea[x - 1][y + 1] = value
                    }
                    // Down-right
                    if (((x + 1) < matrix.count) && (y + 1 < matrix[x].count)) {
                        blastArea[x + 1][y + 1] = value
                    }
                }
            }
        }
        
        // Validate each number against the blastRadius mapping:
        var validNumbers = [Int]()
        
        var firstNumberPos = -1
        var keepLooking = true
        for x in 0..<matrix.count {
            for y in 0..<matrix[x].count {
                let tempChar = String(matrix[x][y])
                if (!tempChar.isNumber && firstNumberPos == -1) { continue }
                
                if (tempChar.isNumber) {
                    if (firstNumberPos == -1) {
                        firstNumberPos = y
                    }
                    
                    keepLooking = true
                } else {
                    keepLooking = false
                }
                
                if ((y + 1) == matrix[x].count) {
                    keepLooking = false
                }
                
                if (!keepLooking) {
                    var tempNumber = ""
                    var banned = true
                    let lastPos = (y == matrix[x].count - 1) ? y : y - 1
                    for z in firstNumberPos...lastPos {
                        if (blastArea[x][z] == "Y") {
                            banned = false
                        }
                        tempNumber += String(matrix[x][z])
                    }
                    
                    if (!banned) {
                        let intsOnly = tempNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).filter({ $0 != ""}).joined()
                        validNumbers.append(Int(intsOnly)!)
                    }
                    
                    firstNumberPos = -1
                }
            }
        }
        
        return validNumbers.reduce(0, {$0 + $1})
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let lines = data.split(separator: "\n")
        var matrix = [[String.SubSequence]]()
        for line in lines {
            matrix.append(line.split(separator: ""))
        }
        
        var validGears: [[Int]: [Int]] = [:]
        var firstNumberPos = -1
        var keepLooking = true
        for x in 0..<matrix.count {
            for y in 0..<matrix[x].count {
                let tempChar = String(matrix[x][y])
                if (!tempChar.isNumber && firstNumberPos == -1) { continue }
                
                if (tempChar.isNumber) {
                    if (firstNumberPos == -1) {
                        firstNumberPos = y
                    }
                    
                    keepLooking = true
                } else {
                    keepLooking = false
                }
                
                if ((y + 1) == matrix[x].count) {
                    keepLooking = false
                }
                
                if (!keepLooking) {
                    var tempNumber = ""
                    var linked = false
                    var selectedGear = [-1, -1]
                    let lastPos = (y == matrix[x].count - 1) ? y : y - 1
                    for z in firstNumberPos...lastPos {
                        let linkedGear = isLinkedToGear(matrix: matrix, pos: [x, z])
                        if ((linkedGear[0] != -1) && (linkedGear[1] != -1)) {
                            if (!linked) {
                                linked = true
                                selectedGear = linkedGear
                            }
                        }
                        tempNumber += String(matrix[x][z])
                    }
                    
                    if (linked) {
                        let intsOnly = tempNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).filter({ $0 != ""}).joined()
                        var currentNumbersForGear = validGears[selectedGear]
                        if (currentNumbersForGear == nil) { currentNumbersForGear = [Int]() }
                        currentNumbersForGear?.append(Int(intsOnly)!)
                        validGears.updateValue(currentNumbersForGear!, forKey: selectedGear)
                    }
                    
                    firstNumberPos = -1
                }
            }
        }
        
        return validGears.filter({ $0.value.count == 2 }).map({ $0.value.reduce(1, *)}).reduce(0, +)                
    }
    
    func isLinkedToGear(matrix: [[String.SubSequence]], pos: [Int]) -> [Int] {
        let checks = [
            [1, 0],
            [-1, 0],
            [0, 1],
            [0, -1],
            [-1, 1],
            [1, 1],
            [1, -1],
            [-1, -1],
        ]
        
        for check in checks {
            let posToTest = [pos[0] + check[0], pos[1] + check[1]]
            if (
                (posToTest[0] >= 0) &&
                (posToTest[0] < matrix.count) &&
                (posToTest[1] < matrix[posToTest[0]].count) &&
                (posToTest[1] >= 0)
            ) {
                if (String(matrix[posToTest[0]][posToTest[1]]) == "*") {
                    return posToTest
                }
            }
        }
        
        return [-1, -1]
    }
    
    /*
    func getCompleteNumberFrom(matrix: [[String.SubSequence]], pos: [Int]) -> Int {
        var fullNumber = ""
        // Find forward:
        var x = pos[0]
        var y = pos[1]
        var keepLooking = true
        while (keepLooking) {
            if (y < matrix[x].count) {
                if (String(matrix[x][y]).isNumber) {
                    fullNumber += String(matrix[x][y])
                    y += 1
                } else {
                    keepLooking = false
                }
            }
        }
        
        // Find backwards:
        x = pos[0]
        y = pos[1] - 1
        keepLooking = true
        var tempNumber = [String]()
        while (keepLooking) {
            if (y >= 0) {
                if (String(matrix[x][y]).isNumber) {
                    tempNumber.append(String(matrix[x][y]))
                    y -= 1
                } else {
                    keepLooking = false
                }
            }
        }
        tempNumber.reverse()
        fullNumber = tempNumber.joined() + fullNumber
        
        
        return Int(fullNumber)!
    }
     */
}
