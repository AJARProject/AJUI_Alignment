//%attributes = {}
C_OBJECT:C1216($flexbox;$1)
C_COLLECTION:C1488($itemsNewCoord;$2)
C_OBJECT:C1216($mainCoord;$coord;$itemDone)
C_REAL:C285($delta_width;$delta_height;$newWidth;$newHeight)
C_REAL:C285($widthToRemovePerItem;$heightToRemovePerItem;$widthToRemove;$heightToRemove)
C_COLLECTION:C1488($itemsDone;$originalWidth;$originalHeight)

$flexbox:=$1
$itemsNewCoord:=$2
$originalWidth:=$itemsNewCoord.extract("suggestedWidth")
$originalHeight:=$itemsNewCoord.extract("suggestedHeight")

$mainCoord:=$flexbox.coord

//If (($mainCoord.width<$flexbox.itemsMaximumWidth) & (($flexbox.direction="row") | ($flexbox.direction="row-reverse"))) | \
(($flexbox.totalHeight>$mainCoord.height) & (($flexbox.direction="column") | ($flexbox.direction="column-reverse")))

$itemsDone:=New collection:C1472()  // will contain all the items that are done with the calculation
$itemsDone[$itemsNewCoord.length-1]:=Null:C1517  // Init all values to null
$widthToRemove:=$flexbox.totalWidth-$mainCoord.width
$heightToRemove:=$flexbox.totalHeight-$mainCoord.height
$itemsLeft:=$itemsNewCoord.length
Repeat 
	
	$widthToRemovePerItem:=($widthToRemove/$itemsLeft)
	$heightToRemovePerItem:=($heightToRemove/$itemsLeft)
	$delta_width:=$mainCoord.x
	$delta_height:=$mainCoord.y
	$i:=0
	$recalc:=False:C215
	For each ($coord;$itemsNewCoord)
		
		Case of 
			: ($flexbox.direction="row-reverse")  // Direction = Row Reverse
				
				If ($mainCoord.width<$flexbox.itemsMinimumWidth)
					$newWidth:=$coord.minWidth
				Else 
					If ($mainCoord.width>$flexbox.itemsMaximumWidth)
						$newWidth:=$coord.maxWidth
					Else 
						$newWidth:=$originalWidth[$i]-$widthToRemovePerItem
						If ($newWidth<$coord.minWidth) | ($newWidth>$coord.maxWidth)
							If ($itemsDone[$i]=Null:C1517)
								If ($newWidth<$coord.minWidth)
									$newWidth:=$coord.minWidth
								Else 
									$newWidth:=$coord.maxWidth
								End if 
								$itemDone:=New object:C1471("width";$originalWidth[$i];"newWidth";$newWidth;"diffWidth";$originalWidth[$i]-$newWidth)
								$itemsDone[$i]:=$itemDone
								$recalc:=True:C214
							Else 
								$newWidth:=$itemsDone[$i].newWidth
							End if 
						End if 
					End if 
				End if 
				
				$coord.suggestedWidth:=$newWidth
				$coord.x:=$delta_width+$mainCoord.width-$newWidth-$coord.marginLeft-$coord.marginRight
				$delta_width:=$delta_width-$newWidth-$coord.marginLeft-$coord.marginRight
				
			: ($flexbox.direction="column")  // Direction = Column
				
				If ($mainCoord.height<$flexbox.itemsMinimumHeight)
					$newHeight:=$coord.minHeight
				Else 
					If ($mainCoord.height>$flexbox.itemsMaximumHeight)
						$newHeight:=$coord.maxHeight
					Else 
						$newHeight:=$originalHeight[$i]-$heightToRemovePerItem
						If ($newHeight<$coord.minHeight) | ($newHeight>$coord.maxHeight)
							If ($itemsDone[$i]=Null:C1517)
								If ($newHeight<$coord.minHeight)
									$newHeight:=$coord.minHeight
								Else 
									$newHeight:=$coord.maxHeight
								End if 
								$itemDone:=New object:C1471("height";$originalHeight[$i];"newHeight";$newHeight;"diffHeight";$originalHeight[$i]-$newHeight)
								$itemsDone[$i]:=$itemDone
								$recalc:=True:C214
							Else 
								$newHeight:=$itemsDone[$i].newHeight
							End if 
						End if 
					End if 
				End if 
				
				$coord.suggestedHeight:=$newHeight
				$coord.y:=$delta_height+$coord.marginTop
				$delta_height:=$delta_height+$newHeight+$coord.marginTop+$coord.marginBottom
				
				
			: ($flexbox.direction="column-reverse")  // Direction = Column Reverse
				
				If ($mainCoord.height<$flexbox.itemsMinimumHeight)
					$newHeight:=$coord.minHeight
				Else 
					If ($mainCoord.height>$flexbox.itemsMaximumHeight)
						$newHeight:=$coord.maxHeight
					Else 
						$newHeight:=$originalHeight[$i]-$heightToRemovePerItem
						If ($newHeight<$coord.minHeight) | ($newHeight>$coord.maxHeight)
							If ($itemsDone[$i]=Null:C1517)
								If ($newHeight<$coord.minHeight)
									$newHeight:=$coord.minHeight
								Else 
									$newHeight:=$coord.maxHeight
								End if 
								$itemDone:=New object:C1471("width";$originalHeight[$i];"newHeight";$newHeight;"diffHeight";$originalHeight[$i]-$newHeight)
								$itemsDone[$i]:=$itemDone
								$recalc:=True:C214
							Else 
								$newHeight:=$itemsDone[$i].newHeight
							End if 
						End if 
					End if 
				End if 
				
				$coord.suggestedHeight:=$newHeight
				$coord.y:=$delta_height+$mainCoord.height-$newHeight-$coord.marginTop-$coord.marginBottom
				$delta_height:=$delta_height-$newHeight-$coord.marginTop-$coord.marginBottom
			Else   // Default Direction = Row
				
				If ($mainCoord.width<$flexbox.itemsMinimumWidth)
					$newWidth:=$coord.minWidth
				Else 
					If ($mainCoord.width>$flexbox.itemsMaximumWidth)
						$newWidth:=$coord.maxWidth
					Else 
						$newWidth:=$originalWidth[$i]-$widthToRemovePerItem
						If ($newWidth<$coord.minWidth) | ($newWidth>$coord.maxWidth)
							If ($itemsDone[$i]=Null:C1517)
								If ($newWidth<$coord.minWidth)
									$newWidth:=$coord.minWidth
								Else 
									$newWidth:=$coord.maxWidth
								End if 
								$itemDone:=New object:C1471("width";$originalWidth[$i];"newWidth";$newWidth;"diffWidth";$originalWidth[$i]-$newWidth)
								$itemsDone[$i]:=$itemDone
								$recalc:=True:C214
							Else 
								$newWidth:=$itemsDone[$i].newWidth
							End if 
						Else 
						End if 
					End if 
				End if 
				
				$coord.suggestedWidth:=$newWidth
				$coord.x:=$delta_width+$coord.marginLeft
				$delta_width:=$delta_width+$newWidth+$coord.marginLeft+$coord.marginRight
				
		End case 
		$coord.right:=$coord.x+$coord.suggestedWidth
		$coord.bottom:=$coord.y+$coord.suggestedHeight
		$coord.line:=1
		$i:=$i+1
	End for each 
	$flexbox.maxLineHeight["1"]:=0
	$flexbox.maxLineWidth["1"]:=0
	$widthToRemove:=$flexbox.totalWidth-$mainCoord.width-$itemsDone.sum("diffWidth")
	$heightToRemove:=$flexbox.totalHeight-$mainCoord.height-$itemsDone.sum("diffHeight")
	$itemsLeft:=$itemsDone.countValues(Null:C1517)
Until ($recalc=False:C215) | ($itemsLeft=0)

//End if 
