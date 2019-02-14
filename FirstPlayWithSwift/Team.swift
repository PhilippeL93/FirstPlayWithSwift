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
    var numberOfAvatar: Int = 3
    
    init(teamName: String) {
        self.teamName = teamName
        arrayAvatars = []    }
    
    func addAvatar(avatar: Avatar) {
        arrayAvatars.append(avatar)
    }
    
    //  check for duplicate name of avatar
    func checkForDuplicate(avatarName: String) -> Bool {
        
        for item in arrayAvatars {
            if item.avatarName == avatarName {
                return false
            }
        }
        return true
    }
    
    //  check for duplicate name of avatar
    func checkForMagus() -> Bool {
        
        for item in arrayAvatars {
            if item.avatarType.avatarTypeName != "Mage" {
                return true
            }
        }
        return false
    }
    
    func printAvatar() {
        
        var weaponDescription: String = ""
        var attackType: String = ""
        
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
            if item.life > 0 {
                print("\(item.avatarName) : \(item.avatarType.avatarTypeName) \(weaponDescription) \(item.weapon.weaponName) - \(item.life) points de vie - \(attackType) \(item.weapon.damage) points de vie")
            }
        }
        print("")
    }
    
    func attack(teamAgainst: Team) -> String {
        //    func attack(teamAgainst: Team) -> Bool {
        
        var typeCall: String
        var description: String
        let teamAgainst = teamAgainst
        
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
            teamAgainst.numberOfAvatar -= 1
            print("")
            print("Equipe \(teamAgainst.teamName) vient de perdre le personnage \(adversary.avatarName).")
            print("")
        }
        
        if teamAgainst.numberOfAvatar > 0 {
            return ""
        } else {
            print("Le vainqueur de ce combat est \(teamFrom.teamName)")
            return "Le vainqueur de ce combat est \(teamFrom.teamName)"
        }
    }
    
    func care() {
        
        var typeCall: String
        var description: String
        var careDone: Int = 0
        
        let teamFrom = self
        
        typeCall = "Care"
        description = "\(self.teamName) quel personnage voulez-vous soigner ?"
        let carer = self.choiceAvatar(team: teamFrom, description: description, typeCall: typeCall)
        
        for item in arrayAvatars {
            switch item.avatarType {
            case is Mage:
                careDone = item.weapon.damage
            default:
                break
            }
        }
        carer.life += careDone
        
        if carer.life > carer.lifeInitial {
            carer.life = carer.lifeInitial
        }
        print("Le personnage \(carer.avatarName) a été soigné et a maintenant \(carer.life) points de vie")
    }
    
    private func changeWeaponAvatar(avatar: Avatar) {
        
        let avatar = avatar
        let weaponArray = [Arc(), Sceptre(), Lance(), Sabre(), Dague() ]
        
        switch avatar.attack {
        case true:
            let randomWeapon = Int(arc4random_uniform(UInt32(weaponArray.count)))
            let weaponSelected = weaponArray[randomWeapon]
            print("Un coffre apparait à vos pieds, saisissez l'arme qu'il contient.")
            print("")
            print("Votre personnage \(avatar.avatarName) a maintenant une nouvelle arme \(weaponSelected.weaponName) qui enlève \(weaponSelected.damage) points de vie ")
            avatar.weapon = weaponSelected
            avatar.weapon.damage = weaponSelected.damage
        case false:
            print("Votre mage va pouvoir soigner avec 10 points de vie au lieu de 5")
            avatar.weapon.damage = 10
        }
    }
    
    private func choiceAvatar(team: Team, description: String, typeCall: String) -> Avatar {
        var userChoice: Int
        var avatarChoice: Int = 0
        var numberOfAvatarInit: Int = 0
        var numberOfAvatarSelect: Int = 0
        let teamSelect = team
        var avatarSelected: Avatar!
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
        // Loop until choice of avatar is OK
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
        avatarSelected = team.arrayAvatars[avatarChoice]
        
        return avatarSelected
    }
    
    // Function allowing at user to fill an Integer
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
