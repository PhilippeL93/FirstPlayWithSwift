//
//  Avatar.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 02/02/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//

// Class Avatar contains
// -init : initialisation of avatar
// -attackAvatar : function in order to adversary receive damage from attacker
// -function receiveDamage : in order 

class Avatar {
    
    var avatarName: String
    let avatarType : AvatarType
    var life: Int
    var lifeInitial: Int
    var attack: Bool
    var weapon: Weapon
    
    init(avatarName: String, avatarType: AvatarType) {
        self.avatarName = avatarName
        self.avatarType = avatarType
        self.weapon = avatarType.weapon
        self.life = avatarType.life
        self.lifeInitial = avatarType.life
        self.attack = avatarType.attack
    }
    
    func attackAvatar(avatar: Avatar) {
        avatar.receiveDamage(damage: self.weapon.damage)
    }
    
    func receiveDamage(damage: Int) {
        // If life is negatif, put to 0 in order avatar dead
        self.life = self.life - damage
        if self.life < 0 {
            self.life = 0
        }
    }
    
}
