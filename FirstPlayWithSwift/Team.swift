//
//  Team.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 02/02/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//

class Team {
    var teamName: String
    var arrayAvatars: [Avatar]
    var numberOfAvatar: Int = 3
//    var numberOfAvatarTeamB: Int = 3
//    var array = ["avatarA1": "", "avatarA2": "", "avatarA3":"", "avatarB1":"", "avatarB2": "", "avatarB3": ""]
    
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
    
    func printAvatar() {
        
        var weaponType: String
        print("")
        print("")
        print("Liste des combattants")
        print("")
        print("Equipe: \(teamName) est constituée de ")
        for item in arrayAvatars {
            if item.life > 0 {
                if item.attack == true {
                    weaponType = "Attaque"
                } else {
                    weaponType = "Soigne"
                }
                print("Personnage : \(item.avatarName), \(item.avatarType)", " - Arme : \(item.weapon)", " - Points de vie : \(item.life)", " - action : \(weaponType)")
            }
        }
        print("")
    }
    
    
    func attack(teamAgainst: Team) -> Bool {

        var typeCall: String
        var description: String
        var teamFrom: Team
        let teamAgainst = teamAgainst
        
        teamFrom = self
        
        typeCall = "Fighter"
        description = "Equipe \(self.teamName) avec quel personnage voulez-vous attaquer ?"
        let fighter = self.choiceAvatar(team: teamFrom, description: description, typeCall: typeCall)
        
        typeCall  = "Adversary"
        description = "Equipe \(self.teamName), Quel personnage voulez-vous attaquer ?"
        let adversary = self.choiceAvatar(team: teamAgainst, description: description, typeCall: typeCall)
        
        fighter.attackAvatar(avatar: adversary)
        
        if adversary.life == 0 {

            teamAgainst.numberOfAvatar -= 1
        }
        
        if teamAgainst.numberOfAvatar > 0 {
            return true
        } else {
            print("L'équipe gagnante est \(teamFrom.teamName)")
            return false
        }
        
    }
  
    
    
//    func choiceAvatar(description: String, typeCall: String) -> Int {
    func choiceAvatar(team: Team, description: String, typeCall: String) -> Avatar {
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
        
        //        for item in teamSelect.arrayAvatars {
        for item in teamSelect.arrayAvatars {
            numberOfAvatarInit += 1
            if typeCall == "Fighter" {
                if item.life > 0 && item.attack == true {
                    numberOfAvatarSelect += 1
                    print("\(numberOfAvatarSelect) - \(item.avatarName)  \(item.avatarType)", " - Arme : \(item.weapon)", " - Points de vie : \(item.life)")
                    arrayAvatarsChoice[numberOfAvatarInit]! += numberOfAvatarSelect
                }
            } else
            {
                if item.life > 0 {
                    numberOfAvatarSelect += 1
                    print("\(numberOfAvatarSelect) - \(item.avatarName)  \(item.avatarType)", " - Arme : \(item.weapon)", " - Points de vie : \(item.life)")
                    arrayAvatarsChoice[numberOfAvatarInit]! += numberOfAvatarSelect
                }
            }

        }
        
        print("")
        // Loop until choice of avatar is OK
        repeat {
            userChoice = inputInteger()
            print("")
        } while userChoice < 1 || userChoice > numberOfAvatarSelect
        
        
        for item in arrayAvatarsChoice {
            ind += 1
            if userChoice == item.value  {
                avatarChoice = item.key - 1
                print("avatarChoice \(avatarChoice)")
            }
        }
//        let choiceArray = arrayAvatarsChoice[userChoice]!
        avatarSelected = team.arrayAvatars[avatarChoice]

        return avatarSelected
    }
    
    
//    //    func choiceAvatar(description: String, typeCall: String) -> Int {
//    func zzchoiceAvatar(team: Team, description: String, typeCall: String) -> String {
//        var userChoice: Int
//        var numberOfAvatarSelect: Int = 0
//        let teamSelect = team
//        var arrayAvatarChoice = [1: "", 2: "", 3:""]
//        let description = description
//        let typeCall = typeCall
//
//        print("")
//        print(description)
//        print("")
//
////        for item in teamSelect.arrayAvatars {
//        for item in teamSelect.arrayAvatars {
//            if typeCall == "Fighter" {
//                if item.life > 0 && item.attack == true {
//                    numberOfAvatarSelect += 1
//                    print("\(numberOfAvatarSelect) - \(item.avatarName)  \(item.avatarType)", " - Arme : \(item.weapon)", " - Points de vie : \(item.life)")
//                    arrayAvatarChoice[numberOfAvatarSelect]! += item.avatarName
//                }
//            } else
//            {
//                if item.life > 0 {
//                    numberOfAvatarSelect += 1
//                    print("\(numberOfAvatarSelect) - \(item.avatarName)  \(item.avatarType)", " - Arme : \(item.weapon)", " - Points de vie : \(item.life)")
//                    arrayAvatarChoice[numberOfAvatarSelect]! += item.avatarName
//                }
//            }
//        }
//        print("")
//        // Loop until choice of avatar is OK
//        repeat {
//            userChoice = inputInteger()
//            print("")
//        } while userChoice < 1 || userChoice > numberOfAvatarSelect
//
//        let avatarNameSelected = arrayAvatarChoice[userChoice]!
//
//        for item in teamSelect.arrayAvatars {
//            if item.avatarName == avatarNameSelected {
//                   print("\(item.avatarName)  \(item.avatarType)", " - Arme : \(item.weapon)", " - Points de vie : \(item.life)")
//            }
//        }
//        let avatarSelected = avatarNameSelected
//        return avatarSelected
//    }
//
//
}
