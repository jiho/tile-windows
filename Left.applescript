(*
 * Resize and tile windows
 *
 * (c) Copyright 2010 JiHO. GNU General Public License
 *
 *)

-- Get display size
tell application "Finder"
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

-- Set menubar size
set menubarSize to 22

set curApp to (path to frontmost application as Unicode text)

tell application curApp
	try
		tell front window
			-- Get current window size
			set {x1, y1, x2, y2} to (get bounds)
			
			-- Vertical size
			set y1 to menubarSize
			set y2 to displayHeight

			if curApp ends with ":Finder.app:" then
				-- account for TotalFinder
				tell application "Finder"
					if (exists "mac:Applications:TotalFinder.app") then
						set y1 to y1 - 44
					end if
				end tell
			end if
			
			-- Horizontal size
			set x1 to dockSize
			set x2 to x1 + (displayWidth - dockSize) / 2
			
			-- Put the new bounds in action
			set bounds to {x1, y1, x2, y2}
		end tell
	end try
end tell
