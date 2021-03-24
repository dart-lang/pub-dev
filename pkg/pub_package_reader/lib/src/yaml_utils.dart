import 'package:yaml/yaml.dart';

/// Check if given YAML string has aliases.
bool yamlContainsAliases(String yamlString) {
  final visited = <YamlNode>{};
  // Traverse YamlNode in a DFS search, return true, if we see the same YamlNode
  // twice, as this happens whenever we have references.
  bool hasAliases(YamlNode node) {
    if (!visited.add(node)) {
      return true;
    }
    if (node is YamlMap) {
      return node.nodes.entries
          .any((e) => hasAliases(e.key as YamlNode) || hasAliases(e.value));
    }
    if (node is YamlList) {
      return node.nodes.any(hasAliases);
    }
    return false;
  }

  try {
    return hasAliases(loadYamlNode(yamlString));
  } catch (e) {
    return false;
  }
}
