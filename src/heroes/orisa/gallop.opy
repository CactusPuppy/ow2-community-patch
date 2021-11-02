#!mainFile "../../main.opy"


globalvar orisaGallopDuration = createWorkshopSetting(float[0.1:2], "Orisa", "Time gallop duration", 0.5, 0)
globalvar orisaGallopDelay = createWorkshopSetting(float[0:2], "Orisa", "Gallop cast time", 0.1, 1)
globalvar orisaGallopDamage = createWorkshopSetting(int[0:200], "Orisa", "Time gallop damage dealt", 75, 2)
globalvar orisaGallopCooldown = createWorkshopSetting(float[1:20], "Orisa", "Time gallop cooldown", 10, 0)


rule "[orisa.del] Gallop":
    @Event eachPlayer
    @Hero orisa
    @Condition (eventPlayer.isHoldingButton(Button.ULTIMATE) or eventPlayer.isHoldingButton(Button.ABILITY_2)) == true
    @Condition not specialAbilitiesDisabled(eventPlayer)

    if eventPlayer.isHoldingButton(Button.ULTIMATE):
        wait(0.4)
        waitUntil(not eventPlayer.isUsingUltimate(), 0.3)
        return
    if eventPlayer.CastingUltimate:
        return
    if eventPlayer.getAbilityCooldown(Button.ABILITY_2) > 0:
        return
    #Communication
    eventPlayer.setDamageDealt(0)
    eventPlayer.forceButtonPress(Button.MELEE)
    eventPlayer.cancelPrimaryAction()
    eventPlayer.setAbilityCooldown(Button.MELEE, 0)
    #Disable
    eventPlayer.setPrimaryFireEnabled(false)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.disallowButton(Button.ULTIMATE)
    #Start transition to third person camera
    eventPlayer.startCamera(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection(), 30)
    wait(0.048)
    eventPlayer.startCamera(raycast(worldVector(vect(0, 0, 0), eventPlayer, Transform.ROTATION_AND_TRANSLATION), worldVector(vect(0, 3, -2), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition(), worldVector(vect(0, 3, 0), eventPlayer, Transform.ROTATION_AND_TRANSLATION), 30)
    #Create effects
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.GOOD_AURA, Color.LIME_GREEN, updateEveryTick(eventPlayer.getEyePosition()), 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.HeroEffects.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.GOOD_AURA, Color.RED, updateEveryTick(eventPlayer.getEyePosition()), 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.HeroEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.WINSTON_PRIMAL_RAGE, eventPlayer.getTeam(), updateEveryTick(eventPlayer.getEyePosition()), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.HeroEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.ENERGY_SOUND, eventPlayer.getTeam(), updateEveryTick(eventPlayer.getEyePosition()), 500, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.HeroEffects.append(getLastCreatedEntity())
    playEffect(getAllPlayers(), DynamicEffect.DEBUFF_IMPACT_SOUND, eventPlayer.getTeam(), eventPlayer.getEyePosition(), 500)
    playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.getEyePosition(), 500)
    #Casting
    eventPlayer.HeroAbsoluteSpeedMod = 0
    eventPlayer.startFacing(vect(0, 0, 1), 500, Relativity.TO_PLAYER, FacingReeval.DIRECTION_AND_TURN_RATE)
    waitUntil(specialAbilitiesDisabled(eventPlayer), orisaGallopDelay)
    eventPlayer.setDamageDealt(100)
    #Gallop
    eventPlayer.startForcingThrottle(1, 1, 0, 0, 0, 0)
    eventPlayer.HeroAbsoluteSpeedMod = 500
    eventPlayer.disablePlayerCollision()
    eventPlayer.forceButtonPress(Button.MELEE)
    eventPlayer.Galloping = true
    eventPlayer.ExcludedPlayers = []
    eventPlayer.TimeRemaining = 0
    chase(eventPlayer.TimeRemaining, 9999, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    while eventPlayer.TimeRemaining < orisaGallopDuration:
        if (not isInLoS(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(Vector.FORWARD * 2, eventPlayer, Transform.ROTATION), BarrierLos.PASS_THROUGH_BARRIERS)) or specialAbilitiesDisabled(eventPlayer):
            #Stop Gallop
            break
        else:
            eventPlayer.TargetPlayers = [player for player in getPlayersInRadius(eventPlayer.getEyePosition(), 5, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES) if eventPlayer.isInViewAngle(player.getEyePosition(), 90)].exclude(eventPlayer.ExcludedPlayers)
            damage(eventPlayer.TargetPlayers, eventPlayer, orisaGallopDamage)
            eventPlayer.ExcludedPlayers.append(eventPlayer.TargetPlayers)
        wait()
    stopChasingVariable(eventPlayer.TimeRemaining)
    CleanupEffects()
    #Stop movement
    eventPlayer.stopForcingThrottle()
    eventPlayer.HeroAbsoluteSpeedMod = 0
    eventPlayer.enablePlayerCollision()
    eventPlayer.setAbilityCooldown(Button.MELEE, 0)
    eventPlayer.Galloping = false
    wait(0.4)
    #Start transition into first person camera
    eventPlayer.startCamera(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection(), 30)
    wait(0.25)
    eventPlayer.stopCamera()
    #Set cooldown / restore movement
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, orisaGallopCooldown)
    eventPlayer.HeroAbsoluteSpeedMod = 100
    eventPlayer.stopFacing()
    #Re-enable
    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.allowButton(Button.ULTIMATE)


rule "[orisa.del] Galloping Knockback":
    @Event playerTookDamage
    @Condition attacker.hero == Hero.ORISA
    @Condition attacker.Galloping == true
    @Condition eventAbility == null

    victim.applyImpulse(eventDirection + Vector.UP / 2, 20, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setEnvironmentalKillCreditor(attacker)
