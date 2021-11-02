#!mainFile "main.opy"

globalvar Colour_TeamOne
globalvar Colour_TeamTwo
globalvar Colour_TextTypeA
globalvar Colour_TextTypeB
globalvar Colour_TextTypeC
globalvar Scrim_DebugMode
globalvar Scrim_RemoveAssemblingHeroes
globalvar Scrim_ReadyUpFreqMode
globalvar Scrim_SetupTimeOverride
globalvar Scrim_ReadyUpCaptainMode
globalvar Scrim_EnableReadyVoiceLine
globalvar Scrim_MinimumPlayersToStart
globalvar Scrim_SetupCountdownTime
globalvar Scrim_FreezeSetupTime
globalvar Scrim_AllowForceTeamReady
globalvar Scrim_ForceTeamReadyHoldTime
globalvar Scrim_MapCompletionMode
globalvar Scrim_ForceNonControlTwoRounds
globalvar Scrim_ForceControlThreeRounds
globalvar Scrim_TeamOneScore
globalvar Scrim_TeamTwoScore
globalvar Scrim_AllowDefendersTeleport
globalvar Scrim_EnableSpecScoreboard
globalvar Scrim_AllowHostHideScoreboard
globalvar Scrim_HideScoreboardID
globalvar Scrim_DisplayScoreboardLegend
globalvar Scrim_ScoreboardGroupMode
globalvar Scrim_ScoreboardSize
globalvar Scrim_DisplayMatchTime
globalvar Scrim_MatchTime
globalvar Scrim_SetupAddTimeCaptainMode
globalvar Scrim_SetupAddTimeStep
globalvar Scrim_SetupAddTimeMax
globalvar Scrim_DisplayServerLoad
globalvar Scrims_KeybindButtonArray
globalvar Scrims_KeybindCommand
globalvar Scrims_KeybindReady
globalvar Scrims_KeybindDefenderTeleport
globalvar Scrims_KeybindAddSetupTime
globalvar Logs_EnableLogTracker
globalvar Logs_AutoMatchEndTime
globalvar Logs_CurrentObjectiveIndex
globalvar Logs_CurrentControlScoringTeam
globalvar Logs_PointCaptureProgressStep
globalvar Logs_PayloadCaptureProgressStep
globalvar Logs_PointCaptureProgress
globalvar Logs_PayloadCaptureProgress
globalvar Logs_PlayerSummaryFrequency
globalvar Logs_PlayerSummaryCount

playervar Scrim_PlayerReady
playervar Scrim_CurrentHoldTime
playervar Logs_LastHero
playervar Logs_LastHeroTime
playervar Logs_HeroesPlayedTimeArray
playervar Logs_HeroesPlayedArray
playervar Logs_OffensiveAssists
playervar Logs_DefensiveAssists
playervar Logs_CurrentHeroIterator
playervar Logs_CurrentHeroIterated
playervar Logs_UltimateID
playervar Logs_DuplicateID

subroutine CalcHeroPlayedTime

rule "Settings: Ready Up Options":
    Scrim_ReadyUpFreqMode = createWorkshopSetting(enum["Only Round One", "Every Round", "Off"], "Ready Up System", "Enable Ready Up System", 1, 0)
    Scrim_ReadyUpCaptainMode = createWorkshopSetting(enum["Only Players in First Slot", "All Players"], "Ready Up System", "Who Needs to Ready Up", 1, 1)
    Scrim_AllowForceTeamReady = createWorkshopSetting(bool, "Ready Up System", "Allow Players to Force Team Ready", false, 2)
    Scrim_ForceTeamReadyHoldTime = createWorkshopSetting(int[1:5], "Ready Up System", "Force Team Ready Button Hold Time", 3, 3)
    Scrim_SetupCountdownTime = createWorkshopSetting(int[5:10], "Ready Up System", "Countdown Timer", 5, 4)
    Scrim_MinimumPlayersToStart = createWorkshopSetting(int[1:12], "Ready Up System", "Minimum Number of Players in Game", 10, 5)
    Scrim_FreezeSetupTime = createWorkshopSetting(bool, "Ready Up System", "Freeze Setup Timer", false, 6)
    Scrim_EnableReadyVoiceLine = createWorkshopSetting(bool, "Ready Up System", "Play Voice Line When Readying", true, 7)


rule "Settings: Setup Phase Options":
    Scrim_RemoveAssemblingHeroes = createWorkshopSetting(bool, "Setup Phase", "Remove Assembling Heroes Phase", true, 0)
    Scrim_AllowDefendersTeleport = createWorkshopSetting(bool, "Setup Phase", "Allow Defenders to Teleport Between Objective and Spawn", true, 1)
    Scrim_SetupTimeOverride = createWorkshopSetting(int[45:120], "Setup Phase", "Setup Time Override", 60, 2)
    Scrim_SetupAddTimeCaptainMode = createWorkshopSetting(enum["Only Players in First Slot", "All Players", "Off"], "Setup Phase", "Who Can Add Setup Time", 1, 3)
    Scrim_SetupAddTimeStep = createWorkshopSetting(int[1:60], "Setup Phase", "Setup Time Added", 30, 4)
    Scrim_SetupAddTimeMax = createWorkshopSetting(int[45:600], "Setup Phase", "Setup Time Maximum", 90, 5)


rule "Settings: Map Completion Options":
    Scrim_MapCompletionMode = createWorkshopSetting(bool, "Map Completion", "Ensure Full Map is Attacked on Round 2 for Non-Control Maps", true, 0)
    Scrim_ForceNonControlTwoRounds = createWorkshopSetting(enum["If either team fails to complete map", "Always", "Off"], "Map Completion", "End Non-Control Maps After Two Rounds", 0, 1)
    Scrim_ForceControlThreeRounds = createWorkshopSetting(bool, "Map Completion", "End Control Maps After Three Rounds", true, 2)


rule "Settings: Spectator Scoreboard Options":
    Scrim_EnableSpecScoreboard = createWorkshopSetting(bool, "Spectator Scoreboard", "Enable Spectator Scoreboard", true, 0)
    Scrim_ScoreboardSize = createWorkshopSetting(enum["Small", "Medium", "Large"], "Spectator Scoreboard", "Size", 0, 1)
    Scrim_ScoreboardGroupMode = createWorkshopSetting(enum["Group by role, sort by team", "Group by team, sort by role", "Group by team, sort by slot"], "Spectator Scoreboard", "Player Grouping Style", 0, 2)
    Scrim_DisplayScoreboardLegend = createWorkshopSetting(bool, "Spectator Scoreboard", "Display Legend", true, 3)
    Scrim_DisplayMatchTime = createWorkshopSetting(bool, "Spectator Scoreboard", "Display Match Time", true, 4)
    Scrim_AllowHostHideScoreboard = createWorkshopSetting(bool, "Spectator Scoreboard", "Allow Host Spectator to Toggle Scoreboard", true, 5)


rule "Settings: Log Options":
    Logs_EnableLogTracker = createWorkshopSetting(bool, "Log Generator", "Enable Log Generator", false, 0)
    Logs_PointCaptureProgressStep = createWorkshopSetting(float[0:100], "Log Generator", "Control Point Progress Increment", 33.333, 16)
    Logs_PayloadCaptureProgressStep = createWorkshopSetting(float[0:100], "Log Generator", "Payload Progress Increment", 10, 17)
    Logs_PlayerSummaryFrequency = createWorkshopSetting(enum["Every Round End", "Only Match End", "Off"], "Log Generator", "Player Stat Summary Frequency", 0, 18)


rule "Settings: Keybind Options":
    Scrims_KeybindButtonArray = [Button.PRIMARY_FIRE, Button.SECONDARY_FIRE, Button.ABILITY_1, Button.ABILITY_2, Button.ULTIMATE, Button.INTERACT, Button.JUMP, Button.CROUCH, Button.MELEE, Button.RELOAD]
    Scrims_KeybindCommand = Scrims_KeybindButtonArray[createWorkshopSetting(enum["Primary Fire", "Secondary Fire", "Ability 1", "Ability 2", "Ultimate", "Interact", "Jump", "Crouch", "Melee", "Reload"], "Keybinds", "Command", 5, 0)]
    Scrims_KeybindReady = Scrims_KeybindButtonArray[createWorkshopSetting(enum["Primary Fire", "Secondary Fire", "Ability 1", "Ability 2", "Ultimate", "Interact", "Jump", "Crouch", "Melee", "Reload"], "Keybinds", "Ready Up Toggle / Force Team Ready", 9, 1)]
    Scrims_KeybindDefenderTeleport = Scrims_KeybindButtonArray[createWorkshopSetting(enum["Primary Fire", "Secondary Fire", "Ability 1", "Ability 2", "Ultimate", "Interact", "Jump", "Crouch", "Melee", "Reload"], "Keybinds", "Defender Teleport", 6, 2)]
    Scrims_KeybindAddSetupTime = Scrims_KeybindButtonArray[createWorkshopSetting(enum["Primary Fire", "Secondary Fire", "Ability 1", "Ability 2", "Ultimate", "Interact", "Jump", "Crouch", "Melee", "Reload"], "Keybinds", "Add Setup Time", 4, 3)]


rule "Settings: Debug Options":
    Scrim_DebugMode = createWorkshopSetting(bool, "Debug", "Enable Debug Mode", false, 0)
    Scrim_DisplayServerLoad = createWorkshopSetting(bool, "Debug", "Display Server Load", true, 1)
    Logs_AutoMatchEndTime = createWorkshopSetting(int[10:3600], "Debug", "Automatically End Match Time", 3600, 2)


rule "Initialisation: Match":
    if not Logs_EnableLogTracker and not devMode:
        disableInspector()
    Colour_TeamOne = rgb(50, 185, 240)
    Colour_TeamTwo = rgb(250, 5, 30)
    Colour_TextTypeA = rgb(255, 255, 255)
    Colour_TextTypeB = rgb(255, 210, 40)
    Colour_TextTypeC = rgb(40, 205, 60)


rule "Initialisation: Player":
    @Event eachPlayer

    eventPlayer.Scrim_PlayerReady = false
    eventPlayer.Logs_HeroesPlayedArray = []


rule "HUD Setup: Top Left Info":
    @Condition Scrim_ReadyUpFreqMode != 2
    @Condition (getMatchRound() == 1 or Scrim_ReadyUpFreqMode == 1) == true
    @Condition isInSetup() == true

    hudSubtext(getAllPlayers(), "workshop.codes/scrimtime", HudPosition.LEFT, 0, Colour_TextTypeB, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Countdown will commence when {0} and {1} are ready".format(getPlayersInSlot(0, Color.TEAM_1), getPlayersInSlot(0, Color.TEAM_2)) if Scrim_ReadyUpCaptainMode == 0 else "Countdown will commence when all players are ready [{0}/{1}]".format(len([player for player in getAllPlayers() if player.Scrim_PlayerReady]), len(getAllPlayers())), HudPosition.LEFT, 0.1, Colour_TextTypeA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubtext(getAllPlayers(), Color.TEAM_1, HudPosition.LEFT, 1, Colour_TeamOne, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubtext(getAllPlayers(), Color.TEAM_2, HudPosition.LEFT, 3, Colour_TeamTwo, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    if Scrim_DebugMode:
        hudSubtext(getAllPlayers(), "{0} Debug Mode is enabled, turn it off in Workshop Settings if this is not intentional {0}".format(iconString(Icon.WARNING)), HudPosition.TOP, 6.1, Colour_TextTypeB, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "HUD Setup: Ready Toggle":
    @Event eachPlayer
    @Condition Scrim_ReadyUpFreqMode != 2
    @Condition (getMatchRound() == 1 or Scrim_ReadyUpFreqMode == 1) == true
    @Condition isInSetup() == true

    if Scrim_ReadyUpCaptainMode == 1 or Scrim_ReadyUpCaptainMode == 0 and eventPlayer.getSlot() == 0:
        hudSubheader(getAllPlayers(), " {0} {1}".format("•" if eventPlayer.Scrim_PlayerReady else "•", eventPlayer), HudPosition.LEFT, (2 if eventPlayer.getTeam() == Color.TEAM_1 else 4) + eventPlayer.getSlot() * 0.1, Colour_TextTypeC if eventPlayer.Scrim_PlayerReady else Colour_TextTypeB, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.ALWAYS)
        hudSubtext(eventPlayer, "You are readied up" if eventPlayer.Scrim_PlayerReady else "You are not readied up", HudPosition.TOP, 5.1, Colour_TextTypeC if eventPlayer.Scrim_PlayerReady else Colour_TextTypeB, HudReeval.STRING_AND_COLOR, SpecVisibility.NEVER)
        if Scrim_ReadyUpCaptainMode == 1 and Scrim_AllowForceTeamReady:
            hudSubheader(eventPlayer, "[{0} + {1}] (Press) {2} / (Hold) Force Team Ready".format(buttonString(Scrims_KeybindCommand), buttonString(Scrims_KeybindReady), "Unready" if eventPlayer.Scrim_PlayerReady else "Ready Up"), HudPosition.TOP, 5.2, Colour_TextTypeB if eventPlayer.isHoldingButton(Scrims_KeybindCommand) and eventPlayer.isHoldingButton(Scrims_KeybindReady) else Colour_TextTypeA, HudReeval.STRING_AND_COLOR, SpecVisibility.NEVER)
        else:
            hudSubheader(eventPlayer, "[{0} + {1}] {2}".format(buttonString(Scrims_KeybindCommand), buttonString(Scrims_KeybindReady), "Unready" if eventPlayer.Scrim_PlayerReady else "Ready Up"), HudPosition.TOP, 5.2, Colour_TextTypeB if eventPlayer.isHoldingButton(Scrims_KeybindCommand) and eventPlayer.isHoldingButton(Scrims_KeybindReady) else Colour_TextTypeA, HudReeval.STRING_AND_COLOR, SpecVisibility.NEVER)


rule "HUD Setup: Force Ready Hold Bar":
    @Event eachPlayer
    @Condition Scrim_ReadyUpFreqMode != 2
    @Condition Scrim_AllowForceTeamReady == true

    progressBarHud(eventPlayer if eventPlayer.Scrim_CurrentHoldTime >= 0.2 else null, eventPlayer.Scrim_CurrentHoldTime / Scrim_ForceTeamReadyHoldTime * 100, null, HudPosition.TOP, 5.5, Colour_TextTypeA, null, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.NEVER)


rule "HUD Setup: Defender Teleport":
    @Event eachPlayer
    @Condition Scrim_AllowDefendersTeleport == true
    @Condition isInSetup() == true
    @Condition isTeamOnDefense(eventPlayer.getTeam()) == true

    hudSubheader(eventPlayer, "[{0} + {1}] {2}".format(buttonString(Scrims_KeybindCommand), buttonString(Scrims_KeybindDefenderTeleport), "Teleport to the Objective" if eventPlayer.isInSpawnRoom() else "Teleport Back to Spawn"), HudPosition.TOP, 5.3, Colour_TextTypeB if eventPlayer.isHoldingButton(Scrims_KeybindCommand) and eventPlayer.isHoldingButton(Scrims_KeybindDefenderTeleport) else Colour_TextTypeA, HudReeval.STRING_AND_COLOR, SpecVisibility.NEVER)


rule "HUD Setup: Add Setup Time":
    @Event eachPlayer
    @Condition Scrim_SetupAddTimeCaptainMode != 2
    @Condition isInSetup() == true

    if eventPlayer.getSlot() == 0 or Scrim_SetupAddTimeCaptainMode == 1:
        hudSubheader(eventPlayer, "[{0} + {1}] Add {2} Sec to Setup Timer ".format(buttonString(Scrims_KeybindCommand), buttonString(Scrims_KeybindAddSetupTime), Scrim_SetupAddTimeStep), HudPosition.TOP, 5.4, Colour_TextTypeB if eventPlayer.isHoldingButton(Scrims_KeybindCommand) and eventPlayer.isHoldingButton(Scrims_KeybindAddSetupTime) else Colour_TextTypeA, HudReeval.STRING_AND_COLOR, SpecVisibility.NEVER)
    else:
        hudSubheader(eventPlayer, "{0} and {1} can add {2} sec to the setup timer".format(getPlayersInSlot(0, Color.TEAM_1), getPlayersInSlot(0, Color.TEAM_2), Scrim_SetupAddTimeStep), HudPosition.TOP, 5.4, Colour_TextTypeA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)


rule "Setup: Remove Assembling Heroes":
    @Condition Scrim_RemoveAssemblingHeroes == true
    @Condition isAssemblingHeroes() == true

    setMatchTime(0)


rule "Setup: Override Setup Time":
    @Condition isInSetup() == true

    wait()
    setMatchTime(Scrim_SetupTimeOverride)


rule "Setup: Freeze Setup Time":
    @Condition Scrim_ReadyUpFreqMode != 2
    @Condition Scrim_FreezeSetupTime == true
    @Condition (getMatchRound() == 1 or Scrim_ReadyUpFreqMode == 1) == true
    @Condition isInSetup() == true

    pauseMatchTime()


rule "Setup: Add Setup Time":
    @Event eachPlayer
    @Condition Scrim_SetupAddTimeCaptainMode != 2
    @Condition isInSetup() == true
    @Condition (eventPlayer.getSlot() == 0 or Scrim_SetupAddTimeCaptainMode == 1) == true
    @Condition eventPlayer.isHoldingButton(Scrims_KeybindCommand) == true
    @Condition eventPlayer.isHoldingButton(Scrims_KeybindAddSetupTime) == true

    if getMatchTime() < Scrim_SetupAddTimeMax:
        setMatchTime(min(Scrim_SetupAddTimeMax + 0.9, Scrim_SetupAddTimeStep + getMatchTime()))
        smallMessage(getAllPlayers(), "{0} extended setup time by {1} sec".format(eventPlayer, Scrim_SetupAddTimeStep))
    else:
        smallMessage(eventPlayer, "Setup timer cannot be extended beyond {0}".format("{0}:{1}{2}".format(floor(Scrim_SetupAddTimeMax / 60), "0" if Scrim_SetupAddTimeMax % 60 < 10 else "", Scrim_SetupAddTimeMax % 60)))


rule "Setup: Teleport to Objective/Spawn (Defenders Only)":
    @Event eachPlayer
    @Condition Scrim_AllowDefendersTeleport == true
    @Condition isTeamOnDefense(eventPlayer.getTeam()) == true
    @Condition isInSetup() == true
    @Condition eventPlayer.isHoldingButton(Scrims_KeybindCommand) == true
    @Condition eventPlayer.isHoldingButton(Scrims_KeybindDefenderTeleport) == true

    if eventPlayer.isInSpawnRoom():
        eventPlayer.teleport(nearestWalkablePosition(getObjectivePosition(getCurrentObjective())))
        smallMessage(eventPlayer, "Teleported to Objective")
    else:
        eventPlayer.teleport(getSpawnPoints(eventPlayer.getTeam()))
        smallMessage(eventPlayer, "Teleported to Spawn")


rule "Setup: Toggle Player Ready / Force Team Ready":
    @Event eachPlayer
    @Condition Scrim_ReadyUpFreqMode != 2
    @Condition (getMatchRound() == 1 or Scrim_ReadyUpFreqMode == 1) == true
    @Condition (eventPlayer.getSlot() == 0 or Scrim_ReadyUpCaptainMode == 1) == true
    @Condition isInSetup() == true
    @Condition eventPlayer.isHoldingButton(Scrims_KeybindCommand) == true
    @Condition eventPlayer.isHoldingButton(Scrims_KeybindReady) == true

    if Scrim_ReadyUpCaptainMode == 1 and Scrim_AllowForceTeamReady:
        eventPlayer.Scrim_CurrentHoldTime = 0
        chase(eventPlayer.Scrim_CurrentHoldTime, Scrim_ForceTeamReadyHoldTime, duration=Scrim_ForceTeamReadyHoldTime, ChaseReeval.NONE)
        waitUntil(not (eventPlayer.isHoldingButton(Scrims_KeybindCommand) and eventPlayer.isHoldingButton(Scrims_KeybindReady)), Scrim_ForceTeamReadyHoldTime)
        stopChasingVariable(eventPlayer.Scrim_CurrentHoldTime)
        eventPlayer.Scrim_CurrentHoldTime = 0
        if eventPlayer.isHoldingButton(Scrims_KeybindCommand) and eventPlayer.isHoldingButton(Scrims_KeybindReady):
            if isInSetup():
                smallMessage(getAllPlayers(), "{0} forced {1} ready".format(eventPlayer, eventPlayer.getTeam()))
                getPlayers(eventPlayer.getTeam()).Scrim_PlayerReady = true
                if Scrim_EnableReadyVoiceLine:
                    eventPlayer.communicate(Comms.GO)
            return
    if eventPlayer.Scrim_PlayerReady:
        eventPlayer.Scrim_PlayerReady = false
    else:
        eventPlayer.Scrim_PlayerReady = true
        if Scrim_EnableReadyVoiceLine:
            eventPlayer.communicate(Comms.READY)


rule "Setup: Both Teams Ready, Start Match (Captain-Only Mode)":
    @Condition Scrim_ReadyUpFreqMode != 2
    @Condition Scrim_ReadyUpCaptainMode == 0
    @Condition (getMatchRound() == 1 or Scrim_ReadyUpFreqMode == 1) == true
    @Condition isInSetup() == true
    @Condition getPlayersInSlot(0, Color.TEAM_1).Scrim_PlayerReady == true
    @Condition getPlayersInSlot(0, Color.TEAM_2).Scrim_PlayerReady == true

    if getNumberOfPlayers(Team.ALL) < Scrim_MinimumPlayersToStart:
        smallMessage(getAllPlayers(), "Both Captains ready, but minimum number of players ({0}) not met".format(Scrim_MinimumPlayersToStart))
        return
    smallMessage(getAllPlayers(), "Both Captains ready, commencing countdown")
    if Scrim_FreezeSetupTime:
        unpauseMatchTime()
    setMatchTime(Scrim_SetupCountdownTime)
    waitUntil(getPlayersInSlot(0, Color.TEAM_1).Scrim_PlayerReady == false or getPlayersInSlot(0, Color.TEAM_2).Scrim_PlayerReady == false, Scrim_SetupCountdownTime)
    if getPlayersInSlot(0, Color.TEAM_1).Scrim_PlayerReady == false or getPlayersInSlot(0, Color.TEAM_2).Scrim_PlayerReady == false:
        smallMessage(getAllPlayers(), "Someone unreadied, resetting setup time")
        if Scrim_FreezeSetupTime:
            pauseMatchTime()
        setMatchTime(Scrim_SetupTimeOverride)


rule "Setup: Both Teams Ready, Start Match (All Players Mode)":
    @Condition Scrim_ReadyUpFreqMode != 2
    @Condition Scrim_ReadyUpCaptainMode == 1
    @Condition (getMatchRound() == 1 or Scrim_ReadyUpFreqMode == 1) == true
    @Condition isInSetup() == true
    @Condition all([player.Scrim_PlayerReady for player in getAllPlayers()]) == true

    if getNumberOfPlayers(Team.ALL) < Scrim_MinimumPlayersToStart:
        smallMessage(getAllPlayers(), "All players ready, but minimum number of players ({0}) not met".format(Scrim_MinimumPlayersToStart))
        return
    smallMessage(getAllPlayers(), "All players ready, commencing countdown")
    if Scrim_FreezeSetupTime:
        unpauseMatchTime()
    setMatchTime(Scrim_SetupCountdownTime)
    waitUntil(len([player for player in getAllPlayers() if player.Scrim_PlayerReady == true]) < len(getAllPlayers()), Scrim_SetupCountdownTime)
    if len([player for player in getAllPlayers() if player.Scrim_PlayerReady == true]) < len(getAllPlayers()):
        smallMessage(getAllPlayers(), "Someone unreadied, resetting setup time")
        if Scrim_FreezeSetupTime:
            pauseMatchTime()
        setMatchTime(Scrim_SetupTimeOverride)


rule "Game: Clean up HUD Text":
    @Condition isGameInProgress() == true

    while true:
        waitUntil(isGameInProgress(), 99999)
        destroyAllHudTexts()
        waitUntil(isMatchBetweenRounds(), 99999)
        destroyAllHudTexts()


rule "Game: Reset Player Ready Status":
    @Condition Scrim_ReadyUpFreqMode != 2
    @Condition isGameInProgress() == true

    wait()
    getAllPlayers().Scrim_PlayerReady = false
    stopChasingVariable(getAllPlayers().Scrim_CurrentHoldTime)
    getAllPlayers().Scrim_CurrentHoldTime = 0


rule "Scoreboard: Update Match Time":
    Scrim_MatchTime = 0
    while true:
        waitUntil(isGameInProgress(), 99999)
        chase(Scrim_MatchTime, 99999, rate=1, ChaseReeval.NONE)
        waitUntil(not isGameInProgress(), 99999)
        stopChasingVariable(Scrim_MatchTime)


rule "Scoreboard: Create Match Time Display":
    @Condition Scrim_DisplayMatchTime == true
    @Condition isGameInProgress() == true

    wait()
    if Scrim_ScoreboardSize == 0:
        hudSubheader(null, "{0} Match Time: {1}".format(abilityIconString(Hero.LUCIO, Button.ABILITY_2), "{0}:{1}{2}".format(floor(Scrim_MatchTime / 60), "0" if Scrim_MatchTime % 60 < 10 else "", floor(Scrim_MatchTime % 60))), HudPosition.LEFT, 4, Colour_TextTypeA, HudReeval.STRING, SpecVisibility.ALWAYS)
    else:
        hudSubtext(null, "{0} Match Time: {1}".format(abilityIconString(Hero.LUCIO, Button.ABILITY_2), "{0}:{1}{2}".format(floor(Scrim_MatchTime / 60), "0" if Scrim_MatchTime % 60 < 10 else "", floor(Scrim_MatchTime % 60))), HudPosition.LEFT, 4, Colour_TextTypeA, HudReeval.STRING, SpecVisibility.ALWAYS)


/*
rule "ScoreboardSD: Create Legend":
    @Condition isGameInProgress() == true
    @Condition Scrim_EnableSpecScoreboard == true
    @Condition Scrim_DisplayScoreboardLegend == true

    wait()
    if Scrim_ScoreboardSize == 0:
        if Scrim_ScoreboardGroupMode == 0:
            hudSubheader(null, "{0} {1}".format(abilityIconString(Hero.GENJI, Button.ULTIMATE), "K • D • DD • DT • OA • UU"), HudPosition.LEFT, 1, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubheader(null, "{0} {1}".format(abilityIconString(Hero.REINHARDT, Button.SECONDARY_FIRE), "K • D • DD • DT • DB • UU"), HudPosition.LEFT, 2, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubheader(null, "{0} {1}".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_1), "K • D • HP • DT • OA • UU"), HudPosition.LEFT, 3, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
        else:
            hudSubheader(null, "{0} {1}".format(abilityIconString(Hero.GENJI, Button.ULTIMATE), "K • D • DD • DT • OA • UU"), HudPosition.LEFT, 1.1, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubheader(null, "{0} {1}".format(abilityIconString(Hero.REINHARDT, Button.SECONDARY_FIRE), "K • D • DD • DT • DB • UU"), HudPosition.LEFT, 1.2, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubheader(null, "{0} {1}".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_1), "K • D • HP • DT • OA • UU"), HudPosition.LEFT, 1.3, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
    else:
        if Scrim_ScoreboardGroupMode == 0:
            hudSubtext(null, "{0} {1}".format(abilityIconString(Hero.GENJI, Button.ULTIMATE), "K • D • DD • DT • OA • UU"), HudPosition.LEFT, 1, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubtext(null, "{0} {1}".format(abilityIconString(Hero.REINHARDT, Button.SECONDARY_FIRE), "K • D • DD • DT • DB • UU"), HudPosition.LEFT, 2, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubtext(null, "{0} {1}".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_1), "K • D • HP • DT • OA • UU"), HudPosition.LEFT, 3, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
        else:
            hudSubtext(null, "{0} {1}".format(abilityIconString(Hero.GENJI, Button.ULTIMATE), "K • D • DD • DT • OA • UU"), HudPosition.LEFT, 1.1, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubtext(null, "{0} {1}".format(abilityIconString(Hero.REINHARDT, Button.SECONDARY_FIRE), "K • D • DD • DT • DB • UU"), HudPosition.LEFT, 1.2, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubtext(null, "{0} {1}".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_1), "K • D • HP • DT • OA • UU"), HudPosition.LEFT, 1.3, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
*/

/*
rule "ScoreboardSD: Create Player Entries (Small)":
    @Event eachPlayer
    @Condition isGameInProgress() == true
    @Condition Scrim_EnableSpecScoreboard == true
    @Condition Scrim_ScoreboardSize == 0

    wait()
    if Scrim_ScoreboardGroupMode == 0:
        hudSubheader(null, "{0} {1} • {2}".format(heroIcon(eventPlayer.getCurrentHero()), "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, (1 if eventPlayer.getCurrentHero() in getDamageHeroes() else 2 if eventPlayer.getCurrentHero() in getTankHeroes() else 3) + (0.1 if eventPlayer.getTeam() == Color.TEAM_1 else 0.2), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
    elif Scrim_ScoreboardGroupMode == 1:
        hudSubheader(null, "{0} {1} • {2}".format(heroIcon(eventPlayer.getCurrentHero()), "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, ((1 if eventPlayer.getCurrentHero() in getDamageHeroes() else 2 if eventPlayer.getCurrentHero() in getTankHeroes() else 3) * 0.1) + (2 if eventPlayer.getTeam() == Color.TEAM_1 else 3), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
    else:
        hudSubheader(null, "{0} {1} • {2}".format(heroIcon(eventPlayer.getCurrentHero()), "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, eventPlayer.getSlot() * 0.1 + (2 if eventPlayer.getTeam() == Color.TEAM_1 else 3), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
*/

/*
rule "ScoreboardSD: Create Player Entries (Medium)":
    @Event eachPlayer
    @Condition isGameInProgress() == true
    @Condition Scrim_EnableSpecScoreboard == true
    @Condition Scrim_ScoreboardSize == 1

    wait()
    if Scrim_ScoreboardGroupMode == 0:
        hudSubtext(null, "{0} {1} • {2}".format(heroIcon(eventPlayer.getCurrentHero()), "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, (1 if eventPlayer.getCurrentHero() in getDamageHeroes() else 2 if eventPlayer.getCurrentHero() in getTankHeroes() else 3) + (0.1 if eventPlayer.getTeam() == Color.TEAM_1 else 0.2), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
    elif Scrim_ScoreboardGroupMode == 1:
        hudSubtext(null, "{0} {1} • {2}".format(heroIcon(eventPlayer.getCurrentHero()), "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, ((1 if eventPlayer.getCurrentHero() in getDamageHeroes() else 2 if eventPlayer.getCurrentHero() in getTankHeroes() else 3) * 0.1) + (2 if eventPlayer.getTeam() == Color.TEAM_1 else 3), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
    else:
        hudSubtext(null, "{0} {1} • {2}".format(heroIcon(eventPlayer.getCurrentHero()), "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, eventPlayer.getSlot() * 0.1 + (2 if eventPlayer.getTeam() == Color.TEAM_1 else 3), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
*/

/*
rule "ScoreboardSD: Create Player Entries (Large)":
    @Event eachPlayer
    @Condition isGameInProgress() == true
    @Condition Scrim_EnableSpecScoreboard == true
    @Condition Scrim_ScoreboardSize == 2

    wait()
    if Scrim_ScoreboardGroupMode == 0:
        hudText(null, heroIcon(eventPlayer.getCurrentHero()), eventPlayer, "{1} • {2}".format(null, "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, (1 if eventPlayer.getCurrentHero() in getDamageHeroes() else 2 if eventPlayer.getCurrentHero() in getTankHeroes() else 3) + (0.1 if eventPlayer.getTeam() == Color.TEAM_1 else 0.2), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, Colour_TextTypeA, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
    elif Scrim_ScoreboardGroupMode == 1:
        hudText(null, heroIcon(eventPlayer.getCurrentHero()), eventPlayer, "{1} • {2}".format(null, "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, ((1 if eventPlayer.getCurrentHero() in getDamageHeroes() else 2 if eventPlayer.getCurrentHero() in getTankHeroes() else 3) * 0.1) + (2 if eventPlayer.getTeam() == Color.TEAM_1 else 3), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, Colour_TextTypeA, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
    else:
        hudText(null, heroIcon(eventPlayer.getCurrentHero()), eventPlayer, "{1} • {2}".format(null, "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, eventPlayer.getSlot() * 0.1 + (2 if eventPlayer.getTeam() == Color.TEAM_1 else 3), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, Colour_TextTypeA, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
*/

rule "ScoreboardT2: Create Legend":
    @Condition Scrim_EnableSpecScoreboard == true
    @Condition Scrim_DisplayScoreboardLegend == true
    @Condition isGameInProgress() == true

    wait()
    if Scrim_ScoreboardSize == 0:
        if Scrim_ScoreboardGroupMode == 0:
            hudSubheader(null, "{0} {1}".format(abilityIconString(Hero.GENJI, Button.ULTIMATE), "K • D • E • DD • DT • UU"), HudPosition.LEFT, 1, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubheader(null, "{0} {1}".format(abilityIconString(Hero.REINHARDT, Button.SECONDARY_FIRE), "K • D • E • DD • DT • UU"), HudPosition.LEFT, 2, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubheader(null, "{0} {1}".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_1), "K • D • E • DD • HP • UU"), HudPosition.LEFT, 3, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
        else:
            hudSubheader(null, "{0} {1}".format(abilityIconString(Hero.GENJI, Button.ULTIMATE), "K • D • E • DD • DT • UU"), HudPosition.LEFT, 1.1, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubheader(null, "{0} {1}".format(abilityIconString(Hero.REINHARDT, Button.SECONDARY_FIRE), "K • D • E • DD • DT • UU"), HudPosition.LEFT, 1.2, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubheader(null, "{0} {1}".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_1), "K • D • E • DD • HP • UU"), HudPosition.LEFT, 1.3, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
    else:
        if Scrim_ScoreboardGroupMode == 0:
            hudSubtext(null, "{0} {1}".format(abilityIconString(Hero.GENJI, Button.ULTIMATE), "K • D • E • DD • DT • UU"), HudPosition.LEFT, 1, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubtext(null, "{0} {1}".format(abilityIconString(Hero.REINHARDT, Button.SECONDARY_FIRE), "K • D • E • DD • DT • UU"), HudPosition.LEFT, 2, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubtext(null, "{0} {1}".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_1), "K • D • E • DD • HP • UU"), HudPosition.LEFT, 3, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
        else:
            hudSubtext(null, "{0} {1}".format(abilityIconString(Hero.GENJI, Button.ULTIMATE), "K • D • E • DD • DT • UU"), HudPosition.LEFT, 1.1, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubtext(null, "{0} {1}".format(abilityIconString(Hero.REINHARDT, Button.SECONDARY_FIRE), "K • D • E • DD • DT • UU"), HudPosition.LEFT, 1.2, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)
            hudSubtext(null, "{0} {1}".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_1), "K • D • E • DD • HP • UU"), HudPosition.LEFT, 1.3, Colour_TextTypeA, HudReeval.NONE, SpecVisibility.ALWAYS)


rule "ScoreboardT2: Create Player Entries (Small)":
    @Event eachPlayer
    @Condition Scrim_EnableSpecScoreboard == true
    @Condition Scrim_ScoreboardSize == 0
    @Condition isGameInProgress() == true

    wait()
    if Scrim_ScoreboardGroupMode == 0:
        hudSubheader(null, "{0} {1} • {2}".format(heroIcon(eventPlayer.getCurrentHero()), "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), eventPlayer.getStatistic(Stat.ELIMINATIONS)), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT)), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, (1 if eventPlayer.getCurrentHero() in getDamageHeroes() else 2 if eventPlayer.getCurrentHero() in getTankHeroes() else 3) + (0.1 if eventPlayer.getTeam() == Color.TEAM_1 else 0.2), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
    elif Scrim_ScoreboardGroupMode == 1:
        hudSubheader(null, "{0} {1} • {2}".format(heroIcon(eventPlayer.getCurrentHero()), "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, ((1 if eventPlayer.getCurrentHero() in getDamageHeroes() else 2 if eventPlayer.getCurrentHero() in getTankHeroes() else 3) * 0.1) + (2 if eventPlayer.getTeam() == Color.TEAM_1 else 3), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
    else:
        hudSubheader(null, "{0} {1} • {2}".format(heroIcon(eventPlayer.getCurrentHero()), "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, eventPlayer.getSlot() * 0.1 + (2 if eventPlayer.getTeam() == Color.TEAM_1 else 3), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)


rule "ScoreboardT2: Create Player Entries (Medium)":
    @Event eachPlayer
    @Condition Scrim_EnableSpecScoreboard == true
    @Condition Scrim_ScoreboardSize == 1
    @Condition isGameInProgress() == true

    wait()
    if Scrim_ScoreboardGroupMode == 0:
        hudSubtext(null, "{0} {1} • {2}".format(heroIcon(eventPlayer.getCurrentHero()), "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, (1 if eventPlayer.getCurrentHero() in getDamageHeroes() else 2 if eventPlayer.getCurrentHero() in getTankHeroes() else 3) + (0.1 if eventPlayer.getTeam() == Color.TEAM_1 else 0.2), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
    elif Scrim_ScoreboardGroupMode == 1:
        hudSubtext(null, "{0} {1} • {2}".format(heroIcon(eventPlayer.getCurrentHero()), "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, ((1 if eventPlayer.getCurrentHero() in getDamageHeroes() else 2 if eventPlayer.getCurrentHero() in getTankHeroes() else 3) * 0.1) + (2 if eventPlayer.getTeam() == Color.TEAM_1 else 3), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
    else:
        hudSubtext(null, "{0} {1} • {2}".format(heroIcon(eventPlayer.getCurrentHero()), "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, eventPlayer.getSlot() * 0.1 + (2 if eventPlayer.getTeam() == Color.TEAM_1 else 3), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)


rule "ScoreboardT2: Create Player Entries (Large)":
    @Event eachPlayer
    @Condition Scrim_EnableSpecScoreboard == true
    @Condition Scrim_ScoreboardSize == 2
    @Condition isGameInProgress() == true

    wait()
    if Scrim_ScoreboardGroupMode == 0:
        hudText(null, heroIcon(eventPlayer.getCurrentHero()), eventPlayer, "{1} • {2}".format(null, "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), eventPlayer.getStatistic(Stat.ELIMINATIONS)), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT)), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, (1 if eventPlayer.getCurrentHero() in getDamageHeroes() else 2 if eventPlayer.getCurrentHero() in getTankHeroes() else 3) + (0.1 if eventPlayer.getTeam() == Color.TEAM_1 else 0.2), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, Colour_TextTypeA, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
    elif Scrim_ScoreboardGroupMode == 1:
        hudText(null, heroIcon(eventPlayer.getCurrentHero()), eventPlayer, "{1} • {2}".format(null, "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, ((1 if eventPlayer.getCurrentHero() in getDamageHeroes() else 2 if eventPlayer.getCurrentHero() in getTankHeroes() else 3) * 0.1) + (2 if eventPlayer.getTeam() == Color.TEAM_1 else 3), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, Colour_TextTypeA, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)
    else:
        hudText(null, heroIcon(eventPlayer.getCurrentHero()), eventPlayer, "{1} • {2}".format(null, "{0} • {1} • {2}".format(eventPlayer.getStatistic(Stat.FINAL_BLOWS), eventPlayer.getStatistic(Stat.DEATHS), round(eventPlayer.getStatistic(Stat.HEALING_DEALT)) if eventPlayer.getCurrentHero() in getSupportHeroes() else round(eventPlayer.getStatistic(Stat.HERO_DAMAGE_DEALT))), "{0} • {1} • {2}".format(round(eventPlayer.getStatistic(Stat.DAMAGE_TAKEN)), round(eventPlayer.getStatistic(Stat.DAMAGE_BLOCKED)) if eventPlayer.getCurrentHero() in getTankHeroes() else eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS), eventPlayer.getStatistic(Stat.ULTIMATES_USED))), HudPosition.LEFT, eventPlayer.getSlot() * 0.1 + (2 if eventPlayer.getTeam() == Color.TEAM_1 else 3), Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, Colour_TeamOne if eventPlayer.getTeam() == Color.TEAM_1 else Colour_TeamTwo, Colour_TextTypeA, HudReeval.SORT_ORDER_AND_STRING, SpecVisibility.ALWAYS)


rule "Scoreboard: Host Spectator Toggle":
    @Condition Scrim_EnableSpecScoreboard == true
    @Condition Scrim_AllowHostHideScoreboard == true
    @Condition isGameInProgress() == true
    @Condition hostPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition hostPlayer.isHoldingButton(Button.ABILITY_1) == true
    @Condition hostPlayer.getTeam() == Team.ALL

    if Scrim_HideScoreboardID == null:
        smallMessage(getAllPlayers(), "Host Toggled Scoreboard Off")
        hudSubtext(null, " \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", HudPosition.LEFT, 0, Colour_TextTypeA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
        Scrim_HideScoreboardID = getLastCreatedText()
    else:
        smallMessage(getAllPlayers(), "Host Toggled Scoreboard On")
        destroyHudText(Scrim_HideScoreboardID)
        Scrim_HideScoreboardID = null


rule "Map Completion: Save Team Scores on Round End":
    @Condition getCurrentGamemode() != Gamemode.CONTROL
    @Condition isMatchBetweenRounds() == true

    if isTeamOnOffense(Color.TEAM_1):
        Scrim_TeamOneScore = teamScore(Color.TEAM_1)
    else:
        Scrim_TeamTwoScore = teamScore(Color.TEAM_2)


rule "Map Completion: Ensure Map Completion (Non-Control)":
    @Condition Scrim_MapCompletionMode == true
    @Condition isMatchBetweenRounds() == true
    @Condition getCurrentGamemode() != Gamemode.CONTROL
    @Condition (teamScore(Color.TEAM_1 if isTeamOnOffense(Color.TEAM_1) else Color.TEAM_2)) < (2 if getCurrentGamemode() == Gamemode.ASSAULT else 3)

    wait()
    if getCurrentGamemode() == Gamemode.ASSAULT:
        smallMessage(getAllPlayers(), "Setting {0} score to {1} to ensure map completion".format(Color.TEAM_1 if isTeamOnOffense(Color.TEAM_1) else Color.TEAM_2, 2))
        setTeamScore(Color.TEAM_1 if isTeamOnOffense(Color.TEAM_1) else Color.TEAM_2, 2)
    else:
        smallMessage(getAllPlayers(), "Setting {0} score to {1} to ensure map completion".format(Color.TEAM_1 if isTeamOnOffense(Color.TEAM_1) else Color.TEAM_2, 3))
        setTeamScore(Color.TEAM_1 if isTeamOnOffense(Color.TEAM_1) else Color.TEAM_2, 3)


rule "Map Completion: Force Match End After Two Rounds (Non-Control)":
    @Condition Scrim_ForceNonControlTwoRounds != 2
    @Condition getCurrentGamemode() != Gamemode.CONTROL
    @Condition isMatchBetweenRounds() == true
    @Condition getMatchRound() == 2

    if Scrim_ForceNonControlTwoRounds == 0 and (Scrim_TeamOneScore + Scrim_TeamTwoScore == (4 if getCurrentGamemode() == Gamemode.ASSAULT else 6)):
        smallMessage(getAllPlayers(), "Both teams completed map, match will proceed as normal")
    else:
        smallMessage(getAllPlayers(), "Concluding match after two rounds")
        wait(1)
        declareDraw()


rule "Map Completion: Force Match End After Three Rounds (Control)":
    @Condition Scrim_ForceControlThreeRounds == true
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition teamScore(Color.TEAM_1) + teamScore(Color.TEAM_2) == 3

    smallMessage(getAllPlayers(), "Concluding match after three rounds")
    wait(1)
    declareTeamVictory(Color.TEAM_1 if teamScore(Color.TEAM_1) > teamScore(Color.TEAM_2) else Color.TEAM_2)


rule "Logs: Match Start":
    @Condition Logs_EnableLogTracker == true
    @Condition getMatchRound() == 1

    if true:
        printLog(",match_start,{0},{1}".format("{0},{1},{2}".format(Scrim_MatchTime, getCurrentMap(), getCurrentGamemode()), "{0},{1}".format(Color.TEAM_1, Color.TEAM_2)))


rule "Logs: Round Start":
    @Condition Logs_EnableLogTracker == true
    @Condition isInSetup() == true

    Logs_CurrentControlScoringTeam = Team.ALL
    Logs_CurrentObjectiveIndex = getCurrentObjective()
    if true:
        printLog(",round_start,{0},{1},{2}".format("{0},{1},{2}".format(Scrim_MatchTime, getMatchRound(), (Color.TEAM_1 if isTeamOnOffense(Color.TEAM_1) else Color.TEAM_2) if getCurrentGamemode() != Gamemode.CONTROL else null), "{0},{1}".format(teamScore(Color.TEAM_1), teamScore(Color.TEAM_2)), "{0}".format(getCurrentObjective())))
        waitUntil(isGameInProgress(), 99999)
        printLog(",setup_complete,{0}".format("{0},{1},{2}".format(Scrim_MatchTime, getMatchRound(), getMatchTime())))


rule "Logs: Round Complete":
    @Condition Logs_EnableLogTracker == true
    @Condition isMatchBetweenRounds() == true

    printLog(",round_end,{0},{1},{2}".format("{0},{1},{2}".format(Scrim_MatchTime, getMatchRound(), (Color.TEAM_1 if isTeamOnOffense(Color.TEAM_1) else Color.TEAM_2) if getCurrentGamemode() != Gamemode.CONTROL else null), "{0},{1}".format(teamScore(Color.TEAM_1), teamScore(Color.TEAM_2)), "{0},{1},{2}".format(getCurrentObjective(), "{0},{1}".format(getControlScorePercentage(Color.TEAM_1), getControlScorePercentage(Color.TEAM_2)), getMatchTime())))


rule "Logs: Match Complete":
    @Condition Logs_EnableLogTracker == true
    @Condition isMatchComplete() == true

    printLog(",match_end,{0},{1},{2}".format("{0},{1}".format(Scrim_MatchTime, getMatchRound()), "{0}".format(teamScore(Color.TEAM_1)), "{0}".format(teamScore(Color.TEAM_2))))


rule "Logs: Control Point Increment":
    @Condition Logs_EnableLogTracker == true
    @Condition Logs_PointCaptureProgressStep > 0
    @Condition isGameInProgress() == true
    @Condition getCapturePercentage() >= Logs_PointCaptureProgress + Logs_PointCaptureProgressStep

    printLog(",point_progress,{0},{1}".format("{0},{1}".format(Scrim_MatchTime, getMatchRound()), "{0},{1},{2}".format(getOppositeTeam(getControlScoringTeam()) if getCurrentGamemode() == Gamemode.CONTROL else Color.TEAM_1 if isTeamOnOffense(Color.TEAM_1) else Color.TEAM_2, getCurrentObjective(), getCapturePercentage())))
    Logs_PointCaptureProgress += Logs_PointCaptureProgressStep


rule "Logs: Payload Increment":
    @Condition Logs_EnableLogTracker == true
    @Condition Logs_PayloadCaptureProgressStep > 0
    @Condition isGameInProgress() == true
    @Condition getPayloadProgressPercentage() >= Logs_PayloadCaptureProgress + Logs_PayloadCaptureProgressStep

    printLog(",payload_progress,{0},{1}".format("{0},{1}".format(Scrim_MatchTime, getMatchRound()), "{0},{1},{2}".format(Color.TEAM_1 if isTeamOnOffense(Color.TEAM_1) else Color.TEAM_2, getCurrentObjective(), getPayloadProgressPercentage())))
    Logs_PayloadCaptureProgress += Logs_PayloadCaptureProgressStep


rule "Logs: Reset Control Point Progress":
    @Condition Logs_EnableLogTracker == true
    @Condition Logs_PointCaptureProgressStep > 0
    @Condition isGameInProgress() == true
    @Condition getCapturePercentage() == 0

    Logs_PointCaptureProgress = 0


rule "Logs: Reset Payload Progress":
    @Condition Logs_EnableLogTracker == true
    @Condition Logs_PayloadCaptureProgressStep > 0
    @Condition isGameInProgress() == true
    @Condition getPayloadProgressPercentage() == 0

    Logs_PayloadCaptureProgress = 0


rule "Logs: Objective Captured (Non-Control)":
    @Condition Logs_EnableLogTracker == true
    @Condition getCurrentGamemode() != Gamemode.CONTROL
    @Condition isObjectiveComplete(Logs_CurrentObjectiveIndex) == true

    printLog(",objective_captured,{0},{1},{2}".format("{0},{1}".format(Scrim_MatchTime, getMatchRound()), "{0},{1}".format(Color.TEAM_1 if isTeamOnOffense(Color.TEAM_1) else Color.TEAM_2, getCurrentObjective()), "{0},{1},{2}".format(null, null, getMatchTime())))
    Logs_CurrentObjectiveIndex = getCurrentObjective()


rule "Logs: Objective Captured (Control)":
    @Condition Logs_EnableLogTracker == true
    @Condition isGameInProgress() == true
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition getControlScoringTeam() != Logs_CurrentControlScoringTeam

    printLog(",objective_captured,{0},{1},{2}".format("{0},{1}".format(Scrim_MatchTime, getMatchRound()), "{0},{1}".format(getControlScoringTeam(), getCurrentObjective()), "{0},{1},{2}".format(getControlScorePercentage(Color.TEAM_1), getControlScorePercentage(Color.TEAM_2), getMatchTime())))
    Logs_CurrentControlScoringTeam = getControlScoringTeam()


rule "Logs: Kills":
    @Event playerDied
    @Condition Logs_EnableLogTracker == true
    @Condition isGameInProgress() == true

    printLog(",kill,{0},{1}".format(Scrim_MatchTime, "{0},{1},{2}".format("{0},{1},{2}".format(attacker.getTeam(), attacker, attacker.getCurrentHero()), "{0},{1},{2}".format(victim.getTeam(), victim, victim.getCurrentHero()), "{0},{1},{2}".format("{0},{1}".format(eventAbility, eventDamage), eventWasCriticalHit, eventWasEnvironment))))


rule "Logs: Hero Spawn/Swap":
    @Event eachPlayer
    @Condition Logs_EnableLogTracker == true
    @Condition eventPlayer.getCurrentHero() != eventPlayer.Logs_LastHero
    @Condition isMatchComplete() == false

    if eventPlayer.getCurrentHero() in getAllHeroes():
        if eventPlayer.Logs_LastHero in getAllHeroes():
            printLog(",hero_swap,{0},{1},{2}".format(Scrim_MatchTime, "{0},{1}".format(eventPlayer.getTeam(), eventPlayer), "{0},{1},{2}".format(eventPlayer.getCurrentHero(), eventPlayer.Logs_LastHero, Scrim_MatchTime - eventPlayer.Logs_LastHeroTime)))
        else:
            printLog(",hero_spawn,{0},{1},{2}".format(Scrim_MatchTime, "{0},{1}".format(eventPlayer.getTeam(), eventPlayer), "{0},{1},{2}".format(eventPlayer.getCurrentHero(), eventPlayer.Logs_LastHero, Scrim_MatchTime - eventPlayer.Logs_LastHeroTime)))
    if not eventPlayer.getCurrentHero() in eventPlayer.Logs_HeroesPlayedArray and eventPlayer.getCurrentHero() in getAllHeroes():
        eventPlayer.Logs_HeroesPlayedArray.append(eventPlayer.getCurrentHero())
    if eventPlayer.getCurrentHero() in getAllHeroes() and eventPlayer.Logs_LastHero in getAllHeroes():
        CalcHeroPlayedTime()
    eventPlayer.Logs_LastHero = eventPlayer.getCurrentHero()
    eventPlayer.Logs_LastHeroTime = Scrim_MatchTime


def CalcHeroPlayedTime():
    @Name "Logs SUBR: Calculate Hero Played Time"

    eventPlayer.Logs_HeroesPlayedTimeArray[eventPlayer.Logs_HeroesPlayedArray.index(eventPlayer.Logs_LastHero)] += Scrim_MatchTime - eventPlayer.Logs_LastHeroTime


rule "Logs: Damage":
    @Event playerDealtDamage
    @Condition Logs_EnableLogTracker == true
    @Condition isGameInProgress() == true

    printLog(",damage,{0},{1}".format(Scrim_MatchTime, "{0},{1},{2}".format("{0},{1},{2}".format(attacker.getTeam(), attacker, attacker.getCurrentHero()), "{0},{1},{2}".format(victim.getTeam(), victim, victim.getCurrentHero()), "{0},{1},{2}".format("{0},{1}".format(eventAbility, eventDamage), eventWasCriticalHit, eventWasEnvironment))))


rule "Logs: Healing":
    @Event playerReceivedHealing
    @Condition Logs_EnableLogTracker == true
    @Condition isGameInProgress() == true

    printLog(",healing,{0},{1}".format(Scrim_MatchTime, "{0},{1},{2}".format("{0},{1},{2}".format(healer.getTeam(), healer, healer.getCurrentHero()), "{0},{1},{2}".format(healee.getTeam(), healee, healee.getCurrentHero()), "{0},{1},{2}".format(eventAbility, eventHealing, eventWasHealthPack))))


rule "Logs: Offensive Assists":
    @Event eachPlayer
    @Condition Logs_EnableLogTracker == true
    @Condition eventPlayer.Logs_OffensiveAssists < eventPlayer.getStatistic(Stat.OFFENSIVE_ASSISTS)
    @Condition isGameInProgress() == true

    printLog(",offensive_assist,{0},{1},{2}".format("{0}".format(Scrim_MatchTime), "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()), "{0}".format(eventPlayer.getHeroOfDuplication())))
    eventPlayer.Logs_OffensiveAssists += 1
    if RULE_CONDITION:
        goto RULE_START


rule "Logs: Defensive Assists":
    @Event eachPlayer
    @Condition Logs_EnableLogTracker == true
    @Condition eventPlayer.Logs_DefensiveAssists < eventPlayer.getStatistic(Stat.DEFENSIVE_ASSISTS)
    @Condition isGameInProgress() == true

    printLog(",defensive_assist,{0},{1},{2}".format("{0}".format(Scrim_MatchTime), "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()), "{0}".format(eventPlayer.getHeroOfDuplication())))
    eventPlayer.Logs_DefensiveAssists += 1
    if RULE_CONDITION:
        goto RULE_START


rule "Logs: Ability 1 Used":
    @Event eachPlayer
    @Condition Logs_EnableLogTracker == true
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition isGameInProgress() == true

    printLog(",ability_1_used,{0},{1},{2}".format("{0}".format(Scrim_MatchTime), "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()), "{0}".format(eventPlayer.getHeroOfDuplication())))


rule "Logs: Ability 2 Used":
    @Event eachPlayer
    @Condition Logs_EnableLogTracker == true
    @Condition eventPlayer.isUsingAbility2() == true
    @Condition isGameInProgress() == true

    printLog(",ability_2_used,{0},{1},{2}".format("{0}".format(Scrim_MatchTime), "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()), "{0}".format(eventPlayer.getHeroOfDuplication())))


rule "Logs: Ultimate Charged":
    @Event eachPlayer
    @Condition Logs_EnableLogTracker == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition isGameInProgress() == true

    eventPlayer.Logs_UltimateID += 1
    if eventPlayer.getCurrentHero() == Hero.DVA and eventPlayer.isInAlternateForm():
        printLog(",remech_charged,{0},{1},{2}".format("{0}".format(Scrim_MatchTime), "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()), "{0},{1}".format(eventPlayer.getHeroOfDuplication(), eventPlayer.Logs_UltimateID)))
    else:
        printLog(",ultimate_charged,{0},{1},{2}".format("{0}".format(Scrim_MatchTime), "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()), "{0},{1}".format(eventPlayer.getHeroOfDuplication(), eventPlayer.Logs_UltimateID)))


rule "Logs: Ultimate Used":
    @Event eachPlayer
    @Condition Logs_EnableLogTracker == true
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.getCurrentHero() != Hero.DVA
    @Condition isGameInProgress() == true

    printLog(",ultimate_start,{0},{1},{2}".format("{0}".format(Scrim_MatchTime), "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()), "{0},{1}".format(eventPlayer.getHeroOfDuplication(), eventPlayer.Logs_UltimateID)))
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    printLog(",ultimate_end,{0},{1},{2}".format("{0}".format(Scrim_MatchTime), "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()), "{0},{1}".format(eventPlayer.getHeroOfDuplication(), eventPlayer.Logs_UltimateID)))


rule "Logs: D.Va Remech/Self-Destruct Used":
    @Event eachPlayer
    @Condition Logs_EnableLogTracker == true
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.getCurrentHero() == Hero.DVA
    @Condition isGameInProgress() == true

    wait(1.74)
    if not eventPlayer.isInAlternateForm():
        printLog(",dva_remech,{0},{1},{2}".format("{0}".format(Scrim_MatchTime), "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()), "{0}".format(eventPlayer.Logs_UltimateID)))
    elif true:
        printLog(",ultimate_start,{0},{1},{2}".format("{0}".format(Scrim_MatchTime), "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()), "{0},{1}".format(eventPlayer.getHeroOfDuplication(), eventPlayer.Logs_UltimateID)))
        waitUntil(not eventPlayer.isUsingUltimate(), 99999)
        printLog(",ultimate_end,{0},{1},{2}".format("{0}".format(Scrim_MatchTime), "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()), "{0},{1}".format(eventPlayer.getHeroOfDuplication(), eventPlayer.Logs_UltimateID)))


rule "Logs: Echo Duplicate":
    @Event eachPlayer
    @Condition Logs_EnableLogTracker == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.isDuplicatingAHero() == true

    eventPlayer.Logs_DuplicateID = eventPlayer.Logs_UltimateID
    printLog(",echo_duplicate_start,{0},{1},{2}".format(Scrim_MatchTime, "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()), "{0},{1}".format(eventPlayer.getHeroOfDuplication(), eventPlayer.Logs_DuplicateID)))
    waitUntil(not eventPlayer.isDuplicatingAHero(), 99999)
    printLog(",echo_duplicate_end,{0},{1},{2}".format(Scrim_MatchTime, "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()), eventPlayer.Logs_DuplicateID))


rule "Logs: Mercy Resurrect":
    @Event eachPlayer
    @Condition Logs_EnableLogTracker == true
    @Condition isGameInProgress() == true
    @Condition eventPlayer.isDead() == true

    waitUntil(eventPlayer.isAlive(), 99999)
    wait(0.24)
    if not eventPlayer.isInSpawnRoom() and isGameInProgress():
        printLog(",mercy_rez,{0},{1}".format(Scrim_MatchTime, "{0},{1}".format("{0},{1},{2}".format(eventPlayer.getTeam(), getPlayersOnHero(Hero.MERCY, eventPlayer.getTeam()), Hero.MERCY), "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.getCurrentHero()))))


rule "Logs: Player Stat Summary":
    @Event eachPlayer
    @Condition Logs_EnableLogTracker == true
    @Condition (Logs_PlayerSummaryFrequency == 0 or Logs_PlayerSummaryFrequency == 1 and isMatchComplete()) == true
    @Condition isMatchBetweenRounds() == true

    CalcHeroPlayedTime()
    for eventPlayer.Logs_CurrentHeroIterator in range(len(eventPlayer.Logs_HeroesPlayedArray)):
        eventPlayer.Logs_CurrentHeroIterated = eventPlayer.Logs_HeroesPlayedArray[eventPlayer.Logs_CurrentHeroIterator]
        printLog(",player_stat,{0},{1},{2}".format("{0},{1}".format(Scrim_MatchTime, getMatchRound()), "{0},{1},{2}".format(eventPlayer.getTeam(), eventPlayer, eventPlayer.Logs_CurrentHeroIterated), "{0},{1}".format("{0},{1},{2}".format("{0},{1},{2}".format("{0},{1},{2}".format(eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.ELIMINATIONS), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.FINAL_BLOWS), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.DEATHS)), "{0},{1},{2}".format(eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.DAMAGE_DEALT), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.BARRIER_DAMAGE_DEALT), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.HERO_DAMAGE_DEALT)), "{0},{1},{2}".format(eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.HEALING_DEALT), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.HEALING_RECEIVED), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.SELF_HEALING))), "{0},{1},{2}".format("{0},{1}".format(eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.DAMAGE_TAKEN), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.DAMAGE_BLOCKED)), "{0},{1}".format(eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.DEFENSIVE_ASSISTS), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.OFFENSIVE_ASSISTS)), "{0},{1}".format(eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.ULTIMATES_EARNED), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.ULTIMATES_USED))), "{0},{1}".format("{0},{1},{2}".format(eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.MULTIKILL_BEST), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.MULTIKILLS), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.SOLO_KILLS)), "{0},{1},{2}".format(eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.OBJECTIVE_KILLS), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.ENVIRONMENTAL_KILLS), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.ENVIRONMENTAL_DEATHS)))), "{0},{1}".format("{0},{1},{2}".format("{0},{1}".format(eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.CRITICAL_HITS), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.CRITICAL_HIT_ACCURACY)), "{0},{1},{2}".format(eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.SCOPED_ACCURACY), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.SCOPED_CRITICAL_HIT_ACCURACY), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.SCOPED_CRITICAL_HIT_KILLS)), "{0},{1},{2}".format(eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.SHOTS_FIRED), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.SHOTS_HIT), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.SHOTS_MISSED))), "{0},{1}".format("{0},{1},{2}".format(eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.SCOPED_SHOTS), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.SCOPED_HITS), eventPlayer.getHeroStatistic(eventPlayer.Logs_CurrentHeroIterated, HeroStat.WEAPON_ACCURACY)), eventPlayer.Logs_HeroesPlayedTimeArray[eventPlayer.Logs_CurrentHeroIterator])))))
    Logs_PlayerSummaryCount += 1


rule "Debug: Force Ready (Interact + Ability 1)":
    @Event eachPlayer
    @Condition Scrim_DebugMode == true
    @Condition isInSetup() == true
    @Condition hostPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition hostPlayer.isHoldingButton(Button.ABILITY_1) == true

    getAllPlayers().Scrim_PlayerReady = true


rule "Debug: Reduce Timer to 5 (Interact + Alt Fire)":
    @Event eachPlayer
    @Condition Scrim_DebugMode == true
    @Condition hostPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition hostPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true

    setMatchTime(5)


rule "Debug: Spawn Test Bot (Interact + Melee)":
    @Condition Scrim_DebugMode == true
    @Condition hostPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition hostPlayer.isHoldingButton(Button.MELEE) == true

    createDummy(Hero.REAPER, getOppositeTeam(hostPlayer.getTeam()), -1, hostPlayer.getPosition(), vect(0, 0, 0))


rule "Debug: Automatically End Match":
    @Condition Scrim_DebugMode == true
    @Condition Logs_AutoMatchEndTime < 3600

    wait(Logs_AutoMatchEndTime)
    declareTeamVictory(Team.ALL)


rule "Debug: Display Server Loads":
    @Condition Scrim_DebugMode == true
    @Condition Scrim_DisplayServerLoad == true
    @Condition isGameInProgress() == true

    wait()
    hudSubheader(getAllPlayers(), "{0} Current Server Load\r\n{1} Average Server Load\r\n{2} Peak Server Load".format(getServerLoad(), getAverageServerLoad(), getPeakServerLoad()), HudPosition.LEFT, 100, Colour_TextTypeA, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)


rule "Disable Inspector Recording if not debug":
    @Condition devMode == false
    @Condition Logs_EnableLogTracker == false

    disableInspector()
