#!mainFile "../../main.opy"


def CleanupMercy():
    @Name "[mercy.del] Subroutine: Cleanup"
    
    CleanupTexts()
    CleanupHealingMods()
    CleanupEffects()
    getAllPlayers().stopForcingOutlineFor(eventPlayer.AngelicBlessingTarget)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.allowButton(Button.ABILITY_2)
    eventPlayer.AngelicBlessingTarget.allowButton(Button.INTERACT)


def InitialMercy():
    @Name "[mercy.del] Subroutine: Initial"
    
    eventPlayer.HealingPercents = []
    eventPlayer.DegenerationEnabled = []
    eventPlayer.Index = 0
    while eventPlayer.Index < 5:
        eventPlayer.HealingPercents[eventPlayer.Index] = 1
        eventPlayer.DegenerationEnabled[eventPlayer.Index] = false
        eventPlayer.Index += 1
    eventPlayer.Index = 0
    while eventPlayer.Index < 5:
        startHealingModification(getPlayersInSlot(evalOnce(eventPlayer.Index), eventPlayer.getTeam()), eventPlayer, eventPlayer.HealingPercents[evalOnce(eventPlayer.Index)] * 100, HealingReeval.RECEIVERS_HEALERS_AND_HEALPERCENT)
        eventPlayer.HeroHealingModifications.append(getLastHealingModification())
        #BUG: Mercy's degeneration visual showing when the player in slot does not exist
        createInWorldText(eventPlayer if entityExists(getPlayersInSlot(evalOnce(eventPlayer.Index), eventPlayer.getTeam())) else null, "[{0}{1}%]\n".format(abilityIconString(Hero.BAPTISTE, Button.ABILITY_1), eventPlayer.HealingPercents[evalOnce(eventPlayer.Index)] * 100), getPlayersInSlot(evalOnce(eventPlayer.Index), eventPlayer.getTeam()), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        eventPlayer.HeroTexts.append(getLastCreatedText())
        eventPlayer.Index += 1
    eventPlayer.disallowButton(Button.ABILITY_2)
    #Create Hud
    hudSubtext(eventPlayer, "{0}({1})".format(" \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n \r\n {0}".format("                                                                                                                            {0}".format("                                                                                                                            {0}".format("                                                                                             " if eventPlayer.isInAlternateForm() else "                                                                     "))), "Blessing"), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.HeroTexts.append(getLastCreatedText())
