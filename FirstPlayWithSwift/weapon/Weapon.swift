//
//  Weapon.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 31/01/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//


/* class weapon
    define
        damage : weapon damage
        weaponName : weapon name
  */
class Weapon {
    var damage: Int
    var weaponName: String
    
    init(damage: Int, weaponName: String) {
        self.damage = damage
        self.weaponName = weaponName
    }
    
}
