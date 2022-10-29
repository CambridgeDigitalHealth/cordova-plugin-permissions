var exec = require('cordova/exec');

function Permissions() {}

Permissions.prototype.request = function (value, success, error) {
  exec(success, error, 'Permissions', 'request', [value + '']);
};

// Permissions.prototype.check = function (value) {
//   return new Promise((resolve, reject) => {
//     const success = (data) => resolve(data);
//     const error = (err) => reject(err);
//     exec(success, error, 'Permissions', 'check', [value + '']);
//   });
// };

Permissions.install = function () {
  window.permissions = new Permissions();
  return window.permissions;
};

cordova.addConstructor(Permissions.install);
