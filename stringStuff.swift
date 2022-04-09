//
//  stringStuff.swift
//
//  Created by Liam Csiffary
//  Created on 2022-04-08
//  Version 1.0
//  Copyright (c) 2022 IMH. All rights reserved.
//
// The stringStuff program takes input from a txt file
// of string, it then expands these strings based on the
// rules outlined on the course website
// it prints these to the console and a txt file.
//

import Foundation


// reads the txt file
// code from
// https://forums.swift.org/t/read-text-file-line-by-line/28852/4
func readFile(_ path: String) -> [String] {
  var arrayOfStrings: [String] = []
  if freopen(path, "r", stdin) == nil {
    perror(path)
    return []
  }
  while let line = readLine() {
    arrayOfStrings.append(String(line))
    //do something with lines..
  }
  return arrayOfStrings
}

// writes the txt file
func writeTxt(from recArray:[String]) {

  // turns the contents of the array into a string
  var str = ""
  for info in recArray {
    str += info + "\n"
  }

  // https://stackoverflow.com/questions/55870174/how-to-create-a-csv-file-using-swift
  let filePath = NSHomeDirectory() + "/Assigns/Assign-02-Swift/expandedStrings.txt"
  if (FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)) {
    print("File created successfully.")
  } else {
    print("File not created.")
  }

  // https://stackoverflow.com/questions/24410473/how-to-convert-this-var-string-to-url-in-swift
  let filename = URL(fileURLWithPath: filePath)
  print(filename)

  // https://www.hackingwithswift.com/example-code/strings/how-to-save-a-string-to-a-file-on-disk-with-writeto
  do {
    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
  } catch {
    // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
    print("failed")
  } 
}

// expands the condensed string
func StringExpander(condensed: String) -> String {
  // define vars
  var expandedStr = ""
  let arrayOfString = Array(condensed)

  // for each letter in the string
  for (i, each) in arrayOfString.enumerated() {
    // converts from a string.element (char) to a string
    // you can't convert or += string.elements
    // in the same way
    let stringEach = String(each)
    
    // try to make it a number
    let currentNum = Int(stringEach) ?? -1

    // if it's not a number
    if (currentNum == -1) {
      expandedStr += stringEach

    // otherwise add the next letter number value
    // number of times
    } else {
      if (i < arrayOfString.count - 1) {
        for _ in 0..<currentNum {
          expandedStr += String(arrayOfString[i + 1])
        }
      }
    }
  }
  // return the expanded string to main
  return expandedStr
}

// main function
func main() {
  // gets the arrays from the txt files
  let file = "condensedStrings.txt"
  let condensedStrings: [String] = readFile(file)

  // empty array to be populated
  var expandedStrings: [String] = []

  // passes each in the array to the expander function
  for each in condensedStrings {
    // gets and adds the result to the formerly
    // empty array
    let expandedString = StringExpander(condensed: each)
    expandedStrings.append(expandedString)
    print("Original string:", each)
    print("Expanded string:", expandedString, "\n")
  }

  // writes it all to a txt file
  writeTxt(from: expandedStrings)
}

// starts the program
main()
