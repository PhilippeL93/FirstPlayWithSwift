//
//  Game.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 02/02/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//


class Game {
    
    var teamA: Team?
    var teamB: Team?
    var teamToPlay: Team?
    var teamNotPlay: Team?
    
    init() {

    }
    
    func start() {

        rulesGame()
        
        createTeams()
        
        launchFight()
        
//        displayWinner()
        
    }
    
    func rulesGame () {
        print("Jeu de combat entre deux équipes")
        print("")
        print("Les règles du jeu sont les suivantes")
        print("")
        print("Vous allez constituer chacun votre tour une équipe avec 3 combattants,")
        print("pour cela vous allez devoir choisir parmi 4 personnages proposés.")
        print("Parmi ces 4 personnages il y a un mage qui a pour rôle de soigner l'un ")
        print("de vos combattants, il ne participe pas au combat.")
        print("")
        print("Les personnages disponibles sont:")
        print("- le combattant, 90 points de vie, armé d'une épée enlevant 10 points de vie à l'adversaire")
        print("- le mage, 110 points de vie, pouvant soigner un membre de son équipe en lui redonnant 5 points de vie")
        print("- le colosse, 125 points de vie, armé d'une masse enlevant 5 points de vie à l'adversaire ")
        print("- le nain, 50 points de vie, armé d'une hache enlevant 15 points de vie à l'adversaire ")
        print("")
        print("Une fois les équipes constituées, vous allez jouer chacun votre tour en \rchoississant soit :")
        print("- d'attaquer l'équipe adverse")
        print("- de soigner un personnage de votre équipe")
        print("")
        print("Le jeu se termine lorsque les personnages d'une équipe ont tous perdu la vie? ")
        print("")
        print("")
        print("")
        print("")
        
    }
    
    func createTeams() {
        
        // Create team A
        let teamNameA = askUserForTeamsName(teamNumber: "Première")
        teamA = createTeam(name: teamNameA)
        if teamA == nil {
            print("An error occured when creating the team \(teamNameA). Game Quit.")
            fatalError()
        }
        createFightersForTeam(team: teamA!, teamNumber: "Première")
        
        print("Equipe \(teamNameA) est complète")
        
        teamA!.printAvatar()
        
        // Create team B
        let teamNameB = askUserForTeamsName(teamNumber: "Deuxième")
        teamB = createTeam(name: teamNameB)
        if teamB == nil {
            print("An error occured when creating the team \(teamNameB). Game Quit.")
            fatalError()
        }
        createFightersForTeam(team: teamB!, teamNumber: "Deuxième")
        
        print("Equipe \(teamNameB) est complète")
        
        teamB!.printAvatar()
    }
    
    
    func createTeam(name: String) -> Team {
        
        let team = Team(teamName: name)
        
        return team
    }
    
    func createFightersForTeam(team: Team, teamNumber : String) {
        
        var avatarNumber: String = ""
        var teamName: String = ""
//        var avatarTeamAB: String = ""
//        var avatarTeamNumber: String = ""
        
        switch teamNumber {
        case "Première":
            teamName = teamA!.teamName
//            avatarTeamAB = "A"
        case "Deuxième":
            teamName = teamB!.teamName
//            avatarTeamAB = "B"
        default:
            break
        }
        
        let teamNumber = teamNumber
        
        for index in 1...3 {
            switch index {
            case 1:
                avatarNumber = "premier"
//                avatarTeamNumber = avatarTeamAB + "1"
            case 2:
                avatarNumber = "deuxième"
//                avatarTeamNumber = avatarTeamAB + "2"
            case 3:
                avatarNumber = "troisième"
//                avatarTeamNumber = avatarTeamAB + "3"
            default:
                break
            }
//            print("avatarTeamNumber \(avatarTeamNumber)")
            //      choice of avatar type
            let avatarType = fillUpAvatarType(teamNameDisplay: teamName, avatarNumber: avatarNumber)
            
            //      choice of avatar name
            let avatarName = askUserForAvatarName(teamNumber: teamNumber)
            
            //      create avatar
            let avatarUsed = Avatar(avatarName: avatarName, avatarType: avatarType)
            
            
            
//            switch avatarTeamNumber {
//            case "A1":
//                let avatarA1 = Avatar(avatarName: avatarName, avatarType: avatarType)
//                teamA!.addAvatar(avatar: avatarA1)
//            case "A2":
//                let avatarA2 = Avatar(avatarName: avatarName, avatarType: avatarType)
//                teamA!.addAvatar(avatar: avatarA2)
//            case "A3":
//                let avatarA3 = Avatar(avatarName: avatarName, avatarType: avatarType)
//                teamA!.addAvatar(avatar: avatarA3)
//            case "B1":
//                let avatarB1 = Avatar(avatarName: avatarName, avatarType: avatarType)
//                teamB!.addAvatar(avatar: avatarB1)
//            case "B2":
//                let avatarB2 = Avatar(avatarName: avatarName, avatarType: avatarType)
//                teamB!.addAvatar(avatar: avatarB2)
//            case "B3":
//                let avatarB3 = Avatar(avatarName: avatarName, avatarType: avatarType)
//                teamB!.addAvatar(avatar: avatarB3)
//            default:
//                break
//            }
            
            
            switch teamNumber {
            case "Première":
                teamA!.addAvatar(avatar: avatarUsed)
            case "Deuxième":
                teamB!.addAvatar(avatar: avatarUsed)
            default:
                break
            }
        }
    }
    
    
    func fillUpAvatarType(teamNameDisplay: String,  avatarNumber: String) ->   AvatarType {
        var answer: Int
        let teamNameDisplay = teamNameDisplay
        let avatarNumber = avatarNumber
        var avatarType: AvatarType!
        
        print("")
        print("Equipe \(teamNameDisplay), Choississez votre \(avatarNumber) personnage")
        
        // meme code avec la creation de joueur
        repeat {
            print("")
            print("1 Combattant")
            print("2 Mage")
            print("3 Colosse")
            print("4 Nain")
            answer = inputInteger()
        } while answer != 1 && answer != 2 && answer != 3 && answer != 4
        
        switch answer {
        case 1:
            avatarType = Combattant()
        case 2:
            avatarType = Mage()
        case 3:
            avatarType = Colosse()
        case 4:
            avatarType = Nain()
        case 5:
            avatarType = Hypnotiseur()
        default:
            break
        }
        
        return avatarType!
    }
    
    
    func askUserForAvatarName(teamNumber: String) -> String {
        var avatarName: String
        var nameFound: Bool
        var checkForDuplicates = true
        let teamNumber = teamNumber
        
        print("")
        print("Veuillez nommer votre Personnage")
        
        repeat {
            nameFound = true
            avatarName = inputString()
            switch teamNumber {
            case "Première" :
                checkForDuplicates = teamA!.checkForDuplicate(avatarName: avatarName)
            case "Deuxième" :
                checkForDuplicates = teamA!.checkForDuplicate(avatarName: avatarName)
                if checkForDuplicates == true {
                    checkForDuplicates = teamB!.checkForDuplicate(avatarName: avatarName)
                }
            default:
                break
            }
            
            if checkForDuplicates == false {
                // Gestion d'erreur
                print("")
                print(Errors.avatarNameAllReadyExist.rawValue)
                nameFound = false
            }
        } while nameFound == false
        
        return avatarName
    }
    
    func askUserForTeamsName(teamNumber: String) -> String{
        var playerName: String = " "
        let teamNumber = teamNumber
        
        print("")
        print("\(teamNumber) équipe, veuillez entrer votre nom?")
        
        playerName = inputString()
        
        return playerName
    }
    
    func launchFight() {
        
        var fight: Bool = true
        
//        while numberOfAvatarTeamA > 0 && numberOfAvatarTeamB > 0 {
        while fight == true {
            
            changeTeamToPlay()

            fight = (teamToPlay?.attack(teamAgainst : teamNotPlay!))!
        
        }
        
    }
    
    
    func changeTeamToPlay() {
        if teamToPlay === teamA! {
            teamToPlay = teamB!
            teamNotPlay = teamA!
        } else {
            teamToPlay = teamA!
            teamNotPlay = teamB!
        }
    }

    

}
