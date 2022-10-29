# cordova-plugin-permissions

## Setup
 - Install plugin in your ionic project:
```bash
npm install --save \
  git@github.com:CambridgeDigitalHealth/cordova-plugin-permissions.git; \
ionic cordova plugin add cordova-plugin-permissions
```
 - To uninstall:
```bash
ionic cordova plugin rm cordova-plugin-permissions
```

## Usage
```javascript
import { Permissions } from 'cordova-plugin-permissions';

const check = async () => {
  const permissions = new Permissions();
  await permissions.request("camera");
  await permissions.request("photos");
};

check().catch(e => console.error(e));
```
