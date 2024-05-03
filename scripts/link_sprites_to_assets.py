import os

repo_folder_path = os.path.abspath(os.getcwd()) + "\\.."
sprites_path = "aseprite"
assets_path = "SnoresvilleTurbulentJokers\\assets"

target_sprites = list(filter(lambda x: x[-6:] == "1x.png" or x[-6:] == "2x.png", os.listdir(repo_folder_path + "\\" + sprites_path)))

for sprite_name in target_sprites:
    sprite_is_2x = sprite_name[-6:] == "2x.png"
    sprite_path = repo_folder_path + "\\" + sprites_path + "\\" + sprite_name
    sprite_mod_asset_path = repo_folder_path + "\\" + assets_path + ("\\2x\\" if sprite_is_2x else "\\1x\\") + sprite_name.replace("_" + ("2x" if sprite_is_2x else "1x"), "")

    if not os.path.exists(sprite_mod_asset_path):
        os.symlink(sprite_path, sprite_mod_asset_path)
        print("Linked " + sprite_name)
    else:
        print("Skipping " + sprite_name)