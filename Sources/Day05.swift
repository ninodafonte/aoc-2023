import Foundation

enum Operation {
    case NO_OP
    case SEEDS_ID
    case SEED_TO_SOIL
    case SOIL_TO_FERTILIZER
    case FERTILIZER_TO_WATER
    case WATER_TO_LIGHT
    case LIGHT_TO_TEMP
    case TEMP_TO_HUMIDITY
    case HUMIDITY_TO_LOCATION
}

struct Day05: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        let lines = data.replacingOccurrences(of: "\n\n", with: "\n").split(separator: "\n")
        var operation = Operation.NO_OP
        var seeds = [Int]()
        var seedToSoil = [[Int]]()
        var soilToFert = [[Int]]()
        var fertTowater = [[Int]]()
        var waterToLight = [[Int]]()
        var lightToTemp = [[Int]]()
        var tempToHumidity = [[Int]]()
        var humidityToLocation = [[Int]]()
        var seedSection = ""
        
        for line in lines {
            // Catch seeds line:
            let seedLine = line.firstMatch(of: /seeds:(.*)/)
            if ( seedLine?.1 != nil) {
                operation = Operation.SEEDS_ID
                seedSection = String(seedLine!.1)
            }
                                              
            // Catch seed to soil:
            let seedToSoilLine = line.firstMatch(of: /(seed-to-soil map:)/)
            if (seedToSoilLine?.1 != nil) {
                operation = Operation.SEED_TO_SOIL
                continue
            }
            
            // Catch soil to fert:
            let soilToFertLine = line.firstMatch(of: /(soil-to-fertilizer map:)/)
            if (soilToFertLine?.1 != nil) {
                operation = Operation.SOIL_TO_FERTILIZER
                continue
            }
            
            // Catch fert to water:
            let seedToFertLine = line.firstMatch(of: /(fertilizer-to-water map:)/)
            if (seedToFertLine?.1 != nil) {
                operation = Operation.FERTILIZER_TO_WATER
                continue
            }
            
            // Catch water to light:
            let waterToLightLine = line.firstMatch(of: /(water-to-light map:)/)
            if (waterToLightLine?.1 != nil) {
                operation = Operation.WATER_TO_LIGHT
                continue
            }
            
            // Catch light to temp:
            let lightToTempLine = line.firstMatch(of: /(light-to-temperature map:)/)
            if (lightToTempLine?.1 != nil) {
                operation = Operation.LIGHT_TO_TEMP
                continue
            }
            
            // Catch temp to humidity:
            let tempToHumidityLine = line.firstMatch(of: /(temperature-to-humidity map:)/)
            if (tempToHumidityLine?.1 != nil) {
                operation = Operation.TEMP_TO_HUMIDITY
                continue
            }
            
            // Catch humidity to location:
            let humToLocationLine = line.firstMatch(of: /(humidity-to-location map:)/)
            if (humToLocationLine?.1 != nil) {
                operation = Operation.HUMIDITY_TO_LOCATION
                continue
            }
            
            switch (operation) {
            case Operation.SEEDS_ID:
                seeds = seedSection.split(separator: " ").map({ Int($0)! })
                break
            case Operation.SEED_TO_SOIL:
                seedToSoil.append(extractElements(text: line))
                break
            case Operation.SOIL_TO_FERTILIZER:
                soilToFert.append(extractElements(text: line))
                break
            case Operation.FERTILIZER_TO_WATER:
                fertTowater.append(extractElements(text: line))
                break
            case Operation.WATER_TO_LIGHT:
                waterToLight.append(extractElements(text: line))
                break
            case Operation.LIGHT_TO_TEMP:
                lightToTemp.append(extractElements(text: line))
                break
            case Operation.TEMP_TO_HUMIDITY:
                tempToHumidity.append(extractElements(text: line))
                break
            case Operation.HUMIDITY_TO_LOCATION:
                humidityToLocation.append(extractElements(text: line))
                break
            case Operation.NO_OP:
                break
            }
        }
        
        // Let's do the math:
        let seedsToSoilTranslated = translate(seeds: seeds, rules: seedToSoil)
        let soilToFertTranslated = translate(seeds: seedsToSoilTranslated, rules: soilToFert)
        let fertToWaterTranslated = translate(seeds: soilToFertTranslated, rules: fertTowater)
        let waterToLightTranslated = translate(seeds: fertToWaterTranslated, rules: waterToLight)
        let lightToTempTranslated = translate(seeds: waterToLightTranslated, rules: lightToTemp)
        let tempToHumidityTranslated = translate(seeds: lightToTempTranslated, rules: tempToHumidity)
        let humidityToLocationTranslated = translate(seeds: tempToHumidityTranslated, rules: humidityToLocation)                
        
        return humidityToLocationTranslated.min()!
    }
    
    func translate(seeds: [Int], rules: [[Int]]) -> [Int] {
        var translation = [Int]()
        
        // crack the ranges:
        for seed in seeds {
            var rangeFound = false
            for rule in rules {
                let sourceRangeStarts = rule[1]
                let destRangeStarts = rule[0]
                let offset = rule[2]
                
                if (seed >= sourceRangeStarts && seed < sourceRangeStarts + offset) {
                    let distance = seed - sourceRangeStarts
                    translation.append(destRangeStarts + distance)
                    rangeFound = true
                }
            }
            
            if (!rangeFound) {
                translation.append(seed)
            }
        }
        
        return translation
    }
    
    func extractElements(text: Substring) -> [Int] {
        let currentLine = text.split(separator: " ").map({ Int($0)! })
        var elems = [Int]()
        for elem in currentLine {
            elems.append(elem)
        }
        
        return elems
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let lines = data.replacingOccurrences(of: "\n\n", with: "\n").split(separator: "\n")
        var operation = Operation.NO_OP
        var seeds = [Int]()
        var seedToSoil = [[Int]]()
        var soilToFert = [[Int]]()
        var fertTowater = [[Int]]()
        var waterToLight = [[Int]]()
        var lightToTemp = [[Int]]()
        var tempToHumidity = [[Int]]()
        var humidityToLocation = [[Int]]()
        var seedSection = ""
        
        for line in lines {
            // Catch seeds line:
            let seedLine = line.firstMatch(of: /seeds:(.*)/)
            if ( seedLine?.1 != nil) {
                operation = Operation.SEEDS_ID
                seedSection = String(seedLine!.1)
            }
                                              
            // Catch seed to soil:
            let seedToSoilLine = line.firstMatch(of: /(seed-to-soil map:)/)
            if (seedToSoilLine?.1 != nil) {
                operation = Operation.SEED_TO_SOIL
                continue
            }
            
            // Catch soil to fert:
            let soilToFertLine = line.firstMatch(of: /(soil-to-fertilizer map:)/)
            if (soilToFertLine?.1 != nil) {
                operation = Operation.SOIL_TO_FERTILIZER
                continue
            }
            
            // Catch fert to water:
            let seedToFertLine = line.firstMatch(of: /(fertilizer-to-water map:)/)
            if (seedToFertLine?.1 != nil) {
                operation = Operation.FERTILIZER_TO_WATER
                continue
            }
            
            // Catch water to light:
            let waterToLightLine = line.firstMatch(of: /(water-to-light map:)/)
            if (waterToLightLine?.1 != nil) {
                operation = Operation.WATER_TO_LIGHT
                continue
            }
            
            // Catch light to temp:
            let lightToTempLine = line.firstMatch(of: /(light-to-temperature map:)/)
            if (lightToTempLine?.1 != nil) {
                operation = Operation.LIGHT_TO_TEMP
                continue
            }
            
            // Catch temp to humidity:
            let tempToHumidityLine = line.firstMatch(of: /(temperature-to-humidity map:)/)
            if (tempToHumidityLine?.1 != nil) {
                operation = Operation.TEMP_TO_HUMIDITY
                continue
            }
            
            // Catch humidity to location:
            let humToLocationLine = line.firstMatch(of: /(humidity-to-location map:)/)
            if (humToLocationLine?.1 != nil) {
                operation = Operation.HUMIDITY_TO_LOCATION
                continue
            }
            
            switch (operation) {
            case Operation.SEEDS_ID:
                let tempSeeds = seedSection.split(separator: " ").map({ Int($0)! })
                for i in stride(from: 0, to: tempSeeds.count, by: 2) {
                    for x in tempSeeds[i]..<(tempSeeds[i] + tempSeeds[i + 1]) {
                        seeds.append(x)
                    }
                }
                seeds = Array(Set(seeds))
                break
            case Operation.SEED_TO_SOIL:
                seedToSoil.append(extractElements(text: line))
                break
            case Operation.SOIL_TO_FERTILIZER:
                soilToFert.append(extractElements(text: line))
                break
            case Operation.FERTILIZER_TO_WATER:
                fertTowater.append(extractElements(text: line))
                break
            case Operation.WATER_TO_LIGHT:
                waterToLight.append(extractElements(text: line))
                break
            case Operation.LIGHT_TO_TEMP:
                lightToTemp.append(extractElements(text: line))
                break
            case Operation.TEMP_TO_HUMIDITY:
                tempToHumidity.append(extractElements(text: line))
                break
            case Operation.HUMIDITY_TO_LOCATION:
                humidityToLocation.append(extractElements(text: line))
                break
            case Operation.NO_OP:
                break
            }
        }
        
        // Let's do the math:
        let seedsToSoilTranslated = translate(seeds: seeds, rules: seedToSoil)
        let soilToFertTranslated = translate(seeds: seedsToSoilTranslated, rules: soilToFert)
        let fertToWaterTranslated = translate(seeds: soilToFertTranslated, rules: fertTowater)
        let waterToLightTranslated = translate(seeds: fertToWaterTranslated, rules: waterToLight)
        let lightToTempTranslated = translate(seeds: waterToLightTranslated, rules: lightToTemp)
        let tempToHumidityTranslated = translate(seeds: lightToTempTranslated, rules: tempToHumidity)
        let humidityToLocationTranslated = translate(seeds: tempToHumidityTranslated, rules: humidityToLocation)
        
        return humidityToLocationTranslated.min()!
    }
}
