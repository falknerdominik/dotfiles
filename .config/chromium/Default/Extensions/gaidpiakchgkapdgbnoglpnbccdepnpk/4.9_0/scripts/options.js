function generateXML(jsonCombinations) {
	if (!jsonCombinations || jsonCombinations === '[]') { // if jsonCombinations is undefined or empty
		return '';
	}
	else {
		var combinations = JSON.parse(jsonCombinations);

		var root = '<?xml version="1.0" encoding="utf-8"?>';

		var metadata = '\t\t<timestamp>' + Date.today().toString("dd/MM/yyyy") + ' ' + new Date().toString("HH:mm:ss") + '</timestamp>\n' +
		'\t\t<setcount>' + combinations.length.toString() + '</setcount>\n';

		var elements = '';
		for (var i = 0; i < combinations.length; i++) {
			var setname = '\t\t\t\t<setname>' + combinations[i]["combinationName"] + '</setname>\n';
			var source = '\t\t\t\t<src>' + combinations[i]["source"] + '</src>\n';
			var medium = '\t\t\t\t<medium>' + combinations[i]["medium"] + '</medium>\n';
			var term = '\t\t\t\t<term>' + combinations[i]["term"] + '</term>\n';
			var content = '\t\t\t\t<content>' + combinations[i]["content"] + '</content>\n';
			var campaign = '\t\t\t\t<campaign>' + combinations[i]["campaign"] + '</campaign>\n';
			var isdefault = '\t\t\t\t<isdefault>' + combinations[i]["isDefault"] + '</isdefault>\n';
			var element = '\t\t\t<quickset>\n' + setname + source + medium + term + content + campaign + isdefault + '\t\t\t</quickset>\n';
			elements += element;
		}

		return root + '\n\t<backup>\n' + metadata + '\t\t<quicksets>\n' + elements + '\t\t</quicksets>' + '\n\t</backup>';
	}
}

$(function () {
	var grid, data;
	var columns = [
			{
				id: "defaultSetSelector", name: "Default", field: "isDefault", selectable: false, focusable: false, formatter: function (row, cell, value) {
					return value ? '<input class="defaultSelector" type="checkbox" checked="' + value + '"></input>' : '<input class="defaultSelector" type="checkbox"></input>';
				}, width: 60
			},
			{
				id: "combinationName", name: "", field: "combinationame", formatter: function () {
					return '<a href="#" class="removeRow"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a>';
				}, minWidth: 20, maxWidth: 20, width: 20
			},
			{ id: "combinationName", name: "Set Name*", field: "combinationName", minWidth: "130", editor: Slick.Editors.Text },
			{ id: "source", name: "Source*", field: "source", minWidth: "130", editor: Slick.Editors.Text },
			{ id: "medium", name: "Medium*", field: "medium", minWidth: "130", editor: Slick.Editors.Text },
			{ id: "term", name: "Term", field: "term", minWidth: "130", editor: Slick.Editors.Text },
			{ id: "content", name: "Content", field: "content", minWidth: "130", editor: Slick.Editors.Text },
			{ id: "campaign", name: "Campaign*", field: "campaign", minWidth: "130", editor: Slick.Editors.Text }
	];

	var options = {
		enableCellNavigation: true,
		enableColumnReorder: false,
		defaultColumnWidth: 130,
		autoHeight: true,
		editable: true,
		autoEdit: true,
		asyncEditorLoading: false
	};

	$('.removeRow').live('click', function () {
		var comboName = $(this).parent().next().text();
		for (var i = 0; i < data.length; i++) {
			if (comboName === data[i]["combinationName"]) {
				data.splice(i, 1);
				grid = new Slick.Grid("#myGrid", data, columns, options);
				grid.onCellChange.subscribe(function () {
					localStorage['combinations'] = JSON.stringify(data);
				});
				localStorage['combinations'] = JSON.stringify(data);
				break;
			}
		}
	});

	var backgroundPage = chrome.extension.getBackgroundPage();

	backgroundPage.checkToken(function (token) {
		if (!token) {
			$('#btnEnableGoogle').show();
		} else {
		    $('#btnEnabledGoogle').show();
		}
	});

	$('#btnEnableGoogle').click(function () {
		backgroundPage.grantAccess(function(token) {
			if (token) {
			    $('#btnEnableGoogle').hide();
			    $('#btnEnabledGoogle').show();
			}
		});
	});

	$('.defaultSelector').live('click', function () {
		var value = $(this).attr('checked');
		var rowIndex = $(this).closest('.slick-row').index();
		for (var i = 0; i < data.length; i++) {
			data[i]["isDefault"] = false;
			if (i === rowIndex) {
				data[i]["isDefault"] = value;
			}
		}
		grid = new Slick.Grid("#myGrid", data, columns, options);
		grid.onCellChange.subscribe(function () {
			localStorage['combinations'] = JSON.stringify(data);
		});
		localStorage['combinations'] = JSON.stringify(data);

	});

	if (localStorage['combinations']) {
		data = JSON.parse(localStorage['combinations']);
	} else {
		data = [];
	}
	grid = new Slick.Grid("#myGrid", data, columns, options);
	grid.onCellChange.subscribe(function () {
		localStorage['combinations'] = JSON.stringify(data);
	});
	if (localStorage['bitlyUser']) {
		$('#username').val(localStorage['bitlyUser']);
	}
	if (localStorage['bitlyApiKey']) {
		$('#apikey').val(localStorage['bitlyApiKey']);
	}
	if (localStorage['defaultShort']) {
	    $('input[name="defaultShort"][value="' + localStorage['defaultShort'] + '"]').prop('checked', true);
	} else if (localStorage['bitlyUser'] && localStorage['bitlyApiKey']) {
	    localStorage['defaultShort'] = "bitly";
	    $('input[name="defaultShort"][value="' + localStorage['defaultShort'] + '"]').prop('checked', true);
	}
	$('#username').keyup(function () {
		localStorage['bitlyUser'] = $(this).val();
	});
	$('#apikey').keyup(function () {
		localStorage['bitlyApiKey'] = $(this).val();
	});
    $('input[name="defaultShort"]').change(function() {
        localStorage['defaultShort'] = $('input[name="defaultShort"]:checked').val();
    });
	$('.addButton').click(function () {
		$('input').removeClass('error');
		if ($('#combinationName').val() === '') $('#combinationName').addClass('error');
		if ($('#source').val() === '') $('#source').addClass('error');
		if ($('#medium').val() === '') $('#medium').addClass('error');
		if ($('#campaign').val() === '') $('#campaign').addClass('error');
		if ($('input.error').length > 0) return;

		var d = {};
		d["combinationName"] = $('#combinationName').val();
		d["source"] = $('#source').val();
		d["medium"] = $('#medium').val();
		d["term"] = $('#term').val();
		d["content"] = $('#content').val();
		d["campaign"] = $('#campaign').val();
		d["isDefault"] = false;
		$('input.insert').val('');
		data.push(d);
		grid = new Slick.Grid("#myGrid", data, columns, options);
		grid.onCellChange.subscribe(function () {
			localStorage['combinations'] = JSON.stringify(data);
		});
		localStorage['combinations'] = JSON.stringify(data);
	}
	);

	$('#backupFile').click(function () {
		if (generateXML(localStorage['combinations']) === '') {
			alert("Quicksets are empty!");
			return;
		}
		$('#filename').val('GAUrlBuilder' + Date.today().toString('ddMMyy') + '.backup');
		$('#dialog').dialog({
			show: "fold",
			hide: "blind",
			resizable: false,
			modal: true,
			buttons: {
				'Save': function () {
					var bb = new BlobBuilder();
					bb.append(generateXML(localStorage['combinations']));
					var blob = bb.getBlob("text/xml");
					saveAs(blob, $('#filename').val() + '.txt');
					$(this).dialog('close');
				},
				'Cancel': function () {
					$(this).dialog('close');
				}
			}
		});
	});

	document.getElementById('fileElem').addEventListener('change', function() {
		var fileList = this.files;
		var file = fileList[0];

		// check for filetypes, because large files will freeze the page
		if (file.type !== 'text/xml' && file.type !== 'text/plain') {
			alert("Invalid backup file.");
			return;
		}

		$('#confirm').dialog({
			show: "clip",
			hide: "fold",
			width: 390,
			height: 165,
			resizable: false,
			modal: true,
			open: function () {
				$('.ui-dialog :button').blur();
			},
			buttons: {
				'Yes': function () {
					// process the file:
					var reader = new FileReader();
					reader.onload = (function () {
						return function (e) {
							var xml = e.target.result;
							var dataXml = [];
							$(xml).find("quickset").each(
							function () {
								var d = {};
								d["combinationName"] = $(this).find("setname").text();
								d["source"] = $(this).find("src").text(); // "src" not "source"
								d["medium"] = $(this).find("medium").text();
								d["term"] = $(this).find("term").text();
								d["content"] = $(this).find("content").text();
								d["campaign"] = $(this).find("campaign").text();
								if ($(this).find("isdefault").text() !== 'false') {
									d["isDefault"] = $(this).find("isdefault").text();
								} else {
									d["isDefault"] = false;
								}
								dataXml.push(d);
							});
							localStorage['combinations'] = JSON.stringify(dataXml);
							data = dataXml;

							grid = new Slick.Grid("#myGrid", dataXml, columns, options);
							grid.onCellChange.subscribe(function () {
								localStorage['combinations'] = JSON.stringify(dataXml);
							});
							document.getElementById("fileElem").value = ""; // clear file input: if user wants to load the same file twice, change event should be fired again                        
						};
					})(file);

					reader.readAsText(file); // asynchronous read
					$(this).dialog('close');
				},
				'No': function () {
					document.getElementById("fileElem").value = ""; // clear file input: if user wants to load the same file twice, change event should be fired again
					$(this).dialog('close');
				}
			}
		});
	}, false);

	var fileSelect = document.getElementById("fileSelect"), fileElem = document.getElementById("fileElem");
	fileSelect.addEventListener("click", function (e) { // delegate event to input fileElem, because it is hidden
		if (fileElem) {
			fileElem.click();
		}
		e.preventDefault(); // prevent navigation to "#"
	}, false);
});