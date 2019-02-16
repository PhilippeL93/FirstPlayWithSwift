//
//  Magus.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 31/01/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//

//  class Magus inherif of Class AvataType

class Magus: AvatarType {
    
    init() {
        super.init(life: 110, attack: false, weapon: Care(), avatarTypeName: "Mage")
    }
}
