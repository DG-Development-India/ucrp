(() => {

	DGCore = {};
	DGCore.HUDElements = [];

	DGCore.setHUDDisplay = function (opacity) {
		$('#hud').css('opacity', opacity);
	};

	DGCore.insertHUDElement = function (name, index, priority, html, data) {
		DGCore.HUDElements.push({
			name: name,
			index: index,
			priority: priority,
			html: html,
			data: data
		});

		DGCore.HUDElements.sort((a, b) => {
			return a.index - b.index || b.priority - a.priority;
		});
	};

	DGCore.updateHUDElement = function (name, data) {

		for (let i = 0; i < DGCore.HUDElements.length; i++) {
			if (DGCore.HUDElements[i].name == name) {
				DGCore.HUDElements[i].data = data;
			}
		}

		DGCore.refreshHUD();
	};

	DGCore.deleteHUDElement = function (name) {
		for (let i = 0; i < DGCore.HUDElements.length; i++) {
			if (DGCore.HUDElements[i].name == name) {
				DGCore.HUDElements.splice(i, 1);
			}
		}

		DGCore.refreshHUD();
	};

	DGCore.refreshHUD = function () {
		$('#hud').html('');

		for (let i = 0; i < DGCore.HUDElements.length; i++) {
			let html = Mustache.render(DGCore.HUDElements[i].html, DGCore.HUDElements[i].data);
			$('#hud').append(html);
		}
	};

	DGCore.inventoryNotification = function (add, item, count) {
		let notif = '';

		if (add) {
			notif += '+';
		} else {
			notif += '-';
		}

		notif += count + ' ' + item.label;

		let elem = $('<div>' + notif + '</div>');

		$('#inventory_notifications').append(elem);

		$(elem).delay(3000).fadeOut(1000, function () {
			elem.remove();
		});
	};

	window.onData = (data) => {
		switch (data.action) {
			case 'setHUDDisplay': {
				DGCore.setHUDDisplay(data.opacity);
				break;
			}

			case 'insertHUDElement': {
				DGCore.insertHUDElement(data.name, data.index, data.priority, data.html, data.data);
				break;
			}

			case 'updateHUDElement': {
				DGCore.updateHUDElement(data.name, data.data);
				break;
			}

			case 'deleteHUDElement': {
				DGCore.deleteHUDElement(data.name);
				break;
			}

			case 'inventoryNotification': {
				DGCore.inventoryNotification(data.add, data.item, data.count);
			}
		}
	};

	window.onload = function (e) {
		window.addEventListener('message', (event) => {
			onData(event.data);
		});
	};

})();