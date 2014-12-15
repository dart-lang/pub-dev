/* Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file. */

$(function() {
  $("article").find("h2, h3, h4").each(function() {
    $(this).append($('<a class="permalink" title="Permalink" href="#' + $(this).attr('id') + '">#</a>'));
  });

  // Allow the anchor to specify which tab of a tabbed control is shown.
  if (window.location.hash !== "") {
    $('a[href="' + window.location.hash + '"][data-toggle="tab"]').tab('show');
  }

  var reload = $(".admin .reload");
  if (reload.length != 0) {
    var reloadInterval = setInterval(function() {
      $.ajax({
        url: "/packages/versions/reload.json",
        dataType: "json"
      }).done(function(data) {
        if (data['done']) {
          clearInterval(reloadInterval);
          reload.find(".progress .bar").css("width", "100%");
          reload.find(".progress").removeClass("active");
          reload.find("h3").text("All packages reloaded")
          return;
        }

        reload.find(".count").text(data["count"]);
        reload.find(".total").text(data["total"]);
        var percentage = (100 * data["count"]/data["total"]) + '%';
        reload.find(".progress .bar").css("width", percentage);
      });
    }, 1000);
  }
});
