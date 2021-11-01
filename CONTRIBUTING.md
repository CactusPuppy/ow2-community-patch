# Developer Guidelines

When developing for this mode, please abide by the following conventions:

- Always use `player.hero` to check a player's effective hero. Never use `@Hero`, `player.getCurrentHero()`, or `getPlayersOnHero()`.
  - The only exception is if you are working on the hero swap code contained in [`src/general/resets.opy`](src/general/resets.opy).

- Put all hero-related setup and cleanup into the relevant subroutines.
  - For example, Reinhardt's setup would be contained in the subroutine called `InitialReinhardt`, and the cleanup would be contained in the subroutine `CleanupReinhardt`.
  - Utilize the `HeroHealthPools` and `HeroTexts` subroutines when creating health pools and text elements, and call `CleanupHealthPools` and `CleanupTexts` during hero cleanup if need be.

- Declare all adjustable Workshop settings in the initialization of a global or player variable. This ensures the ordering of the Workshop Settings page remains consistent.
  - Correct:
    ```python
    globalvar heroSpecificTweakableSetting = createWorkshopSetting(...)

    rule "Use the setting":
      smallMessage(getAllPlayers(), heroSpecificTweakableSetting)
    ```
  - Correct:
    ```python
    globalvar arrayOfSettings = [createWorkshopSetting(...), createWorkshopSetting(...), ...]
    globalvar index

    rule "Use all the settings":
      for index in range(len(arrayOfSettings)):
        smallMessage(getAllPlayers(), arrayOfSettings[evalOnce(index)])
    ```
  - Incorrect:
    ```python
    rule "In-line the setting":
      smallMessage(getAllPlayers(), createWorkshopSetting(...))
    ```
  - Incorrect:
    ```python
    globalvar tweakableSetting

    rule "Initialize the setting in a rule":
      tweakableSetting = createWorkshopSetting(...)
    ```

- Never use `setMoveSpeed`. Instead, use the player variables `AddSpeedMod`, `MultSpeedMod`, and `HeroAbsoluteSpeedMod`.
  - `AddSpeedMod` is for adding a percentage move speed to a player. This value should only ever be added to or subtracted from.
    - For example, to add 10% move speed to a player, do `player.AddSpeedMod += 10`.
  - `MultSpeedMod` is for multiplying base speed by a certain factor (e.g. 1.5 for an additional 50% move speed). This value should only ever be multiplied or divided.
    - For example, to double the move speed of a player, do `player.MultSpeedMod *= 2`.
  - `HeroAbsoluteSpeedMod` is for a speed mod that affects all movements of a hero. It should essentially act as if the base movement speed of the player has been changed to this percentage of their actual base speed. This value should only ever be set directly.
    - For example, to prevent a hero from moving regardless of other circumstances (e.g. when casting an ability), do `player.HeroAbsoluteSpeedMod = 0`. Note that to undo the previous changes, the value should be set to 100 (e.g. `player.HeroAbsoluteSpeedMod = 100`). One should prefer using `AddSpeedMod` or `MultSpeedMod`, and only use `HeroAbsoluteSpeedMod` when absolutely necessary.
