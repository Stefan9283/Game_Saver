# Game_Saver

The script is supposed to be used inside a Windows Subsystem for Linux.

## What it does:

The last game save is stored inside the SAVES dir at a certain location based on the game name and timestamp.
The files inside the SAVE dir are checked so that no 2 successive game saves should be the same.

## Configs needed:

1. The lines in the list should have the following structure:  **WINDOWS_PATH/GAME_NAME**

where the **WINDOWS_PATH** must begin with C: and contain \ between every 2 dirs (It's basically the every Windows path).

In case spaces are included they **must** be replaced with the keyword [SPACE].

2. Inside the script the **PREFIX** variable must be changed if it doesn't match your path for the C: partition root.


3. The command "dos2unix backup.sh list" must be run. (if all the modifications were done from inside the shell this step can be skipped)


TODO: add a restore script
