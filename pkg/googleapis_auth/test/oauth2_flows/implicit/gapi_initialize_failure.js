// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

(function() {
  // This function looks up the URL this script was loaded in and finds the
  // name of the callback function to call when the library is read.
  // The URL of the script load looks like:
  //    http://localhost:8080/folder/file?onload=dartGapiLoaded
  function findDartOnLoadCallback() {
    var scripts = document.getElementsByTagName('script');
    var self = scripts[scripts.length - 1];

    var equalsSign = self.src.indexOf('=');
    if (equalsSign <= 0) throw 'error';

    var callbackName = self.src.substring(equalsSign + 1);
    if (callbackName.length <= 0) throw 'error';

    var dartFunction = window[callbackName];
    if (dartFunction == null) throw 'error';

    return dartFunction;
  }

  function GapiAuth() {}
  // We do not set the init/authorize functions, which should make the
  // the initialization fail.
  //    GapiAuth.prototype.init = ...;
  //    GapiAuth.prototype.authorize = ...;

  // Initialize the gapi.auth mock.
  window.gapi = new Object();
  window.gapi.auth = new GapiAuth();

  // Call the dart function. This signals that gapi.auth was loaded.
  var dartFunction = findDartOnLoadCallback();
  dartFunction();
})();