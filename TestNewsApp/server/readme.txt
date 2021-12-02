Setup for macOS:

1 Install Cakebrew app. https://www.cakebrew.com
2 Via Cakebrew install virtualenv
3 Via Cakebrew install brew-pip
4 cd to this folder
5 virtualenv venv
6 . venv/bin/activate
7 pip install Flask
8 python __init__.py



Server will be started from 127.0.0.1:5001 and can be accessed locally also as localhost:5001
From other devices - you need to get address of the computer - (option + right click) on the wifi icon on the top right corner
Address to access from other devices in a workgroup will looks like 10.0.1.2:5001

start server (cd to folder) -
. venv/bin/activate
python __init__.py

quit server - 
Ctrl+C

exit from venv -
deactivate
