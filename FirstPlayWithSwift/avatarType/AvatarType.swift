//
//  AvatarType.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 31/01/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//

/* class AvatarType
    define
        life : life of avatar
        weapon : depending on class Weapon
        attack :
            true for fighter
            false for magus
        avatarTypeName : name of avatar
 */

class AvatarType {
    var life: Int
    var weapon: Weapon
    var attack: Bool
    var avatarTypeName: String
    
    init(life: Int, attack: Bool, weapon: Weapon, avatarTypeName: String) {
        self.life = life
        self.weapon = weapon
        self.attack = attack
        self.avatarTypeName = avatarTypeName
    }
}
