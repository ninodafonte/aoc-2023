Advent of code 2023
===================

This year I wanted to give Swift a try, even though I have no experience at all.
I know it's going to be tricky but all that matters is the learning part so, no fear!

I'll be updating this README file with my learning during these days.

# Table of Contents
1. [Preliminary work and learnings](#preliminary-work-and-learnings)
2. [Day 1](#day-1-part-1)
3. [Day 2](#day-2-part-1)
4. [Day 3](#day-3-part-1)
5. [Day 4](#day-4-part-1)
5. [Day 5](#day-5-part-1)
5. [Day 6](#day-6-part-1)

## Preliminary work and learnings

Usually, with the first challenge you need to write some common code to load data from a file in the filesystem, and perform a bunch of string operations on each one of the lines, at least that's the deal with most of the challenges.

The learning here: Swift is VERY VERY picky about how and where to load files from disk. I imagine related to how the apps are packaged, knowing that you need a bundle, include things there and so on. 

So, the simples approach that I found was to create a folder in your ~/Documents folder, called aoc2023 and drop the data files there. Not easy but way EASIER than any other approach including your files in a bundle (because usually you have only one bundle -main- but in my case, as I wanted to have unit tests, I have more than one bundle... well, a bit of a mess).

Once I had the data, I've discovered the beauty (and crazyness) of Swift String handling. There are amazing things related to array slices, Strings, SubStrings, Ranges ... It's really powerful, and really dissapointing for newbies, as to find some occurrences in a string and do some replacements you need a year-long master's degree about Strings in Swift. 

But hey, that's what we are here for, so bring it on!

## Day 1 Part 1

Once that was solved, the challenge was easy. The algorithm goes along the lines of:

- Load the file
- Transform each line:
    - Convert to a string array but only the integers.
    - Clean up the array (anything that it's not an int it's an empty element in the array)
    - Get first and last index and sum them up.
    - Keep a total counter and return it.
    
## Day 1 Part 2

Very similar to part 1 but with some additions:

- I've declared an array with the numbers in words, so I can iterate and find them in each line.
- Once I get each line, I get all the occurrences of one number and add the lowerbound position and the index where the number in words is in the original array.


    Example:  

        Master array: ["zero", "one", "two", "three" ...]
        Original line: "abctwothreetwo" creates these entries in the dictionary: 
        
        - [3] => 2 (first t of two and "2" because "two" is the index 2 in the master array)
        - [6] => 3 (first t of three and "3" because "three" is the index 3 in the master array)
        - [11] => 2 (second occurrence of two in index 11 and "2" because "two" is the index 2 in the master array)

- As it's a non destructive operation, I can handle all occurrences, including those with "twone", that are a bit tricky.
- Once I have the dictionary with all the data per line, just replace the items, changing the first letter for the number. 

    Following the previous example:

        "abctwothreetwo" -> "abc2wo3hree2wo"

- Now I just apply the same process than in part 1 getting rid of the non-integers and it's done.

Day 1 code can be found in [here](/Sources/Day01.swift)

## Day 2 Part 1

Mr. David Olivé brought to my attention the existance of a template created by Apple to run the Advent of Code in an easier way so I downloaded it and apply it to this next day. It works great and simplify a lot of operations.

In my (very short) experience with Swift, it looks like instead of creating a framework (to be able to host code and tests in the same place), it's build as a package, so it's way simpler to run and try things in XCode and in the console. New learnings!

Coming back to this second day, the learnings are around using RegExs and maps in Swift. Using a map, I iterate each game, taking the game number and analyzing each one of the rounds. I start with a "drop" flag to false and check each color. If any color in any round goes out of the MAX number for that color, I "drop" the game.

Then, running a reduce with the array of valid games (the numbers of the valid games), done ✅
    
## Day 2 Part 2

Nothing very difficult once the part 1 was done.

- Initialize a min red, blue and green to 1 (as we are using powers, that doesn't create any differences, 0 is dead)
- Using the same regexs to check each one of the rounds and colors but this time just running a max function to see if the current color in that round is greater than the last one. If it's the case, we save it. 
- Return the updated values for min colors
- Reduce the array with the powers of colors in each game

Day 2 code can be found in [here](/Sources/Day02.swift)

## Day 3 Part 1

Started very well trying a (probably) different idea than usual to solve it. I've created an overlay with the blast radius of the symbols (sort of minesweeper effect) so, once I start iterating over the main matrix to get the numbers, I just need to check if the same coordinate is in the overlay with the blast radius. I liked it and it worked, although the code is very rough (meaning BAD) in terms of finding adjacent elements.
    
## Day 3 Part 2

I got a bit desperate trying to solve this one. Probably not my best day. Nevertheless, at the end it worked well. I've cleaned up the code a bit (using an adjacent matrix to make it easy) and following simple steps:

- Iterate the main matrix
- If I find a number, I check if it's adjacent to an *. 
- If it is, I save the position of the star and the number in a dictionary.
- I keep adding the numbers to the right key in the dictionary so at the end I have a coord of a "gear" as the key and the numbers linked to it as values.
- Finally, easy, filter only the ones with a count of 2 (two numbers linked to the gear), map to multiply and reduce to sum it up.

Day 3 code can be found in [here](/Sources/Day03.swift)

## Day 4 Part 1

Once I fought with RegEx and parsing data in previous days, this one was extremely easy.

- RegEx the hell of it to get the winning numbers and my numbers.
- Intersect the arrays and use power of 2 to get the points and add it to the total
     
## Day 4 Part 2

A bit more tricky this time. Extending the previous solution with a caveat:

- For each line, count the points and add the copies of the cloned scratchpads to a new array.
- Also, in every iteration after the first one, take into account not only the points from the original but also the ones of the cloned ones (in the clone array I inserted the index of the card so I can "remember" what are the source of the cloned scratchpads)
- Count the cloned ones at the end and add the original ones.

The execution was quite intense for this part 2. That led me to see the difference between executing the build in debug mode or in release mode. Quite a difference in performance. To take into account in future days with more constraints.

Example of performance:

![Example of performance Day 4](/docs/day4-benchmark.png)

Day 4 code can be found in [here](/Sources/Day04.swift)

## Day 5 Part 1

To make it a bit more interesting I decided to create a mini-state-machine inside the iterator to parse the data.

After everything was in their arrays, it was easy to apply the transformation as a pipeline in all the jumps until reaching the location coordinates. Then getting the min of the array and solved.
     
## Day 5 Part 2

The main difference here was to find a clever way to process the ranges. I didn't 🤷‍♂️.
Tried the brute-force procedure (removing the duplicates at least with the standard Array(Set(Array))) and it took a while, but it got the job done. 

Example of performance:

![Example of performance Day 5](/docs/day5-benchmark.png)

Day 5 code can be found in [here](/Sources/Day05.swift)

## Day 6 Part 1

Quite basic puzzle (or I was having a good day!). A bit of parsing to get the times and the distances. Then creating a function to calculate the options, this one:

    func calculateOptions(seconds: Int, distanceToBeat: Int) -> Int {
        var validOptions = 0
        for i in 1...seconds {
            let option = i * (seconds - i)
            if (option > distanceToBeat) { validOptions += 1 }
        }
        
        return validOptions
    }
    
And that was it.
     
## Day 6 Part 2

Easy one, just had to tweak the two lines to parse the lines at the beginning and the rest was exactly the same.

Day 6 code can be found in [here](/Sources/Day06.swift)



----------------------------------------------------------------


Notes from the original template as reference 
---------------------------------------------------
# Advent of Code Swift Starter Project

[![Language](https://img.shields.io/badge/language-Swift-red.svg)](https://swift.org)

Daily programming puzzles at [Advent of Code](<https://adventofcode.com/>), by
[Eric Wastl](<http://was.tl/>). This is a small example starter project for
building Advent of Code solutions.

## Usage

Swift comes with Xcode, or you can [install it](https://www.swift.org/install/)
on a supported macOS, Linux, or Windows platform. 

If you're using Xcode, you can open this project by choosing File / Open and
select the parent directory. 

If you prefer the command line, you can run the test suite with `swift test`,
and run the output with `swift run`.

If you're using Visual Studio Code to edit, you might find these Swift
extensions useful:

- [Swift](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang)
  (provides core language edit / debug / test features)
- [apple-swift-format](https://marketplace.visualstudio.com/items?itemName=vknabel.vscode-apple-swift-format)
  (supports the [swift-format](https://github.com/apple/swift-format) package)

## Challenges

The challenges assume three files (replace 00 with the day of the challenge).

- `Data/Day00.txt`: the input data provided for the challenge
- `Sources/Day00.swift`: the code to solve the challenge
- `Tests/Day00.swift`: any unit tests that you want to include

To start a new day's challenge, make a copy of these files and update as
necessary. The `AdventOfCode.swift` file controls which day's challenge is run
with `swift run`. By default that runs the most recent challenge in the package.

To supply command line arguments use `swift run AdventOfCode`. For example,
`swift run -c release AdventOfCode --benchmark 3` builds the binary with full
optimizations, and benchmarks the challenge for day 3.

## Linting and Formatting

Challenge source code can be linted and formatted automatically using the
included dependency on `swift-format`.

Lint source code with the following command:

```shell
$ swift package lint-source-code
```

Format source code with the following command:

```shell
$ swift package format-source-code
Plugin ‘Format Source Code’ wants permission to write to the package directory.
Stated reason: “This command formats the Swift source files”.
Allow this plugin to write to the package directory? (yes/no)
```

To avoid the interactive prompt when formatting source code, use the 
`--allow-writing-to-package-directory` flag.
 
```shell
$ swift package format-source-code --allow-writing-to-package-directory
```

swift-format will use the built-in default style to lint and format code. A
`.swift-format` configuration file can be used to customize the style used, see
[Configuration](https://github.com/apple/swift-format/blob/main/Documentation/Configuration.md)
for more details. 
