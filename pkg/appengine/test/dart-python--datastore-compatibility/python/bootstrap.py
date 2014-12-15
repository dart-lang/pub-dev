#!/usr/bin/env python

import sys
import os

APPENGINE_DIR = os.path.realpath(
    os.path.join(os.environ['APPENGINE_DART_API_SERVER_EXE'],  '..'))
sys.path = [APPENGINE_DIR] + sys.path


def setup_pythonpath():
  import wrapper_util

  _PATHS = wrapper_util.Paths(APPENGINE_DIR)

  script_name = 'remote_api_shell.py'
  sys.path = (_PATHS.script_paths(script_name) +
              _PATHS.scrub_path(script_name, sys.path))
  if 'google' in sys.modules:
    del sys.modules['google']


def configure_remote_api(servername, appid):
  from google.appengine.ext.remote_api import remote_api_stub
  from google.appengine.tools import appengine_rpc

  def auth_func():
    raise Exception('Did not expect to get an authentication callback')

  remote_api_stub.ConfigureRemoteApi(
      appid, '/_ah/remote_api', auth_func, servername=servername,
      save_cookies=True, secure=False,
      rpc_server_factory=appengine_rpc.HttpRpcServer)


def main(argv):
  setup_pythonpath()

  servername =  '127.0.0.1:4444'
  appid = 'dev~test-application'
  configure_remote_api(servername, appid)

  if len(argv) != 2 or argv[1] not in ('read', 'write'):
    print 'usage: %s <read|write>' % argv[0]
    sys.exit(1)

  import main
  is_writing = argv[1] == 'write'
  main.runTests(is_writing)

if __name__ == '__main__':
  main(sys.argv)

