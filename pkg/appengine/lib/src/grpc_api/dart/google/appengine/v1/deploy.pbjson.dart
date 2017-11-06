///
//  Generated code. Do not modify.
///
library google.appengine.v1_deploy_pbjson;

const Deployment$json = const {
  '1': 'Deployment',
  '2': const [
    const {'1': 'files', '3': 1, '4': 3, '5': 11, '6': '.google.appengine.v1.Deployment.FilesEntry'},
    const {'1': 'container', '3': 2, '4': 1, '5': 11, '6': '.google.appengine.v1.ContainerInfo'},
    const {'1': 'zip', '3': 3, '4': 1, '5': 11, '6': '.google.appengine.v1.ZipInfo'},
  ],
  '3': const [Deployment_FilesEntry$json],
};

const Deployment_FilesEntry$json = const {
  '1': 'FilesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.appengine.v1.FileInfo'},
  ],
  '7': const {},
};

const FileInfo$json = const {
  '1': 'FileInfo',
  '2': const [
    const {'1': 'source_url', '3': 1, '4': 1, '5': 9},
    const {'1': 'sha1_sum', '3': 2, '4': 1, '5': 9},
    const {'1': 'mime_type', '3': 3, '4': 1, '5': 9},
  ],
};

const ContainerInfo$json = const {
  '1': 'ContainerInfo',
  '2': const [
    const {'1': 'image', '3': 1, '4': 1, '5': 9},
  ],
};

const ZipInfo$json = const {
  '1': 'ZipInfo',
  '2': const [
    const {'1': 'source_url', '3': 3, '4': 1, '5': 9},
    const {'1': 'files_count', '3': 4, '4': 1, '5': 5},
  ],
};

