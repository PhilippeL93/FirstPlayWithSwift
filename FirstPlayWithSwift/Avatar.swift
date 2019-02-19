//
//  Avatar.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 02/02/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//

/* class Avatar
        avatarName : name of avatar
        avatarType : depending on Class AvatarType
        life : number of points of life
        lifeInitial : initial number of points of life
        attack :
            true for fighter
            false for magus
        weapon: depending on Class Weapon
 */


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

/*    function attack avatar
        avatar attacked receive damage from avatar attacker by calling function receiveDamage
     */
    func attackAvatar(avatar: Avatar) {
        avatar.receiveDamage(damage: self.weapon.damage)
        print("")
        print("Le personnage \(self.avatarName) a attaqué le personnage \(avatar.avatarName) et lui a infligé une perte de \(self.weapon.damage) points de vie")
        
    }
    
/*    function receive damage from attacker
        If life is negative, put to 0 in order have avatar dead
*/
    func receiveDamage(damage: Int) {
        self.life = self.life - damage
        if self.life < 0 {
            self.life = 0
        }
    }
    
/*    function care avatar of own team with care form magus
        check new life is not greather than initial life
     
*/
    func care(avatar: Avatar) {
        
        let magus = avatar
        
        self.life += magus.weapon.damage

        if self.life > self.lifeInitial {
            self.life = self.lifeInitial
        }
        print("")
        print("Le personnage \(self.avatarName) a été soigné et a maintenant \(self.life) points de vie")
        
    }
}
