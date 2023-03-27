# CW rework of [QB-Racing](https://github.com/ItsANoBrainer/qb-racing)

This is a rework of the superb free resource [QB-Racing](https://github.com/ItsANoBrainer/qb-racing) by ItsANoBrainer.


**Some of the added features:**
- Integration with [cw-performance](https://github.com/Coffeelot/cw-performance) to create class based racing
- Advanced leaderboard for each track and class showing everyones best times
- By-class leaderboard
- Replacement of tire-piles lamps
- Increased size of checkpoints
- Not as harsh checkpoint-pass detection compared to qb-racing
- Remove race tracks you have created
- See your position in the race
- Updated HUD
- Accurate time (old one would vary depending on computer performance) **NOW IN MS!**
- Ability to reset/run the SQL scripts from in game
- Phasing/Ghosting of racers
- Ability to lock tracks down to people by citizen ID


**Original features by ItsANoBrainer:**
- Standalone racing script not requiring qb-phone to utilize
- Items to immerse your racing scene with Racer Names
- Config options to adjust item permissions to your liking
- Config options to adjust different options
- Locale Support
- Create Custom Races Tracks

**Planned:** 
- Better track editing

# Developed by Coffeelot and Wuggie
[More scripts by us](https://github.com/stars/Coffeelot/lists/cw-scripts)  👈

**Support, updates and script previews**:

[![Join The discord!](https://cdn.discordapp.com/attachments/977876510620909579/1013102122985857064/discordJoin.png)](https://discord.gg/FJY4mtjaKr )

**All our scripts are and will remain free**. If you want to support what we do, you can buy us a coffee here:

[![Buy Us a Coffee](https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg)](https://www.buymeacoffee.com/cwscriptbois )

# Racing App

This script lets you manage your racing scene in a better way using items and custom racer names instead of player names! There are two items involved, the `master racing fob`, and the `basic racing fob`. At the moment, these are created using the `createracingfob` command by a qb-core admin, but you can implement any system you want. When created, the fob is bound to the citizenid it was created for, and has a racer name attached to it. Only the citizenid created for it can use it. Using the fob brings up the racing options menu (examples below) which is where you do all the interacting with the script. Each fob has an entry in the Config to tune it to your server to allow or deny certain usage abilities (listed below). By default the master racing fob is required to CREATE new race tracks, and both dongles allow you to do everything else.

Config Options per Dongle:
 - Join a race
 - View race records
 - Setup a new race
 - Create a new race track

# Preview 📽
[![YOUTUBE VIDEO](http://img.youtube.com/vi/APtMydz4gF8/0.jpg)](https://youtu.be/APtMydz4gF8)

Update to track editor:

[![YOUTUBE VIDEO](http://img.youtube.com/vi/N_HI0jAsgbg/0.jpg)](https://youtu.be/N_HI0jAsgbg)
## Setup
You only need either this resource and [cw-performance](https://github.com/Coffeelot/cw-performance).

1. Update or insert the database table. Instructions are found in the `racing.sql` file
* Option 1: Updating from qb-lapraces must follow OPTION 1 to update their database table and preserve their race tracks
* Option 2: NOT updating from qb-lapraces must follow OPTION 2 to create the database table 
2. Adjust values in the `config.lua` file to your likings
3. Add the items to your `qb-core/shared/items.lua`
```lua
['fob_racing_basic'] = {['name'] = 'fob_racing_basic', ['label'] = 'Basic Racing Fob', ['weight'] = 500, ['type'] = 'item', ['image'] = 'fob_racing_basic.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['description'] = 'This basic fob allows someone to join custom races.'},
['fob_racing_master'] = {['name'] = 'fob_racing_master', ['label'] = 'Master Racing Fob', ['weight'] = 500, ['type'] = 'item', ['image'] = 'fob_racing_master.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['description'] = 'This master fob allows someone to create custom races.'},
```
4. Add the item images to your inventory image folder
5. Setup your DB by running one of these commands:

`/resetracetracks` - This command will remove the current `race_tracks` table and add a new one (good if you got bad data)  (warning: all tracks and records will be gone)

`/updateracetracks` - This command will update the `race_tracks` table from how it's done in qb-racing. This DOES NOT reset any laptimes and **old ones WILL BREAK** the script. If you're still getting issues consider wiping old records or using the other command.

Then restart cw-racingapp

Also, note that you **CAN NOT** spawn the racing fobs with `/giveitem`. Spawn them with the built in command `/createracingfob` or get one at the trader or laptop

> NOTE: If you're getting errors after a later update (released 27th March 2023) do `/addAccessCol`

## Dependencies
* [qb-menu](https://github.com/qbcore-framework/qb-menu)
* [qb-input](https://github.com/qbcore-framework/qb-input)
* [cw-performance](https://github.com/Coffeelot/cw-performance)



## Example Usage
### Interface Images

**Main Menu**

![Interface](https://i.imgur.com/49027bo.png)

**Leaderboards**
Change from normal qb-racing: Sorted by track, added classes and added full list of laptimes. Each person can have one entry per class + track, so you can have multiple times on a track, with different classes, but the script keeps track of your best times.

![Interface](https://i.imgur.com/8480LVX.png)
![Interface](https://i.imgur.com/H7Trlzz.png)
![Interface](https://i.imgur.com/5FthsBY.png)

**Setting up a Race**
Change from normal qb-racing: Added classes to list. If you set up a race with A class, people can join with A and lower, but not higher.

![Interface](https://i.imgur.com/4r6iriO.png)

# Uninstalling or full reset
## /removeracetracks
Drops the `race_tracks` table. Use this if you're uninstalling (warning: all tracks and records will be gone)
## Developed by Coffeelot#1586, Wuggie#1683
