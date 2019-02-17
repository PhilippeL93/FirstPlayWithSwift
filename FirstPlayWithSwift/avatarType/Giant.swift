//
//  Giant.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 31/01/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//

//  class Giant inherit of Class AvataType

class Giant: AvatarType {
    
    init() {
        super.init(life: 125,attack: true, weapon: Mace(), avatarTypeName: "Colosse")
    }
}
