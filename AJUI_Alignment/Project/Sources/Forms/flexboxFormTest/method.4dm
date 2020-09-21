$evt:=Form event code:C388

Case of 
	: ($evt=On Load:K2:1)
		counter:=0
		ms:=0
		
		Form:C1466.flexbox_def:=JSON Parse:C1218(Document to text:C1236(Get 4D folder:C485(Current resources folder:K5:16;*)+"test1.json";"UTF-8"))
		
		OBJECT Get pointer:C1124(Object named:K67:5;"item_1")->:="1"
		OBJECT Get pointer:C1124(Object named:K67:5;"item_2")->:="2 dsa dadas as dsas"
		OBJECT Get pointer:C1124(Object named:K67:5;"item_3")->:="3"
		OBJECT Get pointer:C1124(Object named:K67:5;"item_4")->:="4"
		OBJECT Get pointer:C1124(Object named:K67:5;"item_5")->:="aaaaad a dsadaaa dsa"
		OBJECT Get pointer:C1124(Object named:K67:5;"item_6")->:="aaaaaaaaa"
		OBJECT Get pointer:C1124(Object named:K67:5;"item_7")->:="aaaaaaaa"
		OBJECT Get pointer:C1124(Object named:K67:5;"item_8")->:="aaaaaaaa"
		OBJECT Get pointer:C1124(Object named:K67:5;"item_9")->:="aaaaaa"
		OBJECT Get pointer:C1124(Object named:K67:5;"item_10")->:="10"
		OBJECT Get pointer:C1124(Object named:K67:5;"item_11")->:="11"
		OBJECT Get pointer:C1124(Object named:K67:5;"item_12")->:="12"
		OBJECT Get pointer:C1124(Object named:K67:5;"item_13")->:="13"
		
	: ($evt=On Resize:K2:27)
		If (Form:C1466.flexbox_def#Null:C1517)
			$start_ms:=Milliseconds:C459
			AJUI_Flexbox_apply(Form:C1466.flexbox_def)
			$end_ms:=Milliseconds:C459
			ms:=ms+($end_ms-$start_ms)
			counter:=counter+1
		End if 
		zz_testUpdateGUI_Info
End case 
