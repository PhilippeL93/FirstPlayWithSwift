//
//  Fighter.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 31/01/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//

//  class Fighter inherit of Class AvataType

class Fighter: AvatarType {
    
    init() {
        super.init(life: 90, attack : true, weapon: Sword(), avatarTypeName: "Combattant")
    }
    
}
