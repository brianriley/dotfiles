on run argv
    tell application "Terminal" to set current settings of front tab of front window to first settings set whose name is (item 1 of argv)
end run
