//%attributes = {}

C_OBJECT:C1216($flexbox;$1)
C_COLLECTION:C1488($itemsNewCoord;$2)
C_OBJECT:C1216($coord;$item)
C_REAL:C285($horizontalAxis_delta;$verticalAxis_delta)

$flexbox:=$1
$itemsNewCoord:=$2

// Here we prefere optimization of the executing time over a complexe intellectual implementation that at the end will slow down the execution time (tested during development)
Case of 
	: ($flexbox.direction="row")
		// Define where the "main start" coordinate starts. This will position the first element in the space
		// The delta will always be updated to know where the next element will be placed
		$horizontalAxis_delta:=$flexbox.coord.x
		$verticalAxis_delta:=$flexbox.coord.y
		// For row, we start from the "main start" and add the next item at the right of the previous
		// So we add, to the delta, the width of the item
		For each ($item;$flexbox.items)
			$coord:=OB Copy:C1225($item)
			$horizontalAxis_delta:=$horizontalAxis_delta+$coord.marginLeft
			$coord.x:=$horizontalAxis_delta
			$coord.y:=$verticalAxis_delta+$coord.marginTop
			$coord.right:=$coord.x+$coord.suggestedWidth
			$coord.bottom:=$coord.y+$coord.suggestedHeight
			$itemsNewCoord.push($coord)
			$horizontalAxis_delta:=$horizontalAxis_delta+$coord.suggestedWidth+$coord.marginRight
		End for each 
		
	: ($flexbox.direction="row-reverse")
		// Define where the "main start" coordinate starts. This will position the first element in the space
		// The delta will always be updated to know where the next element will be placed
		$horizontalAxis_delta:=$flexbox.coord.right
		$verticalAxis_delta:=$flexbox.coord.y
		// For row-reverse, we start from the "main start" and we add the next item to the left of the previous
		// So we remove, to the delta, the width of the item
		For each ($item;$flexbox.items)
			$coord:=OB Copy:C1225($item)
			$horizontalAxis_delta:=$horizontalAxis_delta-($coord.suggestedWidth+$coord.marginLeft+$coord.marginRight)  // To find the correct x coordinate we have to make right-width
			$coord.x:=$horizontalAxis_delta
			$coord.y:=$verticalAxis_delta+$coord.marginTop
			$coord.right:=$coord.x+$coord.suggestedWidth
			$coord.bottom:=$coord.y+$coord.suggestedHeight
			$itemsNewCoord.push($coord)
		End for each 
		
	: ($flexbox.direction="column")
		// Define where the "main start" coordinate starts. This will position the first element in the space
		// The delta will always be updated to know where the next element will be placed
		$horizontalAxis_delta:=$flexbox.coord.x
		$verticalAxis_delta:=$flexbox.coord.y
		// For column, we start from the "main start" and add the next item at the bottom of the previous
		// So we add, to the delta, the height of the item
		For each ($item;$flexbox.items)
			$coord:=OB Copy:C1225($item)
			$verticalAxis_delta:=$verticalAxis_delta+$coord.marginTop
			$coord.x:=$horizontalAxis_delta+$coord.marginLeft
			$coord.y:=$verticalAxis_delta
			$coord.right:=$coord.x+$coord.suggestedWidth
			$coord.bottom:=$coord.y+$coord.suggestedHeight
			$itemsNewCoord.push($coord)
			$verticalAxis_delta:=$verticalAxis_delta+$coord.suggestedHeight+$coord.marginBottom
		End for each 
		
	: ($flexbox.direction="column-reverse")
		// Define where the "main start" coordinate starts. This will position the first element in the space
		// The delta will always be updated to know where the next element will be placed
		$horizontalAxis_delta:=$flexbox.coord.x
		$verticalAxis_delta:=$flexbox.coord.bottom
		// For column-reverse, we start from the "main start" and we add the next item to the top of the previous
		// So we remove, to the delta, the height of the item
		For each ($item;$flexbox.items)
			$coord:=OB Copy:C1225($item)
			$verticalAxis_delta:=$verticalAxis_delta-($coord.suggestedHeight+$coord.marginTop+$coord.marginBottom)  // To find the correct y coordinate we have to make bottom-height
			$coord.x:=$horizontalAxis_delta+$coord.marginLeft
			$coord.y:=$verticalAxis_delta
			$coord.right:=$coord.x+$coord.suggestedWidth
			$coord.bottom:=$coord.y+$coord.suggestedHeight
			$itemsNewCoord.push($coord)
		End for each 
End case 