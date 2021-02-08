import colorama as color
import filecmp
import io
import os
import shutil
import sys

restoreAll = False

f = open("list", "r")
gamePathOnSystem = f.readlines()

for path in gamePathOnSystem:
    entry = path.split("~")
    entry[1] = entry[1].split("\n")[0]
    print(entry)

    savesDir = 'SAVES\\' + entry[0]

    if os.path.exists(savesDir) and len(os.listdir(savesDir)) != 0:
        lastSaveDir = os.listdir(savesDir)[-1]
        if os.path.exists(entry[1]) is False and restoreAll is False:
            print(f"{entry[0]} doesn't seem to have ever been played on the system.\n"
                  "Are you sure you want to restore the save for it?\n"
                  "[Y/N/A]")
            inp = input()
            if inp.count('N') != 0:
                continue
            elif inp.count('A') != 0:
                restoreAll = True
        os.makedirs(entry[1], 0o777, True)
        old_stdout = sys.stdout
        new_stdout = io.StringIO()
        sys.stdout = new_stdout
        abspath = os.path.abspath(entry[1])
        filecmp.dircmp(abspath, savesDir + "\\" + lastSaveDir).report_full_closure()
        output = new_stdout.getvalue()
        sys.stdout = old_stdout
        diffcount = output.count('Only')
        print(diffcount)
        if diffcount != 0:
            print(f'{color.Fore.GREEN}{entry[0]}{color.Style.RESET_ALL} doesn\'t have the latest save. Restoring...')
            shutil.rmtree(abspath)
            shutil.copytree(savesDir + "\\" + lastSaveDir, abspath)
        else:
            print(f'{color.Fore.YELLOW}Skipping! {entry[0]}{color.Style.RESET_ALL} save dir found but the current game state is the same as the last backup.')

        abspath = os.path.abspath(entry[1])
        print(lastSaveDir)

    else:
        print(f'{color.Fore.RED}Skipping! {entry[0]}{color.Style.RESET_ALL} has no backups')

    print("\n")
