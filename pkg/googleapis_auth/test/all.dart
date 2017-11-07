import 'http_client_base_test.dart' as test1;
import 'crypto/rsa_test.dart' as test2;
import 'crypto/pem_test.dart' as test3;
import 'crypto/asn1_test.dart' as test4;
import 'crypto/rsa_sign_test.dart' as test5;
import 'oauth2_test.dart' as test6;
import 'oauth2_flows/implicit/gapi_initialize_successful_test.dart' as test7;
import 'oauth2_flows/implicit/gapi_auth_immediate_test.dart' as test8;
import 'oauth2_flows/implicit/gapi_initialize_failure_test.dart' as test9;
import 'oauth2_flows/implicit/gapi_auth_hybrid_immediate_test.dart' as test10;
import 'oauth2_flows/implicit/gapi_load_failure_test.dart' as test11;
import 'oauth2_flows/implicit/gapi_auth_hybrid_nonforce_test.dart' as test12;
import 'oauth2_flows/implicit/gapi_auth_user_denied_test.dart' as test13;
import 'oauth2_flows/implicit/gapi_auth_hybrid_force_test.dart' as test14;
import 'oauth2_flows/implicit/gapi_auth_nonforce_test.dart' as test15;
import 'oauth2_flows/jwt_test.dart' as test16;
import 'oauth2_flows/auth_code_test.dart' as test17;
import 'oauth2_flows/metadata_server_test.dart' as test18;

main() {
  test1.main();
  test2.main();
  test3.main();
  test4.main();
  test5.main();
  test6.main();
  test7.main();
  test8.main();
  test9.main();
  test10.main();
  test11.main();
  test12.main();
  test13.main();
  test14.main();
  test15.main();
  test16.main();
  test17.main();
  test18.main();
}
