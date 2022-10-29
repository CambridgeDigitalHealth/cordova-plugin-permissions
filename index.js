class Permissions {
  constructor() {
    this.listening = false;
    this.ready = false;

    const fn = (fnName) => {
      return (data) =>
        new Promise(async (resolve, reject) => {
          await this.isReady();
          window.permissions[fnName](data, resolve, reject);
        });
    };
    this.request = fn('request');
    // this.check = fn('check');
  }

  isReady() {
    return new Promise((resolve) => {
      if (this.ready) {
        resolve(true);
      } else {
        if (!this.listening) {
          document.addEventListener(
            'deviceready',
            () => {
              this.ready = true;
              resolve(true);
            },
            false
          );
          this.listening = true;
        }
      }
    });
  }
}

module.exports = { Permissions };
