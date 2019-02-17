//
//  Hypnotise.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 31/01/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//

//  class Hypnotist inherit of Class AvataType

class Hypnotist: AvatarType {
    init() {
        super.init(life: 80, attack: true, weapon: Hypnotise(), avatarTypeName: "Hypnotiseur")
    }

}

