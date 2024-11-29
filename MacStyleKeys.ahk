#Requires AutoHotkey v2.0
; #Include <UIA>
; ==========================================================
; Version: 1.0.0
; AutoHotkey Emacs-Style Keybindings
; Mac-style Keyboard Shortcuts for Windows
; Last Updated: 2024-11-29
; Author: [frank wang]
; License: MIT
; ==========================================================

; ========== Key Binding Groups ==========
/*
 * Ctrl Keys:
 * - Navigation: Basic cursor movement (q,e,f,b,n,p)
 * - Editing: Character-level operations (h,d,k,u)
 *
 * Win Keys:
 * - Navigation: Word-level movement (f,b)
 * - Management: Tab operations (q,w,e)
 *
 * Alt Keys:
 * - Standard Windows shortcuts
 * - Terminal-specific operations
 */

; ========== Terminal Detection ==========
; 全局变量
global terminalCache := Map()
global MAX_CACHE_SIZE := 100        ; 添加最大缓存数量限制
global cacheOrder := []             ; 新增：用于追踪添加顺序的数组
global terminalClasses := Map(
    "ConsoleWindowClass", 1,        ; CMD
    "CASCADIA_HOSTING_WINDOW_CLASS", 1,  ; Windows Terminal
    "mintty", 1,                    ; Git Bash
    "VirtualConsoleClass", 1,       ; ConEmu/Cmder
)
global terminalExeMap := Map(
    "WindowsTerminal.exe", 1,
    "powershell.exe", 1,
    "pwsh.exe", 1,
    "bash.exe", 1,
    "wezterm-gui.exe", 1,
    "alacritty.exe", 1,
    "mintty.exe", 1,        ; git-bash
    "ConEmu64.exe", 1,      ; cmder
    "ConEmu.exe", 1,        ; cmder
    "cmd.exe", 1,           ; Windows CMD
    "wsl.exe", 1,           ; Windows Subsystem for Linux
    "ubuntu.exe", 1,        ; Ubuntu WSL
    "debian.exe", 1,        ; Debian WSL
    "kitty.exe", 1,         ; 高性能GPU加速终端，支持SSH/远程开发
    "msys2.exe", 1,         ; MSYS2 终端环境
    "mingw64.exe", 1,       ; MinGW-w64 终端环境
    "putty.exe", 1,         ; PuTTY SSH连接常用
    ; "tabby.exe", 1,         ; tabby
    ; "xterm.exe", 1,         ; X Window System 的标准终端模拟器
    ; "terminus.exe", 1,      ; Terminus - 很少见
    ; "openssh.exe", 1,       ; OpenSSH 客户端程序
)

IsTerminal() {
    global terminalCache, cacheOrder, MAX_CACHE_SIZE
    static lastWindowId := 0    ; 静态变量缓存上一次的窗口ID
    static lastResult := false  ; 缓存上一次的结果

    currentWindowId := WinExist("A")

    ; 检查静态缓存, 如果是同一个窗口，直接返回缓存结果
    if (lastWindowId == currentWindowId) {
        return lastResult
    }

    ; 缓存管理 清理缓存时使用顺序数组
    if (cacheOrder.Length >= MAX_CACHE_SIZE) {
        newCache := Map()
        maxKeep := MAX_CACHE_SIZE // 2

        ; 从顺序数组的后半部分获取最新的记录, 只保留最新的记录
        for windowId in cacheOrder.Slice(-maxKeep) {
            newCache[windowId] := terminalCache[windowId]
        }

        terminalCache := newCache
        cacheOrder := cacheOrder.Slice(-maxKeep)  ; 只保留最后 maxKeep 个元素
    }

    ; 如果有缓存，直接返回
    if (terminalCache.Has(currentWindowId)) {
        lastWindowId := currentWindowId
        lastResult := terminalCache[currentWindowId]
        return lastResult
    } else {
        ; 如果有新的窗口ID，添加到顺序追踪数组
        cacheOrder.Push(currentWindowId)
    }

    ; 先检查进程名（更快）
    if (exeName := WinGetProcessName("A")) && terminalExeMap.Has(exeName) {
        terminalCache[currentWindowId] := true
        lastWindowId := currentWindowId
        lastResult := true
        return true
    }

    ; 再检查窗口类名
    if (className := WinGetClass("A")) && terminalClasses.Has(className) {
        terminalCache[currentWindowId] := true
        lastWindowId := currentWindowId
        lastResult := true
        return true
    }

    ; 更新缓存
    terminalCache[currentWindowId] := false
    lastWindowId := currentWindowId
    lastResult := false
    return false
}


; ========== Ctrl Group ==========
; ctrl-1 q e u p
^q:: SendInput("{Home}")
^q Up:: return
^e:: SendInput("{End}")
^e Up:: return

#HotIf !IsTerminal()
^u:: SendInput("+{Home}{Backspace}")
^u Up:: return
#HotIf

^p:: SendInput("{Up}")
^p Up:: return

; ctrl-2 d f h k
^d:: SendInput("{Del}")
^d Up:: return
^f:: SendInput("{Right}")
^f Up:: return
^h:: SendInput("{Backspace}")
^h Up:: return

#HotIf !IsTerminal()
^k:: SendInput("+{End}{Del}")
^k Up:: return
#HotIf

; ctrl-3 b n
^b:: SendInput("{Left}")
^b Up:: return
^n:: SendInput("{Down}")
^n Up:: return

; ========== Win Group ==========
; win-1 q w e u
#q:: SendInput("^+{tab}")
#q Up:: return
#w:: SendInput("^w")
#w Up:: return
#e:: SendInput("^{tab}")
#e Up:: return
#u:: SendInput("^u")
#u Up:: return

; win-2 d f h j k
; #d:: SendInput("^{Del}") ; 和 win 自带的冲突
; #d Up:: return
#f:: SendInput("^{Right}")
#f Up:: return
#h:: SendInput("^{Backspace}")
#h Up:: return
#j:: SendInput("^j")
#j Up:: return
#k:: SendInput("^k")
#k Up:: return

; win-3 c v b
#c:: SendInput("^+c")
#c Up:: return
#v:: SendInput("^+v")
#v Up:: return
#b:: SendInput("^{Left}")
#b Up:: return

; ========== Alt Group ==========
; alt-1 w t y u i o p []
!w:: SendInput("^w")
!w Up:: return
!t:: SendInput("^t")
!t Up:: return
!y:: SendInput("^y")
!y Up:: return
!u:: SendInput("^u")
!u Up:: return
!i:: SendInput("^i")
!i Up:: return
!o:: SendInput("^o")
!o Up:: return
!p:: SendInput("^p")
!p Up:: return
![:: SendInput("^[")
![ Up:: return
!]:: SendInput("^]")
!] Up:: return

; alt-2 a s d f g h l '
!a:: SendInput("^a")
!a Up:: return
!s:: SendInput("^s")
!s Up:: return
!d:: SendInput("^d")
!d Up:: return
!f:: SendInput("^f")
!f Up:: return
!g:: SendInput("^g")
!g Up:: return
!h:: SendInput("^{Backspace}")
!h Up:: return
!l:: SendInput("^l")
!l Up:: return
!':: SendInput("^'")
!' Up:: return

; alt-3 z x c v b n , /
!z:: SendInput("^z")
!z Up:: return
!x:: SendInput("^x")
!x Up:: return
!c:: SendInput("^c")
!c Up:: return
!v:: SendInput("^v")
!v Up:: return
!b:: SendInput("^b")
!b Up:: return
!n:: SendInput("^n")
!n Up:: return
; !m:: SendInput("^m")
; !m Up:: return
; !,:: SendInput("^,")
; !, Up:: return
!/:: SendInput("^/")
!/ Up:: return

; Terminal specific shortcuts
#HotIf IsTerminal()
!c:: SendInput("^{Insert}")
!c Up:: return
!v:: SendInput("+{Insert}")
!v Up:: return
!r:: SendInput("^r") ; terminal search
!r Up:: return
#HotIf

; ========== Advanced Combinations ==========
; Ctrl + Win combinations d f h b
^#d:: SendInput("^{Del}")
^#d Up:: return
^#f:: SendInput("^{Right}")
^#f Up:: return
^#h:: SendInput("^{Backspace}")
^#h Up:: return
^#b:: SendInput("^{Left}")
^#b Up:: return

; Ctrl + Alt combinations  d f h b
; ^!d:: SendInput("^{Del}") ; 与 win 自带的冲突
; ^!d Up:: return
^!f:: SendInput("^{Right}")
^!f Up:: return
^!h:: SendInput("^{Backspace}")
^!h Up:: return
^!b:: SendInput("^{Left}")
^!b Up:: return
