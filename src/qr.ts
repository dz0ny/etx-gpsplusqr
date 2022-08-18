import { App } from "./app";

let app!: App;

function init(w: number = LCD_W, h: number = LCD_H): void {
    app = new App(w, h);
}

function run(event: any, touchState: any): number {
    return app.run(event, touchState);
}

function bg(): number {
    return app.bg();
}

export { init, run, bg }
