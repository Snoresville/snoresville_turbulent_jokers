:: Gets the path of this file since Administrator cmd starts at C:/Windows/system32
SET mypath=%~dp0
cd %mypath:~0,-1%

py ./copy_sprites_to_web.py
cd ../website
npm run deploy