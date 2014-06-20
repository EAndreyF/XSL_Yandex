$(function() {
	$('body').on('click', 'input[type=submit]', function() {
		var $this = $(this),
			$form = $this.parents('form'),
			$input = $form.find('input').not($this),
			$error = $form.find('.errors'),
			$ok = $form.find('.ok'),
			global_err = [],
			flag = location.search;

		$input.each(function() {
			var err = [],
				$el = $(arguments[1]),
				val = $el.val(),
				name = $el.attr('name'),
				min = $el.attr('mn') * 1,
				max = $el.attr('mx') * 1,
				regexp = $el.attr('regexp'),
				length = $el.attr('len') * 1,
				required = $el.attr('req'),
				error = $el.attr('error');

			min && val * 1 <= min && err.push('less than ' + min);
			max && val * 1 >= max && err.push('more than ' + max);
			regexp && !new RegExp(regexp).test(val) && err.push('incorrect value');
			length && val.toString().length !== length && err.push("length isn't " + length);
			required && !val && err.push('field is required');

			if (err.length) {
				if (error) {
					global_err.push('field ' + name + ' incorrect: ' + error);
				} else {
					global_err.push('field ' + name + ' incorrect: ' + err.join(', '));
				}
			}
		});

		console.log(global_err.join('; '));

		if (global_err.length && !flag) {
			$error.html(global_err.join(';<br /> ')).show();
			$ok.hide();
		} else {
			$error.html('').hide();
			$.ajax({
				url: $form.attr('action'),
				type: $form.attr('method'),
				data: $form.serialize(),
				dataType: 'JSON',
				success: function(data) {
					console.log(data);
					if (data.status === 'OK') {
						$ok.show();
					} else {
						$error.html(data.error_message).show();
					}
				}
			})
		}
		return false;
	});
});