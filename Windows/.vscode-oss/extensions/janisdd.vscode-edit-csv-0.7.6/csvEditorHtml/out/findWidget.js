"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
class FindWidget {
    constructor() {
        this.findOptionMatchCaseCache = false;
        this.findOptionMatchWholeCellCache = false;
        this.findOptionTrimCellCache = false;
        this.findOptionUseRegexCache = false;
        this.findOptionMatchCasePreviousCache = false;
        this.findOptionMatchWholeCellPreviousCache = false;
        this.findOptionTrimCellPreviousCache = false;
        this.findOptionUseRegexPreviousCache = false;
        this.tableHasChangedAfterSearch = false;
        this.findWidgetQueryCancellationToken = {
            isCancellationRequested: false
        };
        this.findWidgetCurrRegex = null;
        this.findMatchCellClass = 'search-result-cell';
        this.findOldMatchCellClass = 'old-search-result-cell';
        this.lastFindResults = [];
        this.currentFindIndex = 0;
        this.findWidget = _getById('find-widget');
        this.findWidgetStartSearch = _getById('find-widget-start-search');
        this.findWidgetInput = _getById('find-widget-input');
        this.findWWidgetErrorMessage = _getById('find-widget-error-message');
        this.findWidgetInfo = _getById('find-widget-info');
        this.findWidgetOutdatedSearch = _getById('find-widget-outdated-search');
        this.findWidgetCancelSearch = _getById('find-widget-cancel-search');
        this.findWidgetOptionMatchCase = _getById('find-window-option-match-case');
        this.findWidgetOptionWholeCell = _getById('find-window-option-whole-cell');
        this.findWidgetOptionWholeCellTrimmed = _getById('find-window-option-whole-cell-trimmed');
        this.findWidgetOptionRegex = _getById('find-window-option-regex');
        this.findWidgetPrevious = _getById('find-widget-previous');
        this.findWidgetNext = _getById('find-widget-next');
        this.findWidgetGripperIsMouseDown = false;
        this.findWidgetDownPointOffsetInPx = 0;
        this.findWidgetInputValueCache = '';
        this.onWindowResizeThrottled = throttle(this.onWindowResize, 200);
        this.onSearchInputPreDebounced = debounce(this.onSearchInputPre, 200);
        this.onWindowResizeThrottledBound = this.onWindowResizeThrottled.bind(this);
        this.onSearchInputPreDebouncedBound = this.onSearchInputPre.bind(this);
        this.onDocumentRootKeyDownBound = this.onDocumentRootKeyDown.bind(this);
        this.onFindWidgetDragEndBound = this.onFindWidgetDragEnd.bind(this);
        this.onFindWidgetDragBound = this.onFindWidgetDrag.bind(this);
        this.findWidgetProgressbar = new Progressbar('find-widget-progress-bar');
    }
    showOrHideWidget(show) {
        if (!hot)
            return;
        let currIsSown = this.isFindWidgetDisplayed();
        if (currIsSown === show) {
            if (show) {
                setTimeout(() => {
                    this.findWidgetInput.focus();
                }, 0);
            }
            return;
        }
        this.findWidget.style.display = show ? 'flex' : 'none';
        if (show) {
            if (this.findWidgetInput.value === '' && this.findWidgetInputValueCache !== '') {
                this.findWidgetInput.value = this.findWidgetInputValueCache;
            }
            if (this.lastFindResults.length > 0) {
                _updateHandsontableSettings({
                    search: {
                        isSuspended: false
                    }
                }, false, false);
            }
            setTimeout(() => {
                this.findWidgetInput.focus();
            }, 0);
        }
        else {
            if (this.getIsSearchCancelDisplayed()) {
                this.onCancelSearch();
                this.findWidget.style.display = 'flex';
            }
            else {
                _updateHandsontableSettings({
                    search: {
                        isSuspended: true
                    }
                }, false, false);
            }
        }
    }
    isFindWidgetDisplayed() {
        return this.findWidget.style.display !== 'none';
    }
    toggleFindWidgetVisibility() {
        this.showOrHideWidget(this.findWidget.style.display === 'none');
    }
    setupFind() {
        Mousetrap.unbind(['meta+f', 'ctrl+f']);
        Mousetrap.bindGlobal(['meta+f', 'ctrl+f'], (e) => {
            e.preventDefault();
            this.showOrHideWidget(true);
        });
        this.findWidgetInput.removeEventListener('keyup', this.onSearchInputPreDebouncedBound);
        this.findWidgetInput.addEventListener('keyup', this.onSearchInputPreDebouncedBound);
        document.documentElement.removeEventListener('keydown', this.onDocumentRootKeyDownBound);
        document.documentElement.addEventListener('keydown', this.onDocumentRootKeyDownBound);
        Mousetrap.unbind('esc');
        Mousetrap.bindGlobal('esc', (e) => {
            this.showOrHideWidget(false);
        });
        Mousetrap.bindGlobal('f3', (e) => {
            if (this.isFindWidgetDisplayed() === false && this.lastFindResults.length === 0)
                return;
            this.gotoNextFindMatch();
        });
        Mousetrap.unbind('shift+f3');
        Mousetrap.bindGlobal('shift+f3', (e) => {
            if (this.isFindWidgetDisplayed() === false && this.lastFindResults.length === 0)
                return;
            this.gotoPreviousFindMatch();
        });
        window.removeEventListener('resize', this.onWindowResizeThrottledBound);
        window.addEventListener('resize', this.onWindowResizeThrottledBound);
    }
    onDocumentRootKeyDown(e) {
        if (this.isFindWidgetDisplayed() && document.activeElement === this.findWidgetInput) {
            if ((e.key === 'F1') ||
                (e.metaKey || e.ctrlKey)) {
                let xyz = 1;
            }
            else {
                e.stopImmediatePropagation();
            }
            if (e.key === 'Escape') {
                Mousetrap.trigger('esc');
            }
            else if (e.key === 'F3') {
                Mousetrap.trigger(e.shiftKey ? 'shift+f3' : 'f3');
            }
            else if (e.key === 'F2') {
                if (hot && this.lastFindResults.length > 0) {
                    let match = this.lastFindResults[this.currentFindIndex];
                    hot.selectCell(match.row, match.col);
                    hot.scrollViewportTo(match.row);
                }
            }
            else if (e.key === 'Enter') {
                this.refreshCurrentSearch();
            }
        }
    }
    onSearchInputPre(e) {
        if (e && e.key !== 'Enter')
            return;
    }
    onSearchInput(isOpeningFindWidget, jumpToResult, pretendedText) {
        return __awaiter(this, void 0, void 0, function* () {
            if (!hot)
                return;
            if (isOpeningFindWidget === true && this.findWidgetInput.value === "") {
                this.findWidgetInput.focus();
                return;
            }
            this.showOrHideOutdatedSearchIndicator(false);
            if (this.findOptionUseRegexCache) {
                let regexIsValid = this.refreshFindWidgetRegex(false);
                if (!regexIsValid) {
                    this.findWidgetInput.focus();
                    return;
                }
            }
            this.findOptionMatchCasePreviousCache = this.findOptionMatchCaseCache;
            this.findOptionMatchWholeCellPreviousCache = this.findOptionMatchWholeCellCache;
            this.findOptionTrimCellPreviousCache = this.findOptionTrimCellCache;
            this.findOptionUseRegexPreviousCache = this.findOptionUseRegexCache;
            this.tableHasChangedAfterSearch = false;
            let searchPlugin = hot.getPlugin('search');
            if (pretendedText === null) {
                this.findWidgetProgressbar.setValue(0);
                this.findWidgetProgressbar.show();
                this.findWidgetQueryCancellationToken.isCancellationRequested = false;
                this.enableOrDisableFindWidgetInput(false);
                this.showOrHideSearchCancel(true);
                this._enabledOrDisableFindWidgetInteraction(false);
                this.lastFindResults = yield searchPlugin.queryAsync(this.findWidgetInput.value, this.findWidgetQueryCancellationToken, this._onSearchProgress.bind(this), 5);
                this._getRealIndicesFromFindResult();
            }
            else {
                this.lastFindResults = searchPlugin.query(pretendedText);
                this._getRealIndicesFromFindResult();
            }
            statusInfo.innerText = `Rendering table...`;
            if (this.lastFindResults.length === 0) {
                if (this.findWidgetQueryCancellationToken.isCancellationRequested === false) {
                    this.findWidgetInfo.innerText = `No results`;
                }
                else {
                    this.findWidgetInfo.innerText = `Cancelled`;
                }
            }
            if (jumpToResult && this.lastFindResults.length > 0) {
                this.gotoFindMatchByIndex(0);
            }
            setTimeout(() => {
                hot.updateSettings({
                    search: {
                        isSuspended: this.lastFindResults.length === 0
                    }
                }, false);
            }, 0);
            setTimeout(() => {
                this.findWidgetQueryCancellationToken.isCancellationRequested = false;
                statusInfo.innerText = ``;
                this.enableOrDisableFindWidgetInput(true);
                this._enabledOrDisableFindWidgetInteraction(true);
                if (this.lastFindResults.length === 0) {
                    this.findWidgetNext.classList.add('div-disabled');
                    this.findWidgetPrevious.classList.add('div-disabled');
                }
                this.findWidgetProgressbar.hide();
                this.findWidgetInput.focus();
            }, 0);
        });
    }
    _getRealIndicesFromFindResult() {
        if (!hot)
            return;
        for (let i = 0; i < this.lastFindResults.length; i++) {
            const findResult = this.lastFindResults[i];
            findResult.rowReal = hot.toPhysicalRow(findResult.row);
            findResult.colReal = hot.toPhysicalColumn(findResult.col);
        }
    }
    _onSearchProgress(index, maxIndex, percentage) {
        this.findWidgetProgressbar.setValue(percentage);
        if (index >= maxIndex) {
            this._onSearchFinished();
        }
    }
    _onSearchFinished() {
        this.showOrHideSearchCancel(false);
    }
    onCancelSearch() {
        this.findWidgetQueryCancellationToken.isCancellationRequested = true;
        this._onSearchFinished();
        if (!hot)
            return;
        _updateHandsontableSettings({
            search: {
                isSuspended: true
            }
        }, false, false);
    }
    toggleFindWindowOptionMatchCase() {
        this.setFindWindowOptionMatchCase(this.findWidgetOptionMatchCase.classList.contains(`active`) ? false : true);
    }
    setFindWindowOptionMatchCase(enabled) {
        if (enabled) {
            this.findWidgetOptionMatchCase.classList.add(`active`);
        }
        else {
            this.findWidgetOptionMatchCase.classList.remove(`active`);
        }
        this.findOptionMatchCaseCache = enabled;
        if (this.findWidgetInputValueCache !== '') {
            if (this._hasAnyFindOptionChanged()) {
                this.showOrHideOutdatedSearchIndicator(true);
            }
            else {
                if (this.tableHasChangedAfterSearch) {
                }
                else {
                    this.showOrHideOutdatedSearchIndicator(false);
                }
            }
        }
    }
    toggleFindWindowOptionWholeCell() {
        this.setFindWindowOptionWholeCell(this.findWidgetOptionWholeCell.classList.contains(`active`) ? false : true);
    }
    setFindWindowOptionWholeCell(enabled) {
        if (enabled) {
            this.findWidgetOptionWholeCell.classList.add(`active`);
        }
        else {
            this.findWidgetOptionWholeCell.classList.remove(`active`);
        }
        this.findOptionMatchWholeCellCache = enabled;
        if (this.findWidgetInputValueCache !== '') {
            if (this._hasAnyFindOptionChanged()) {
                this.showOrHideOutdatedSearchIndicator(true);
            }
            else {
                if (this.tableHasChangedAfterSearch) {
                }
                else {
                    this.showOrHideOutdatedSearchIndicator(false);
                }
            }
        }
    }
    toggleFindWindowOptionMatchTrimmedCell() {
        this.setFindWindowOptionMatchTrimmedCell(this.findWidgetOptionWholeCellTrimmed.classList.contains(`active`) ? false : true);
    }
    setFindWindowOptionMatchTrimmedCell(enabled) {
        if (enabled) {
            this.findWidgetOptionWholeCellTrimmed.classList.add(`active`);
        }
        else {
            this.findWidgetOptionWholeCellTrimmed.classList.remove(`active`);
        }
        this.findOptionTrimCellCache = enabled;
        if (this.findWidgetInputValueCache !== '') {
            if (this._hasAnyFindOptionChanged()) {
                this.showOrHideOutdatedSearchIndicator(true);
            }
            else {
                if (this.tableHasChangedAfterSearch) {
                }
                else {
                    this.showOrHideOutdatedSearchIndicator(false);
                }
            }
        }
    }
    toggleFindWindowOptionRegex() {
        this.setFindWindowOptionRegex(this.findWidgetOptionRegex.classList.contains(`active`) ? false : true);
    }
    setFindWindowOptionRegex(enabled) {
        if (enabled) {
            this.findWidgetOptionRegex.classList.add(`active`);
            this.refreshFindWidgetRegex(false);
        }
        else {
            this.findWidgetOptionRegex.classList.remove(`active`);
            this.refreshFindWidgetRegex(true);
        }
        this.findOptionUseRegexCache = enabled;
        if (this.findWidgetInputValueCache !== '') {
            if (this._hasAnyFindOptionChanged()) {
                this.showOrHideOutdatedSearchIndicator(true);
            }
            else {
                if (this.tableHasChangedAfterSearch) {
                }
                else {
                    this.showOrHideOutdatedSearchIndicator(false);
                }
            }
        }
    }
    _hasAnyFindOptionChanged() {
        if (this.findOptionMatchCasePreviousCache !== this.findOptionMatchCaseCache)
            return true;
        if (this.findOptionMatchWholeCellPreviousCache !== this.findOptionMatchWholeCellCache)
            return true;
        if (this.findOptionTrimCellPreviousCache !== this.findOptionTrimCellCache)
            return true;
        if (this.findOptionUseRegexPreviousCache !== this.findOptionUseRegexCache)
            return true;
        return false;
    }
    refreshFindWidgetRegex(forceReset) {
        if (forceReset) {
            this.findWidgetCurrRegex = null;
            this.findWWidgetErrorMessage.innerText = '';
            this.findWidgetInput.classList.remove('error-input');
            return false;
        }
        try {
            this.findWidgetCurrRegex = new RegExp(this.findWidgetInput.value, this.findOptionMatchCaseCache ? '' : 'i');
            this.findWWidgetErrorMessage.innerText = '';
            this.findWidgetInput.classList.remove('error-input');
            return true;
        }
        catch (error) {
            console.log(`error:`, error === null || error === void 0 ? void 0 : error.message);
            this.findWidgetCurrRegex = null;
            this.findWWidgetErrorMessage.innerText = error === null || error === void 0 ? void 0 : error.message;
            this.findWidgetInput.classList.add('error-input');
            return false;
        }
    }
    _enabledOrDisableFindWidgetInteraction(enable) {
        const disabledClass = 'div-disabled';
        if (enable) {
            this.findWidgetOptionMatchCase.classList.remove(disabledClass);
            this.findWidgetOptionWholeCell.classList.remove(disabledClass);
            this.findWidgetOptionWholeCellTrimmed.classList.remove(disabledClass);
            this.findWidgetOptionRegex.classList.remove(disabledClass);
            this.findWidgetPrevious.classList.remove(disabledClass);
            this.findWidgetNext.classList.remove(disabledClass);
        }
        else {
            this.findWidgetOptionMatchCase.classList.add(disabledClass);
            this.findWidgetOptionWholeCell.classList.add(disabledClass);
            this.findWidgetOptionWholeCellTrimmed.classList.add(disabledClass);
            this.findWidgetOptionRegex.classList.add(disabledClass);
            this.findWidgetPrevious.classList.add(disabledClass);
            this.findWidgetNext.classList.add(disabledClass);
        }
    }
    enableOrDisableFindWidgetInput(isEnable) {
        this.findWidgetInput.disabled = !isEnable;
    }
    showOrHideOutdatedSearchIndicator(isOutdated) {
        this.findWidgetOutdatedSearch.style.display = isOutdated ? 'block' : 'none';
    }
    refreshCurrentSearch() {
        this.findWidgetInputValueCache = this.findWidgetInput.value;
        if (this.findWidgetInput.value === '')
            return;
        this.onSearchInput(false, true, null);
    }
    showOrHideSearchCancel(show) {
        this.findWidgetCancelSearch.style.display = show ? 'block' : 'none';
        this.findWidgetInfo.style.display = show ? 'none' : 'block';
        this.findWidgetStartSearch.style.display = show ? 'none' : 'block';
    }
    getIsSearchCancelDisplayed() {
        return this.findWidgetCancelSearch.style.display === 'block';
    }
    selectAllInputText() {
        this.findWidgetInput.control.select();
    }
    gotoPreviousFindMatch() {
        this.gotoFindMatchByIndex(this.currentFindIndex - 1);
    }
    gotoNextFindMatch() {
        this.gotoFindMatchByIndex(this.currentFindIndex + 1);
    }
    gotoFindMatchByIndex(matchIndex) {
        if (!hot)
            return;
        if (matchIndex >= this.lastFindResults.length) {
            this.gotoFindMatchByIndex(0);
            return;
        }
        if (matchIndex < 0) {
            this.gotoFindMatchByIndex(this.lastFindResults.length - 1);
            return;
        }
        let match = this.lastFindResults[matchIndex];
        {
            const autoColumnSizePlugin = hot.getPlugin('autoColumnSize');
            const autoRowSizePlugin = hot.getPlugin('autoRowSize');
            const visualRowIndex = hot.toVisualRow(match.rowReal);
            const visualColIndex = hot.toVisualColumn(match.colReal);
            const _firstVisualRow = autoRowSizePlugin.getFirstVisibleRow();
            const _lastVisualRow = autoRowSizePlugin.getLastVisibleRow();
            const _firstVisualCol = autoColumnSizePlugin.getFirstVisibleColumn();
            const _lastVisualCol = autoColumnSizePlugin.getLastVisibleColumn();
            let virtualColumnIndexToScrollTo = undefined;
            let virtualRowIndexToScrollTo = undefined;
            let useAutoScroll = true;
            let useAutoScrollRow = false;
            let useAutoScrollCol = false;
            if (visualRowIndex < _firstVisualRow || visualRowIndex > _lastVisualRow) {
                useAutoScroll = false;
                useAutoScrollRow = true;
            }
            if (visualColIndex < _firstVisualCol || visualColIndex > _lastVisualCol) {
                useAutoScroll = false;
                useAutoScrollCol = true;
            }
            if (getAreCommentsDisplayed() === false) {
                useAutoScroll = true;
                useAutoScrollRow = false;
                useAutoScrollCol = false;
            }
            hot.selectCell(visualRowIndex, visualColIndex, undefined, undefined, useAutoScroll);
            if (useAutoScroll === false) {
                if (useAutoScrollRow) {
                    const rowsToSubtract = Math.floor((_lastVisualRow - _firstVisualRow) / 2);
                    const clampedVisualRowIndex = Math.max(visualRowIndex - rowsToSubtract, 0);
                    virtualRowIndexToScrollTo = clampedVisualRowIndex;
                }
                if (useAutoScrollCol) {
                    const rowsToSubtract = Math.floor((_lastVisualCol - _firstVisualCol) / 2);
                    const clampedVisualRowIndex = Math.max(visualColIndex - rowsToSubtract, 0);
                    virtualColumnIndexToScrollTo = clampedVisualRowIndex;
                }
                hot.scrollViewportTo(virtualRowIndexToScrollTo, virtualColumnIndexToScrollTo);
            }
        }
        this.findWidgetInfo.innerText = `${matchIndex + 1}/${this.lastFindResults.length}`;
        this.currentFindIndex = matchIndex;
        setTimeout(() => {
            this.findWidgetInput.focus();
        }, 0);
    }
    onFindWidgetGripperMouseDown(e) {
        e.preventDefault();
        this.findWidgetGripperIsMouseDown = true;
        let xFromRight = document.body.clientWidth - e.clientX;
        if (this.findWidget.style.right === null || this.findWidget.style.right === "") {
            return;
        }
        let rightString = this.findWidget.style.right.substr(0, this.findWidget.style.right.length - 2);
        this.findWidgetDownPointOffsetInPx = xFromRight - parseInt(rightString);
        document.addEventListener('mouseup', this.onFindWidgetDragEndBound);
        document.addEventListener('mousemove', this.onFindWidgetDragBound);
    }
    onFindWidgetDrag(e) {
        e.preventDefault();
        let xFromRight = document.body.clientWidth - e.clientX;
        let newRight = xFromRight - this.findWidgetDownPointOffsetInPx;
        newRight = Math.max(newRight, 0);
        newRight = Math.min(newRight, document.body.clientWidth - this.findWidget.clientWidth);
        this.findWidget.style.right = `${newRight}px`;
    }
    onFindWidgetDragEnd(e) {
        this.findWidgetGripperIsMouseDown = false;
        document.removeEventListener('mousemove', this.onFindWidgetDragBound);
        document.removeEventListener('mouseup', this.onFindWidgetDragEndBound);
    }
    onWindowResize() {
        if (this.findWidget.style.right === null || this.findWidget.style.right === "") {
            return;
        }
        let rightString = this.findWidget.style.right.substr(0, this.findWidget.style.right.length - 2);
        let currRight = parseInt(rightString);
        currRight = Math.max(currRight, 0);
        currRight = Math.min(currRight, document.body.clientWidth - this.findWidget.clientWidth);
        this.findWidget.style.right = `${currRight}px`;
    }
}
//# sourceMappingURL=findWidget.js.map