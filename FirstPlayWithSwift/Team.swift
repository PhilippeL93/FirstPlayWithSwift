//
//  Team.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 02/02/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//
import Foundation

/* class AvatarType
    define
        teamName : name of team
        arrayAvatars : array containing avatars of team
  */
class Team {
    var teamName: String
    var arrayAvatars: [Avatar]
    
    init(teamName: String) {
        self.teamName = teamName
        arrayAvatars = []
        
    }
    
//  function to add avatar in team array
    func addAvatar(avatar: Avatar) {
        arrayAvatars.append(avatar)
        
    }
    
//    MARK: group team check
/*  function to check at least one avatar is still alive in team
     if at least one avatar is still alive in team
        return true
     otherwise
        return false
     
     */
    func checkTeam() -> Bool {
        
        for item in arrayAvatars {
            if item.life > 0 {
                return true
            }
        }
        return false
    }
   
    
/*  function to check if Magus is still alive
     if magus is still alive in team
        return true
     otherwise
        return false
    */
    func checkTeamMagusAlive() -> Bool {
        
        for item in arrayAvatars {
            switch item.avatarType {
            case is Magus:
                if item.life > 0 {
                    return true
                }
            default:
                break
            }
        }
        return false
    }

/*  function to check if at least one avatar is injured
     if at least one avatar is injured in team
        return true
     otherwise
        return false
    */
    
    func checkTeamAvatarInjure() -> Bool {
        
        for item in arrayAvatars {
            if item.life < item.lifeInitial  && item.life > 0 {
                return true
            }
        }
        return false
    }
    

/*  function to check for duplicate name of avatar
    if name found in team
        return false
    otherwise
        return true
     
    */
    func checkForDuplicateAvatarName(avatarName: String) -> Bool {
        
        for item in arrayAvatars {
            if item.avatarName == avatarName {
                return true
            }
        }
        return false
    }
    
/*  function to check for existing not only Magus in team
     if at least one avatar is not a magus
        return false
     otherwise
        return true
     */
    func checkForMagus() -> Bool {
        
        for item in arrayAvatars {
            if item.avatarType.avatarTypeName != "Mage" {
                return false
            }
        }
        return true
    }

/*  function to display avatars of team when team has been fully created
        for each avatar in team
            call function printAvatar with key of arreyAvatar (0 to 2)
     */
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
        call function to determine randomly a number
            if number is modulo 9
                call function changeWeaponAvatar
        determine Adversary by calling function choiceAvatar
        call attackAvatar with Fighter and Adversary
        verify looser by calling function checkTeam
     */
    func attack(teamAgainst: Team) -> String {
        
        var typeCall: String                    // to distinguish type of call : fighter or adversary
        var description: String                 // to distinguish description for type of call : fighter or adversary
        let teamAgainst = teamAgainst           // team attacked
        
        let teamFrom = self
        
        typeCall = "Fighter"
        description = "\(self.teamName) avec quel personnage voulez-vous attaquer ?"
        let fighter = self.chooseAvatar(team: teamFrom, description: description, typeCall: typeCall)
        
        let randomNumber = Int.random(in: 0..<99) % 9
        
        if randomNumber == 0 {
            changeWeaponAvatar(avatar: fighter)
        }
        
        typeCall  = "Adversary"
        description = "\(self.teamName), Quel personnage voulez-vous attaquer ?"
        let adversary = self.chooseAvatar(team: teamAgainst, description: description, typeCall: typeCall)
        
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
        3 types of call in entry
            Fighter in order to determine avatar fightering
            Adversary in order to determine avatar attacked
            Care in order to determine avatar to be care
        return avatar selected for respective call
     */
    private func chooseAvatar(team: Team, description: String, typeCall: String) -> Avatar {
       
        var userChoice: Int                            // choise avatar by player
        var numberOfAvatarSelect: Int = 0              // number of avatar concerned by typeCall
        var arrayAvatarsChoice = [1: 0, 2: 0, 3:0]     // array to store key of avatars
        
        print("")
        print(description)
        print("")

        for numberAvatar in 0...2 {
            switch typeCall {
            case "Fighter":
                if team.arrayAvatars[numberAvatar].life > 0 && team.arrayAvatars[numberAvatar].attack == true {
                    numberOfAvatarSelect += 1
                    arrayAvatarsChoice[numberOfAvatarSelect]! += numberAvatar
                    print("   \(numberOfAvatarSelect) -", terminator: " "); team.printAvatar(numberAvatar: numberAvatar)
                }
            case "Adversary":
                if team.arrayAvatars[numberAvatar].life > 0 {
                    numberOfAvatarSelect += 1
                    arrayAvatarsChoice[numberOfAvatarSelect]! += numberAvatar
                    print("   \(numberOfAvatarSelect) -", terminator: " "); team.printAvatar(numberAvatar: numberAvatar)
                    }
            case "Care":
                if team.arrayAvatars[numberAvatar].life < team.arrayAvatars[numberAvatar].lifeInitial {
                    numberOfAvatarSelect += 1
                    arrayAvatarsChoice[numberOfAvatarSelect]! += numberAvatar
                    print("   \(numberOfAvatarSelect) -", terminator: " "); team.printAvatar(numberAvatar: numberAvatar)
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
        depending of avatar attack type
            true (concern fighter)
                --> change of weapon by random access to an array containing new weapons
                    change damage of weapon
            false (concern only magus)
                --> increase of care by random access to an array containing different care
        */
    private func changeWeaponAvatar(avatar: Avatar) {
        
        let weaponRandomArray = [Bow(), Sceptre(), Spear(), Sabre(), Dagger() ]     // array containing new weapons
        let careRandomArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]                       // array containing new care
        
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
/*  function to choice what avatar should be care
        call function choiceAvatar to choice avatar to care
        search magus in team in order to have points of life to care
            call function care with avatar to care and magus
     */
    func chooseCare() {
        
        let teamFrom = self
        let typeCall = "Care"
        
        print("")
        let description = "\(self.teamName) quel personnage voulez-vous soigner ?"
        let carer = self.chooseAvatar(team: teamFrom, description: description, typeCall: typeCall)
        
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
    /*    function allowing at player to fill an Integer
     executed until an integer has been filled
     */
    fileprivate func inputInteger() -> Int {
        
        guard let stringRead = readLine(), let numberToReturn = Int(stringRead) else {
            print(Errors.selectANumber.rawValue)
            print("")
            return 0
        }
        return numberToReturn
    }
}
