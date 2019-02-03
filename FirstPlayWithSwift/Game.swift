//
//  Game.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 02/02/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//


class Game {
    
    init() {
        
    }
    
    func startPlay() {
        
        print("Jeu de combat entre deux équipes")
        
        //      choice of name of first team
        var teamNumber = "Première"
        let teamNameOne = askUserForTeamsName(teamNumber: teamNumber)
        
        //      create of first team
        teamOne = createTeam(name: teamNameOne)
        
        //      choice of type for first avatar
        var avatarNumber = "premier"
        let avatarTypeOneOne = fillUpAvatarType(teamNameDisplay: teamNameOne, avatarNumber: avatarNumber)

        //      choice of name for first avatar
        let avatarNameOneOne = askUserForAvatarName(teamNumber: teamNumber)
        
        //      create first avatar in first team
        let avatarOneOne = Avatar(avatarName: avatarNameOneOne, avatarType: avatarTypeOneOne)
        
        teamOne.addAvatar(avatar: avatarOneOne)
        
        //      choice of type for second avatar
        avatarNumber = "deuxième"
        let avatarTypeTwoOne = fillUpAvatarType(teamNameDisplay: teamNameOne, avatarNumber: avatarNumber)
        
        //      choice of name for second avatar
        let avatarNameTwoOne = askUserForAvatarName(teamNumber: teamNumber)
        
        //      create second avatar in first team
        let avatarTwoOne = Avatar(avatarName: avatarNameTwoOne, avatarType: avatarTypeTwoOne)
        
        teamOne.addAvatar(avatar: avatarTwoOne)
        
        //      choice of type for third avatar
        avatarNumber = "troisième"
        let avatarTypeThreeOne = fillUpAvatarType(teamNameDisplay: teamNameOne, avatarNumber: avatarNumber)
                
        //      choice of name for third avatar
        let avatarNameThreeOne = askUserForAvatarName(teamNumber: teamNumber)
        
        //      create third avatr in first team
        let avatarThreeOne = Avatar(avatarName: avatarNameThreeOne, avatarType: avatarTypeThreeOne)
        
        teamOne.addAvatar(avatar: avatarThreeOne)
        
        print("Equipe \(teamNameOne) est complète")
        
        teamOne.printAvatar()

        
        //      choice name of second team
        teamNumber = "Deuxième"
        let teamNameTwo = askUserForTeamsName(teamNumber: teamNumber)
        
        //      create second team
        teamTwo = createTeam(name: teamNameTwo)
        
        //      choice of type for first avatar
        avatarNumber = "premier"
        let avatarTypeOneTwoo = fillUpAvatarType(teamNameDisplay: teamNameTwo, avatarNumber: avatarNumber)
        
        //      choice of name for first avatar
        let avatarNameOneTwo = askUserForAvatarName(teamNumber: teamNumber)
        
        //      create first avatar in second team
        let avatarOneTwo = Avatar(avatarName: avatarNameOneTwo, avatarType: avatarTypeOneTwoo)
        
        teamTwo.addAvatar(avatar: avatarOneTwo)
        
        //      choice of type for second avatar
        avatarNumber = "deuxième"
        let avatarTypeTwoTwo = fillUpAvatarType(teamNameDisplay: teamNameTwo, avatarNumber: avatarNumber)
        
        //      choice of name for second avatar
        let avatarNameTwoTwo = askUserForAvatarName(teamNumber: teamNumber)
        
        //      create second avatar in second team
        let avatarTwoTwo = Avatar(avatarName: avatarNameTwoTwo, avatarType: avatarTypeTwoTwo)
        
        teamTwo.addAvatar(avatar: avatarTwoTwo)
        
        //      choice of type for third avatar
        avatarNumber = "troisième"
        let avatarTypeThreeTwo = fillUpAvatarType(teamNameDisplay: teamNameTwo, avatarNumber: avatarNumber)
        
        //      choice of name for third avatar
        let avatarNameThreeTwo = askUserForAvatarName(teamNumber: teamNumber)
        
        //      create third avatr in second team
        let avatarThreeTwo = Avatar(avatarName: avatarNameThreeTwo, avatarType: avatarTypeThreeTwo)
        
        teamTwo.addAvatar(avatar: avatarThreeTwo)
        
        print("Equipe \(teamNameTwo) est complète")
        teamTwo.printAvatar()

        
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
        print(team)
        
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
        var checkForDoublons = false
        let teamNumber = teamNumber
        
        print("")
        print("Veuillez nommer votre Personnage")
        
        repeat {
            nameFound = true
            avatarName = inputString()
            
            switch teamNumber {
                case "Première" :
                    checkForDoublons = teamOne.checkForDuplicate(avatarName: avatarName)
                case "Deuxième" :
                    checkForDoublons = teamOne.checkForDuplicate(avatarName: avatarName)
                    if checkForDoublons == true {
                        checkForDoublons = teamTwo.checkForDuplicate(avatarName: avatarName)
                    }
                default:
                    break
            }
    
            if checkForDoublons == false {
                // Gestion d'erreur
                print("")
                print(Errors.avatarNameAllReadyExist.rawValue)
                nameFound = false
            }
        } while nameFound == false
        
        return avatarName
    }
    
    
}
