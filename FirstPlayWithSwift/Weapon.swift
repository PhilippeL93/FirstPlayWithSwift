//
//  Weapon.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 31/01/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//

class Weapon {
    var damage: Int
    var attack: Bool
    var weaponName: String
    
    init(damage: Int, attack: Bool, weaponName: String) {
        self.damage = damage
        self.attack = true
        self.weaponName = weaponName
    }
    
}
