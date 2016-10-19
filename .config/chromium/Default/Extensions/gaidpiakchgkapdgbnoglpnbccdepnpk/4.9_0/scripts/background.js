function shortenUrl(longUrl, callback) {
	chrome.identity.getAuthToken({ 'interactive': false }, function (token) {
		if (!token) {
			return;
		}
		var request = $.ajax({
			url: "https://www.googleapis.com/urlshortener/v1/url",
			type: 'POST',
			contentType: 'application/json',
			data: '{longUrl:"' + encodeURI(longUrl) + '"}',
			dataType: 'json',
			beforeSend: function(xhr) { xhr.setRequestHeader('Authorization', 'Bearer ' + token); }
		});
		request.done(function(data) {
			callback({ status: 'success', url: data.id });
		});
		request.fail(function () {
			chrome.identity.removeCachedAuthToken({ token: token }, function () { });
		});
	});
}

chrome.runtime.onInstalled.addListener(function (details) {
	if (details.reason === "install") {
		chrome.tabs.create({ url: "http://www.quickwin.io/extension/" });
	} 
});

function checkToken(callback) {
	chrome.identity.getAuthToken({ 'interactive': false }, function(token) {
		callback(token);
	});
}

function grantAccess(callback) {
	chrome.identity.getAuthToken({ 'interactive': true }, function (token) {
		callback(token);
	});
}

