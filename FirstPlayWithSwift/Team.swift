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
            if item.avatarType.avatarTypeName == "Mage" {
                return true
            }
        }
        return false
    }
    
//  function to display avatars of team when team has been fully created
    func printAvatar() {
        
        var weaponDescription: String = ""   // to distinguish damage of wepaon between fighter or magus
        var attackType: String = ""          // to distinguish type of wepaon between fighter or magus
        
        print("")
        print("Equipe: \(teamName) est constituée de ")
        print("")
        for item in arrayAvatars {
            
            switch item.attack {
            case true:
                attackType = "Dégâts de son arme :"
                weaponDescription = "- Arme :"
            case false:
                attackType = "Soigne avec :"
                weaponDescription = "- Soigneur :"
            }
//            if item.life > 0 {
                print("\(item.avatarName) : \(item.avatarType.avatarTypeName) \(weaponDescription) \(item.weapon.weaponName) - \(item.life) points de vie - \(attackType) \(item.weapon.damage) points de vie")
//            }
        }
        print("")
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
        
        print("Le personnage \(fighter.avatarName) a attaqué le personnage \(adversary.avatarName) et lui a infligé une perte de \(fighter.weapon.damage) points de vie")
        
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
        var avatarChoice: Int = 0
        var numberOfAvatarInit: Int = 0
        var numberOfAvatarSelect: Int = 0
        let teamSelect = team
        let description = description
        let typeCall = typeCall
        var ind: Int =  0
        
        var arrayAvatarsChoice = [1: 0, 2: 0, 3:0]
        
        print("")
        print(description)
        print("")
        
        for item in teamSelect.arrayAvatars {
            numberOfAvatarInit += 1
            switch typeCall {
            case "Fighter":
                if item.life > 0 && item.attack == true {
                    numberOfAvatarSelect += 1
                    print("\(numberOfAvatarSelect) - \(item.avatarName)  \(item.avatarType.avatarTypeName) - Arme : \(item.weapon.weaponName) - \(item.life) points de vie - Dégâts de son arme : \(item.weapon.damage) points de vie")
                    arrayAvatarsChoice[numberOfAvatarInit]! += numberOfAvatarSelect
                }
            case "Adversary":
                if item.life > 0 {
                    numberOfAvatarSelect += 1
                    print("\(numberOfAvatarSelect) - \(item.avatarName)  \(item.avatarType.avatarTypeName) - Arme : \(item.weapon.weaponName) \(item.life) points de vie - Dégâts de son arme : \(item.weapon.damage) points de vie")
                    arrayAvatarsChoice[numberOfAvatarInit]! += numberOfAvatarSelect
                }
            case "Care":
                if item.life < item.lifeInitial {
                    numberOfAvatarSelect += 1
                    print("\(numberOfAvatarSelect) - \(item.avatarName)  \(item.avatarType.avatarTypeName) - Arme : \(item.weapon.weaponName) - Points de vie : \(item.life)")
                    arrayAvatarsChoice[numberOfAvatarInit]! += numberOfAvatarSelect
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
        
        for item in arrayAvatarsChoice {
            ind += 1
            if userChoice == item.value  {
                avatarChoice = item.key - 1
            }
        }
        let avatarSelected = team.arrayAvatars[avatarChoice]
        
        return avatarSelected
    }

/*    function to change weapon at random
        depending of avatar type
            mage
                --> increase of care
            otherwise
                --> change of weapon by random access to an array containing new weapons
*/
    private func changeWeaponAvatar(avatar: Avatar) {
        
        let avatar = avatar
        let weaponArray = [Bow(), Sceptre(), Spear(), Sabre(), Dagger() ]
        
        switch avatar.attack {
        case true:
            let randomWeapon = Int(arc4random_uniform(UInt32(weaponArray.count)))
            let weaponSelected = weaponArray[randomWeapon]
            print("Un coffre apparait à vos pieds, saisissez l'arme qu'il contient.")
            print("")
            print("Votre personnage \(avatar.avatarName) a maintenant une nouvelle arme, \(weaponSelected.weaponName) qui enlève \(weaponSelected.damage) points de vie ")
            avatar.weapon = weaponSelected
            avatar.weapon.damage = weaponSelected.damage
        case false:
            print("Votre mage va pouvoir soigner avec 10 points de vie au lieu de 5")
            avatar.weapon.damage = 10
        }
    }
    
//    MARK: group team care
//  function to choice what avatar should be care
    func careChoice() {
        
        var typeCall: String
        var description: String
        
        let teamFrom = self
        
        typeCall = "Care"
        description = "\(self.teamName) quel personnage voulez-vous soigner ?"
        let carer = self.choiceAvatar(team: teamFrom, description: description, typeCall: typeCall)
        
        for item in arrayAvatars {
            print(item.avatarName)
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
