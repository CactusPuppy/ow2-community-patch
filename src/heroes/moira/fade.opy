#!mainFile "../../main.opy"

globalvar moiraFadeCleanseRadius = createWorkshopSetting(float[1:3], "Moira Fade Cleanse", "Range - How close should Moira be to the teammate?", 2, 0)

playervar FadePlayerInRange
playervar FadePlayersCleansed


rule "Moira using Fade - Clear debuffs from allies":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.isUsingAbility1() == true

    #Get player near Moira
    eventPlayer.FadePlayerInRange = ([player for player in getPlayers(eventPlayer.getTeam()) if player != eventPlayer and not player in eventPlayer.FadePlayersCleansed and distance(eventPlayer, player) <= moiraFadeCleanseRadius])[0]
    if eventPlayer.FadePlayerInRange:
        eventPlayer.FadePlayersCleansed = eventPlayer.FadePlayersCleansed.concat(eventPlayer.FadePlayerInRange)
        #Set Phased Out to clear debuffs not created by the Workshop
        eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 0.05)
        #Cleanse all negative statuses set by the Workshop
        eventPlayer.FadePlayerInRange.clearStatusEffect(Status.HACKED)
        eventPlayer.FadePlayerInRange.clearStatusEffect(Status.BURNING)
        eventPlayer.FadePlayerInRange.clearStatusEffect(Status.KNOCKED_DOWN)
        # eventPlayer.FadePlayerInRange.clearStatusEffect(Status.ASLEEP)
        eventPlayer.FadePlayerInRange.clearStatusEffect(Status.ROOTED)
        eventPlayer.FadePlayerInRange.clearStatusEffect(Status.STUNNED)
        playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.VIOLET, eventPlayer.FadePlayerInRange, 1.5)
        playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.BLACK, eventPlayer.FadePlayerInRange, 1.5)
        playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.VIOLET, eventPlayer.FadePlayerInRange, 50)
    wait()
    eventPlayer.FadePlayerInRange = null
    if RULE_CONDITION:
        goto RULE_START
    #Reset array
    eventPlayer.FadePlayersCleansed = []


