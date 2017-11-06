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
  GapiAuth.prototype.init = function(doneCallback) {
    doneCallback();
  };
  GapiAuth.prototype.authorize = function(json, doneCallback) {
    /*
      Input:
        argument1 = {
            'client_id'
            'immediate'
            'approval_prompt'
            'response_type'
            'scope'
            'access_type'
        };
        argument2 = dartCallback(json);

      Output:
        output_1 = {
          'token_type',
          'access_token',
          'expires_in',
          'code',
          'state',
          'error',
        };
    */

    var client_id = json['client_id'];
    var immediate = json['immediate'];
    var approval_prompt = json['approval_prompt'];
    var response_type = json['response_type'];
    var scope = json['scope'];
    var access_type = json['access_type'];

    if (client_id == 'foo_client' &&
        immediate == false &&
        approval_prompt == 'force' &&
        response_type == 'code token' &&
        scope == 'scope1 scope2' &&
        access_type == 'offline') {
      doneCallback({
        'token_type' : 'Bearer',
        'access_token' : 'foo_token',
        'expires_in' : '3210',
        'code' : 'mycode'
      });
    } else {
      throw 'error';
    }
  };

  // Initialize the gapi.auth mock.
  window.gapi = new Object();
  window.gapi.auth = new GapiAuth();

  // Call the dart function. This signals that gapi.auth was loaded.
  var dartFunction = findDartOnLoadCallback();
  dartFunction();
})();
