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
            print("premier")
            print(item.avatarName)
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
                print(item.avatarType)
            }
        }
        print("")
    }

}
