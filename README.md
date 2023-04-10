Homework

To run (tested on MacOS):

- `git clone https://github.com/kasparsj/homework`
- `cd homework`
- `npm i`
- `node_modules/.bin/cordova run android`
- `node_modules/.bin/cordova run ios`

if that does not work, try:
- `cd ..`
- `git clone https://github.com/kasparsj/homework-plugin`
- `cd homework`
- `node_modules/.bin/cordova plugin remove cordova-plugin-homework`
- `node_modules/.bin/cordova plugin add ../homework-plugin`

this might fix it - you can try running again
- `node_modules/.bin/cordova run android`
- `node_modules/.bin/cordova run ios`

or if it does not fix then try removing and re-adding the platforms as well:
- `node_modules/.bin/cordova platform remove android`
- `node_modules/.bin/cordova platform add android`
- `node_modules/.bin/cordova run android`
- `node_modules/.bin/cordova platform remove ios`
- `node_modules/.bin/cordova platform add ios`
- `node_modules/.bin/cordova run ios`