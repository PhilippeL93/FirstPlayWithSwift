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
    
    init() {
//        print("Initializer called")
    }
    
    func start() {
        print("Jeu de combat entre deux équipes")
        
        createTeams()
        
    }
    
    func createTeams() {
        
        // Create team A
        let teamNameOne = askUserForTeamsName(teamNumber: "Première")
        teamA = createTeam(name: teamNameOne)
        if teamA == nil {
            print("An error occured when creating the team \(teamNameOne). Game Quit.")
            fatalError()
        }
        createFightersForTeam(team: teamA!, teamNumber: "Première")
        
        // Create team B
        let teamNameTwo = askUserForTeamsName(teamNumber: "Deuxième")
        teamB = createTeam(name: teamNameTwo)
        if teamB == nil {
            print("An error occured when creating the team \(teamNameTwo). Game Quit.")
            fatalError()
        }
        createFightersForTeam(team: teamB!, teamNumber: "Deuxième")
    }
    
    func createFightersForTeam(team: Team, teamNumber : String) {
        
        var avatarNumber: String = ""
        let teamUsed = Team.self
        var teamName: String = ""
        
        switch teamNumber {
        case "Première":
            teamName = teamA!.teamName
        case "Deuxième":
            teamName = teamB!.teamName
        default:
            break
        }
        
        let teamNumber = teamNumber
        
        for index in 1...3 {
            switch index {
            case 1:
                avatarNumber = "premier"
            case 2:
                avatarNumber = "deuxième"
            case 3:
                avatarNumber = "troisième"
            default:
                break
            }
            //      choice of avatar type
            let avatarType = fillUpAvatarType(teamNameDisplay: teamName, avatarNumber: avatarNumber)
            
            //      choice of avatar name
            let avatarName = askUserForAvatarName(teamNumber: teamNumber)
            
            //      create avatar team
            let avatarUsed = Avatar(avatarName: avatarName, avatarType: avatarType)
            
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
    
    
    
    func askUserForTeamsName(teamNumber: String) -> String{
        var playerName: String = " "
        let teamNumber = teamNumber
        
        print("")
        print("\(teamNumber) équipe, veuillez entrer votre nom?")
        
        playerName = inputString()
        
        return playerName
    }
    
    func createTeam(name: String) -> Team {
        
        let team = Team(teamName: name)
        
        return team
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
        
        return avatarType!    }
    
    
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

}
