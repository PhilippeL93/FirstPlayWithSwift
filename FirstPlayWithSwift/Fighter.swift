//
//  Fighter.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 31/01/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//

class Combattant: AvatarType {
    
    init() {        
        super.init(life: 90, attack : true, weapon: Epee(), avatarTypeName: "Combattant")
    }
    
}
