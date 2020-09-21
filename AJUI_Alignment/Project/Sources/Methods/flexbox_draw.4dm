//%attributes = {}
// DEPRECATED --> USE AJUI_Flexbox_apply

ON ERR CALL:C155("error_handler")

C_OBJECT:C1216($1;$flexbox;$item)
C_COLLECTION:C1488($itemsNewCoord)
C_LONGINT:C283($bestWidth;$bestHeight)

$flexbox:=$1

If ($flexbox.display="flex")
	// display
	
	// We always start from the original coordinates of the items
	$itemsNewCoord:=New collection:C1472()
	$flexbox.maxLineHeight:=New object:C1471()
	$flexbox.maxLineWidth:=New object:C1471()
	For ($i;1;100)
		// Initialize 100 lines to 0
		$flexbox.maxLineHeight[String:C10($i)]:=0
		$flexbox.maxLineWidth[String:C10($i)]:=0
	End for 
	
	// store container coordinates once for all
	OBJECT GET COORDINATES:C663(*;$flexbox.id;$left;$top;$right;$bottom)
	$flexbox.coord:=New object:C1471("x";$left;"y";$top;"width";$right-$left;"height";$bottom-$top;"right";$right;"bottom";$bottom)
	
	If ($flexbox.totalMinWidth=Null:C1517)
		$totalMinWidth:=0
		$totalMinHeight:=0
		$totalWidth:=0
		$totalHeight:=0
		
		For each ($item;$flexbox.items)
			OBJECT GET BEST SIZE:C717(*;$item.id;$bestWidth;$bestHeight)
			$item.bestWidth:=$bestWidth
			$item.bestHeight:=$bestHeight
			
			If ($item.minWidth#Null:C1517)
				$item.bestWidth:=$item.minWidth
			End if 
			If ($item.minHeight#Null:C1517)
				$item.bestHeight:=$item.minHeight
			End if 
			
			$totalMinWidth:=$totalMinWidth+$item.bestWidth
			$totalMinHeight:=$totalMinHeight+$item.bestHeight
			
			If ($item.width=Null:C1517)
				$item.width:=$item.bestWidth
				$item.autoWidth:=True:C214
			Else 
				$item.autoWidth:=False:C215
			End if 
			If ($item.height=Null:C1517)
				$item.height:=$item.bestHeight
				$item.autoHeight:=True:C214
			Else 
				$item.autoHeight:=False:C215
			End if 
			
			$totalWidth:=$totalWidth+$item.width
			$totalHeight:=$totalHeight+$item.height
			
			$item.line:=1
		End for each 
		$flexbox.totalMinWidth:=$totalMinWidth
		$flexbox.totalMinHeight:=$totalMinHeight
		$flexbox.totalWidth:=$totalWidth
		$flexbox.totalHeight:=$totalHeight
		
		
	End if 
	//  // direction
	//Case of 
	//: ($flexbox.direction="column")
	//  //fb_direction_column ($flexbox;$itemsNewCoord)
	
	//: ($flexbox.direction="row-reverse")
	//  //fb_direction_row_reverse ($flexbox;$itemsNewCoord)
	
	//: ($flexbox.direction="column-reverse")
	//  //fb_direction_column_reverse ($flexbox;$itemsNewCoord)
	
	//Else 
	//  // default row
	//If ($flexbox.direction=Null)
	//$flexbox.direction:="row"
	//End if 
	//  //AJUI_Flexbox_direction ($flexbox;$itemsNewCoord)
	
	//End case 
	
	
	// wrap
	Case of 
		: ($flexbox.wrap="wrap")
			fb_wrap_wrap($flexbox;$itemsNewCoord)
			
		: ($flexbox.wrap="wrap-reverse")
			fb_wrap_wrap_reverse($flexbox;$itemsNewCoord)
			
		Else 
			// default nowrap
			If ($flexbox.direction=Null:C1517)
				$flexbox.wrap:="nowrap"
			End if 
			fb_wrap_nowrap($flexbox;$itemsNewCoord)
			
	End case 
	
	// justify-content - main axis
	Case of 
		: ($flexbox.justifyContent="flex-end")
			fb_justCont_flexEnd($flexbox;$itemsNewCoord)
			
		: ($flexbox.justifyContent="center")
			fb_justCont_center($flexbox;$itemsNewCoord)
			
		: ($flexbox.justifyContent="space-between")
			fb_justCont_spaceBetween($flexbox;$itemsNewCoord)
			
		: ($flexbox.justifyContent="space-around")
			fb_justCont_spaceAround($flexbox;$itemsNewCoord)
			
		: ($flexbox.justifyContent="space-evenly")
			fb_justCont_spaceEvenly($flexbox;$itemsNewCoord)
			
		Else 
			
			// default flex-start
			If ($flexbox.justifyContent=Null:C1517)
				$flexbox.justifyContent:="flex-start"
			End if 
			// Do nothing by default it is already aligned to the left
			//fb_justCont_flexStart ($flexbox;$itemsNewCoord)
			
	End case 
	
	If (1=2)
		// align-items
		Case of 
			: ($flexbox.alignItems="stretch")
				// Only work for the no-wrap today
				//fb_alignItems_stretch ($flexbox;$itemsNewCoord)
				
			: ($flexbox.alignItems="flex-end")
				fb_alignItems_flexEnd($flexbox;$itemsNewCoord)
				
			: ($flexbox.alignItems="center")
				//fb_alignItems_center($flexbox;$itemsNewCoord)
				
			Else 
				
				// default flex-start
				If ($flexbox.justifyContent=Null:C1517)
					$flexbox.alignItems:="flex-start"
				End if 
				// No code needed
				
		End case 
		
		
		If ($flexbox.wrapIsActive=True:C214)
			// align-content
			Case of 
				: ($flexbox.alignContent="stretch")
					
					// Last to do
					//fb_alignCont_Stretch
					
				: ($flexbox.alignContent="flex-end")
					
				: ($flexbox.alignContent="center")
					
				: ($flexbox.alignContent="space-between")
					
				: ($flexbox.alignContent="space-around")
					
				: ($flexbox.alignContent="space-evenly")
					
				Else 
					
					// default flex-start
					If ($flexbox.alignContent=Null:C1517)
						$flexbox.alignContent:="flex-start"
					End if 
					// Do nothing by default
					
			End case 
		End if 
		
	End if 
	
	$flexbox.itemsNewCoord:=$itemsNewCoord
	
	// display the items
	For each ($item;$itemsNewCoord)
		OBJECT SET COORDINATES:C1248(*;$item.id;$item.x;$item.y;$item.x+$item.width;$item.y+$item.height)
		If ($item.items#Null:C1517)
			If ($item.items.length>0)
				$item.Draw()
			End if 
		End if 
	End for each 
	
End if 