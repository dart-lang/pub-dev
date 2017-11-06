///
//  Generated code. Do not modify.
///
library google.cloud.ml.v1beta1_prediction_service_pbjson;

import '../../../api/httpbody.pbjson.dart' as google$api;

const PredictRequest$json = const {
  '1': 'PredictRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'http_body', '3': 2, '4': 1, '5': 11, '6': '.google.api.HttpBody'},
  ],
};

const OnlinePredictionService$json = const {
  '1': 'OnlinePredictionService',
  '2': const [
    const {'1': 'Predict', '2': '.google.cloud.ml.v1beta1.PredictRequest', '3': '.google.api.HttpBody', '4': const {}},
  ],
};

const OnlinePredictionService$messageJson = const {
  '.google.cloud.ml.v1beta1.PredictRequest': PredictRequest$json,
  '.google.api.HttpBody': google$api.HttpBody$json,
};

