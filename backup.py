import colorama as color
import filecmp
import io
import os
import shutil
import socket
import sys
from datetime import datetime

timestamp = datetime.now().strftime("%Y_%m_%d_%H-%M-%S") + "_" + socket.gethostname()

f = open("list", "r")
gamePathOnSystem = f.readlines()

for path in gamePathOnSystem:
    entry = path.split("~")
    entry[1] = entry[1].split("\n")[0]
    if os.path.exists(entry[1]) is True:
        abspath = os.path.abspath(entry[1])

        savesDir = 'SAVES\\' + entry[0]
        os.makedirs(savesDir, 0o777, True)

        if len(os.listdir(savesDir)) != 0:
            lastSaveDir = os.listdir(savesDir)[-1]

            old_stdout = sys.stdout
            new_stdout = io.StringIO()
            sys.stdout = new_stdout
            filecmp.dircmp(abspath, savesDir + "\\" + lastSaveDir).report_full_closure()
            print(os.listdir(abspath))
            print(os.listdir(savesDir + "\\" + lastSaveDir))

            output = new_stdout.getvalue()
            sys.stdout = old_stdout
            diffcount = output.count('Only')
            if diffcount != 0:
                print(f'{color.Fore.GREEN}New save!{entry[0]}{color.Style.RESET_ALL} save folder found. ')
                newGameSaveFolder = savesDir + '\\' + timestamp
                os.makedirs(newGameSaveFolder, 0o777, True)
                shutil.copytree(abspath, newGameSaveFolder, dirs_exist_ok=True)
            else:
                print(f'{color.Fore.YELLOW}Skipping! {entry[0]}{color.Style.RESET_ALL} save dir found but the last backup is the same as current game state.')
        else:
            print(f'{color.Fore.BLUE}First save! {entry[0]}{color.Style.RESET_ALL} save folder.')
            os.makedirs(newGameSaveFolder, 0o777, True)
            shutil.copytree(abspath, newGameSaveFolder, dirs_exist_ok=True)
    else:
        print(f'{color.Fore.RED}Nothing to do here... {entry[0]}{color.Style.RESET_ALL} save folder was not found. ')
