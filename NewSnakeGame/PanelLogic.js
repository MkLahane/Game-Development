class PanelLogic {
  constructor() {
    this.panels = [];
    this.panels.push(new Panel());
  }
  show() {
    for (let panel of this.panels) {
      panel.show();
    }
  }
  check(sn) {
    if (sn.snakes.length <= 0) {
      return;
    }
    for (let i = this.panels.length - 1; i >= 0; i--) {
      let panel = this.panels[i];
      if (panel.check(sn)) {
        this.panels.splice(i, 1);
        //this.addPanel();
        break;
      }
    }
  }
  addPanel() {
    this.panels.push(new Panel());
  }
  update() {
    for (let i = this.panels.length - 1; i >= 0; i--) {
      this.panels[i].update();
      if (this.panels[i].offscreen()) {
        this.panels.splice(i, 1);
        this.addPanel();
      }
    }
  }
}
