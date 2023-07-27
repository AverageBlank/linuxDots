"use strict";
const defaultInitialVars = {
    isWatchingSourceFile: false,
    sourceFileCursorLineIndex: null,
    sourceFileCursorColumnIndex: null,
    isCursorPosAfterLastColumn: false,
    openTableAndSelectCellAtCursorPos: 'initialOnly_correctRowAlwaysFirstColumn',
};
let vscode = undefined;
if (typeof acquireVsCodeApi !== 'undefined') {
    vscode = acquireVsCodeApi();
}
if (typeof initialConfig === 'undefined') {
    var initialConfig = undefined;
    var initialVars = Object.assign({}, defaultInitialVars);
}
const csv = window.Papa;
let hot;
toFormat(Big);
const defaultCsvContentIfEmpty = `,\n,`;
let headerRowWithIndex = null;
let lastClickedHeaderCellTh = null;
let editHeaderCellTextInputEl = null;
let editHeaderCellTextInputLeftOffsetInPx = 0;
let handsontableOverlayScrollLeft = 0;
let _onTableScrollThrottled = null;
let hiddenPhysicalRowIndices = [];
let copyPasteRowLimit = 10000000;
let copyPasteColLimit = 10000000;
let headerRowWithIndexUndoStack = [];
let headerRowWithIndexRedoStack = [];
let columnIsQuoted;
let defaultCsvReadOptions = {
    header: false,
    comments: '#',
    delimiter: '',
    newline: '',
    quoteChar: '"',
    escapeChar: '"',
    skipEmptyLines: true,
    dynamicTyping: false,
    _hasHeader: false,
};
let defaultCsvWriteOptions = {
    header: false,
    comments: '#',
    delimiter: '',
    newline: '',
    quoteChar: '"',
    escapeChar: '"',
    quoteAllFields: false,
    quoteEmptyOrNullFields: false,
    retainQuoteInformation: true,
};
let newLineFromInput = '\n';
let lastHandsonMoveWas = null;
let highlightCsvComments = true;
let newColumnQuoteInformationIsQuoted = false;
let enableWrapping = true;
let disableBorders = false;
let fixedRowsTop = 0;
let fixedColumnsLeft = 0;
let isFirstHasHeaderChangedEvent = true;
let initialColumnWidth = 0;
let shouldApplyHasHeaderAfterRowsAdded = false;
let isReadonlyMode = false;
let hasFinalNewLine;
let allColWidths = [];
let isInitialHotRender = true;
const csvEditorWrapper = _getById('csv-editor-wrapper');
const csvEditorDiv = _getById('csv-editor');
const helModalDiv = _getById('help-modal');
const askReadAgainModalDiv = _getById('ask-read-again-modal');
const askReloadFileModalDiv = _getById('ask-reload-file-modal');
const sourceFileChangedDiv = _getById('source-file-changed-modal');
const readContent = _getById('read-options-content');
const writeContent = _getById('write-options-content');
const previewContent = _getById('preview-content');
const btnApplyChangesToFileAndSave = _getById(`btn-apply-changes-to-file-and-save`);
const readDelimiterTooltip = _getById('read-delimiter-tooltip');
const readDelimiterTooltipText = "Empty to auto detect";
const receivedCsvProgBar = _getById('received-csv-prog-bar');
const receivedCsvProgBarWrapper = _getById('received-csv-prog-bar-wrapper');
const statusInfo = _getById('status-info');
const fixedRowsTopInfoSpan = _getById('fixed-rows-top-info');
const fixedRowsTopIcon = _getById('fixed-rows-icon');
const fixedRowsTopText = _getById('fixed-rows-text');
const fixedColumnsTopInfoSpan = _getById('fixed-columns-top-info');
const fixedColumnsTopIcon = _getById('fixed-columns-icon');
const fixedColumnsTopText = _getById('fixed-columns-text');
const showCommentsBtn = _getById('show-comments-btn');
const hideCommentsBtn = _getById('hide-comments-btn');
const newlineSameSsInputOption = _getById('newline-same-as-input-option');
const newlineSameSsInputOptionText = `Same as input`;
updateNewLineSelect();
const warningTooltipTextWhenCommentRowNotFirstCellIsUsed = `Please use only the first cell in comment row (others are not exported)`;
const unsavedChangesIndicator = _getById('unsaved-changes-indicator');
const reloadFileSpan = _getById('reload-file');
const sourceFileUnwatchedIndicator = _getById('source-file-unwatched-indicator');
const hasHeaderReadOptionInput = _getById('has-header');
const hasHeaderLabel = _getById(`has-header-label`);
const leftSidePanelToggle = document.getElementById('left-panel-toggle');
if (vscode && !leftSidePanelToggle)
    throw new Error(`element with id 'left-panel-toggle' not found`);
const leftPanelToggleIconExpand = document.getElementById(`left-panel-toggle-icon-expand`);
if (vscode && !leftPanelToggleIconExpand)
    throw new Error(`element with id 'left-panel-toggle-icon-expand' not found`);
const sideBarResizeHandle = _getById(`side-panel-resize-handle`);
const sidePanel = _getById(`side-panel`);
const statSelectedRows = _getById(`stat-selected-rows`);
const statSelectedCols = _getById(`stat-selected-cols`);
const statRowsCount = _getById(`stat-rows-count`);
const statColsCount = _getById(`stat-cols-count`);
const statSelectedCellsCount = _getById(`stat-selected-cells-count`);
const statSelectedNotEmptyCells = _getById(`stat-selected-not-empty-cells`);
const statSumOfNumbers = _getById(`stat-sum-of-numbers`);
const numbersStyleEnRadio = _getById(`numbers-style-en`);
const numbersStyleNonEnRadio = _getById(`numbers-style-non-en`);
const isReadonlyModeToggleSpan = _getById(`is-readonly-mode-toggle`);
const toolMenuWrapper = _getById(`tools-menu-wrapper`);
const toolsMenuBtnIcon = _getById(`tools-menu-btn-icon`);
const findWidgetInstance = new FindWidget();
setupSideBarResizeHandle();
setupDropdownHandlers();
let previousSelectedCell = null;
let previousViewportOffsets = null;
setCsvReadOptionsInitial(defaultCsvReadOptions);
setCsvWriteOptionsInitial(defaultCsvWriteOptions);
if (typeof initialContent === 'undefined') {
    var initialContent = '';
}
if (initialContent === undefined) {
    initialContent = '';
}
if (!vscode) {
    console.log("initialConfig: ", initialConfig);
    console.log("initialContent: " + initialContent);
}
setupAndApplyInitialConfigPart1(initialConfig, initialVars);
setupGlobalShortcutsInVs();
let _data = parseCsv(initialContent, defaultCsvReadOptions);
if (_data && !vscode) {
    let _exampleData = [];
    let initialRows = 5;
    let initialCols = 5;
    _exampleData = [...Array(initialRows).keys()].map(p => [...Array(initialCols).keys()].map(k => ''));
    _data = {
        columnIsQuoted: _exampleData[0].map(p => false),
        data: _exampleData
    };
    displayData(_data, defaultCsvReadOptions);
}
if (vscode) {
    receivedCsvProgBarWrapper.style.display = "block";
    window.addEventListener('message', (e) => {
        handleVsCodeMessage(e);
    });
    _postReadyMessage();
}
function setupGlobalShortcutsInVs() {
    if (vscode) {
        Mousetrap.bindGlobal(['meta+s', 'ctrl+s'], (e) => {
            e.preventDefault();
            if (hot) {
                let editor = hot.getActiveEditor();
                if (editor.isOpened()) {
                    editor.finishEditing(false);
                }
            }
            postApplyContent(true);
        });
    }
    Mousetrap.bindGlobal(['ctrl+ins'], (e) => {
        insertRowBelow();
    });
    Mousetrap.bindGlobal(['ctrl+shift+ins'], (e) => {
        insertRowAbove();
    });
    Mousetrap.bindGlobal(['ctrl+shift+alt+-'], (e) => {
        pretendRemoveRowContextMenuActionClicked();
    });
}
//# sourceMappingURL=main.js.map