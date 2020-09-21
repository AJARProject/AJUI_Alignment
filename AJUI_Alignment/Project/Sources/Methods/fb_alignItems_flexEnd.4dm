//%attributes = {}
// TEMPLATE

C_OBJECT:C1216($flexbox;$1)
C_COLLECTION:C1488($itemsNewCoord;$2)
C_OBJECT:C1216($mainCoord;$coord)

$flexbox:=$1
$itemsNewCoord:=$2

$mainCoord:=$flexbox.coord

If ($itemsNewCoord#Null:C1517)
	If ($itemsNewCoord.length>0)
		
		For each ($coord;$itemsNewCoord)
			
			Case of 
				: ($flexbox.direction="row-reverse")  // Direction = Row Reverse
				: ($flexbox.direction="column")  // Direction = Column
				: ($flexbox.direction="column-reverse")  // Direction = Column Reverse
				Else   // Default Direction = Row
					If ($flexbox.wrap="wrap-reverse")
					Else 
					End if 
			End case 
			
			$coord.right:=$coord.x+$coord.width
			$coord.bottom:=$coord.y+$coord.height
		End for each 
		
	End if 
End if 