# Vscode snapshot

📸 Take beautiful screenshots of your code in VS Code!

## Exam

![](https://raw.githubusercontent.com/2noScript/vscode-snapshot/main/examples/exam.png)

## Features

-  Quickly save screenshots of your code
-  Copy screenshots to your clipboard
-  Show line numbers
-  Many other configuration options
-  Background transparent

## Usage Instructions

1. Open the command palette (Ctrl+Shift+P on Windows and Linux, Cmd+Shift+P on OS X) and search for `vscode snapshot`.
2. Select the code you'd like to screenshot.
3. Adjust the width of the screenshot if desired.
4. Click the shutter button to save the screenshot to your disk.

**Tips**:

-  You can also start CodeSnap by selecting code, right clicking, and clicking CodeSnap
-  If you'd like to bind CodeSnap to a hotkey, open up your keyboard shortcut settings and bind `codesnap.start` to a custom keybinding.
-  If you'd like to copy to clipboard instead of saving, click the image and press the copy keyboard shortcut (defaults are Ctrl+C on Windows and Linux, Cmd+C on OS X), or bind `codesnap.shutterAction` to `copy` in your settings

## Configuration

CodeSnap is highly configurable. Here's a list of settings you can change to tune the way your screenshots look:

**`codesnap.backgroundColor`:** The background color of the snippet's container. Can be any valid CSS color.

**`codesnap.boxShadow`:** The CSS box-shadow for the snippet. Can be any valid CSS box shadow.

**`codesnap.containerPadding`:** The padding for the snippet's container. Can be any valid CSS padding.

**`codesnap.roundedCorners`:** Boolean value to use rounded corners or square corners for the window.

**`codesnap.showWindowControls`:** Boolean value to show or hide OS X style window buttons.

**`codesnap.showWindowTitle`:** Boolean value to show or hide window title `folder_name - file_name`.

**`codesnap.showLineNumbers`:** Boolean value to show or hide line numbers.

**`codesnap.realLineNumbers`:** Boolean value to start from the real line number of the file instead of 1.

**`codesnap.transparentBackground`:** Boolean value to use a transparent background when taking the screenshot.

**`codesnap.target`:** Either `container` to take the screenshot with the container, or `window` to only take the window.

**`codesnap.shutterAction`:** Either `save` to save the screenshot into a file, or `copy` to copy the screenshot into the clipboard.
