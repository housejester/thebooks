function submitFormOnEnter(field, e){
    var keycode;
    var ctrlPressed;
    var shiftPressed;
    if (window.event){
        keycode = window.event.keyCode;
        ctrlPressed = window.event.ctrlKey;
        shiftPressed = window.event.shiftKey;
    }else if (e){
        keycode = e.which;
        ctrlPressed = e.ctrlKey;
        shiftPressed = e.shiftKey;
    }else {
        return true;
    }

    if (keycode == 13){
        if(ctrlPressed){
            field.form.elements['reconciled'].value = 'true';
        }
        if(shiftPressed){
            field.form.elements['paid'].value = 'true';
        }

        field.form.submit();
        return false;
    } else {
        return true;
    }
}
function updateTxOnEnter(field, e){
    var keycode;
    var ctrlPressed;
    var shiftPressed;
    if (window.event){
        keycode = window.event.keyCode;
        ctrlPressed = window.event.ctrlKey;
        shiftPressed = window.event.shiftKey;
    }else if (e){
        keycode = e.which;
        ctrlPressed = e.ctrlKey;
        shiftPressed = e.shiftKey;
    }else {
        return true;
    }
    if (keycode == 13){
        var tr = upTo(field, 'tr');
        var inputs = tr.getElementsByTagName('input');
        var form = document.getElementById("updateTransaction");
        for(var i = 0; i<inputs.length; i++){
            var fakeInput = inputs[i];
            var input = form.elements[fakeInput.name];
            if(input){
                if(fakeInput.value.trim() != ''){
                    input.value = fakeInput.value;
                }
            }else{
                form.reset();
                return;
            }
        }
        form.submit();
    }
}
function upTo(el, tag){
    tag = tag.toUpperCase();
    var parent = el.parentNode;
    while(parent != document.body){
        if(parent.tagName == tag){
            return parent;
        }
        parent = parent.parentNode;
    }
    return null;
}
function onDateClicked(tr, e, id, version){
    if(e.shiftKey){
        var dateCell = tr.cells[0];
        var dateVal = dateCell.innerHTML.trim();
        dateCell.innerHTML = "<input name='id' value='"+id+"' type='hidden'/>" +
                             "<input name='version' value='"+version+"' type='hidden'/>" +
                             "<input name='clearDate' value='"+dateVal+"' onkeypress='return updateTxOnEnter(this, event);'/>";

        var topDiv = tr.cells[1].getElementsByTagName("DIV")[0];
        var descCell = topDiv.getElementsByTagName("A")[0];
        var desc = descCell.innerHTML;
        topDiv.innerHTML = "<input name='description' value='"+desc+"' onkeypress='return updateTxOnEnter(this, event);'/>";

        var bottomDiv = tr.cells[1].getElementsByTagName("DIV")[1];
        var cat = '';
        if(bottomDiv.getElementsByTagName("A").length > 0){
            cat = bottomDiv.getElementsByTagName("A")[0].innerHTML;
        }
        bottomDiv.innerHTML = "<input name='category' value='"+cat+"' onkeypress='return updateTxOnEnter(this, event);'/>";

        var commerceCell = tr.cells[2];
        commerceCell.innerHTML = "<input name='commerceAmount' value='"+commerceCell.innerHTML.trim()+"' onkeypress='return updateTxOnEnter(this, event);'/>";

        var usbankCell = tr.cells[4];
        usbankCell.innerHTML = "<input name='usbankAmount' value='"+usbankCell.innerHTML.trim()+"' onkeypress='return updateTxOnEnter(this, event);'/>";
        
        dateCell.getElementsByTagName('INPUT')[0].focus();
    }else if(e.altKey){
        var dateCell = tr.cells[0];
        var dateVal = dateCell.innerHTML.trim();
        
	var topDiv = tr.cells[1].getElementsByTagName("DIV")[0];
        var descCell = topDiv.getElementsByTagName("A")[0];
        var desc = descCell.innerHTML;

        var bottomDiv = tr.cells[1].getElementsByTagName("DIV")[1];
        var cat = '';
        if(bottomDiv.getElementsByTagName("A").length > 0){
            cat = bottomDiv.getElementsByTagName("A")[0].innerHTML;
        }

        var commerceCell = tr.cells[2];
	var commerceAmt = commerceCell.innerHTML.trim();
	if(commerceAmt == '&nbsp;'){
		commerceAmt = '';
	}

        var usbankCell = tr.cells[4];
	var usbankAmt = usbankCell.innerHTML.trim();
	if(usbankAmt == '&nbsp;'){
		usbankAmt = '';
	}
	
	new Ajax.Request('/thebooks/user/addTransaction', {
		method : 'post',
		onSuccess : function(){
			alert('success');
		},
		onFailure : function(){
			alert("failed.");
		},
		parameters : {
			copyToNextMonth : true,
			category : cat,
			clearDate : dateVal,
			commerceAmount : commerceAmt,
			description : desc,
			paid : false,
			reconciled : false,
			usbankAmount : usbankAmt
		}
	});
    }
}
function reconcile(tr, id, reconciled){
    if(typeof tr.reconciled != 'undefined'){
        reconciled = tr.reconciled;
    }
    if(reconciled){
        tr.className = tr.className.replace("reconciled", "pending");
    }else{
        tr.className = tr.className.replace("pending", "reconciled");
    }
    tr.reconciled = !reconciled;

    var form = document.getElementById('reconcileForm');
    form.txId.value = id;
    form.reconciled.value = tr.reconciled;
    form.onsubmit();
}
function markPaid(tr, id, paid){
    if(typeof tr.paid != 'undefined'){
        paid = tr.paid;
    }
    if(paid){
        tr.className = tr.className.replace("paid", "unpaid");
    }else{
        tr.className = tr.className.replace("unpaid", "paid");
    }
    tr.paid = !paid;

    var form = document.getElementById('paidForm');
    form.txId.value = id;
    form.paid.value = tr.paid;
    form.onsubmit();
}
