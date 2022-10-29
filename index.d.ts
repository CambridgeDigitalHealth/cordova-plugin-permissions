declare module 'cordova-plugin-permissions' {
  export class Permissions {
    constructor();
    request(type: string): Promise<void>;
  }
}
