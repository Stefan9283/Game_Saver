# Game_Saver

The script is supposed to be used inside a Windows Subsystem for Linux.

## What it does:

The last game save is stored inside the SAVES dir at a certain location based on the game name and timestamp.
The files inside the SAVE dir are checked so that no 2 successive game saves should be the same.

## Configs needed:

The lines in the list should have the following structure:  **GAME_NAME~WINDOWS_PATH**

The **WINDOWS_PATH** gets converted automatically to a WSL compatible one so spaces can now be used.

TODO: add a restore script
