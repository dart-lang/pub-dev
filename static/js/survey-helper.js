// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This script is embedded from GTM when activating surveys. Identifiers for the
// survey is embedded in data attributes on the <script> tag.
(function() {
  var data = document.currentScript.dataset;
  // This uses internal survey API, which has to be included before this snippet
  // is embedded through GTM.
  var helpApi = window.help.service.Lazy.create(0, {
    apiKey: data.apiKey,
    locale: data.locale
  });
  helpApi.requestSurvey({
    triggerId: data.triggerId,
    enableTestingMode: data.testingMode === 'true',
    callback: function(rscp) {
      if (rscp.surveyData) {
        helpApi.presentSurvey({
          surveyData: rscp.surveyData,
          colorScheme: 1,
          customZIndex: 10000
        });      
      }
    }
  });
})();
