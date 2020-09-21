//%attributes = {}
// justify-content : space-around

C_OBJECT:C1216($flexbox;$1)
C_COLLECTION:C1488($itemsNewCoord;$2)
C_OBJECT:C1216($mainCoord;$coord)
C_REAL:C285($sizeRest)
C_LONGINT:C283($count)

$flexbox:=$1
$itemsNewCoord:=$2

If ($itemsNewCoord#Null:C1517)
	If ($itemsNewCoord.length>0)
		
		$mainCoord:=$flexbox.coord
		$delta_width:=0
		$delta_height:=0
		$previous_line:=-777
		$calc:=False:C215
		$count:=$itemsNewCoord.length-1
		$spaceEven:=0
		
		For ($i;$itemsNewCoord.length-1;0;-1)
			$coord:=$itemsNewCoord[$i]
			
			Case of 
				: ($flexbox.direction="row-reverse")  // Direction = Row Reverse
					
					$current_line:=$coord.line
					
					// Check if we have some space left for each line
					If ($coord.x>=$mainCoord.x) & ($current_line#$previous_line)
						$calc:=True:C214
						// Store values to be recalculated after each elements
						$sizeRest:=($coord.x-$mainCoord.x)
						$count:=$itemsNewCoord.countValues($coord.line;"line")
						$spaceEven:=$sizeRest/($count+1)
					End if 
					
					If ($calc=True:C214) & ($spaceEven#0)
						$delta_width:=$spaceEven*($count)  // Store the delta of the space left
						$coord.x:=$coord.x-$delta_width  // Move with the delta
					End if 
					$previous_line:=$current_line  // This mecanism is to see if we are on a new line
					
				: ($flexbox.direction="column")  // Direction = Column
					
					$current_line:=$coord.line
					
					// Check if we have some space left for each line
					If (($coord.bottom+$coord.marginBottom)<=$mainCoord.bottom) & ($current_line#$previous_line)
						$calc:=True:C214
						// Store values to be recalculated after each elements
						$sizeRest:=($mainCoord.bottom-$coord.bottom)
						$count:=$itemsNewCoord.countValues($coord.line;"line")
						$spaceEven:=$sizeRest/($count+1)
					End if 
					
					If ($calc=True:C214) & ($spaceEven#0)
						$delta_height:=$spaceEven*($count)  // Store the delta of the space left
						$coord.y:=$coord.y+$delta_height  // Move with the delta
					End if 
					$previous_line:=$current_line  // This mecanism is to see if we are on a new line
					
				: ($flexbox.direction="column-reverse")  // Direction = Column Reverse
					
					$current_line:=$coord.line
					
					// Check if we have some space left for each line
					If ($coord.y>=$mainCoord.y) & ($current_line#$previous_line)
						$calc:=True:C214
						// Store values to be recalculated after each elements
						$sizeRest:=($coord.y-$mainCoord.y)
						$count:=$itemsNewCoord.countValues($coord.line;"line")
						$spaceEven:=$sizeRest/($count+1)
					End if 
					
					If ($calc=True:C214) & ($spaceEven#0)
						$delta_height:=$spaceEven*($count)  // Store the delta of the space left
						$coord.y:=$coord.y-$delta_height  // Move with the delta
					End if 
					$previous_line:=$current_line  // This mecanism is to see if we are on a new line
					
					
				Else   // Default Direction = Row
					
					$current_line:=$coord.line
					
					// Check if we have some space left for each line
					If (($coord.right+$coord.marginRight)<=$mainCoord.right) & ($current_line#$previous_line)
						$calc:=True:C214
						// Store values to be recalculated after each elements
						$sizeRest:=($mainCoord.right-($coord.right+$coord.marginRight))
						$count:=$itemsNewCoord.countValues($coord.line;"line")
						$spaceEven:=$sizeRest/($count+1)
					End if 
					
					If ($calc=True:C214) & ($spaceEven#0)
						$delta_width:=$spaceEven*($count)  // Store the delta of the space left
						$coord.x:=$coord.x+$delta_width  // Move with the delta
					End if 
					$previous_line:=$current_line  // This mecanism is to see if we are on a new line
			End case 
			$count:=$count-1
			$coord.right:=$coord.x+$coord.suggestedWidth
			$coord.bottom:=$coord.y+$coord.suggestedHeight
		End for 
		
	End if 
End if 