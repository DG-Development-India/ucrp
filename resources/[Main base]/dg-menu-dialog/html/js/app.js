(function () {

	let MenuTpl =
		'<div id="menu_{{_namespace}}_{{_name}}" class="dialog {{#isBig}}big{{/isBig}}">' +
			'{{#isDefault}}<input type="text" name="value" placeholder="{{title}}" id="inputText"/>{{/isDefault}}' +
				'{{#isBig}}<textarea name="value"/>{{/isBig}}' +
				'<button type="button" name="submit">Accept</button>' +
				'<button type="button" name="cancel">Cancel</button>'
			'</div>' +
		'</div>'
	;

	window.DGCore_MENU       = {};
	DGCore_MENU.ResourceName = 'dg-menu-dialog';
	DGCore_MENU.opened       = {};
	DGCore_MENU.focus        = [];
	DGCore_MENU.pos          = {};

	DGCore_MENU.open = function (namespace, name, data) {

		if (typeof DGCore_MENU.opened[namespace] == 'undefined') {
			DGCore_MENU.opened[namespace] = {};
		}

		if (typeof DGCore_MENU.opened[namespace][name] != 'undefined') {
			DGCore_MENU.close(namespace, name);
		}

		if (typeof DGCore_MENU.pos[namespace] == 'undefined') {
			DGCore_MENU.pos[namespace] = {};
		}

		if (typeof data.type == 'undefined') {
			data.type = 'default';
		}

		if (typeof data.align == 'undefined') {
			data.align = 'top-left';
		}

		data._index = DGCore_MENU.focus.length;
		data._namespace = namespace;
		data._name = name;

		DGCore_MENU.opened[namespace][name] = data;
		DGCore_MENU.pos[namespace][name] = 0;

		DGCore_MENU.focus.push({
			namespace: namespace,
			name: name
		});

		document.onkeyup = function (key) {
			if (key.which == 27) { // Escape key
				$.post('http://' + DGCore_MENU.ResourceName + '/menu_cancel', JSON.stringify(data));
			} else if (key.which == 13) { // Enter key
				$.post('http://' + DGCore_MENU.ResourceName + '/menu_submit', JSON.stringify(data));
			}
		};

		DGCore_MENU.render();

	};

	DGCore_MENU.close = function (namespace, name) {

		delete DGCore_MENU.opened[namespace][name];

		for (let i = 0; i < DGCore_MENU.focus.length; i++) {
			if (DGCore_MENU.focus[i].namespace == namespace && DGCore_MENU.focus[i].name == name) {
				DGCore_MENU.focus.splice(i, 1);
				break;
			}
		}

		DGCore_MENU.render();

	};

	DGCore_MENU.render = function () {

		let menuContainer = $('#menus')[0];

		$(menuContainer).find('button[name="submit"]').unbind('click');
		$(menuContainer).find('button[name="cancel"]').unbind('click');
		$(menuContainer).find('[name="value"]').unbind('input propertychange');

		menuContainer.innerHTML = '';

		$(menuContainer).hide();

		for (let namespace in DGCore_MENU.opened) {
			for (let name in DGCore_MENU.opened[namespace]) {

				let menuData = DGCore_MENU.opened[namespace][name];
				let view = JSON.parse(JSON.stringify(menuData));

				switch (menuData.type) {
					case 'default': {
						view.isDefault = true;
						break;
					}

					case 'big': {
						view.isBig = true;
						break;
					}

					default: break;
				}

				let menu = $(Mustache.render(MenuTpl, view))[0];

				$(menu).css('z-index', 1000 + view._index);

				$(menu).find('button[name="submit"]').click(function () {
					DGCore_MENU.submit(this.namespace, this.name, this.data);
				}.bind({ namespace: namespace, name: name, data: menuData }));

				$(menu).find('button[name="cancel"]').click(function () {
					DGCore_MENU.cancel(this.namespace, this.name, this.data);
				}.bind({ namespace: namespace, name: name, data: menuData }));

				$(menu).find('[name="value"]').bind('input propertychange', function () {
					this.data.value = $(menu).find('[name="value"]').val();
					DGCore_MENU.change(this.namespace, this.name, this.data);
				}.bind({ namespace: namespace, name: name, data: menuData }));

				if (typeof menuData.value != 'undefined')
					$(menu).find('[name="value"]').val(menuData.value);

				menuContainer.appendChild(menu);
			}
		}

		$(menuContainer).show();
		$("#inputText").focus();
	};

	DGCore_MENU.submit = function (namespace, name, data) {
		$.post('http://' + DGCore_MENU.ResourceName + '/menu_submit', JSON.stringify(data));
	};

	DGCore_MENU.cancel = function (namespace, name, data) {
		$.post('http://' + DGCore_MENU.ResourceName + '/menu_cancel', JSON.stringify(data));
	};

	DGCore_MENU.change = function (namespace, name, data) {
		$.post('http://' + DGCore_MENU.ResourceName + '/menu_change', JSON.stringify(data));
	};

	DGCore_MENU.getFocused = function () {
		return DGCore_MENU.focus[DGCore_MENU.focus.length - 1];
	};

	window.onData = (data) => {

		switch (data.action) {
			case 'openMenu': {
				DGCore_MENU.open(data.namespace, data.name, data.data);
				break;
			}

			case 'closeMenu': {
				DGCore_MENU.close(data.namespace, data.name);
				break;
			}
		}

	};

	window.onload = function (e) {
		window.addEventListener('message', (event) => {
			onData(event.data);
		});
	};

})();