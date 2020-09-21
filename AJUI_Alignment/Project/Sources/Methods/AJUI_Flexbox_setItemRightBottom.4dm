//%attributes = {}
// AJUI_Flexbox_setItemRightBottom ( $item )
//
// $item : (object) item to set
// DEPREACTED -> GENERIC KILL EXECUTION SPEED

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): gabriel inzirillo
	// Date and time: 11.09.19, 16:23:41
	// ----------------------------------------------------
	// Method: AJUI_Flexbox_setItemRightBottom
	// Description
	// This method will set the item right and bottom values depending of the x,y and suggestWidth and suggestedHeight
	// This method should always be called at the end of a loop of the items when any of the values mentionned above are modified.
	// This is to be sure the coordinates are always correct after a calculation
	// ----------------------------------------------------
End if 

C_OBJECT:C1216($1;$item)

$item:=$1
$item.right:=$item.x+$item.suggestedWidth
$item.bottom:=$item.y+$item.suggestedHeight