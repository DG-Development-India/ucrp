(function(){

	let MenuTpl =
		'<div id="menu_{{_namespace}}_{{_name}}" class="menu{{#align}} align-{{align}}{{/align}}">' +
			'<div class="head"><span>{{{title}}}</span></div>' +
				'<div class="menu-items">' + 
					'{{#elements}}' +
						'<div class="menu-item {{#selected}}selected{{/selected}}">' +
							'{{{label}}}{{#isSlider}} : &lt;{{{sliderLabel}}}&gt;{{/isSlider}}' +
						'</div>' +
					'{{/elements}}' +
				'</div>'+
			'</div>' +
		'</div>'
	;

	window.DGCore_MENU       = {};
	DGCore_MENU.ResourceName = 'DGCore_menu_default';
	DGCore_MENU.opened       = {};
	DGCore_MENU.focus        = [];
	DGCore_MENU.pos          = {};

	DGCore_MENU.open = function(namespace, name, data) {

		if (typeof DGCore_MENU.opened[namespace] == 'undefined') {
			DGCore_MENU.opened[namespace] = {};
		}

		if (typeof DGCore_MENU.opened[namespace][name] != 'undefined') {
			DGCore_MENU.close(namespace, name);
		}

		if (typeof DGCore_MENU.pos[namespace] == 'undefined') {
			DGCore_MENU.pos[namespace] = {};
		}

		for (let i=0; i<data.elements.length; i++) {
			if (typeof data.elements[i].type == 'undefined') {
				data.elements[i].type = 'default';
			}
		}

		data._index     = DGCore_MENU.focus.length;
		data._namespace = namespace;
		data._name      = name;

		for (let i=0; i<data.elements.length; i++) {
			data.elements[i]._namespace = namespace;
			data.elements[i]._name      = name;
		}

		DGCore_MENU.opened[namespace][name] = data;
		DGCore_MENU.pos   [namespace][name] = 0;

		for (let i=0; i<data.elements.length; i++) {
			if (data.elements[i].selected) {
				DGCore_MENU.pos[namespace][name] = i;
			} else {
				data.elements[i].selected = false;
			}
		}

		DGCore_MENU.focus.push({
			namespace: namespace,
			name     : name
		});
		
		DGCore_MENU.render();
		$('#menu_' + namespace + '_' + name).find('.menu-item.selected')[0].scrollIntoView();
	};

	DGCore_MENU.close = function(namespace, name) {
		
		delete DGCore_MENU.opened[namespace][name];

		for (let i=0; i<DGCore_MENU.focus.length; i++) {
			if (DGCore_MENU.focus[i].namespace == namespace && DGCore_MENU.focus[i].name == name) {
				DGCore_MENU.focus.splice(i, 1);
				break;
			}
		}

		DGCore_MENU.render();

	};

	DGCore_MENU.render = function() {

		let menuContainer       = document.getElementById('menus');
		let focused             = DGCore_MENU.getFocused();
		menuContainer.innerHTML = '';

		$(menuContainer).hide();

		for (let namespace in DGCore_MENU.opened) {
			for (let name in DGCore_MENU.opened[namespace]) {

				let menuData = DGCore_MENU.opened[namespace][name];
				let view     = JSON.parse(JSON.stringify(menuData));

				for (let i=0; i<menuData.elements.length; i++) {
					let element = view.elements[i];

					switch (element.type) {
						case 'default' : break;

						case 'slider' : {
							element.isSlider    = true;
							element.sliderLabel = (typeof element.options == 'undefined') ? element.value : element.options[element.value];

							break;
						}

						default : break;
					}

					if (i == DGCore_MENU.pos[namespace][name]) {
						element.selected = true;
					}
				}

				let menu = $(Mustache.render(MenuTpl, view))[0];
				$(menu).hide();
				menuContainer.appendChild(menu);
			}
		}

		if (typeof focused != 'undefined') {
			$('#menu_' + focused.namespace + '_' + focused.name).show();
		}

		$(menuContainer).show();

	};

	DGCore_MENU.submit = function(namespace, name, data) {
		$.post('http://' + DGCore_MENU.ResourceName + '/menu_submit', JSON.stringify({
			_namespace: namespace,
			_name     : name,
			current   : data,
			elements  : DGCore_MENU.opened[namespace][name].elements
		}));
	};

	DGCore_MENU.cancel = function(namespace, name) {
		$.post('http://' + DGCore_MENU.ResourceName + '/menu_cancel', JSON.stringify({
			_namespace: namespace,
			_name     : name
		}));
	};

	DGCore_MENU.change = function(namespace, name, data) {
		$.post('http://' + DGCore_MENU.ResourceName + '/menu_change', JSON.stringify({
			_namespace: namespace,
			_name     : name,
			current   : data,
			elements  : DGCore_MENU.opened[namespace][name].elements
		}));
	};

	DGCore_MENU.getFocused = function() {
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

			case 'controlPressed': {

				switch (data.control) {

					case 'ENTER': {
						let focused = DGCore_MENU.getFocused();

						if (typeof focused != 'undefined') {
							let menu    = DGCore_MENU.opened[focused.namespace][focused.name];
							let pos     = DGCore_MENU.pos[focused.namespace][focused.name];
							let elem    = menu.elements[pos];

							if (menu.elements.length > 0) {
								DGCore_MENU.submit(focused.namespace, focused.name, elem);
							}
						}

						break;
					}

					case 'BACKSPACE': {
						let focused = DGCore_MENU.getFocused();

						if (typeof focused != 'undefined') {
							DGCore_MENU.cancel(focused.namespace, focused.name);
						}

						break;
					}

					case 'TOP': {

						let focused = DGCore_MENU.getFocused();

						if (typeof focused != 'undefined') {

							let menu = DGCore_MENU.opened[focused.namespace][focused.name];
							let pos  = DGCore_MENU.pos[focused.namespace][focused.name];

							if (pos > 0) {
								DGCore_MENU.pos[focused.namespace][focused.name]--;
							} else {
								DGCore_MENU.pos[focused.namespace][focused.name] = menu.elements.length - 1;
							}

							let elem = menu.elements[DGCore_MENU.pos[focused.namespace][focused.name]];

							for (let i=0; i<menu.elements.length; i++) {
								if (i == DGCore_MENU.pos[focused.namespace][focused.name]) {
									menu.elements[i].selected = true;
								} else {
									menu.elements[i].selected = false;
								}
							}

							DGCore_MENU.change(focused.namespace, focused.name, elem);
							DGCore_MENU.render();

							$('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
						}

						break;

					}

					case 'DOWN' : {

						let focused = DGCore_MENU.getFocused();

						if (typeof focused != 'undefined') {
							let menu   = DGCore_MENU.opened[focused.namespace][focused.name];
							let pos    = DGCore_MENU.pos[focused.namespace][focused.name];
							let length = menu.elements.length;

							if (pos < length - 1) {
								DGCore_MENU.pos[focused.namespace][focused.name]++;
							} else {
								DGCore_MENU.pos[focused.namespace][focused.name] = 0;
							}

							let elem = menu.elements[DGCore_MENU.pos[focused.namespace][focused.name]];

							for (let i=0; i<menu.elements.length; i++) {
								if (i == DGCore_MENU.pos[focused.namespace][focused.name]) {
									menu.elements[i].selected = true;
								} else {
									menu.elements[i].selected = false;
								}
							}

							DGCore_MENU.change(focused.namespace, focused.name, elem);
							DGCore_MENU.render();

							$('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
						}

						break;
					}

					case 'LEFT' : {

						let focused = DGCore_MENU.getFocused();

						if (typeof focused != 'undefined') {
							let menu = DGCore_MENU.opened[focused.namespace][focused.name];
							let pos  = DGCore_MENU.pos[focused.namespace][focused.name];
							let elem = menu.elements[pos];

							switch(elem.type) {
								case 'default': break;

								case 'slider': {
									let min = (typeof elem.min == 'undefined') ? 0 : elem.min;

									if (elem.value > min) {
										elem.value--;
										DGCore_MENU.change(focused.namespace, focused.name, elem);
									}

									DGCore_MENU.render();
									break;
								}

								default: break;
							}

							$('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
						}

						break;
					}

					case 'RIGHT' : {

						let focused = DGCore_MENU.getFocused();

						if (typeof focused != 'undefined') {
							let menu = DGCore_MENU.opened[focused.namespace][focused.name];
							let pos  = DGCore_MENU.pos[focused.namespace][focused.name];
							let elem = menu.elements[pos];

							switch(elem.type) {
								case 'default': break;

								case 'slider': {
									if (typeof elem.options != 'undefined' && elem.value < elem.options.length - 1) {
										elem.value++;
										DGCore_MENU.change(focused.namespace, focused.name, elem);
									}

									if (typeof elem.max != 'undefined' && elem.value < elem.max) {
										elem.value++;
										DGCore_MENU.change(focused.namespace, focused.name, elem);
									}

									DGCore_MENU.render();
									break;
								}

								default: break;
							}

							$('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
						}

						break;
					}

					default : break;

				}

				break;
			}

		}

	};

	window.onload = function(e){
		window.addEventListener('message', (event) => {
			onData(event.data);
		});
	};

})();