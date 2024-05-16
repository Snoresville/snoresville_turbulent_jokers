import os
import shutil

repo_folder_path = os.path.abspath(__file__) + "\\..\\.."
sprites_path = "aseprite"
target_path = "website\\public\\img\\"

target_sprites = list(filter(lambda x: x[-6:] == "1x.png" or x[-6:] == "2x.png", os.listdir(repo_folder_path + "\\" + sprites_path)))

for sprite_name in target_sprites:
    sprite_is_2x = sprite_name[-6:] == "2x.png"
    if sprite_is_2x:
        sprite_path = repo_folder_path + "\\" + sprites_path + "\\" + sprite_name
        sprite_mod_asset_path = repo_folder_path + "\\" + target_path + sprite_name.replace("_" + ("2x" if sprite_is_2x else "1x"), "")

        shutil.copyfile(sprite_path, sprite_mod_asset_path)
