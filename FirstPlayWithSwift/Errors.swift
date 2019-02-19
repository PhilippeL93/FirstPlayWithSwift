//
//  Errors.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 02/02/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//


/*   enum of errors
        enum of kind of errors
*/

enum Errors: String {
    case selectANumber = "Veuillez saisir un chiffre"
    case nameEmpty = "Veuillez saisir au moins un caractère!"
    case teamAllReadyExist = "Nom d'équipe déjà existant, merci d'en choisir un autre"
    case avatarNameAllReadyExist = "Nom de joueur déjà existant, merci d'en choisir un autre"
    case teamEmpty = "Equipe vide"
    case selectFighter = "Choix erroné, chiffre doit être compris entre 1 et 5"
    case selectAttackOrCare = "Choix erroné, sélectionner 1 ou 2"
    case selectAvatar = "Choix erroné, veuiller saisir un chiffe parmi la liste"
    case teamMagusOnly = "Une équipe ne peut pas comporter que des mages, veuillez sélectionner au moins un combattant"
}
