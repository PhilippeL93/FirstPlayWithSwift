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
    
    
    init(teamName: String) {
        self.teamName = teamName
        arrayAvatars = []
    }
    
    
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
    
    
    func attack(teamAgainst: Team) {

        var typeCall: String
        var description: String
        var teamFrom: Team
        let teamAgainst = teamAgainst
        
        teamFrom = self
        
        print("from \(teamFrom)")
        print("against \(teamAgainst)")
        
        typeCall = "Fighter"
        description = "Equipe \(self.teamName) avec quel personnage voulez-vous attaquer ?"
        let fighter = self.choiceAvatar(team: teamFrom, description: description, typeCall: typeCall)
//        let fighter = self.choiceAvatar(description: description, typeCall: typeCall)
        print("retour function fighter  \(fighter)")
        
        typeCall  = "Adversary"
        description = "Equipe \(self.teamName), Quel personnage voulez-vous attaquer ?"
        let adversary = self.choiceAvatar(team: teamAgainst, description: description, typeCall: typeCall)
//        let adversary = choiceAvatar(description: description, typeCall: typeCall)
        print("retour function Adversaire  \(adversary)")
        
        
        
        
    }
    
//    func choiceAvatar(description: String, typeCall: String) -> Int {
    
    func choiceAvatar(team: Team, description: String, typeCall: String) -> Int {
        var userChoice: Int
        var numberOfAvatarInit: Int = 0
        var numberOfAvatarSelect: Int = 0
        let teamSelect = team
        var arrayAvatars = [1: 0, 2: 0, 3:0]
        var avatarSelected: Int = 0
        let description = description
        let typeCall = typeCall
        
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
                    //                arrayAvatarsChoice.append(item.avatarType)
                    arrayAvatars[numberOfAvatarInit]! += numberOfAvatarSelect
                }
            } else
            {
                if item.life > 0 {
                    numberOfAvatarSelect += 1
                    print("\(numberOfAvatarSelect) - \(item.avatarName)  \(item.avatarType)", " - Arme : \(item.weapon)", " - Points de vie : \(item.life)")
                    //                arrayAvatarsChoice.append(item.avatarType)
                    arrayAvatars[numberOfAvatarInit]! += numberOfAvatarSelect
                }
            }
        }
        print("")
        // On boucle tant qu'il n'a pas choisi qui est attaqué
        repeat {
            userChoice = inputInteger()
            print("")
        } while userChoice < 1 || userChoice > numberOfAvatarSelect
        
        for item in arrayAvatars {
            if item.value == userChoice {
                avatarSelected = item.key
            }
        }
        return avatarSelected
        
    }
    
    
}
