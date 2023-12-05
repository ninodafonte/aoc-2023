Advent of code 2023
===================

This year I wanted to give Swift a try, even though I have no experience at all.
I know it's going to be tricky but all that matters is the learning part so, no fear!

I'll be updating this README file with my learning during these days.

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

Day 1 code can be found in [here](/aoc_2023_Framework/day1.swift)


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
