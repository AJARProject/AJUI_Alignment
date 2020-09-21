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
		$deltaTotal_width:=$itemsNewCoord[0].width
		$deltaTotal_height:=$itemsNewCoord[0].height
		$delta_x:=0
		$delta_y:=0
		$delta_width:=0
		$delta_height:=0
		$currentLine:=1
		$itemsNewCoord[0].line:=$currentLine
		$maxLineHeight:=0
		$maxLineWidth:=0
		
		If (($flexbox.direction="row@"))
			$itemsNewCoord[0].y:=$mainCoord.bottom-$itemsNewCoord[0].height
		End if 
		If (($flexbox.direction="column@"))
			$itemsNewCoord[0].x:=$mainCoord.right-$itemsNewCoord[0].width
		End if 
		$itemsNewCoord[0].right:=$itemsNewCoord[0].x+$itemsNewCoord[0].width
		$itemsNewCoord[0].bottom:=$itemsNewCoord[0].y+$itemsNewCoord[0].height
		$atLeastOneWrap:=False:C215
		For each ($coord;$itemsNewCoord;1)
			$wrap:=False:C215
			Case of 
				: ($flexbox.direction="row-reverse")  // Direction = Row Reverse
					
					If ($atLeastOneWrap=True:C214)
						$coord.x:=$delta_x-$coord.width
						$coord.y:=$delta_y
						$coord.right:=$coord.x+$coord.width
						$coord.bottom:=$coord.y+$coord.height
						$delta_x:=$delta_x-$coord.width
					End if 
					
					If ($coord.x<$mainCoord.x)
						$wrap:=True:C214
						$flexbox.wrapIsActive:=True:C214
					End if 
					
					If ($wrap=True:C214)
						$coord.x:=$mainCoord.right-$coord.width
						$coord.y:=$mainCoord.bottom-$coord.height-$deltaTotal_height
						$coord.right:=$coord.x+$coord.width
						$coord.bottom:=$coord.y+$coord.height
						$delta_x:=$coord.x
						$delta_y:=$coord.y
						$delta_width:=$delta_width+$coord.width
						$delta_height:=$deltaTotal_height
						$deltaTotal_height:=$deltaTotal_height+$coord.height
						$atLeastOneWrap:=True:C214
						$currentLine:=$currentLine+1
					Else 
						
						$coord.y:=$mainCoord.bottom-$coord.height-$delta_height
						If (($coord.height+$delta_height)>($deltaTotal_height))
							$deltaTotal_height:=$coord.height+$delta_height
						End if 
						
					End if 
					
					If ($coord.autoHeight=False:C215) & ($coord.height>$maxLineHeight)
						$maxLineHeight:=$coord.height
					End if 
					
					$flexbox["maxLineHeight"][String:C10($currentLine)]:=$maxLineHeight
					
					
				: ($flexbox.direction="column")  // Direction = Column
					
					If ($atLeastOneWrap=True:C214)
						$coord.x:=$delta_x
						$coord.y:=$delta_y
						$coord.right:=$coord.x+$coord.width
						$coord.bottom:=$coord.y+$coord.height
						$delta_y:=$coord.y+$coord.height
					End if 
					
					If ($coord.bottom>$mainCoord.bottom)
						$wrap:=True:C214
						$flexbox.wrapIsActive:=True:C214
					End if 
					
					If ($wrap=True:C214)
						$coord.x:=$mainCoord.right-$coord.width-$deltaTotal_width
						$coord.y:=$mainCoord.y
						$coord.right:=$coord.x+$coord.width
						$coord.bottom:=$coord.y+$coord.height
						$delta_x:=$coord.x
						$delta_y:=$coord.bottom
						$delta_width:=$deltaTotal_width
						$delta_height:=$delta_height+$coord.height
						$deltaTotal_width:=$deltaTotal_width+$coord.width
						$atLeastOneWrap:=True:C214
						$currentLine:=$currentLine+1
					Else 
						$coord.x:=$mainCoord.right-$coord.width-$delta_width
						If (($coord.width+$delta_width)>($deltaTotal_width))
							$deltaTotal_width:=$coord.width+$delta_width
						End if 
						
					End if 
					
					If ($coord.autoWidth=False:C215) & ($coord.width>$maxLineWidth)
						$maxLineWidth:=$coord.width
					End if 
					
					$flexbox["maxLineWidth"][String:C10($currentLine)]:=$maxLineWidth
					
				: ($flexbox.direction="column-reverse")  // Direction = Column Reverse
					
					
					If ($atLeastOneWrap=True:C214)
						$coord.x:=$delta_x
						$coord.y:=$delta_y-$coord.height
						$coord.right:=$coord.x+$coord.width
						$coord.bottom:=$coord.y+$coord.height
						$delta_y:=$delta_y-$coord.height
					End if 
					
					If ($coord.y<$mainCoord.y)
						$wrap:=True:C214
						$flexbox.wrapIsActive:=True:C214
					End if 
					
					If ($wrap=True:C214)
						$coord.x:=$mainCoord.right-$coord.width-$deltaTotal_width
						$coord.y:=$mainCoord.bottom-$coord.height
						$coord.right:=$coord.x+$coord.width
						$coord.bottom:=$coord.y+$coord.height
						$delta_x:=$coord.x
						$delta_y:=$coord.y
						$delta_width:=$deltaTotal_width
						$delta_height:=$delta_height+$coord.height
						$deltaTotal_width:=$deltaTotal_width+$coord.width
						$atLeastOneWrap:=True:C214
						$currentLine:=$currentLine+1
					Else 
						
						$coord.x:=$mainCoord.right-$coord.width-$delta_width
						If (($coord.width+$delta_width)>($deltaTotal_width))
							$deltaTotal_width:=$coord.width+$delta_width
						End if 
						
					End if 
					
					If ($coord.autoWidth=False:C215) & ($coord.width>$maxLineWidth)
						$maxLineWidth:=$coord.width
					End if 
					
					$flexbox["maxLineWidth"][String:C10($currentLine)]:=$maxLineWidth
					
				Else   // Default Direction = Row
					
					If ($atLeastOneWrap=True:C214)
						$coord.x:=$delta_x
						$coord.y:=$delta_y
						$coord.right:=$coord.x+$coord.width
						$coord.bottom:=$coord.y+$coord.height
						$delta_x:=$coord.x+$coord.width
					End if 
					
					If ($coord.right>$mainCoord.right)
						$wrap:=True:C214
						$flexbox.wrapIsActive:=True:C214
					End if 
					
					If ($wrap=True:C214)
						$coord.x:=$mainCoord.x
						$coord.y:=$mainCoord.bottom-$coord.height-$deltaTotal_height
						$coord.right:=$coord.x+$coord.width
						$coord.bottom:=$coord.y+$coord.height
						$delta_x:=$coord.right
						$delta_y:=$coord.y
						$delta_width:=$delta_width+$coord.width
						$delta_height:=$deltaTotal_height
						$deltaTotal_height:=$deltaTotal_height+$coord.height
						$atLeastOneWrap:=True:C214
						$currentLine:=$currentLine+1
					Else 
						$coord.y:=$mainCoord.bottom-$coord.height-$delta_height
						If (($coord.height+$delta_height)>($deltaTotal_height))  // See if the current height is bigger than the previous height
							$deltaTotal_height:=$coord.height+$delta_height
						End if 
						
					End if 
					
					If ($coord.autoHeight=False:C215) & ($coord.height>$maxLineHeight)
						$maxLineHeight:=$coord.height
					End if 
					
					$flexbox["maxLineHeight"][String:C10($currentLine)]:=$maxLineHeight
					
			End case 
			$coord.right:=$coord.x+$coord.width
			$coord.bottom:=$coord.y+$coord.height
			$coord.line:=$currentLine
			
		End for each 
		
	End if 
End if 




