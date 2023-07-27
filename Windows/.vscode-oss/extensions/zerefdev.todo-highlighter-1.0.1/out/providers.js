"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TodoTreeListProvider = void 0;
const vscode_1 = require("vscode");
const constants_1 = require("./constants");
const decoration_1 = require("./decoration");
class TodoTreeListProvider {
    constructor() {
        this._onDidChangeTreeData = new vscode_1.EventEmitter();
        this.onDidChangeTreeData = this._onDidChangeTreeData.event;
    }
    getTreeItem(element) {
        return element;
    }
    async getChildren(element) {
        if (!element)
            return Promise.resolve(await this.getTodoList());
        return Promise.resolve(element.children ?? []);
    }
    async getTodoList() {
        const arr1 = [];
        const files = await vscode_1.workspace.findFiles(pattern(decoration_1.Decoration.include(), constants_1.INCLUDE), pattern(decoration_1.Decoration.exclude(), constants_1.EXCLUDE), constants_1.MAX_RESULTS);
        if (files.length) {
            for (let i = 0; i < files.length; i++) {
                const arr2 = [];
                const file = files[i];
                const doc = await vscode_1.workspace.openTextDocument(file);
                const docUri = doc.uri;
                const fileName = doc.fileName
                    .replace(/\\/g, '/')
                    .split('/').pop()
                    ?? 'unknown';
                let k = 1;
                for (let j = 0; j < doc.lineCount; j++) {
                    const text = doc.lineAt(j).text;
                    if (constants_1.REGEX.test(text)) {
                        const todoText = text.slice(text.indexOf(constants_1.TODO) + constants_1.TODO.length + 1, text.length);
                        if (todoText) {
                            arr2.push(new Todo(`${k}. ${todoText}`, undefined, docUri, j));
                            k++;
                        }
                    }
                }
                if (arr2.length)
                    arr1.push(new Todo(fileName, arr2, docUri));
            }
        }
        // TODO: find a better way
        return arr1.sort(({ label: label1 }, { label: label2 }) => {
            const l1 = label1.toLowerCase();
            const l2 = label2.toLowerCase();
            if (l1 < l2)
                return -1;
            if (l1 > l2)
                return 1;
            return 0;
        });
    }
    refresh() {
        this._onDidChangeTreeData.fire();
    }
}
exports.TodoTreeListProvider = TodoTreeListProvider;
class Todo extends vscode_1.TreeItem {
    constructor(label, children, path, col) {
        super(label, children ? vscode_1.TreeItemCollapsibleState.Expanded : vscode_1.TreeItemCollapsibleState.None);
        this.label = label;
        this.children = children;
        this.iconPath = children ? new vscode_1.ThemeIcon('file') : undefined;
        this.resourceUri = children ? path : undefined;
        this.description = !!children;
        this.command = !children ? {
            command: constants_1.COMMANDS.OPEN_FILE,
            title: 'Open file',
            arguments: [path, col]
        } : undefined;
    }
}
function pattern(glob, def) {
    if (Array.isArray(glob) && glob.length) {
        return '{' + glob.join(',') + '}';
    }
    return '{' + def.join(',') + '}';
}
//# sourceMappingURL=providers.js.map