//%attributes = {}
// align-items : stretch

C_OBJECT:C1216($flexbox;$1)
C_COLLECTION:C1488($itemsNewCoord;$2)
C_OBJECT:C1216($mainCoord;$coord)
C_REAL:C285($restWidth;$restHeight)
C_LONGINT:C283($delta_x;$delta_y)

$flexbox:=$1
$itemsNewCoord:=$2

$mainCoord:=$flexbox.coord

$nbLines:=$itemsNewCoord.distinct("line").length
If ($nbLines=0)
	$nbLines:=1  // Patch if the line item not defined (only defined in the wrap(-reverse) methods)
End if 

If ($itemsNewCoord#Null:C1517)
	If ($itemsNewCoord.length>0)
		If ($flexbox.wrap="wrap-reverse")
			$delta_y:=$mainCoord.bottom
			$delta_x:=$mainCoord.right
		Else 
			$delta_y:=$mainCoord.y
			$delta_x:=$mainCoord.x
		End if 
		$previousLine:=1
		$newDeltaTemp:=0
		$restApply:=False:C215
		
		$restHeight:=($mainCoord.bottom-$mainCoord.y)/$nbLines
		$restWidth:=($mainCoord.right-$mainCoord.x)/$nbLines
		
		For each ($coord;$itemsNewCoord)
			
			Case of 
				: ($flexbox.direction="column@")  // Direction = Column
					
					If ($coord.autoWidth=True:C214) & ($restWidth>$coord.bestWidth)
						$coord.width:=$restWidth
					End if 
					
					If ($previousLine#$coord.line)
						If ($newDeltaTemp#0)
							If ($flexbox.wrap="wrap-reverse")
								$delta_x:=$delta_x-$newDeltaTemp
							Else 
								$delta_x:=$delta_x+$newDeltaTemp
							End if 
							$newDeltaTemp:=0
						Else 
							If ($flexbox.wrap="wrap-reverse")
								$delta_x:=$delta_x-$restWidth
							Else 
								$delta_x:=$delta_x+$restWidth
							End if 
						End if 
					End if 
					If ($flexbox.wrap="wrap-reverse")
						$coord.x:=$delta_x-$coord.width
					Else 
						$coord.x:=$delta_x
					End if 
					If (($coord.width<=$flexbox["maxLineWidth"][String:C10($coord.line)]) & \
						($flexbox["maxLineWidth"][String:C10($coord.line)]>$restWidth) & \
						($coord.width>$newDeltaTemp))
						$coord.width:=$flexbox["maxLineWidth"][String:C10($coord.line)]
						$newDeltaTemp:=$coord.width
					End if 
					
					//If ($coord.width<=$flexbox["maxLineWidth"][String($coord.line)]) & \
						($flexbox["maxLineWidth"][String($coord.line)]<$restWidth) & \
						($newDeltaTemp=0)
					//$newDeltaTemp:=$coord.width
					//End if 
					
				Else   // Default Direction = Row Or Row-Reverse
					
					If ($coord.autoHeight=True:C214) & ($restHeight>$coord.bestHeight)
						$coord.height:=$restHeight
						$restApply:=True:C214
					End if 
					
					If ($previousLine#$coord.line)
						If ($newDeltaTemp#0)
							If ($flexbox.wrap="wrap-reverse")
								$delta_y:=$delta_y-$newDeltaTemp
							Else 
								$delta_y:=$delta_y+$newDeltaTemp
							End if 
							$newDeltaTemp:=0
						Else 
							If ($flexbox.wrap="wrap-reverse")
								$delta_y:=$delta_y-$restHeight
							Else 
								$delta_y:=$delta_y+$restHeight
							End if 
						End if 
						$restApply:=False:C215
					End if 
					If ($flexbox.wrap="wrap-reverse")
						$coord.y:=$delta_y-$coord.height
					Else 
						$coord.y:=$delta_y
					End if 
					If ($coord.height<$flexbox["maxLineHeight"][String:C10($coord.line)]) & \
						($flexbox["maxLineHeight"][String:C10($coord.line)]>$restHeight) & \
						($coord.autoHeight=True:C214)
						$coord.height:=$flexbox["maxLineHeight"][String:C10($coord.line)]
						$newDeltaTemp:=$coord.height
					End if 
					
					If ($coord.height<=$flexbox["maxLineHeight"][String:C10($coord.line)]) & \
						($flexbox["maxLineHeight"][String:C10($coord.line)]<$restHeight) & \
						($coord.autoHeight=False:C215) & ($restApply=False:C215)
						$newDeltaTemp:=$coord.height
					End if 
					
			End case 
			
			$coord.right:=$coord.x+$coord.width
			$coord.bottom:=$coord.y+$coord.height
			$previousLine:=$coord.line
		End for each 
		
	End if 
End if 