$(function () {
	function clearSelection() {
		if (document.selection)
			document.selection.empty();
		else if (window.getSelection)
			window.getSelection().removeAllRanges();
	}

	function shorten(url, callback) {
		var apiKey = localStorage['bitlyApiKey'];
		var apiLogin = localStorage['bitlyUser'];
		var apiUrl = "api-ssl.bitly.com";

		// if the call to load the api_key  and api_url has not yet returned,
		// and the key/url are still null do not try to shorten
		if (!apiKey || !apiLogin) { return; }

		// here is where the call to the bitly api would go
		// with the callback method that was passed in used as the success handler
		$.getJSON("https://" + apiUrl + "/v3/shorten?longUrl=" + encodeURIComponent(url) + "&login=" + apiLogin + "&apiKey=" + apiKey + "&callback=?", callback);
	}

	var backgroundPage = chrome.extension.getBackgroundPage();

	var initializeCurrentUrl = function () {
		var deferred = new $.Deferred();
		//get active tab
		chrome.tabs.query({ active: true, currentWindow: true }, function (tabs) {
			//set first input to url of active tab
			$('#url').val(tabs[0].url);
			deferred.resolve();
		});
		return deferred.promise();
	};

	var main = function() {
		getAdLink();
		var currenturl = $('#url');
		var source = $('#utm_source');
		var medium = $('#utm_medium');
		var term = $('#utm_term');
		var content = $('#utm_content');
		var campaign = $('#utm_campaign');
		var result = $('#result');
		var bitResult = $('#bitResult');

		$('.optionsLink').click(function() {
			chrome.tabs.create({url: "options.html"});
		});

		$('.copyClipboard').click(function (e) {
		    e.preventDefault();
		    if ($(this).hasClass('bitlyGenerate')) {
		        if (localStorage['defaultShort'] === 'bitly' || (!localStorage['defaultShort'] && localStorage['bitlyUser'] && localStorage['bitlyApiKey'])) {
		            shorten(result.val(), setShortAndCopyToClip);
		        } else if (localStorage['defaultShort'] === 'google') {
		            backgroundPage.shortenUrl(result.val(), function (response) {
		                bitResult.val(response.url);
		                bitResult.focus();
		                bitResult[0].select();
		                document.execCommand('Copy');
		                clearSelection();
		            });
		        }
		    } else {
				result.focus();
				result[0].select();
				document.execCommand('Copy');
				clearSelection();
			}
		});

		var data = [];
		if (localStorage['combinations']) {
			data = JSON.parse(localStorage['combinations']);
		}

		var hasDefault = false;
		$.each(data, function(index, value) {
			//if is default add as selected option
			if (value["isDefault"]) {
				$('#savedCombinations').append('<option selected value="' + value["combinationName"] + '">' + value["combinationName"] + '</option>');
				//set hasDefault to true
				hasDefault = true;
			} else {
				$('#savedCombinations').append('<option value="' + value["combinationName"] + '">' + value["combinationName"] + '</option>');
			}
		});

		$('#savedCombinations').change(function () {
			if ($(this).val() !== '-1') {
				var selectedCombination;
				for (var i = 0; i < data.length; i++) {
					if ($(this).val() === data[i]["combinationName"]) {
						selectedCombination = data[i];
					}
				}
				if (selectedCombination !== null) {
					source.val(selectedCombination["source"]);
					medium.val(selectedCombination["medium"]);
					term.val(selectedCombination["term"]);
					content.val(selectedCombination["content"]);
					campaign.val(selectedCombination["campaign"]);
					createUrl();
				}
			}
			refreshIcons();
		});

		//check of hasdefault in case tabs.query handler has executed first
		if (hasDefault && currenturl.val()) {		
				$('#savedCombinations').change();
		}

		$('input:not(#result)').keyup(function () {
			if (source.val() && medium.val() && campaign.val()) {
				createUrl();
			} else {
				result.val('');
			}
			refreshIcons();
		});

		function setShortAndCopyToClip(bitlyResponse) {
			bitResult.val(bitlyResponse["data"]["url"]);
			bitResult.focus();
			bitResult[0].select();
			document.execCommand('Copy');
			clearSelection();
		}

		function createUrl() {
			if (currenturl.val() === "")
				return;
			var myurl = new URI(currenturl.val());
			if (source.val()) {
				myurl.addQuery("utm_source", source.val());
			}
			if (medium.val()) {
				myurl.addQuery("utm_medium", medium.val());
			}
			if (term.val()) {
				myurl.addQuery("utm_term", term.val());
			}
			if (content.val()) {
				myurl.addQuery("utm_content", content.val());
			}
			if (campaign.val() !== "") {
				myurl.addQuery("utm_campaign", campaign.val());
			}
			result.val(myurl.toString());
		}

		function refreshIcons() {
			if (currenturl.val()) {
				$('#section1').attr('src', 'images/checkmark.png');
			} else {
				$('#section1').attr('src', 'images/section1.png');
			}
			if (source.val() && medium.val() && campaign.val()) {
				$('#section2').attr('src', 'images/checkmark.png');
				$('#section3').attr('src', 'images/checkmark.png');
			} else {
				$('#section2').attr('src', 'images/section2.png');
				$('#section3').attr('src', 'images/section3.png');
			}
		}

		function getAdLink() {
			$.getJSON("https://dl.dropboxusercontent.com/s/v6mfyh2yox4tygw/link.json?dl=0", function (response) {
				var item = response.items[Math.floor(Math.random() * response.items.length)];
				$('#adBottomLink').attr('href', item.link_url);
				$('#adBottomLink').text(item.link_text);
			});
		}
	};

	initializeCurrentUrl().then(main);
});