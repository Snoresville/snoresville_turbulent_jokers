import os
import shutil

repo_folder_path = os.path.abspath(os.getcwd()) + "\\.."
mods_folder_path = os.getenv('APPDATA') + "\\Balatro\\Mods"

if not os.path.exists(mods_folder_path + "\\SnoresvilleTurbulentJokers"):
    shutil.move(repo_folder_path + "\\SnoresvilleTurbulentJokers", mods_folder_path)
    os.symlink(mods_folder_path + "\\SnoresvilleTurbulentJokers", repo_folder_path + "\\SnoresvilleTurbulentJokers")
    print("Installed and linked mod folder (Windows)")
else:
    print("Skipped installing mod folder (Windows)")