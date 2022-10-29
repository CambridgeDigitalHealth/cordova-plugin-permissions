# cordova-plugin-permissions

## Setup
 - Install plugin in your ionic project:
```bash
npm install --save \
  git@github.com:CambridgeDigitalHealth/cordova-plugin-haptics.git; \
ionic cordova plugin add cordova-plugin-haptics
```
 - To uninstall:
```bash
ionic cordova plugin rm cordova-plugin-haptics
```

## Usage
```javascript
import { Haptics, ImpactStyle, NotificationType } from 'cordova-plugin-haptics';

const perform = async () => {
  const haptics = new Haptics();
  // impact
  await haptics.impact(ImpactStyle.Light);
  await wait(500);
  await haptics.impact(ImpactStyle.Medium);
  await wait(500);
  await haptics.impact(ImpactStyle.Heavy);
  // notification
  await wait(2000);
  await haptics.notification(NotificationType.Success);
  await wait(1000);
  await haptics.notification(NotificationType.Warning);
  await wait(1000);
  await haptics.notification(NotificationType.Error);
  // selection
  await wait(2000);
  await haptics.selectionStart();
  await haptics.selectionChanged();
  await wait(1000);
  await haptics.selectionChanged();
  await wait(1000);
  await haptics.selectionChanged();
  await haptics.selectionEnd();
  // vibration
  await wait(2000);
  await haptics.vibrate(150);
  await wait(500);
  await haptics.vibrate(300);
  await wait(500);
  await haptics.vibrate(600);
};

const wait = (ms: number) => new Promise((resolve) => setTimeout(resolve, ms));

perform();
```
