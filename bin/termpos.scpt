# termpos.scpt - set terminal size/position using applescript
on run args
	set xPos to item 1 of args
	set yPos to item 2 of args
	set cols to item 3 of args
	set rows to item 4 of args
	tell application "Terminal"
		activate
		try
			tell front window
				set position to {xPos, yPos}
				set the number of columns to cols
				set the number of rows to rows
			end tell
		on error the error_message number the error_number
			display dialog "Error: " & the error_number & ". " & the error_message buttons {"Cancel"} default button 1
		end try
	end tell
end run
