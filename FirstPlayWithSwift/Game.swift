//
//  Game.swift
//  FirstPlayWithSwift
//
//  Created by Philippe on 02/02/2019.
//  Copyright © 2019 Philippe. All rights reserved.
//

/* class Avatar
 teamA : team A
 teamB : team B
 teamAttacker : team attacker
 teamAttacked : team attacked
 */

class Game {
    
    var teamA: Team?
    var teamB: Team?
    var teamAttacker: Team?
    var teamAttacked: Team?
    
    init() {
        
    }
    
    /*    function start of game
     call function to print rules
     loop while a new game is required (newGameToPlay = true)
     call function createTeams to create 2 teams
     call function launchFight to launch fight between 2 teams
     call function chooseOfNewGame to choose to play a new game
     */
    func start() {
        
        printRulesGame()
        
        var newGameToPlay: Bool = true
        
        while newGameToPlay == true {
            
            createTeams()
            
            launchFight()
            
            newGameToPlay = chooseOfNewGame()
        }
    }
    
    
    //    MARK: group rulesgame function
    
    //    display rules of the game
    private func printRulesGame () {
        
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
    
    /*    function choice in order to start a new game
     return true is new game required
        answer Oui to question
     return false is not new game required
        answer Non to question
     */
    private func chooseOfNewGame() -> Bool {
        
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
     call function askUserForTeamsName for teamA's name
     call function createTeam to create teamA
     creation of teamA's avatars
     call function createFightersForTeam in order to create avatar of teamA
     display avatars of teamA
     call function printAvatarTeam
     
     creation of teamB
     call function askUserForTeamsName for teamB's name
     call function createTeam to create teamB
     creation of teamB's avatars
     call function createFightersForTeam in order to create avatar of teamB
     display avatars of teamB
     call function printAvatarTeam
     */
    private func createTeams() {
        
        let teamAName = askUserForTeamName(teamNumber: "Premier")

        teamA = createTeam(name: teamAName)
        
        if teamA == nil {
            print("Première \(Errors.teamEmpty.rawValue)")
            fatalError()
        }

        createFightersForTeam(team: teamA!)
        
        print("")
        print("Equipe \(teamAName) est complète")
        
        teamA!.printAvatarTeam()
        
        let teamBName = askUserForTeamName(teamNumber: "Deuxième")

        teamB = createTeam(name: teamBName)
        
        if teamB == nil {
            print("Deuxième \(Errors.teamEmpty.rawValue)")
            fatalError()
        }
        
        createFightersForTeam(team: teamB!)
        
        print("")
        print("Equipe \(teamBName) est complète")
        
        teamB!.printAvatarTeam()
    }
    
    /*    function to create instancy of team
     return team
     */
    private func createTeam(name: String) -> Team {
        
        let team = Team(teamName: name)
        
        return team
    }
    
    /*    function to ask a name for team
     call function inputString
     return name of the team
     */
    fileprivate func askUserForTeamName(teamNumber: String) -> String{
        let teamNumber = teamNumber    // numbering of team to differentiate message
        
        print("")
        print("\(teamNumber) joueur, veuillez nommer votre équipe?")
        
        let playerName = inputString()
        
        return playerName
    }
    
    //    MARK: group avatars function
    
    /*    function to create 3 avatars in a team
     executed 3 times
     call function fillUpAvatarType for selection Avatar Type
     call function askUserForAvatarName for avtar's name
     call init Avatar in order to create avatar
     call function addAvatar in order to add avatar in team
     */
    private func createFightersForTeam(team: Team) {
        
        var avatarNumber: String = ""       // to distinguish number of avatar first to third
        
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
    
    /*    function to selection type of avatar
     a check is done to verify that team contains at least one fighter not only magus
     call function checkForMagus
     return type of avatar to create
     */
    private func fillUpAvatarType(team: Team,  avatarNumber: String) ->   AvatarType {
        
        var answerAvatarType: Int                       // number of answer
        var avatarType: AvatarType!                     // type of avatar created by fucntion
        
        print("")
        print("Equipe \(team.teamName ), Choississez votre \(avatarNumber) personnage")
        
        repeat {
            print("""
                1 Combattant
                2 Mage
                3 Colosse
                4 Nain
                5 Hypnotiseur
            """)
            answerAvatarType = inputInteger()
            switch answerAvatarType {
            case 1:
                avatarType = Fighter()
            case 2:
                switch avatarNumber {
                case "troisième":
                    if team.checkForMagus() {
                        answerAvatarType = 0
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
        } while answerAvatarType < 1 || answerAvatarType > 5
        return avatarType!
    }
    
    /*    function to name avatar by asking to user
     a check is done to verify that avatar's name is single for both teams
     if teamA exist
     call function checkForDuplicate for search in teamA
     if no duplicate avatar name
     if teamB exist
     call function checkForDuplicate for search in teamB
     if name duplicate
     print error
     return name of avatar
     */
    private func askUserForAvatarName() -> String {
        
        var avatarName: String                      // name of avatar done by player
        var isAvatarNameDuplicate = false           // true when duplicate name found
        
        print("")
        print("Veuillez nommer votre Personnage")
        
        repeat {
            avatarName = inputString()

            isAvatarNameDuplicate = teamA!.checkForDuplicateAvatarName(avatarName: avatarName)
            
            if isAvatarNameDuplicate == false {
                if teamB != nil {
                    isAvatarNameDuplicate = teamB!.checkForDuplicateAvatarName(avatarName: avatarName)
                }
            }
            if isAvatarNameDuplicate == true {
                // Gestion d'erreur
                print("")
                print(Errors.avatarNameAllReadyExist.rawValue)
            }
        } while isAvatarNameDuplicate == true
        
        return avatarName
    }
    
    //    MARK: group fight function
    /*    funtion to launch game
     is executed while a winner has not been declared
     call function changeTeamToPlay to alternate attacker between teamA and teamB
     call function choiceAttackOrCare to choose between attack or care
     depending on return of function choiceAttackOrCare
     attack
     call function attack
     return name of winner when a team won
     care
     call function chooseCare
     */
    private func launchFight() {
        
        var winner: String = ""                // name of winner come from function attack
        
        while winner == "" {
            changeTeamToPlay()
            
            let attackOrCare = (choiceAttackOrCare(teamToPlay : teamAttacker!))
            
            switch attackOrCare {
            case "attack":
                winner = ((teamAttacker?.attack(teamAgainst : teamAttacked!))!)
            case "care":
                teamAttacker?.chooseCare()
            default:
                break
            }
        }
        print(winner)
    }
    
    /*    function to alternate player betweem teamA and teamB
     alternatively
     teamToPlay contains team attacker : teamAttacker
     teamNotToPlay contains team attacked : teamAttacked
     */
    fileprivate func changeTeamToPlay() {
        if teamAttacker === teamA! {
            teamAttacker = teamB!
            teamAttacked = teamA!
        } else {
            teamAttacker = teamA!
            teamAttacked = teamB!
        }
    }
    
    /*    function to choice between attack or care
     call function checkTeamMagusAlive to detrmine if Magus alive
     call function checkTeamAvatarInjure to determione if at least one fighter is injured
     If magus alive and avatarsInjured
     --> care is possible
     proposal to player to choose between care or attack
     depending on answer
     1 -> return attack
     2 -> return "care"
     otherwise
     --> attack only
     return "attack"
     */
    fileprivate func choiceAttackOrCare(teamToPlay: Team) -> String {
        
        let teamToPlay = teamToPlay                     // team Attacker
        var choiceUser: Int                             // choice
        var returnChoice: String = "attack"             // return Attack or Care depending on choice of player
        
        let isMagusAlive = teamToPlay.checkTeamMagusAlive()
        
        let isAvatarInjured = teamToPlay.checkTeamAvatarInjure()
        
        if isAvatarInjured == true && isMagusAlive == true {
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
            return returnChoice
        }
    }
    
    //    MARK: group readline function
    /*    function allowing at player to fill an Integer
     executed until an integer has been filled
     */
    fileprivate func inputInteger() -> Int {
        
        guard let stringRead = readLine(), let numberToReturn = Int(stringRead) else {
            print(Errors.selectANumber.rawValue)
            print("")
            return 0
        }
        return numberToReturn
    }
    
    /*    function allowing at player to fill a String
     executed until a not empty answer has been filled
     */
    fileprivate func inputString() -> String {
        
        var stringToReturn: String = ""
        repeat {
            guard let stringRead = readLine(), !stringRead.isEmpty
                else {
                    print(Errors.nameEmpty.rawValue)
                    print("")
                    stringToReturn = ""
                    continue
            }
            stringToReturn = stringRead
        } while stringToReturn == ""
        
        return stringToReturn
    }
    
}
