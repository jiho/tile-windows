(*
 * Resize and tile windows
 *
 * (c) Copyright 2010 JiHO. GNU General Public License
 *
 *)

-- Get display sizetell application "Finder"
	set b to bounds of window of desktop
	set displayHeight to (item 4 of b)
end tell

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
			set y2 to displayHeight
			
			-- Put the new bounds in action
			set bounds to {x1, y1, x2, y2}
		end tell
	end try
end tell