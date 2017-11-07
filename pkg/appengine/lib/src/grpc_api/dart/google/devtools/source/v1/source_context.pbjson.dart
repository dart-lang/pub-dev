///
//  Generated code. Do not modify.
///
library google.devtools.source.v1_source_context_pbjson;

const SourceContext$json = const {
  '1': 'SourceContext',
  '2': const [
    const {'1': 'cloud_repo', '3': 1, '4': 1, '5': 11, '6': '.google.devtools.source.v1.CloudRepoSourceContext'},
    const {'1': 'cloud_workspace', '3': 2, '4': 1, '5': 11, '6': '.google.devtools.source.v1.CloudWorkspaceSourceContext'},
    const {'1': 'gerrit', '3': 3, '4': 1, '5': 11, '6': '.google.devtools.source.v1.GerritSourceContext'},
    const {'1': 'git', '3': 6, '4': 1, '5': 11, '6': '.google.devtools.source.v1.GitSourceContext'},
  ],
};

const ExtendedSourceContext$json = const {
  '1': 'ExtendedSourceContext',
  '2': const [
    const {'1': 'context', '3': 1, '4': 1, '5': 11, '6': '.google.devtools.source.v1.SourceContext'},
    const {'1': 'labels', '3': 2, '4': 3, '5': 11, '6': '.google.devtools.source.v1.ExtendedSourceContext.LabelsEntry'},
  ],
  '3': const [ExtendedSourceContext_LabelsEntry$json],
};

const ExtendedSourceContext_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const AliasContext$json = const {
  '1': 'AliasContext',
  '2': const [
    const {'1': 'kind', '3': 1, '4': 1, '5': 14, '6': '.google.devtools.source.v1.AliasContext.Kind'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9},
  ],
  '4': const [AliasContext_Kind$json],
};

const AliasContext_Kind$json = const {
  '1': 'Kind',
  '2': const [
    const {'1': 'ANY', '2': 0},
    const {'1': 'FIXED', '2': 1},
    const {'1': 'MOVABLE', '2': 2},
    const {'1': 'OTHER', '2': 4},
  ],
};

const CloudRepoSourceContext$json = const {
  '1': 'CloudRepoSourceContext',
  '2': const [
    const {'1': 'repo_id', '3': 1, '4': 1, '5': 11, '6': '.google.devtools.source.v1.RepoId'},
    const {'1': 'revision_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'alias_name', '3': 3, '4': 1, '5': 9},
    const {'1': 'alias_context', '3': 4, '4': 1, '5': 11, '6': '.google.devtools.source.v1.AliasContext'},
  ],
};

const CloudWorkspaceSourceContext$json = const {
  '1': 'CloudWorkspaceSourceContext',
  '2': const [
    const {'1': 'workspace_id', '3': 1, '4': 1, '5': 11, '6': '.google.devtools.source.v1.CloudWorkspaceId'},
    const {'1': 'snapshot_id', '3': 2, '4': 1, '5': 9},
  ],
};

const GerritSourceContext$json = const {
  '1': 'GerritSourceContext',
  '2': const [
    const {'1': 'host_uri', '3': 1, '4': 1, '5': 9},
    const {'1': 'gerrit_project', '3': 2, '4': 1, '5': 9},
    const {'1': 'revision_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'alias_name', '3': 4, '4': 1, '5': 9},
    const {'1': 'alias_context', '3': 5, '4': 1, '5': 11, '6': '.google.devtools.source.v1.AliasContext'},
  ],
};

const GitSourceContext$json = const {
  '1': 'GitSourceContext',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9},
    const {'1': 'revision_id', '3': 2, '4': 1, '5': 9},
  ],
};

const RepoId$json = const {
  '1': 'RepoId',
  '2': const [
    const {'1': 'project_repo_id', '3': 1, '4': 1, '5': 11, '6': '.google.devtools.source.v1.ProjectRepoId'},
    const {'1': 'uid', '3': 2, '4': 1, '5': 9},
  ],
};

const ProjectRepoId$json = const {
  '1': 'ProjectRepoId',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'repo_name', '3': 2, '4': 1, '5': 9},
  ],
};

const CloudWorkspaceId$json = const {
  '1': 'CloudWorkspaceId',
  '2': const [
    const {'1': 'repo_id', '3': 1, '4': 1, '5': 11, '6': '.google.devtools.source.v1.RepoId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9},
  ],
};

