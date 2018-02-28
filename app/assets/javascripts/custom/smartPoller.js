// simple poll
/*
 * a smart poller for jquery.
 *    (by github)
 *
 * simple example:
 *
 *   $.smartPoller(function(retry) {
 *     $.getJSON(url, function(data) {
 *       if (data) {
 *         doSomething(data)
 *       } else {
 *         retry()
 *       }
 *     })
 *   })
 *
 * The $.smartPoller function accepts a starting
 * interval in ms but defaults to 1000:
 *
 *   $.smartPoller(2000, function(retry) {
 *
 */

;(function($) {
  $.smartPoller = function(wait, poller) {
    if ($.isFunction(wait)) {
      poller = wait
      wait = 1000
    }

    (function startPoller() {
      setTimeout(function() {
        poller.call(this, startPoller)
      }, wait)
      wait = wait * 1.5
    })()
  }
})(jQuery);

