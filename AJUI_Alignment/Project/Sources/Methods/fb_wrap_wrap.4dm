//%attributes = {}

C_OBJECT:C1216($flexbox;$1)
C_COLLECTION:C1488($itemsNewCoord;$2)
C_OBJECT:C1216($mainCoord;$coord)

$flexbox:=$1
$itemsNewCoord:=$2

$mainCoord:=$flexbox.coord

If ($itemsNewCoord#Null:C1517)
	If ($itemsNewCoord.length>0)
		// when wrap is done, we apply the new offset to the position of the remaining items
		$deltaTotal_width:=$itemsNewCoord[0].suggestedWidth+$itemsNewCoord[0].marginRight+$itemsNewCoord[0].marginLeft
		$deltaTotal_height:=$itemsNewCoord[0].suggestedHeight+$itemsNewCoord[0].marginTop+$itemsNewCoord[0].marginBottom
		$delta_x:=0
		$delta_y:=0
		$delta_width:=0
		$delta_height:=0
		$currentLine:=1
		$itemsNewCoord[0].line:=$currentLine
		$maxLineHeight:=0
		$maxLineWidth:=0
		
		$atLeastOneWrap:=False:C215
		For each ($coord;$itemsNewCoord;1)
			$wrap:=False:C215
			Case of 
				: ($flexbox.direction="row-reverse")  // Direction = Row Reverse
					
					If ($atLeastOneWrap=True:C214)
						$coord.x:=$delta_x-$coord.suggestedWidth-$coord.marginRight
						$coord.y:=$delta_y+$coord.marginTop
						$coord.right:=$coord.x+$coord.suggestedWidth
						$coord.bottom:=$coord.y+$coord.suggestedHeight
						$delta_x:=$delta_x-$coord.suggestedWidth-$coord.marginRight
					End if 
					
					If (($coord.x-$coord.marginLeft)<$mainCoord.x)
						$wrap:=True:C214
						$flexbox.wrapIsActive:=True:C214
					End if 
					
					If ($wrap=True:C214)
						$coord.x:=$mainCoord.right-$coord.suggestedWidth-$coord.marginRight
						$coord.y:=$mainCoord.y+$coord.marginTop+$deltaTotal_height
						$delta_x:=$coord.x-$coord.marginLeft
						$delta_y:=$mainCoord.y+$deltaTotal_height
						$coord.right:=$coord.x+$coord.suggestedWidth
						$coord.bottom:=$coord.y+$coord.suggestedHeight
						$delta_width:=$delta_width+$coord.suggestedWidth+$coord.marginRight+$coord.marginLeft
						$delta_height:=$deltaTotal_height
						$deltaTotal_height:=$deltaTotal_height+$coord.suggestedHeight+$coord.marginTop+$coord.marginBottom
						$atLeastOneWrap:=True:C214
						$currentLine:=$currentLine+1
					Else 
						
						If ((($coord.suggestedHeight+$coord.marginTop+$coord.marginBottom)+$delta_height)>($deltaTotal_height))
							$deltaTotal_height:=($coord.suggestedHeight+$coord.marginTop+$coord.marginBottom)+$delta_height
						End if 
						
					End if 
					
					If (($coord.suggestedHeight+$coord.marginTop+$coord.marginBottom)>$maxLineHeight)
						$maxLineHeight:=($coord.suggestedHeight+$coord.marginTop+$coord.marginBottom)
					End if 
					
					$flexbox["maxLineHeight"][String:C10($currentLine)]:=$maxLineHeight
					
				: ($flexbox.direction="column")  // Direction = Column
					
					If ($atLeastOneWrap=True:C214)
						$coord.x:=$delta_x+$coord.marginLeft
						$coord.y:=$delta_y+$coord.marginTop
						$coord.right:=$coord.x+$coord.suggestedWidth
						$coord.bottom:=$coord.y+$coord.suggestedHeight
						$delta_y:=$coord.y+$coord.suggestedHeight+$coord.marginTop
					End if 
					
					If (($coord.bottom+$coord.marginBottom)>$mainCoord.bottom)
						$wrap:=True:C214
						$flexbox.wrapIsActive:=True:C214
					End if 
					
					If ($wrap=True:C214)
						$coord.x:=$mainCoord.x+$coord.marginLeft+$deltaTotal_width
						$coord.y:=$mainCoord.y+$coord.marginTop
						$coord.right:=$coord.x+$coord.suggestedWidth
						$coord.bottom:=$coord.y+$coord.suggestedHeight
						$delta_x:=$mainCoord.x+$deltaTotal_width
						$delta_y:=$coord.bottom+$coord.marginBottom
						$delta_width:=$deltaTotal_width
						$delta_height:=$delta_height+$coord.suggestedHeight+$coord.marginTop+$coord.marginBottom
						$deltaTotal_width:=$deltaTotal_width+$coord.suggestedWidth+$coord.marginLeft+$coord.marginRight
						$atLeastOneWrap:=True:C214
						$currentLine:=$currentLine+1
						$maxLineWidth:=0
					Else 
						
						If ((($coord.suggestedWidth+$coord.marginLeft+$coord.marginRight)+$delta_width)>($deltaTotal_width))
							$deltaTotal_width:=($coord.suggestedWidth+$coord.marginLeft+$coord.marginRight)+$delta_width
						End if 
						
					End if 
					
					If (($coord.suggestedWidth+$coord.marginLeft+$coord.marginRight)>$maxLineWidth)
						$maxLineWidth:=($coord.suggestedWidth+$coord.marginLeft+$coord.marginRight)
					End if 
					
					$flexbox["maxLineWidth"][String:C10($currentLine)]:=$maxLineWidth
					
					
				: ($flexbox.direction="column-reverse")  // Direction = Column Reverse
					
					If ($atLeastOneWrap=True:C214)
						$coord.x:=$delta_x+$coord.marginLeft
						$coord.y:=$delta_y-$coord.suggestedHeight-$coord.marginBottom
						$coord.right:=$coord.x+$coord.suggestedWidth
						$coord.bottom:=$coord.y+$coord.suggestedHeight
						$delta_y:=$delta_y-$coord.suggestedHeight-$coord.marginBottom
					End if 
					
					If (($coord.y-$coord.marginTop)<$mainCoord.y)
						$wrap:=True:C214
						$flexbox.wrapIsActive:=True:C214
					End if 
					
					If ($wrap=True:C214)
						$coord.x:=$mainCoord.x+$coord.marginLeft+$deltaTotal_width
						$coord.y:=$mainCoord.bottom-$coord.marginBottom-$coord.suggestedHeight
						$coord.right:=$coord.x+$coord.suggestedWidth
						$coord.bottom:=$coord.y+$coord.suggestedHeight
						$delta_x:=$mainCoord.x+$deltaTotal_width
						$delta_y:=$coord.y-$coord.marginTop
						$delta_width:=$deltaTotal_width
						$delta_height:=$delta_height+$coord.suggestedHeight+$coord.marginTop+$coord.marginBottom
						$deltaTotal_width:=$deltaTotal_width+$coord.suggestedWidth+$coord.marginRight+$coord.marginLeft
						$atLeastOneWrap:=True:C214
						$currentLine:=$currentLine+1
						$maxLineWidth:=0
					Else 
						
						If ((($coord.suggestedWidth+$coord.marginLeft+$coord.marginRight)+$delta_width)>($deltaTotal_width))
							$deltaTotal_width:=($coord.suggestedWidth+$coord.marginLeft+$coord.marginRight)+$delta_width
						End if 
						
					End if 
					
					If (($coord.suggestedWidth+$coord.marginLeft+$coord.marginRight)>$maxLineWidth)
						$maxLineWidth:=($coord.suggestedWidth+$coord.marginLeft+$coord.marginRight)
					End if 
					
					$flexbox["maxLineWidth"][String:C10($currentLine)]:=$maxLineWidth
					
					
				Else   // Default Direction = Row
					
					If ($atLeastOneWrap=True:C214)
						$coord.x:=$delta_x+$coord.marginLeft
						$coord.y:=$delta_y+$coord.marginTop
						$coord.right:=$coord.x+$coord.suggestedWidth
						$coord.bottom:=$coord.y+$coord.suggestedHeight
						$delta_x:=$coord.x+$coord.suggestedWidth+$coord.marginLeft
					End if 
					
					If (($coord.right+$coord.marginRight)>$mainCoord.right)
						$wrap:=True:C214
						$flexbox.wrapIsActive:=True:C214
					End if 
					
					If ($wrap=True:C214)
						$coord.x:=$mainCoord.x+$coord.marginLeft
						$coord.y:=$mainCoord.y+$coord.marginTop+$deltaTotal_height
						$coord.right:=$coord.x+$coord.suggestedWidth
						$coord.bottom:=$coord.y+$coord.suggestedHeight
						$delta_x:=$coord.right+$coord.marginRight
						$delta_y:=$mainCoord.y+$deltaTotal_height
						$delta_width:=$delta_width+$coord.suggestedWidth+$coord.marginRight+$coord.marginLeft
						$delta_height:=$deltaTotal_height
						$deltaTotal_height:=$deltaTotal_height+$coord.suggestedHeight+$coord.marginTop+$coord.marginBottom
						$atLeastOneWrap:=True:C214
						$currentLine:=$currentLine+1
						$maxLineHeight:=0  // Reset the max line height
					Else 
						
						If ((($coord.suggestedHeight+$coord.marginTop+$coord.marginBottom)+$delta_height)>($deltaTotal_height))  // See if the current height is bigger than the previous height
							$deltaTotal_height:=($coord.suggestedHeight+$coord.marginTop+$coord.marginBottom)+$delta_height
						End if 
						
					End if 
					
					If (($coord.suggestedHeight+$coord.marginTop+$coord.marginBottom)>$maxLineHeight)
						$maxLineHeight:=$coord.suggestedHeight+$coord.marginTop+$coord.marginBottom
					End if 
					
					$flexbox["maxLineHeight"][String:C10($currentLine)]:=$maxLineHeight
					
			End case 
			$coord.right:=$coord.x+$coord.suggestedWidth
			$coord.bottom:=$coord.y+$coord.suggestedHeight
			$coord.line:=$currentLine
			
		End for each 
		
	End if 
End if 




