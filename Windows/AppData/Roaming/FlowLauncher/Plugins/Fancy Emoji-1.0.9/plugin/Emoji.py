# 821C3 Emoji DB Plugin
# v1 5/18/2020

#encoding=utf8
from flowlauncher import FlowLauncher
from csv import reader
from os import path

####
# Copy to clipboard function (put) compatible with x64 from https://forums.autodesk.com/t5/maya-programming/ctypes-bug-cannot-copy-data-to-clipboard-via-python/td-p/9195866
import ctypes
from ctypes import wintypes
CF_UNICODETEXT = 13

user32 = ctypes.WinDLL('user32')
kernel32 = ctypes.WinDLL('kernel32')

OpenClipboard = user32.OpenClipboard
OpenClipboard.argtypes = wintypes.HWND,
OpenClipboard.restype = wintypes.BOOL
CloseClipboard = user32.CloseClipboard
CloseClipboard.restype = wintypes.BOOL
EmptyClipboard = user32.EmptyClipboard
EmptyClipboard.restype = wintypes.BOOL
GetClipboardData = user32.GetClipboardData
GetClipboardData.argtypes = wintypes.UINT,
GetClipboardData.restype = wintypes.HANDLE
SetClipboardData = user32.SetClipboardData
SetClipboardData.argtypes = (wintypes.UINT, wintypes.HANDLE)
SetClipboardData.restype = wintypes.HANDLE

GlobalLock = kernel32.GlobalLock
GlobalLock.argtypes = wintypes.HGLOBAL,
GlobalLock.restype = wintypes.LPVOID
GlobalUnlock = kernel32.GlobalUnlock
GlobalUnlock.argtypes = wintypes.HGLOBAL,
GlobalUnlock.restype = wintypes.BOOL
GlobalAlloc = kernel32.GlobalAlloc
GlobalAlloc.argtypes = (wintypes.UINT, ctypes.c_size_t)
GlobalAlloc.restype = wintypes.HGLOBAL
GlobalSize = kernel32.GlobalSize
GlobalSize.argtypes = wintypes.HGLOBAL,
GlobalSize.restype = ctypes.c_size_t

GMEM_MOVEABLE = 0x0002
GMEM_ZEROINIT = 0x0040

unicode = type(u'')

def put(s):
    if not isinstance(s, unicode):
        s = s.decode('mbcs')
    data = s.encode('utf-16le')
    OpenClipboard(None)
    EmptyClipboard()
    handle = GlobalAlloc(GMEM_MOVEABLE | GMEM_ZEROINIT, len(data) + 2)
    pcontents = GlobalLock(handle)
    ctypes.memmove(pcontents, data, len(data))
    GlobalUnlock(handle)
    SetClipboardData(CF_UNICODETEXT, handle)
    CloseClipboard()
######

class Emoji(FlowLauncher):

    # A function named query is necessary, we will automatically invoke this function when user query this plugin
    def query(self,key):
        key = key.lower()
        defaultPath = "Images/icon.png"
        transparentPixel = "1x1-transparent.png"

        if len(key)<3:
            return [
                {
                    "Title": "Please type 3 characters or more",
                    "IcoPath": transparentPixel
                }
            ]

        maxResults = 20

        try:
            #Load EmojiDB
            with open('emojidb.csv', "r", encoding="utf-8") as read_obj:
                # pass the file object to reader() to get the reader object
                csv_reader = reader(read_obj)
                # Pass reader object to list() to get a list of lists
                emlist = list(csv_reader)
            results = []
            for row in emlist:
                if key in row[3]:
                    emoji = ''.join([chr(int(code, 16)) for code in row[1].split('-')])
                    if path.exists("Images/Emojis/"+row[1]+".png"):
                        pathImg = "Images/Emojis/"+row[1]+".png"
                    else:
                        pathImg = defaultPath
                    results.append({
                        "Title": emoji,
                        "SubTitle":row[2],
                        "IcoPath":pathImg,
                        "JsonRPCAction":{
                            "method": "copy",
                            "parameters":[emoji],
                            "dontHideAfterAction":False
                       }
                    })
                    if len(results) >= maxResults:
                        results.insert(0, {
                            "Title": "Too many results",
                            "SubTitle": "Please narrow your search term further, only showing {} results".format(str(maxResults))
                        })

                        return results

            if not results:
                return [
                    {
                        "Title": "No results for '" + str(key) + "'",
                        "IcoPath": transparentPixel
                    }
                ]

            return results
        except BaseException as exception:
            return [
                {
                    "Title": "An exception occurred: {}".format(exception)
                }
            ]


    def copy(self,code):
        put(code)

#Following statement is necessary
if __name__ == "__main__":
    Emoji()
