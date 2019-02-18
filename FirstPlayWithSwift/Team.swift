//
//  Team.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 02/02/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//
import Foundation

class Team {
    var teamName: String
    var arrayAvatars: [Avatar]
    
    init(teamName: String) {
        self.teamName = teamName
        arrayAvatars = []
        
    }
    
    //  function to add avatar in team
    func addAvatar(avatar: Avatar) {
        arrayAvatars.append(avatar)
        
    }
    
    //    MARK: group team check
    //  function to check at least one avatar is still alive in team
    func checkTeam() -> Bool {
        
        for item in arrayAvatars {
            if item.life > 0 {
                return true
            }
        }
        return false
    }
    
    //  function to check for duplicate name of avatar
    func checkForDuplicate(avatarName: String) -> Bool {
        
        for item in arrayAvatars {
            if item.avatarName == avatarName {
                return false
            }
        }
        return true
    }
    
    //  function to check for existing Magus in team
    func checkForMagus() -> Bool {
        
        for item in arrayAvatars {
            if item.avatarType.avatarTypeName != "Mage" {
                return false
            }
        }
        return true
    }
    
    //  function to display avatars of team when team has been fully created
    func printAvatarTeam() {
        
        print("")
        for numberAvatar in 0...2 {
            printAvatar(numberAvatar: numberAvatar)
        }
        print("")
    }
    
    //  function to display one avatar
    func printAvatar(numberAvatar: Int) {
        
        var weaponDescription: String = ""   // to distinguish damage of wepaon between fighter or magus
        var attackType: String = ""          // to distinguish type of wepaon between fighter or magus
        
        switch arrayAvatars[numberAvatar].attack {
        case true:
            attackType = "Dégâts de son arme :"
            weaponDescription = "- Arme :"
        case false:
            attackType = "Soigne avec :"
            weaponDescription = "- Soigneur :"
        }
        print("\(arrayAvatars[numberAvatar].avatarName) : \(arrayAvatars[numberAvatar].avatarType.avatarTypeName) \(weaponDescription) \(arrayAvatars[numberAvatar].weapon.weaponName) - \(arrayAvatars[numberAvatar].life) points de vie - \(attackType) \(arrayAvatars[numberAvatar].weapon.damage) points de vie")
    }
    
    //    MARK: group team attack
    /*    function attack
     determine Fighter by calling function choiceAvatar
     determine Adversary by calling function choiceAvatar
     call attackAvatar with Fighter and Adversary
     verify looser by calling function checkTeam
     */
    func attack(teamAgainst: Team) -> String {
        
        var typeCall: String           // to distinguish type of call : fighter or adversary
        var description: String        // to distinguish description for type of call : fighter or adversary
        let teamAgainst = teamAgainst  // team attacked
        
        let teamFrom = self
        
        typeCall = "Fighter"
        description = "\(self.teamName) avec quel personnage voulez-vous attaquer ?"
        let fighter = self.choiceAvatar(team: teamFrom, description: description, typeCall: typeCall)
        
        let randomNumber = Int.random(in: 0..<99) % 9
        
        if randomNumber == 0 {
            changeWeaponAvatar(avatar: fighter)
        }
        
        typeCall  = "Adversary"
        description = "\(self.teamName), Quel personnage voulez-vous attaquer ?"
        let adversary = self.choiceAvatar(team: teamAgainst, description: description, typeCall: typeCall)
        
        fighter.attackAvatar(avatar: adversary)
        
        if adversary.life == 0 {
            print("")
            print("Equipe \(teamAgainst.teamName) vient de perdre le personnage \(adversary.avatarName).")
            print("")
        }
        
        let looser = teamAgainst.checkTeam()
        
        if looser == false {
            return "Le vainqueur de ce combat est \(teamFrom.teamName)"
        } else {
            return ""
        }
        
    }
    
    /*    function to select avatar depending on type of call
     3 types of call
     Fighter in order to determine avatar fightering
     Adversary in order to determine avatar attacked
     Care in order to determine avatar to be care
     */
    private func choiceAvatar(team: Team, description: String, typeCall: String) -> Avatar {
        var userChoice: Int
        var numberOfAvatarSelect: Int = 0
        let teamSelect = team
        let description = description
        let typeCall = typeCall

        var arrayAvatarsChoice = [1: 0, 2: 0, 3:0]
        
        print("")
        print(description)
        print("")

        for numberAvatar in 0...2 {
            switch typeCall {
            case "Fighter":
                if teamSelect.arrayAvatars[numberAvatar].life > 0 && teamSelect.arrayAvatars[numberAvatar].attack == true {
                    numberOfAvatarSelect += 1
                    print("   \(numberOfAvatarSelect) -", terminator: " "); teamSelect.printAvatar(numberAvatar: numberAvatar)
                    arrayAvatarsChoice[numberOfAvatarSelect]! += numberAvatar
                }
            case "Adversary":
                if teamSelect.arrayAvatars[numberAvatar].life > 0 {
                    numberOfAvatarSelect += 1
                    print("   \(numberOfAvatarSelect) -", terminator: " "); teamSelect.printAvatar(numberAvatar: numberAvatar)
                    arrayAvatarsChoice[numberOfAvatarSelect]! += numberAvatar
                }
            case "Care":
                if teamSelect.arrayAvatars[numberAvatar].life < teamSelect.arrayAvatars[numberAvatar].lifeInitial {
                    numberOfAvatarSelect += 1
                    print("   \(numberOfAvatarSelect) -", terminator: " "); teamSelect.printAvatar(numberAvatar: numberAvatar)
                    arrayAvatarsChoice[numberOfAvatarSelect]! += numberAvatar
                }
            default:
                break
            }
        }
  
        print("")
        
        repeat {
            userChoice = inputInteger()
            print("")
            switch userChoice {
            case 1...numberOfAvatarSelect:
                break
            default:
                print(Errors.selectAvatar.rawValue)
            }
        } while userChoice < 1 || userChoice > numberOfAvatarSelect
        
        let avatarSelected = team.arrayAvatars[arrayAvatarsChoice[userChoice]!]
        
        print("Vous avez choisi le personnage : \(avatarSelected.avatarName)")
        
        return avatarSelected
            }
    
    /*    function to change weapon at random
            depending of avatar type
            mage
                --> increase of care by random access to an array containing different care
            otherwise
                --> change of weapon by random access to an array containing new weapons
     */
    private func changeWeaponAvatar(avatar: Avatar) {
        
        let avatar = avatar
        let weaponRandomArray = [Bow(), Sceptre(), Spear(), Sabre(), Dagger() ]
        let careRandomArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        switch avatar.attack {
        case true:
            let randomWeapon = Int(arc4random_uniform(UInt32(weaponRandomArray.count)))
            let weaponSelected = weaponRandomArray[randomWeapon]
            print("""
                Un coffre apparait à vos pieds, saisissez l'arme qu'il contient.
                """)
            print("Votre personnage \(avatar.avatarName) a maintenant une nouvelle arme, \(weaponSelected.weaponName) qui enlève \(weaponSelected.damage) points de vie ")
            avatar.weapon = weaponSelected
            avatar.weapon.damage = weaponSelected.damage
        case false:
            let randomCare = Int(arc4random_uniform(UInt32(careRandomArray.count)))
            let careSelected = careRandomArray[randomCare]
            print("Un coffre apparait à vos pieds, saisissez ce qu'il contient.")
            print("")
            print("Votre mage va pouvoir soigner avec \(careSelected) points de vie supplémentaire.")
            avatar.weapon.damage += careSelected
        }
    }
    
    //    MARK: group team care
    //  function to choice what avatar should be care
    func careChoice() {
        
        var typeCall: String
        var description: String
        
        let teamFrom = self
        
        typeCall = "Care"
        print("")
        description = "\(self.teamName) quel personnage voulez-vous soigner ?"
        let carer = self.choiceAvatar(team: teamFrom, description: description, typeCall: typeCall)
        
        for item in arrayAvatars {
            switch item.avatarType {
            case is Magus:
                carer.care(avatar: item)
            default:
                break
            }
        }
    }
    
    //    MARK: group readline function
    //    Function allowing at user to fill an Integer
    fileprivate func inputInteger() -> Int {
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
}
