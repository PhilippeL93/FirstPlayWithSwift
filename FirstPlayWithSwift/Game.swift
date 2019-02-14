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
        
        var newGame: Bool = true
        
        while newGame == true {
            
            createTeams()
            
            launchFight()
            
            newGame = choiceOfNewGame()
        }
    }
    
    
    
    private func rulesGame () {
        
        print("-------------------------------------------------------------------------------------------------------")
        print("")
        print("Jeu de combat entre deux équipes")
        print("")
        print("Règles du jeu.")
        print("")
        print("Vous allez constituer chacun votre tour une équipe de 3 personnages,")
        print("pour cela vous allez devoir choisir parmi 4 propositions.")
        print("Parmi ces 5 personnages il y a un mage qui a pour rôle de soigner l'un ")
        print("de vos combattants, il ne peux pas attaquer.")
        print("")
        print("Les personnages disponibles sont:")
        print("- le combattant, 90 points de vie, armé d'une épée enlevant 10 points de vie à l'adversaire")
        print("- le mage, 110 points de vie, pouvant soigner un membre de son équipe en lui redonnant 5 points de vie")
        print("- le colosse, 125 points de vie, armé d'une masse enlevant 8 points de vie à l'adversaire ")
        print("- le nain, 50 points de vie, armé d'une hache enlevant 15 points de vie à l'adversaire ")
        print("- l'hypnotiseur, 80 points de vie, pouvoir d'hypnotiser enlevant 12 points de vie à l'adversaire")
        print("")
        print("Une fois les équipes constituées, vous allez jouer chacun votre tour en choississant :")
        print("- soit d'attaquer l'équipe adverse")
        print("- soit de soigner un personnage de votre équipe")
        print("")
        print("Il est obligatoire d'avoir au moins un attaquant dans son équipe.")
        print("")
        print("Il n'est possible de soigner un personnage de son équipe que si il a déjà perdu des points de vie.")
        print("Un personnage soigné ne peut pas avoir plus de points de vie qu'il n'en avait initialement.")
        print("")
        print("Aléatoirement apparaîtra un coffre contenant une nouvelle arme qui remplacera celle du personnage en question.")
        print("- Si il s'agit du mage, son pouvoir de guérison sera augmenté de 5 points")
        print("- Sinon, l'arme et l'attaque du personnage concerné seront changées de façon aléatoire soit par :")
        print("     - un sabre enlevant 11 point de vie")
        print("     - une lance enlevant 8 point de vie")
        print("     - un sceptre enlevant 8 points de vie")
        print("     - un arc enlevant 12 points de vie")
        print("     - une dague enlevant 8 points de vie")
        print("")
        print("Le jeu se termine lorsque les personnages d'une équipe ont tous perdu la vie? ")
        print("")
        print("-------------------------------------------------------------------------------------------------------")
    }
    
    private func choiceOfNewGame() -> Bool {
        
        var answerForNewGame: String
        
        print("")
        print("Voulez-vous faire une nouvelle partie?")
        
        repeat {
            print("Répondre par Oui ou par Non.")
            answerForNewGame = inputString()
            print()
        } while answerForNewGame != "Oui" && answerForNewGame != "Non"
        
        if answerForNewGame == "Oui" {
            return true
        } else {
            return false
        }
    }
    
    private func createTeams() {
        
        // Create team A
        let teamNameA = askUserForTeamsName(teamNumber: "Première")
        teamA = createTeam(name: teamNameA)
        if teamA == nil {
            print("Première \(Errors.teamEmpty.rawValue)")
            fatalError()
        }
        createFightersForTeam(team: teamA!, teamNumber: "Premier")
        
        print("Equipe \(teamNameA) est complète")
        
        teamA!.printAvatar()
        
        // Create team B
        let teamNameB = askUserForTeamsName(teamNumber: "Deuxième")
        teamB = createTeam(name: teamNameB)
        if teamB == nil {
            print("Deuxième \(Errors.teamEmpty.rawValue)")
            fatalError()
        }
        createFightersForTeam(team: teamB!, teamNumber: "Deuxième")
        
        print("Equipe \(teamNameB) est complète")
        
        teamB!.printAvatar()
    }
    
    
    private func createTeam(name: String) -> Team {
        
        let team = Team(teamName: name)
        
        return team
    }
    
    private func createFightersForTeam(team: Team, teamNumber : String) {
        
        var avatarNumber: String = ""
        //        var teamName: String = ""
        let team = team
        let teamNumber = teamNumber
        
        //        teamName = team.teamName
        
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
            //            let avatarType = fillUpAvatarType(teamNameDisplay: teamName, avatarNumber: avatarNumber)
            let avatarType = fillUpAvatarType(team: team, avatarNumber: avatarNumber)
            
            //      choice of avatar name
            let avatarName = askUserForAvatarName(teamNumber: teamNumber)
            
            //      create avatar
            let avatarUsed = Avatar(avatarName: avatarName, avatarType: avatarType)
            
            team.addAvatar(avatar: avatarUsed)
            
        }
    }
    
    private func fillUpAvatarType(team: Team,  avatarNumber: String) ->   AvatarType {
        //    private func fillUpAvatarType(teamNameDisplay: String,  avatarNumber: String) ->   AvatarType {
        var answer: Int
        let teamNameDisplay = team.teamName
        let avatarNumber = avatarNumber
        var avatarType: AvatarType!
        var checkForMagus: Bool = true
        
        print("")
        print("Equipe \(teamNameDisplay), Choississez votre \(avatarNumber) personnage")
        
        repeat {
            print("")
            print("1 Combattant")
            print("2 Mage")
            print("3 Colosse")
            print("4 Nain")
            print("5 Hypnotiseur")
            answer = inputInteger()
            switch answer {
            case 1:
                avatarType = Combattant()
            case 2:
                switch avatarNumber {
                case "troisième":
                    checkForMagus = team.checkForMagus()
                    switch checkForMagus {
                    case true:
                        avatarType = Mage()
                    case false:
                        answer = 0
                        print(Errors.teamMagusOnly.rawValue)
                    }
                default:
                    avatarType = Mage()
                }
            case 3:
                avatarType = Colosse()
            case 4:
                avatarType = Nain()
            case 5:
                avatarType = Hypnotiseur()
            default:
                print("")
                print(Errors.selectFighter.rawValue)
            }
        } while answer < 1 || answer > 5
        return avatarType!
    }
    
    private func askUserForAvatarName(teamNumber: String) -> String {
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
            case "Premier" :
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
    
    fileprivate func askUserForTeamsName(teamNumber: String) -> String{
        var playerName: String = " "
        let teamNumber = teamNumber
        
        print("")
        print("\(teamNumber) joueur, veuillez nommer votre équipe?")
        
        playerName = inputString()
        
        return playerName
    }
    
    private func launchFight() {
        
        //        var fight: Bool = true
        var winner: String = ""
        var attackOrCare: String = ""
        
        //        while fight == true {
        while winner == "" {
            changeTeamToPlay()
            
            attackOrCare = (choiceAttackOrCare(teamToPlay : teamToPlay!))
            
            switch attackOrCare {
            case "attack":
                winner = ((teamToPlay?.attack(teamAgainst : teamNotPlay!))!)
            case "care":
                teamToPlay?.care()
            default:
                break
            }
        }
    }
    
    fileprivate func changeTeamToPlay() {
        if teamToPlay === teamA! {
            teamToPlay = teamB!
            teamNotPlay = teamA!
        } else {
            teamToPlay = teamA!
            teamNotPlay = teamB!
        }
    }
    
    fileprivate func choiceAttackOrCare(teamToPlay: Team) -> String {
        
        let teamToPlay = teamToPlay
        var choiceUser: Int
        var mageAlive: Bool = false
        var numberOfInjured: Int = 0
        var returnChoice: String = ""
    
        for item in teamToPlay.arrayAvatars {
            
            switch item.avatarType {
            case is Mage:
                if item.life > 0 {
                    mageAlive = true
                } else {
                    mageAlive = false
                }
            default:
                break
            }
            if item.life < item.lifeInitial  && item.life > 0 {
                numberOfInjured += 1
            }
        }
        if numberOfInjured > 0 && mageAlive == true {
            repeat {
                print("")
                print("Equipe \(teamToPlay.teamName) : Que voulez vous faire?")
                print("1. Attaquer l'équipe adverse")
                print("2. Soigner un combattant de votre équipe")
                print("")
                choiceUser = inputInteger()
                print()
                
                switch choiceUser {
                case 1:
                    returnChoice = "attack"
                case 2:
                    returnChoice = "care"
                default:
                    print(Errors.selectAttackOrCare.rawValue)
                }
            } while choiceUser != 1 && choiceUser != 2
            return returnChoice
        } else {
            return "attack"
        }
    }
    
    // Function allowing at user to fill an Integer
    fileprivate func inputInteger() -> Int {
        var strIntReturn: Int = 0
        
        if let strData1 = readLine() {
            if let int = Int(strData1)
            {
                strIntReturn = int
            } else {
                print(Errors.selectANumber.rawValue)
                print("")
            }
        }
        return Int(strIntReturn)
    }
    
    // Function allowing at user to fill a String
    fileprivate func inputString() -> String {
        var stringReturn: String = ""
        var inputOk: Bool
        
        repeat {
            inputOk = true
            if let strData2 = readLine() {
                let processed = String(strData2.filter { !" ".contains($0) })
                if processed.count == 0 {
                    // print error message
                    print("")
                    print(Errors.nameEmpty.rawValue)
                    inputOk = false
                } else {
                    stringReturn = strData2
                    inputOk = true
                }
            }
        } while inputOk == false
        
        return (stringReturn)
    }
    
}
