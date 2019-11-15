class Button {
    constructor(value, x, y, w, h) {
        this.value = value;
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.hovered = false;
        this.pressed = false;
    }
    show() {
        strokeWeight(2);
        stroke(255);
        if (this.hovered) {
            fill(255, 100);
        } else {
            fill(255, 50);
        }
        rect(this.x, this.y, this.w, this.h, 12);
        if (this.hovered) {
            fill(0);
            stroke(0);
        } else {
            fill(255);
            
        }
        textSize(40);
        textAlign(CENTER);
        text(this.value, this.x + this.w / 2, this.y + this.h * 0.75);
    }
    isMouseInZone(mx, my) {
        return (mx >= this.x && mx < this.x + this.w && my >= this.y && my < this.y + this.h);
    }
    hover(mx, my) {
       if (this.isMouseInZone(mx, my) || this.pressed) {
           this.hovered = true;
       } else {
           this.hovered = false;
       }
    }
    isPressed(mx, my) {
        if (this.isMouseInZone(mx, my)) {
            this.pressed = !this.pressed;
        } 
    }
}