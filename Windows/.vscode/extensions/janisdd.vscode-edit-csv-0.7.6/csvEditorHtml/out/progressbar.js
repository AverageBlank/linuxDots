"use strict";
class Progressbar {
    constructor(id) {
        this.id = id;
        this.el = document.getElementById(id);
        if (!this.el) {
            throw new Error(`could not find element with id ${id}`);
        }
    }
    setValue(percentage) {
        this.el.style.right = `${100 - percentage}%`;
    }
    show() {
        this.el.style.display = 'block';
    }
    hide() {
        this.el.style.display = 'none';
    }
}
//# sourceMappingURL=progressbar.js.map