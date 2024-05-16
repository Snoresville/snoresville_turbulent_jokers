:: Gets the path of this file since Administrator cmd starts at C:/Windows/system32
SET mypath=%~dp0
cd %mypath:~0,-1%

cd ../website
npm run predeploy
npm run deploy