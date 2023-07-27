"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.activate = void 0;
const vscode_1 = require("vscode");
const constants_1 = require("./constants");
const decoration_1 = require("./decoration");
const providers_1 = require("./providers");
function activate(ctx) {
    const todoTreeList = new providers_1.TodoTreeListProvider();
    let editor = vscode_1.window.activeTextEditor;
    vscode_1.window.registerTreeDataProvider(constants_1.VIEWS.TODO_LIST, todoTreeList);
    decoration_1.Decoration.config(vscode_1.workspace.getConfiguration(constants_1.EXTENSION_ID));
    styleText(editor);
    ctx.subscriptions.push(vscode_1.commands.registerCommand(constants_1.COMMANDS.REFRESH, () => {
        todoTreeList.refresh();
    }));
    ctx.subscriptions.push(vscode_1.commands.registerCommand(constants_1.COMMANDS.OPEN_FILE, (uri, col) => {
        vscode_1.window.showTextDocument(uri)
            .then((editor) => {
            const pos = new vscode_1.Position(col, 0);
            editor.revealRange(new vscode_1.Range(pos, pos), vscode_1.TextEditorRevealType.InCenterIfOutsideViewport);
            editor.selection = new vscode_1.Selection(pos, pos);
        });
    }));
    vscode_1.window.onDidChangeActiveTextEditor((e) => {
        if (e) {
            editor = e;
            styleText(e);
        }
    });
    vscode_1.workspace.onDidChangeTextDocument(() => {
        styleText(editor);
    });
    vscode_1.workspace.onDidSaveTextDocument(() => {
        todoTreeList.refresh();
    });
    vscode_1.workspace.onDidChangeConfiguration(async () => {
        decoration_1.Decoration.config(vscode_1.workspace.getConfiguration(constants_1.EXTENSION_ID));
        styleText(editor);
        todoTreeList.refresh();
    });
}
exports.activate = activate;
function styleText(editor) {
    if (!editor)
        return;
    const doc = editor.document;
    const str = doc.getText();
    let match;
    while ((match = constants_1.REGEX.exec(str))) {
        editor.setDecorations(vscode_1.window.createTextEditorDecorationType(decoration_1.Decoration.decoration()), [new vscode_1.Range(doc.positionAt(match.index), doc.positionAt(match.index + constants_1.TODO.length))]);
    }
}
//# sourceMappingURL=extension.js.map