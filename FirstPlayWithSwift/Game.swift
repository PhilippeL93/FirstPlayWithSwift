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

/*    function start of game
        call rules
        loop while a new game is required (newGame = true)
*/
 func start() {
        
        rulesGame()
        
        var newGame: Bool = true
        
        while newGame == true {
            
            createTeams()
            
            launchFight()
            
            newGame = choiceOfNewGame()
        }
    }
    
    
//    MARK: group rulesgame function
    
//    display rules of the game
    private func rulesGame () {
        
        print("""
        -------------------------------------------------------------------------------------------------------

        Jeu de combat entre deux équipes

        Règles du jeu.

            Vous allez constituer chacun votre tour une équipe de 3 combattants,
            pour cela vous allez devoir choisir parmi 5 personnages.
            Au sein de ces 5 personnages se trouve un mage qui a pour rôle de soigner l'un
            de vos combattants, il ne peut pas attaquer.

            Les personnages disponibles sont:
            - le combattant, 90 points de vie, armé d'une épée enlevant 10 points de vie à l'adversaire
            - le mage, 110 points de vie, pouvant soigner un membre de son équipe en lui redonnant 5 points de vie
            - le colosse, 125 points de vie, armé d'une masse enlevant 8 points de vie à l'adversaire
            - le nain, 50 points de vie, armé d'une hache enlevant 15 points de vie à l'adversaire
            - l'hypnotiseur, 80 points de vie, pouvoir d'hypnotiser enlevant 12 points de vie à l'adversaire

            Une fois les équipes constituées, vous allez jouer chacun votre tour en choississant :
            - soit d'attaquer l'équipe adverse
            - soit de soigner un personnage de votre équipe
            
            Il est obligatoire d'avoir au moins un attaquant dans son équipe.
            
            Il n'est possible de soigner un personnage de son équipe que s'il a déjà perdu des points de vie.
            Un personnage soigné ne peut pas avoir plus de points de vie qu'il n'en avait initialement.
            
            Aléatoirement apparaîtra un coffre contenant une nouvelle arme qui remplacera celle du personnage en question.
            - S'il s'agit du mage, son pouvoir de guérison sera augmenté de de façon aléatoire entre 1 et 10 points
            - Sinon, l'arme et l'attaque du personnage concerné seront changées de façon aléatoire soit par :
                - un sabre enlevant 11 points de vie
                - une lance enlevant 8 points de vie
                - un sceptre enlevant 8 points de vie
                - un arc enlevant 12 points de vie
                - une dague enlevant 8 points de vie
            
            Le jeu se termine lorsqu'une équipe n'a plus de personnages.
            
        -------------------------------------------------------------------------------------------------------
        """)
    }

//    function choice in order to a new game
    private func choiceOfNewGame() -> Bool {
        
        var answerForNewGame: String
        
        print("")
        print("Voulez-vous faire une nouvelle partie?")
        
        repeat {
            print("")
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
    
//    MARK: group team function
/*    function to create two teams
        creation of teamA
        creation of teamA's avatars
        creation of teamB
        creation of teamB's avatars
*/
    private func createTeams() {
        
        let teamNameA = askUserForTeamsName(teamNumber: "Premier")
        teamA = createTeam(name: teamNameA)
        if teamA == nil {
            print("Première \(Errors.teamEmpty.rawValue)")
            fatalError()
        }
        createFightersForTeam(team: teamA!)
        
        print("")
        print("Equipe \(teamNameA) est complète")
        
        teamA!.printAvatarTeam()
        
        let teamNameB = askUserForTeamsName(teamNumber: "Deuxième")
        teamB = createTeam(name: teamNameB)
        if teamB == nil {
            print("Deuxième \(Errors.teamEmpty.rawValue)")
            fatalError()
        }
        createFightersForTeam(team: teamB!)
        
        print("")
        print("Equipe \(teamNameB) est complète")
        
        teamB!.printAvatarTeam()
    }
    
//    function to create instancy of team
    private func createTeam(name: String) -> Team {
        
        let team = Team(teamName: name)
        
        return team
    }
    
//    function to ask a name for team
    fileprivate func askUserForTeamsName(teamNumber: String) -> String{
        var playerName: String = " "
        let teamNumber = teamNumber
        
        print("")
        print("\(teamNumber) joueur, veuillez nommer votre équipe?")
        
        playerName = inputString()
        
        return playerName
    }
    
//    MARK: group avatars function
//    function to create 3 avatars in a team
    private func createFightersForTeam(team: Team) {
        
        var avatarNumber: String = ""       // to distinguish number of avatar first to third
        let team = team
        
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

            let avatarType = fillUpAvatarType(team: team, avatarNumber: avatarNumber)
            
            let avatarName = askUserForAvatarName()
            
            let avatarUsed = Avatar(avatarName: avatarName, avatarType: avatarType)
            
            team.addAvatar(avatar: avatarUsed)
            
        }
    }

/*    function to determine type of avatar
        a check is done to verify that team contains at least one fighter not only magus
*/
    private func fillUpAvatarType(team: Team,  avatarNumber: String) ->   AvatarType {
        var answer: Int
        let teamNameDisplay = team.teamName
        let avatarNumber = avatarNumber
        var avatarType: AvatarType!
        
        print("")
        print("Equipe \(teamNameDisplay), Choississez votre \(avatarNumber) personnage")
        
        repeat {
            print("""
                1 Combattant
                2 Mage
                3 Colosse
                4 Nain
                5 Hypnotiseur
            """)
            answer = inputInteger()
            switch answer {
            case 1:
                avatarType = Fighter()
            case 2:
                switch avatarNumber {
                case "troisième":
                    if team.checkForMagus() {
                        answer = 0
                        print(Errors.teamMagusOnly.rawValue)
                    } else {
                        avatarType = Magus()
                    }
                default:
                    avatarType = Magus()
                }
            case 3:
                avatarType = Giant()
            case 4:
                avatarType = Dwarf()
            case 5:
                avatarType = Hypnotist()
            default:
                print("")
                print(Errors.selectFighter.rawValue)
            }
        } while answer < 1 || answer > 5
        return avatarType!
    }

/*    function to name avatar by asking to user
        a check is done to verify that avatar's name is single
*/
    private func askUserForAvatarName() -> String {
        var avatarName: String
        var nameFound: Bool
        var checkForDuplicates = true
        
        print("")
        print("Veuillez nommer votre Personnage")
        
        repeat {
            nameFound = true
            avatarName = inputString()
            
            if teamA != nil {
                checkForDuplicates = teamA!.checkForDuplicate(avatarName: avatarName)
            }
            if teamB != nil {
                checkForDuplicates = teamB!.checkForDuplicate(avatarName: avatarName)
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
    
//    MARK: group fight function
/*    funtion to launch game
        is executed while a winner has not been declared
*/
    private func launchFight() {
        
        var winner: String = ""
        
        while winner == "" {
            changeTeamToPlay()
            
            let attackOrCare = (choiceAttackOrCare(teamToPlay : teamToPlay!))
            
            switch attackOrCare {
            case "attack":
                winner = ((teamToPlay?.attack(teamAgainst : teamNotPlay!))!)
            case "care":
                teamToPlay?.careChoice()
            default:
                break
            }
        }
        print(winner)
    }

//    function to alternate player betweem teamA and teamB
    fileprivate func changeTeamToPlay() {
        if teamToPlay === teamA! {
            teamToPlay = teamB!
            teamNotPlay = teamA!
        } else {
            teamToPlay = teamA!
            teamNotPlay = teamB!
        }
    }

/*    function to choice between attack or care
        depending on Magus alive and fighter is injured
            --> care is possible
                return "care"
        otherwise
            --> attack only
                return "attack"
*/
    fileprivate func choiceAttackOrCare(teamToPlay: Team) -> String {
        
        let teamToPlay = teamToPlay
        var choiceUser: Int
        var mageAlive: Bool = false
        var numberOfInjured: Int = 0
        var returnChoice: String = ""
        
        for item in teamToPlay.arrayAvatars {
            
            switch item.avatarType {
            case is Magus:
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
                print("""
                
                \(teamToPlay.teamName) : Que voulez vous faire?
                    1. Attaquer l'équipe adverse
                    2. Soigner un combattant de votre équipe
                """)
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
    
//    MARK: group readline function
//    function allowing at user to fill an Integer
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
    
//    function allowing at user to fill a String
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
