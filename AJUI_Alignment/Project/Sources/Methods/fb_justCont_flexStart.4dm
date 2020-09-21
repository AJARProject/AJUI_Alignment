//%attributes = {}
// DEPRECATED : Not needed by default it is flex-start

//  // justify-content : flex-start

//C_OBJECT($flexbox;$1)
//C_COLLECTION($itemsNewCoord;$2)
//C_OBJECT($mainCoord;$coord)

//$flexbox:=$1
//$itemsNewCoord:=$2

//$mainCoord:=$flexbox.coord


//If ($itemsNewCoord#Null)
//If ($itemsNewCoord.length>0)

//For each ($coord;$itemsNewCoord;1)

//Case of 
//: ($flexbox.direction="row-reverse")  // Direction = Row Reverse
//: ($flexbox.direction="column")  // Direction = Column
//: ($flexbox.direction="column-reverse")  // Direction = Column Reverse
//Else   // Default Direction = Row
//End case 

//End for each 

//End if 
//End if 