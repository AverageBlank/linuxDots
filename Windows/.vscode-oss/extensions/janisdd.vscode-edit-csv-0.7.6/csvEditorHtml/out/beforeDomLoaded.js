"use strict";
document.documentElement.style.setProperty('--extension-options-bar-display', (initialConfig === null || initialConfig === void 0 ? void 0 : initialConfig.optionsBarAppearance) === "collapsed" ? `none` : `block`);
document.documentElement.style.setProperty('--extension-side-panel-display', (initialConfig === null || initialConfig === void 0 ? void 0 : initialConfig.sidePanelAppearance) === "collapsed" ? `none` : `flex`);
document.documentElement.style.setProperty('--extension-side-panel-expand-icon-display', (initialConfig === null || initialConfig === void 0 ? void 0 : initialConfig.sidePanelAppearance) === "collapsed" ? `block` : `none`);
document.documentElement.style.setProperty('--extension-side-panel-collapse-icon-display', (initialConfig === null || initialConfig === void 0 ? void 0 : initialConfig.sidePanelAppearance) === "collapsed" ? `none` : `block`);
document.documentElement.style.setProperty('--extension-table-font-family', (initialConfig === null || initialConfig === void 0 ? void 0 : initialConfig.fontFamilyInTable) === "sameAsCodeEditor" ? `var(--vscode-editor-font-family)` : `inherit`);
//# sourceMappingURL=beforeDomLoaded.js.map