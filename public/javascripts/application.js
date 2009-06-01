
// Override jQuery's Ajax data sending to include Rails-generated
// authenticity token
// Source: http://henrik.nyh.se/2008/05/rails-authenticity-token-with-jquery
$(document).ajaxSend(function(event, request, settings) {
  if (typeof(window.AUTH_TOKEN) == "undefined") return;
  // IE6 fix for http://dev.jquery.com/ticket/3155
  if (settings.type == 'GET' || settings.type == 'get') return;

  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(window.AUTH_TOKEN);
});
