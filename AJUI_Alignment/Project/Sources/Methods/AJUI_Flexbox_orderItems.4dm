//%attributes = {}
// Order method to order the items according to their defined order
// or their position in the definition if the order is missing

C_OBJECT:C1216($1)
C_COLLECTION:C1488($2;$indices)

If ($1.value.order=Null:C1517)
	$indices:=$2.indices("id = :1";$1.value.id)
	If ($indices.length>0)
		$order1:=($indices[0]+1)*10
	Else 
		$order1:=0
	End if 
Else 
	$order1:=($1.value.order*10)-1
End if 

If ($1.value2.order=Null:C1517)
	$indices:=$2.indices("id = :1";$1.value2.id)
	If ($indices.length>0)
		$order2:=($indices[0]+1)*10
	Else 
		$order2:=0
	End if 
Else 
	$order2:=($1.value2.order*10)-1
End if 


$1.result:=$order1<$order2