#!mainFile "../../main.opy"


rule "Primary Damage":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition (not eventPlayer.isMeleeing()) == true
    @Condition (not eventPlayer.isUsingAbility1() and not eventPlayer.isUsingAbility2() and not eventPlayer.isUsingUltimate() and not eventPlayer.isFiringSecondaryFire()) == true
    @Condition not hardCCd(eventPlayer)
    @Condition eventPlayer.getAmmo(0) > 0
    @Condition (not eventPlayer.Punching) == true

    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.setDamageDealt(900 / 6.6)
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.setDamageDealt(100)
    eventPlayer.setPrimaryFireEnabled(false)
    wait(0.333)
    if RULE_CONDITION:
        goto RULE_START
    wait()
    if RULE_CONDITION:
        goto RULE_START
