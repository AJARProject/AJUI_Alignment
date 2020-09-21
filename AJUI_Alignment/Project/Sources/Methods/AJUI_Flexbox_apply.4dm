//%attributes = {"invisible":true,"shared":true}
ON ERR CALL:C155("error_handler")

C_OBJECT:C1216($1;$flexbox;$item)
C_COLLECTION:C1488($itemsNewCoord)

$flexbox:=$1

If ($flexbox.display="flex")
	If ($flexbox.items#Null:C1517)
		If ($flexbox.items.length>0)
			// We always start from the original coordinates of the items
			// This collection contain the items with the calculated properties based on the definition
			// This collection of items will be passed to different calculation method and will 
			$itemsNewCoord:=New collection:C1472()
			// Objects containing the max width and height for each lines
			$flexbox.maxLineHeight:=New object:C1471()
			$flexbox.maxLineWidth:=New object:C1471()
			
			// Initial preprocessing to prepare some calculated values that will be needed afterwards.
			AJUI_Flexbox_prepareItems($flexbox)
			
			// =========================================================
			// Direction
			If (False:C215)
				// ╔═══════════════════════════╗
				// ║ row ────>                 ║
				// ║                           ║
				// ╚═══════════════════════════╝
				// ╔═══════════════════════════╗
				// ║         <──── row-reverse ║
				// ║                           ║
				// ╚═══════════════════════════╝
				// ╔════════════╗
				// ║ c          ║
				// ║ o          ║
				// ║ l          ║
				// ║ u          ║
				// ║ m          ║
				// ║ n          ║
				// ║ │          ║
				// ║ │          ║
				// ║ ⌄          ║
				// ║            ║
				// ╚════════════╝
				// ╔════════════╗
				// ║            ║
				// ║ ⌃          ║
				// ║ │          ║
				// ║ │          ║
				// ║ c          ║
				// ║ o          ║
				// ║ l          ║
				// ║ u          ║
				// ║ m          ║
				// ║ n          ║
				// ║ |          ║
				// ║ r          ║
				// ║ e          ║
				// ║ v          ║
				// ║ e          ║
				// ║ r          ║
				// ║ s          ║
				// ║ e          ║
				// ╚════════════╝
				// =========================================================
			End if 
			// By default and if the direction is not defined
			// The row direction is applied
			If ($flexbox.direction=Null:C1517)
				$flexbox.direction:="row"
			End if 
			AJUI_Flexbox_direction($flexbox;$itemsNewCoord)
			// =========================================================
			
			
			// =========================================================
			// Wrap
			Case of 
				: ($flexbox.wrap="wrap")
					fb_wrap_wrap($flexbox;$itemsNewCoord)
				: ($flexbox.wrap="wrap-reverse")
					fb_wrap_wrap_reverse($flexbox;$itemsNewCoord)
				Else 
					// By default and if the wrap is not defined
					// The nowrap is applied
					If ($flexbox.wrap=Null:C1517)
						$flexbox.wrap:="nowrap"
					End if 
					fb_wrap_nowrap($flexbox;$itemsNewCoord)
			End case 
			// =========================================================
			
			
			
			// =========================================================
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
					
					// Do nothing by default it is already aligned to the left
					//fb_justCont_flexStart ($flexbox;$itemsNewCoord)
					
			End case 
			// =========================================================
			
			
			// display the items
			For each ($item;$itemsNewCoord)
				OBJECT SET COORDINATES:C1248(*;$item.id;$item.x;$item.y;$item.right;$item.bottom)
				If ($item.items#Null:C1517)
					If ($item.items.length>0)
						AJUI_Flexbox_apply($item)
					End if 
				End if 
			End for each 
		End if 
	End if 
End if 