"use strict";
function parseCsv(content, csvReadOptions) {
    var _a, _b;
    if (content === '') {
        content = defaultCsvContentIfEmpty;
    }
    hasFinalNewLine = content.endsWith('\n');
    const parseResult = csv.parse(content, Object.assign(Object.assign({}, csvReadOptions), { comments: false, rowInsertCommentLines_commentsString: typeof csvReadOptions.comments === 'string' && csvReadOptions.comments !== '' ? csvReadOptions.comments : null, retainQuoteInformation: true, calcLineIndexToCsvLineIndexMapping: initialVars.sourceFileCursorLineIndex !== null ? true : false, calcColumnIndexToCsvColumnIndexMapping: initialVars.sourceFileCursorColumnIndex !== null ? true : false }));
    if (parseResult.errors.length === 1 && parseResult.errors[0].type === 'Delimiter' && parseResult.errors[0].code === 'UndetectableDelimiter') {
    }
    else {
        if (parseResult.errors.length > 0) {
            for (let i = 0; i < parseResult.errors.length; i++) {
                const error = parseResult.errors[i];
                if (error.type === 'Delimiter' && error.code === 'UndetectableDelimiter') {
                    continue;
                }
                if (typeof error.row === 'number') {
                    statusInfo.innerText = `Error`;
                    const errorMsg = `${error.message} on line ${error.row + 1}`;
                    csvEditorDiv.innerText = errorMsg;
                    _error(errorMsg);
                    continue;
                }
                statusInfo.innerText = `Error`;
                const errorMsg = `${error.message}`;
                csvEditorDiv.innerText = errorMsg;
                _error(errorMsg);
            }
            return null;
        }
    }
    defaultCsvWriteOptions.delimiter = parseResult.meta.delimiter;
    newLineFromInput = parseResult.meta.linebreak;
    updateNewLineSelect();
    readDelimiterTooltip.setAttribute('data-tooltip', `${readDelimiterTooltipText} (detected: ${defaultCsvWriteOptions.delimiter.replace("\t", "⇥")})`);
    let _parseResult = parseResult;
    return {
        data: parseResult.data,
        columnIsQuoted: parseResult.columnIsQuoted,
        outLineIndexToCsvLineIndexMapping: (_a = _parseResult.outLineIndexToCsvLineIndexMapping) !== null && _a !== void 0 ? _a : null,
        outColumnIndexToCsvColumnIndexMapping: (_b = _parseResult.outColumnIndexToCsvColumnIndexMapping) !== null && _b !== void 0 ? _b : null,
        originalContent: content,
        hasFinalNewLine: hasFinalNewLine,
    };
}
function updateNewLineSelect() {
    newlineSameSsInputOption.innerText = `${newlineSameSsInputOptionText} (${newLineFromInput === `\n` ? 'LF' : 'CRLF'})`;
}
function getData() {
    if (!hot)
        throw new Error('table was null');
    return hot.getData();
}
function getFirstRowWithIndex(skipCommentLines = true) {
    if (!hot)
        return null;
    const rowCount = hot.countRows();
    if (rowCount === 0)
        return null;
    let firstDataRow = [];
    let rowIndex = -1;
    for (let i = 0; i < rowCount; i++) {
        const row = hot.getDataAtRow(i);
        if (row.length === 0)
            continue;
        if (skipCommentLines && isCommentCell(row[0], defaultCsvReadOptions))
            continue;
        firstDataRow = [...row];
        rowIndex = i;
        break;
    }
    if (rowIndex === -1) {
        return null;
    }
    return {
        physicalIndex: rowIndex,
        row: firstDataRow
    };
}
function getFirstRowWithIndexByData(data, skipCommentLines = true) {
    const rowCount = data.length;
    if (rowCount === 0)
        return null;
    let firstDataRow = [];
    let rowIndex = -1;
    for (let i = 0; i < rowCount; i++) {
        const row = data[i];
        if (row.length === 0)
            continue;
        if (skipCommentLines && isCommentCell(row[0], defaultCsvReadOptions))
            continue;
        firstDataRow = [...row];
        rowIndex = i;
        break;
    }
    if (rowIndex === -1) {
        return null;
    }
    return {
        physicalIndex: rowIndex,
        row: firstDataRow
    };
}
function getDataAsCsv(csvReadOptions, csvWriteOptions) {
    const data = getData();
    if (csvWriteOptions.newline === '') {
        csvWriteOptions.newline = newLineFromInput;
    }
    const _conf = Object.assign(Object.assign({}, csvWriteOptions), { quotes: csvWriteOptions.quoteAllFields, quoteEmptyOrNullFields: csvWriteOptions.quoteEmptyOrNullFields });
    if (csvWriteOptions.header) {
        if (!hot)
            throw new Error('table was null');
        if (headerRowWithIndex === null) {
            const colHeaderCells = hot.getColHeader();
            data.unshift(colHeaderCells.map((p, index) => getSpreadsheetColumnLabel(index)));
        }
        else {
            if (headerRowWithIndex === null) {
                throw new Error('header row was null');
            }
            data.unshift(headerRowWithIndex.row.map((val) => val !== null ? val : ''));
        }
    }
    for (let i = 0; i < data.length; i++) {
        const row = data[i];
        if (row[0] === null)
            continue;
        if (typeof csvReadOptions.comments === 'string'
            && typeof csvWriteOptions.comments === 'string'
            && isCommentCell(row[0], csvReadOptions)) {
            const index = row[0].indexOf(csvReadOptions.comments);
            row[0] = `${row[0].substring(0, index)}${csvWriteOptions.comments}${row[0].substring(index + csvReadOptions.comments.length)}`.trimLeft().replace(/\n/mg, "");
        }
    }
    _conf['skipEmptyLines'] = false;
    _conf['rowInsertCommentLines_commentsString'] = typeof csvWriteOptions.comments === 'string' ? csvWriteOptions.comments : null;
    _conf['columnIsQuoted'] = csvWriteOptions.retainQuoteInformation ? columnIsQuoted : null;
    let dataAsString = csv.unparse(data, _conf);
    let finalNewLineOption = "sameAsSourceFile";
    if (initialConfig) {
        finalNewLineOption = initialConfig.finalNewLine;
    }
    switch (finalNewLineOption) {
        case 'sameAsSourceFile': {
            if (hasFinalNewLine) {
                dataAsString += csvWriteOptions.newline;
            }
            else {
            }
            break;
        }
        case 'add': {
            dataAsString += csvWriteOptions.newline;
            break;
        }
        case 'remove': {
            break;
        }
        default:
            notExhaustiveSwitch(finalNewLineOption);
    }
    return dataAsString;
}
function postReloadFile() {
    if (!vscode) {
        console.log(`postReloadFile (but in browser)`);
        return;
    }
    _postReadyMessage();
}
var postVsInformation = (text) => {
    if (!vscode) {
        console.log(`postVsInformation (but in browser)`);
        return;
    }
    vscode.postMessage({
        command: 'msgBox',
        type: 'info',
        content: text
    });
};
var postVsWarning = (text) => {
    if (!vscode) {
        console.log(`postVsWarning (but in browser)`);
        return;
    }
    vscode.postMessage({
        command: 'msgBox',
        type: 'warn',
        content: text
    });
};
var postVsError = (text) => {
    if (!vscode) {
        console.log(`postVsError (but in browser)`);
        return;
    }
    vscode.postMessage({
        command: 'msgBox',
        type: 'error',
        content: text
    });
};
function postCopyToClipboard(text) {
    if (!vscode) {
        console.log(`postCopyToClipboard (but in browser)`);
        navigator.clipboard.writeText(text);
        return;
    }
    vscode.postMessage({
        command: 'copyToClipboard',
        text
    });
}
function postSetEditorHasChanges(hasChanges) {
    _setHasUnsavedChangesUiIndicator(hasChanges);
    if (!vscode) {
        console.log(`postSetEditorHasChanges (but in browser)`);
        return;
    }
    vscode.postMessage({
        command: 'setHasChanges',
        hasChanges
    });
}
function _postApplyContent(csvContent, saveSourceFile) {
    _setHasUnsavedChangesUiIndicator(false);
    if (!vscode) {
        console.log(`_postApplyContent (but in browser)`);
        return;
    }
    vscode.postMessage({
        command: 'apply',
        csvContent,
        saveSourceFile
    });
}
function _postReadyMessage() {
    if (!vscode) {
        console.log(`_postReadyMessage (but in browser)`);
        return;
    }
    startReceiveCsvProgBar();
    vscode.postMessage({
        command: 'ready'
    });
}
function handleVsCodeMessage(event) {
    const message = event.data;
    switch (message.command) {
        case 'csvUpdate': {
            if (typeof message.csvContent === 'string') {
                onReceiveCsvContentSlice({
                    text: message.csvContent,
                    sliceNr: 1,
                    totalSlices: 1
                });
            }
            else {
                onReceiveCsvContentSlice(message.csvContent);
            }
            break;
        }
        case "applyPress": {
            postApplyContent(false);
            break;
        }
        case 'applyAndSavePress': {
            postApplyContent(true);
            break;
        }
        case 'changeFontSizeInPx': {
            changeFontSizeInPx(message.fontSizeInPx);
            break;
        }
        case 'sourceFileChanged': {
            const hasAnyChanges = getHasAnyChangesUi();
            if (!hasAnyChanges && !isReadonlyMode) {
                reloadFileFromDisk();
                return;
            }
            toggleSourceFileChangedModalDiv(true);
            break;
        }
        default: {
            _error('received unknown message from vs code');
            notExhaustiveSwitch(message);
            break;
        }
    }
}
function onReceiveCsvContentSlice(slice) {
    if (slice.sliceNr === 1) {
        initialContent = '';
        statusInfo.innerText = `Receiving csv...`;
        csvEditorDiv.innerText = ``;
    }
    initialContent += slice.text;
    receivedCsvProgBar.value = slice.sliceNr * 100 / slice.totalSlices;
    if (slice.sliceNr === slice.totalSlices) {
        stopReceiveCsvProgBar();
        startRenderData();
    }
}
function startRenderData() {
    statusInfo.innerText = `Rendering table...`;
    if (hasHeaderReadOptionInput.checked) {
        isFirstHasHeaderChangedEvent = true;
        defaultCsvReadOptions._hasHeader = true;
    }
    else {
        isFirstHasHeaderChangedEvent = false;
        defaultCsvReadOptions._hasHeader = false;
    }
    call_after_DOM_updated(() => {
        resetData(initialContent, defaultCsvReadOptions);
        statusInfo.innerText = `Performing last steps...`;
        if (!defaultCsvReadOptions._hasHeader) {
            setTimeout(() => {
                statusInfo.innerText = '';
            }, 0);
        }
    });
}
function call_after_DOM_updated(fn) {
    var intermediate = function () { window.requestAnimationFrame(fn); };
    window.requestAnimationFrame(intermediate);
}
function notExhaustiveSwitch(x) {
    throw new Error('not exhaustive switch');
}
//# sourceMappingURL=io.js.map