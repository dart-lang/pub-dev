// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Fake partial bindings for the Google JS APIs.
/// https://developers.google.com/identity/sign-in/web/reference

window.gapi = {
  load: function (name, onReady) {
    console.log('gapi.load');
    onReady();
  },
  auth2: {
    init: function (params) {return googleAuth;},
    getAuthInstance: function () {return googleAuth;},
  },
};

function runPubInit() {
  // TODO: use DOMContentLoaded instead of timer
  setTimeout(function () {
    if ('pubAuthInit' in window) {
      pubAuthInit();
    } else {
      runPubInit();
    }
  }, 50);
}

// TODO: enable this after the header issue got resolved
// runPubInit();

var googleUser = {};
var changeListeners = [];
var nextUsers = [];

var googleAuth = {
  'isSignedIn': {
    'get': function () {
      return googleUser.isSignedIn || false;
    },
  },
  'currentUser': {
    'get': function () {
      return wrapGoogleUser(googleUser);
    },
    'listen': function (callback) {
      changeListeners.push(callback);
    },
  },
  'signIn': function (options) {
    if (nextUsers.length > 0) {
      googleUser = nextUsers.shift();
    } else {
      googleUser = {};
    }
    var u = wrapGoogleUser(googleUser);
    changeListeners.forEach(function (item, i) {item(u);});
    return Promise.resolve(u);
  },
  'signOut': function () {
    googleUser = {};
    var u = wrapGoogleUser(googleUser);
    changeListeners.forEach(function (item, i) {item(u);});
    return Promise.resolve(u);
  },
  'disconnect': function () {
    // TODO: implement function
    return Promise.resolve({});
  },
  'then': function (onValue) {
    setTimeout(function () {
      onValue(googleAuth);
    }, 0);
  },
};

// Expected data structure:
// {
//   isSignedIn: true,
//   id: 'user-id',
//   email: 'user@domain.com',
//   imageUrl: 'https://.../',
//   accessToken: 'token',
//   idToken: 'token',
//   scope: 'profile email',
//   expiresAt: 234235345346,
// }
function wrapGoogleUser(data) {
  data = data || {};
  return {
    'isSignedIn': function () {
      return data.isSignedIn || false;
    },
    'getId': function () {
      return data.id;
    },
    'getBasicProfile': function () {
      return {
        'getImageUrl': function () {
          return data.imageUrl;
        },
        'getEmail': function () {
          return data.email;
        },
      };
    },
    'getAuthResponse': function (includeAuthorizationData) {
      return {
        'access_token': data.accessToken,
        'id_token': data.idToken,
        'scope': data.scope,
        'expires_at': data.expiresAt,
      };
    },
    'reloadAuthResponse': function () {
      return Promise.resolve(data.authResponse);
    },
    'hasGrantedScopes': function (scopes) {
      // TODO: implement function
      return false;
    },
    'grant': function (options) {
      // TODO: implement function
      return Promise.reject();
    },
  };
}
