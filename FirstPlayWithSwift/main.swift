//
//  main.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 31/01/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//

// Function allowing at user to fill an Integer
func inputInteger() -> Int {
    var strIntReturn: Int = 0
    
    if let strData1 = readLine() {
        if let int = Int(strData1)
        {
            strIntReturn = int
        } else {
            print(Errors.selectANumber.rawValue)
            print("")
        }
    }
    return Int(strIntReturn)
}

// Function allowing at user to fill a String
func inputString() -> String {
    var stringReturn: String = ""
    var inputOk: Bool
    
    repeat {
        inputOk = true
        if let strData2 = readLine() {
            let processed = String(strData2.filter { !" ".contains($0) })
            if processed.count == 0 {
                // print error message
                print("")
                print(Errors.nameEmpty.rawValue)
                inputOk = false
            } else {
                stringReturn = strData2
                inputOk = true
            }
        }
    } while inputOk == false
    
    return (stringReturn)
}

var teamOne: Team
var teamTwo: Team

var game = Game()

game.startPlay()


