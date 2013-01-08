jQuery(function($) {
	$('input:first').keyboard({
		layout : 'custom',
		customLayout : {
			'default' : [
				'{bksp}',
				'{accept}',
				'\u0430',
				'\u0431',
				'\u0432',
				'\u0433',
				'\u0434',
				'\u0435',
				'\u0436',
				'\u0437',
				'\u0438',
				'\u0439',
				'\u043A',
				'\u043B',
				'\u043C',
				'\u043D',
				'\u043E',
				'\u043F',
				'\u0440',
				'\u0441',
				'\u0442',
				'\u0443',
				'\u0444',
				'\u0445',
				'\u0446',
				'\u0447',
				'\u0448',
				'\u0449',
				'\u044C',
				'\u044A',
				'\u044E',
				'\u044F']
		},
		position: {
			of : $(window),
			my : 'center center',
			at : 'center center'
		},
		accepted: function (e, keyboard, el) { $('input:first').keyup(); }
	});
});