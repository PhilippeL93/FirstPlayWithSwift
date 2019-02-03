//
//  Avatar.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 02/02/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//

class Avatar {
    
    var avatarName: String
    let avatarType : AvatarType
    var life: Int
    var attack: Bool
    var weapon: Weapon
    
    init(avatarName: String, avatarType: AvatarType) {
        self.avatarName = avatarName
        self.avatarType = avatarType
        self.weapon = avatarType.weapon
        self.life = avatarType.life
        self.attack = true
        
        switch self.avatarType {
        case is Combattant:
            self.attack = true
        case is Mage:
            self.attack = false
        case is Colosse:
            self.attack = true
        case is Nain:
            self.attack = true
        case is Hypnotiseur:
            self.attack = true
        default :
            break
        }
    }

}