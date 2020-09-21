//%attributes = {}
// flexbox_prepareItems ( $flexbox )
//
// param1 : (object) $flexbox object
//

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): gabriel inzirillo
	// Date and time: 11.09.19, 13:51:48
	// ----------------------------------------------------
	// Method: flexbox_prepareItems
	// Description
	// This method will prepare the items with the initial calculated values.
	// It must be run only once per definition. It must be relaunch if the items definition have changed.
	// It doesn't need to be relaunch if the definition of the flexbox behavior has changed
	//
	// ----------------------------------------------------
End if 

C_OBJECT:C1216($1;$flexbox;$item)
C_LONGINT:C283($bestWidth;$bestHeight)

$flexbox:=$1

If ($flexbox.itemsReady=Null:C1517)
	$flexbox.itemsReady:=False:C215  // Flag if the items definition has changed
End if 

If ($flexbox.itemsReady=False:C215)
	
	// Initialize global values
	$itemsMinimumWidth:=0  // Minimum width respecting the minWidth and/or bestWidth values of each items
	$itemsMinimumHeight:=0  // Minimum height respecting the minHeight and/or bestHeight values of each items
	$itemsMaximumWidth:=0  // Maximum width respecting the maxWidth and/or suggestedWidth values of each items
	$itemsMaximumHeight:=0  // Maximum height respecting the maxWidth and/or suggestedHeight values of each items
	$totalWidth:=0  // Total width. Calculated based on the defined width or the bestWidth if definition is missing
	$totalHeight:=0  // Total height. Calculated based on the defined height or the bestHeight if definition is missing
	$maxLineWidth:=0  // Maximum line width. By default we have only one line. If we wrap each line will have his own value
	$maxLineHeight:=0  // Maximum line Height. By default we have only one line. If we wrap each line will have his own value
	
	// Set default property if missing
	// default flex-start
	If ($flexbox.justifyContent=Null:C1517)
		$flexbox.justifyContent:="flex-start"
	End if 
	
	// Set the padding left/top/right/bottom for the container
	// Container padding :
	// ╔══════════════════════════════════╗
	// ║                top               ║
	// ║       ╔═══╦═════╦═══╦═════╗      ║
	// ║ right ║ 1 ║  2  ║ 3 ║  4  ║ left ║
	// ║       ╚═══╩═════╩═══╩═════╝      ║
	// ║              bottom              ║
	// ╚══════════════════════════════════╝
	If ($flexbox.padding=Null:C1517)
		$flexbox.padding:=0  // default padding value
	End if 
	// Left / Top / Right / Bottom manually defined
	If ($flexbox.paddingLeft=Null:C1517)
		$flexbox.paddingLeft:=$flexbox.padding
	End if 
	If ($flexbox.paddingTop=Null:C1517)
		$flexbox.paddingTop:=$flexbox.padding
	End if 
	If ($flexbox.paddingRight=Null:C1517)
		$flexbox.paddingRight:=$flexbox.padding
	End if 
	If ($flexbox.paddingBottom=Null:C1517)
		$flexbox.paddingBottom:=$flexbox.padding
	End if 
End if 

// store container coordinates before calculating items positioning
// Include the padding
OBJECT GET COORDINATES:C663(*;$flexbox.id;$left;$top;$right;$bottom)
$flexbox.coord:=New object:C1471
$flexbox.coord.x:=$left+$flexbox.paddingLeft
$flexbox.coord.y:=$top+$flexbox.paddingTop
$flexbox.coord.right:=$right-$flexbox.paddingRight
$flexbox.coord.bottom:=$bottom-$flexbox.paddingBottom
$flexbox.coord.width:=$flexbox.coord.right-$flexbox.coord.x
$flexbox.coord.height:=$flexbox.coord.bottom-$flexbox.coord.y

If ($flexbox.itemsReady=False:C215)
	If ($flexbox.items#Null:C1517)
		
		// Reorder the items
		$flexbox.items:=$flexbox.items.orderByMethod("AJUI_Flexbox_orderItems";$flexbox.items)
		
		// Goo trhough each item
		For each ($item;$flexbox.items)
			// By default each item is located at the top-left of the container
			// We will move each items at its correct location during the next steps where the location will depends on the definition
			$item.x:=$flexbox.coord.x
			$item.y:=$flexbox.coord.y
			
			// Item margin :
			// ╔══════════════════════════════════╗
			// ║                top               ║
			// ║       ╔═══════════════════╗      ║
			// ║ right ║         1         ║ left ║
			// ║       ╚═══════════════════╝      ║
			// ║              bottom              ║
			// ╚══════════════════════════════════╝
			If ($item.margin=Null:C1517)
				$item.margin:=0  // default margin value
			End if 
			// Left / Top / Right / Bottom manually defined
			If ($item.marginLeft=Null:C1517)
				$item.marginLeft:=$item.margin
			End if 
			If ($item.marginTop=Null:C1517)
				$item.marginTop:=$item.margin
			End if 
			If ($item.marginRight=Null:C1517)
				$item.marginRight:=$item.margin
			End if 
			If ($item.marginBottom=Null:C1517)
				$item.marginBottom:=$item.margin
			End if 
			
			// Get the best height and width
			OBJECT GET BEST SIZE:C717(*;$item.id;$bestWidth;$bestHeight)
			// If min width or min height are not defined, minWidth or minHeight become the bestWidth or bestHeight
			If ($item.minWidth=Null:C1517)
				$item.minWidth:=$bestWidth
			End if 
			If ($item.minHeight=Null:C1517)
				$item.minHeight:=$bestHeight
			End if 
			
			// Set the suggested width and height
			// The suggested width and height are the defined width and height or the minWidth minHeight if they are not defined
			If ($item.width=Null:C1517)
				$item.suggestedWidth:=$item.minWidth
			Else 
				$item.suggestedWidth:=$item.width
			End if 
			If ($item.height=Null:C1517)
				$item.suggestedHeight:=$item.minHeight
			Else 
				$item.suggestedHeight:=$item.height
			End if 
			
			// Check if suggested is smaller than min and set to min if true
			If ($item.suggestedWidth<$item.minWidth)
				$item.suggestedWidth:=$item.minWidth
			End if 
			If ($item.suggestedHeight<$item.minHeight)
				$item.suggestedHeight:=$item.minHeight
			End if 
			
			// Set the maxWidth and maxHeight to the suggested width and height if they are not defined
			If ($item.maxWidth=Null:C1517)
				$item.maxWidth:=$item.suggestedWidth
			End if 
			If ($item.maxHeight=Null:C1517)
				$item.maxHeight:=$item.suggestedHeight
			End if 
			
			If ($item.maxWidth<$item.minWidth)
				$item.maxWidth:=$item.minWidth
			End if 
			If ($item.maxHeight<$item.minHeight)
				$item.maxHeight:=$item.minHeight
			End if 
			
			// Check if suggested is bigger than max and set to max if true
			If ($item.suggestedWidth>$item.maxWidth)
				$item.suggestedWidth:=$item.maxWidth
			End if 
			If ($item.suggestedHeight>$item.maxHeight)
				$item.suggestedHeight:=$item.maxHeight
			End if 
			
			
			// Accumulate the minimum width and height
			$itemsMinimumWidth:=$itemsMinimumWidth+$item.minWidth+$item.marginLeft+$item.marginRight
			$itemsMinimumHeight:=$itemsMinimumHeight+$item.minHeight+$item.marginTop+$item.marginBottom
			
			// Accumulate the maximum width and height
			$itemsMaximumWidth:=$itemsMaximumWidth+$item.maxWidth+$item.marginLeft+$item.marginRight
			$itemsMaximumHeight:=$itemsMaximumHeight+$item.maxHeight+$item.marginTop+$item.marginBottom
			
			// Accumulate the total width and height
			$totalWidth:=$totalWidth+$item.suggestedWidth+$item.marginLeft+$item.marginRight
			$totalHeight:=$totalHeight+$item.suggestedHeight+$item.marginTop+$item.marginBottom
			
			// Calculate the max line height and width for the first line
			If ($item.suggestedWidth>$maxLineWidth)
				$maxLineWidth:=$item.suggestedWidth+$item.marginLeft+$item.marginRight
			End if 
			If ($item.suggestedHeight>$maxLineHeight)
				$maxLineHeight:=$item.suggestedHeight+$item.marginTop+$item.marginBottom
			End if 
			$item.line:=1
			
			$item.right:=$item.x+$item.suggestedWidth
			$item.bottom:=$item.y+$item.suggestedHeight
			
		End for each 
	End if 
	$flexbox.itemsMinimumWidth:=$itemsMinimumWidth
	$flexbox.itemsMinimumHeight:=$itemsMinimumHeight
	$flexbox.itemsMaximumWidth:=$itemsMaximumWidth
	$flexbox.itemsMaximumHeight:=$itemsMaximumHeight
	$flexbox.totalWidth:=$totalWidth
	$flexbox.totalHeight:=$totalHeight
	$flexbox.maxLineWidth["1"]:=$maxLineWidth
	$flexbox.maxLineHeight["1"]:=$maxLineHeight
	
	$flexbox.itemsReady:=True:C214
End if 


