$evt:=Form event code:C388

Case of 
	: ($evt=On Load:K2:1)
		Form:C1466.flexbox:=New object:C1471()
		Form:C1466.flexbox.display:="flex"
		Form:C1466.flexbox.id:="Rectangle"
		Form:C1466.flexbox.items:=New collection:C1472()
		Form:C1466.flexbox.items.push(New object:C1471("id";"item1"))
		Form:C1466.flexbox.items.push(New object:C1471("id";"item2"))
		Form:C1466.flexbox.items.push(New object:C1471("id";"btn1"))
		Form:C1466.flexbox.items.push(New object:C1471("id";"btn2"))
		Form:C1466.flexbox.items.push(New object:C1471("id";"lb1";"width";200;"height";200))
		AJUI_Flexbox_apply(Form:C1466.flexbox)
	: ($evt=On Resize:K2:27)
		AJUI_Flexbox_apply(Form:C1466.flexbox)
End case 
