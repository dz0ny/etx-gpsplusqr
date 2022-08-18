const plusmap = ["2", "3", "4", "5", "6", "7", "8", "9", "C", "F",
    "G", "H", "J", "M", "P", "Q", "R", "V", "W", "X"]

export class App {
    public w: number = 0;
    public h: number = 0;
    public latitude: number = 0.0;
    public longitude: number = 0.0;
    private gps: any = null;
    private showqr: boolean = false;

    constructor(w: number, h: number) {
        this.w = w;
        this.h = h;
        this.latitude = 0;
        this.longitude = 0;
        if (getFieldInfo("GPS") != null) {
            this.gps = getFieldInfo("GPS").id;
        }
    }
    private getcode(lat: number, lon: number) {
        let int = math.floor(lat)
        let codepair = plusmap[int]
        lat = 20 * (lat - int)
        int = math.floor(lon)
        codepair = `${codepair}${plusmap[int]}`
        lon = 20 * (lon - int)
        return [lat, lon, codepair] as const
    }

    private pluscode(): string {
        let latc = (this.latitude + 90) / 20
        let lonc = (this.longitude + 180) / 20
        let pluscode = ""
        for (let index = 1; index <= 4; index++) {
            const [latl, lonl, _] = this.getcode(latc, lonc)
            latc = latl
            lonc = lonl
        }
        pluscode += "+"
        const [latp, lonp, codepair] = this.getcode(latc, lonc)
        latc = latp
        lonc = lonp
        pluscode += codepair
        pluscode += plusmap[4 * math.floor(latc / 5) + math.floor(lonc / 4)]
        return pluscode
    }

    private draw() {
        const mid = this.w / 2;
        lcd.clear();
        if (this.showqr) {
            const url = `https://www.google.com/maps/search/?api=1&query=${this.latitude}%2C${this.longitude}`
            const qr1 = qrcodegen.QrCode.encodeText(url, qrcodegen.QrCode.Ecc.MEDIUM);
            for (let y = 0; y < qr1.size; y++) {
                for (let x = 0; x < qr1.size; x++) {
                    if (qr1.getModule(x, y)) {
                        lcd.drawPoint(mid + x, y)
                    }
                }
            }
        } else {
            lcd.drawText(mid - 53, 5, "GPS coordinates are")
            lcd.drawText(mid - 44, 15, `${this.latitude} , ${this.longitude}`)
            lcd.drawText(mid - 49, 35, "Google Plus Code is")
            lcd.drawText(mid - 32, 45, this.pluscode())
        }
    }

    private keyHandler(event: any) {
        switch (event) {
            case EVT_VIRTUAL_NEXT: // right
            case EVT_VIRTUAL_PREV: // left
                this.showqr != this.showqr;
                break;
        }
    }

    public bg(): number {
        if (this.gps != null) {
            this.latitude = this.gps.lat;
            this.longitude = this.gps.lon;
        }
        return 0;
    }

    public run(event: any, touchState: any): number {
        this.draw();
        this.keyHandler(event);
        return 0;
    }
}