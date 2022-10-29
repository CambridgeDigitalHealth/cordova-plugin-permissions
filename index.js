class Permissions {
  constructor() {
    this.listening = false;
    this.ready = false;

    const fn = (fnName) => {
      return (data) =>
        new Promise((resolve, reject) => {
          this.isReady()
            .then(() => {
              window.permissions[fnName](data).then((result) => {
                resolve(result);
              });
            })
            .catch((e) => {
              reject(e);
            });
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
