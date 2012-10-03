function fnFormatDetails(oTable, nTr) {
	var bookID = oTable.fnGetData(nTr)[1];
	var out = '<table cellpadding="5" cellspacing="0" border="0" style="background-color:#ffffff;">';
	out += '<tr><td><img src="' + json[bookID]['cover'] + '" width="100" align="left"/>' + json[bookID]['description'] + '</td></tr>';
	out += '</table>';
	return out;
}


$(document).ready(function() {
	var nCloneTh = document.createElement('th');
	var nCloneTd = document.createElement('td');
	nCloneTd.innerHTML = '<a href="#" class="details_button">+</a>';
	nCloneTd.className = "center";
	
	$('#books thead tr').each(function() {
		this.insertBefore(nCloneTh, this.childNodes[0]);
	});

	$('#books tbody tr').each(function() {
		this.insertBefore(nCloneTd.cloneNode(true), this.childNodes[0]);
	});
	
	var oTable = $('#books').dataTable({
		"aoColumnDefs" : [
			{"bSortable" : false, "aTargets" : [0]}
		],
		"bJQueryUI": true,
		"sPaginationType" : "full_numbers"
	});
	
	
	$('#books tbody td .details_button').live('click', function() {
		var nTr = this.parentNode.parentNode;
		if(this.text.match('-')) {
			this.text = "+";
			oTable.fnClose(nTr);
		} else {
			this.text = "-";
			oTable.fnOpen(nTr, fnFormatDetails(oTable, nTr), 'details');
		}
	});

});