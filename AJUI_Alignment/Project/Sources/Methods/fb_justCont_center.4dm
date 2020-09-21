//%attributes = {}
// justify-content : flex-end

C_OBJECT:C1216($flexbox;$1)
C_COLLECTION:C1488($itemsNewCoord;$2)
C_OBJECT:C1216($mainCoord;$coord)

$flexbox:=$1
$itemsNewCoord:=$2

If ($itemsNewCoord#Null:C1517)
	If ($itemsNewCoord.length>0)
		
		$mainCoord:=$flexbox.coord
		$delta_width:=0
		$delta_height:=0
		$previous_line:=-777
		
		For ($i;$itemsNewCoord.length-1;0;-1)
			$coord:=$itemsNewCoord[$i]
			
			Case of 
				: ($flexbox.direction="row-reverse")  // Direction = Row Reverse
					
					$current_line:=$coord.line
					
					If ($coord.x>=$mainCoord.x) & ($current_line#$previous_line)
						$delta_width:=($coord.x-$mainCoord.x)/2
					End if 
					$previous_line:=$current_line
					If ($coord.x>=$mainCoord.x)
						$coord.x:=$coord.x-$delta_width
					End if 
					
				: ($flexbox.direction="column")  // Direction = Column
					
					$current_line:=$coord.line
					
					If (($coord.bottom+$coord.marginBottom)<=$mainCoord.bottom) & ($current_line#$previous_line)
						$delta_width:=($mainCoord.bottom-($coord.bottom+$coord.marginBottom))/2
					End if 
					$previous_line:=$current_line
					If (($coord.bottom+$coord.marginBottom)<=$mainCoord.bottom)
						$coord.y:=$coord.y+$delta_width
					End if 
					
				: ($flexbox.direction="column-reverse")  // Direction = Column Reverse
					
					$current_line:=$coord.line
					
					If ($coord.y>=$mainCoord.y) & ($current_line#$previous_line)
						$delta_width:=($coord.y-$mainCoord.y)/2
					End if 
					$previous_line:=$current_line
					If ($coord.y>=$mainCoord.y)
						$coord.y:=$coord.y-$delta_width
					End if 
					
				Else   // Default Direction = Row
					
					// Check if we have a new line
					$current_line:=$coord.line
					
					// Check if we have some space left
					If (($coord.right+$coord.marginRight)<$mainCoord.right) & ($current_line#$previous_line)
						$delta_width:=($mainCoord.right-($coord.right+$coord.marginRight))/2  // Store the delta of the space left
					End if 
					$previous_line:=$current_line  // This mecanism is to see if we are on a new line
					If (($coord.right+$coord.marginRight)<$mainCoord.right)
						$coord.x:=$coord.x+$delta_width  // Move with the delta
					End if 
			End case 
			
			$coord.right:=$coord.x+$coord.suggestedWidth
			$coord.bottom:=$coord.y+$coord.suggestedHeight
		End for 
		
	End if 
End if 