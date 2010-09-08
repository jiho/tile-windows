(*
 * Resize and tile windows
 *
 * (c) Copyright 2010 JiHO. GNU General Public License
 *
 *)

-- Get display sizetell application "Finder"
	set b to bounds of window of desktop
	set displayWidth to (item 3 of b)
	set displayHeight to (item 4 of b)
end tell

-- Get dock size if not hidden
if (do shell script "defaults read com.apple.dock autohide") is equal to "0" then
	set dockSize to ((do shell script "defaults read com.apple.dock tilesize") as number) + 19
	-- NB: size of the dock is size of the icons + 19 pixels
else
	set dockSize to 0
end if

-- "Get" menubar size
set menubarSize to 22

set curApp to (path to frontmost application as Unicode text)

tell application curApp
	try
		tell front window
			-- Get current window size
			set {x1, y1, x2, y2} to (get bounds)
			
			-- Vertical size
			set y1 to menubarSize
			set y2 to y1 + (displayHeight - y1) / 2
			-- account for status bar in the Finder
			if curApp ends with ":Finder.app:" then
				set y2 to y2 - 22
			end if
			
			-- Horizontal size
			set x1 to dockSize + (displayWidth - dockSize) / 2
			set x2 to displayWidth
			
			-- Put the new bounds in action
			set bounds to {x1, y1, x2, y2}
		end tell
	end try
end tell
