library googleapis.games.v1.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/games/v1.dart' as api;

class HttpServerMock extends http.BaseClient {
  core.Function _callback;
  core.bool _expectJson;

  void register(core.Function callback, core.bool expectJson) {
    _callback = callback;
    _expectJson = expectJson;
  }

  async.Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (_expectJson) {
      return request.finalize()
          .transform(convert.UTF8.decoder)
          .join('')
          .then((core.String jsonString) {
        if (jsonString.isEmpty) {
          return _callback(request, null);
        } else {
          return _callback(request, convert.JSON.decode(jsonString));
        }
      });
    } else {
      var stream = request.finalize();
      if (stream == null) {
        return _callback(request, []);
      } else {
        return stream.toBytes().then((data) {
          return _callback(request, data);
        });
      }
    }
  }
}

http.StreamedResponse stringResponse(
    core.int status, core.Map headers, core.String body) {
  var stream = new async.Stream.fromIterable([convert.UTF8.encode(body)]);
  return new http.StreamedResponse(stream, status, headers: headers);
}

core.int buildCounterAchievementDefinition = 0;
buildAchievementDefinition() {
  var o = new api.AchievementDefinition();
  buildCounterAchievementDefinition++;
  if (buildCounterAchievementDefinition < 3) {
    o.achievementType = "foo";
    o.description = "foo";
    o.experiencePoints = "foo";
    o.formattedTotalSteps = "foo";
    o.id = "foo";
    o.initialState = "foo";
    o.isRevealedIconUrlDefault = true;
    o.isUnlockedIconUrlDefault = true;
    o.kind = "foo";
    o.name = "foo";
    o.revealedIconUrl = "foo";
    o.totalSteps = 42;
    o.unlockedIconUrl = "foo";
  }
  buildCounterAchievementDefinition--;
  return o;
}

checkAchievementDefinition(api.AchievementDefinition o) {
  buildCounterAchievementDefinition++;
  if (buildCounterAchievementDefinition < 3) {
    unittest.expect(o.achievementType, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.experiencePoints, unittest.equals('foo'));
    unittest.expect(o.formattedTotalSteps, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.initialState, unittest.equals('foo'));
    unittest.expect(o.isRevealedIconUrlDefault, unittest.isTrue);
    unittest.expect(o.isUnlockedIconUrlDefault, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.revealedIconUrl, unittest.equals('foo'));
    unittest.expect(o.totalSteps, unittest.equals(42));
    unittest.expect(o.unlockedIconUrl, unittest.equals('foo'));
  }
  buildCounterAchievementDefinition--;
}

buildUnnamed34() {
  var o = new core.List<api.AchievementDefinition>();
  o.add(buildAchievementDefinition());
  o.add(buildAchievementDefinition());
  return o;
}

checkUnnamed34(core.List<api.AchievementDefinition> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAchievementDefinition(o[0]);
  checkAchievementDefinition(o[1]);
}

core.int buildCounterAchievementDefinitionsListResponse = 0;
buildAchievementDefinitionsListResponse() {
  var o = new api.AchievementDefinitionsListResponse();
  buildCounterAchievementDefinitionsListResponse++;
  if (buildCounterAchievementDefinitionsListResponse < 3) {
    o.items = buildUnnamed34();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterAchievementDefinitionsListResponse--;
  return o;
}

checkAchievementDefinitionsListResponse(api.AchievementDefinitionsListResponse o) {
  buildCounterAchievementDefinitionsListResponse++;
  if (buildCounterAchievementDefinitionsListResponse < 3) {
    checkUnnamed34(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterAchievementDefinitionsListResponse--;
}

core.int buildCounterAchievementIncrementResponse = 0;
buildAchievementIncrementResponse() {
  var o = new api.AchievementIncrementResponse();
  buildCounterAchievementIncrementResponse++;
  if (buildCounterAchievementIncrementResponse < 3) {
    o.currentSteps = 42;
    o.kind = "foo";
    o.newlyUnlocked = true;
  }
  buildCounterAchievementIncrementResponse--;
  return o;
}

checkAchievementIncrementResponse(api.AchievementIncrementResponse o) {
  buildCounterAchievementIncrementResponse++;
  if (buildCounterAchievementIncrementResponse < 3) {
    unittest.expect(o.currentSteps, unittest.equals(42));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.newlyUnlocked, unittest.isTrue);
  }
  buildCounterAchievementIncrementResponse--;
}

core.int buildCounterAchievementRevealResponse = 0;
buildAchievementRevealResponse() {
  var o = new api.AchievementRevealResponse();
  buildCounterAchievementRevealResponse++;
  if (buildCounterAchievementRevealResponse < 3) {
    o.currentState = "foo";
    o.kind = "foo";
  }
  buildCounterAchievementRevealResponse--;
  return o;
}

checkAchievementRevealResponse(api.AchievementRevealResponse o) {
  buildCounterAchievementRevealResponse++;
  if (buildCounterAchievementRevealResponse < 3) {
    unittest.expect(o.currentState, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAchievementRevealResponse--;
}

core.int buildCounterAchievementSetStepsAtLeastResponse = 0;
buildAchievementSetStepsAtLeastResponse() {
  var o = new api.AchievementSetStepsAtLeastResponse();
  buildCounterAchievementSetStepsAtLeastResponse++;
  if (buildCounterAchievementSetStepsAtLeastResponse < 3) {
    o.currentSteps = 42;
    o.kind = "foo";
    o.newlyUnlocked = true;
  }
  buildCounterAchievementSetStepsAtLeastResponse--;
  return o;
}

checkAchievementSetStepsAtLeastResponse(api.AchievementSetStepsAtLeastResponse o) {
  buildCounterAchievementSetStepsAtLeastResponse++;
  if (buildCounterAchievementSetStepsAtLeastResponse < 3) {
    unittest.expect(o.currentSteps, unittest.equals(42));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.newlyUnlocked, unittest.isTrue);
  }
  buildCounterAchievementSetStepsAtLeastResponse--;
}

core.int buildCounterAchievementUnlockResponse = 0;
buildAchievementUnlockResponse() {
  var o = new api.AchievementUnlockResponse();
  buildCounterAchievementUnlockResponse++;
  if (buildCounterAchievementUnlockResponse < 3) {
    o.kind = "foo";
    o.newlyUnlocked = true;
  }
  buildCounterAchievementUnlockResponse--;
  return o;
}

checkAchievementUnlockResponse(api.AchievementUnlockResponse o) {
  buildCounterAchievementUnlockResponse++;
  if (buildCounterAchievementUnlockResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.newlyUnlocked, unittest.isTrue);
  }
  buildCounterAchievementUnlockResponse--;
}

buildUnnamed35() {
  var o = new core.List<api.AchievementUpdateRequest>();
  o.add(buildAchievementUpdateRequest());
  o.add(buildAchievementUpdateRequest());
  return o;
}

checkUnnamed35(core.List<api.AchievementUpdateRequest> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAchievementUpdateRequest(o[0]);
  checkAchievementUpdateRequest(o[1]);
}

core.int buildCounterAchievementUpdateMultipleRequest = 0;
buildAchievementUpdateMultipleRequest() {
  var o = new api.AchievementUpdateMultipleRequest();
  buildCounterAchievementUpdateMultipleRequest++;
  if (buildCounterAchievementUpdateMultipleRequest < 3) {
    o.kind = "foo";
    o.updates = buildUnnamed35();
  }
  buildCounterAchievementUpdateMultipleRequest--;
  return o;
}

checkAchievementUpdateMultipleRequest(api.AchievementUpdateMultipleRequest o) {
  buildCounterAchievementUpdateMultipleRequest++;
  if (buildCounterAchievementUpdateMultipleRequest < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed35(o.updates);
  }
  buildCounterAchievementUpdateMultipleRequest--;
}

buildUnnamed36() {
  var o = new core.List<api.AchievementUpdateResponse>();
  o.add(buildAchievementUpdateResponse());
  o.add(buildAchievementUpdateResponse());
  return o;
}

checkUnnamed36(core.List<api.AchievementUpdateResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAchievementUpdateResponse(o[0]);
  checkAchievementUpdateResponse(o[1]);
}

core.int buildCounterAchievementUpdateMultipleResponse = 0;
buildAchievementUpdateMultipleResponse() {
  var o = new api.AchievementUpdateMultipleResponse();
  buildCounterAchievementUpdateMultipleResponse++;
  if (buildCounterAchievementUpdateMultipleResponse < 3) {
    o.kind = "foo";
    o.updatedAchievements = buildUnnamed36();
  }
  buildCounterAchievementUpdateMultipleResponse--;
  return o;
}

checkAchievementUpdateMultipleResponse(api.AchievementUpdateMultipleResponse o) {
  buildCounterAchievementUpdateMultipleResponse++;
  if (buildCounterAchievementUpdateMultipleResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed36(o.updatedAchievements);
  }
  buildCounterAchievementUpdateMultipleResponse--;
}

core.int buildCounterAchievementUpdateRequest = 0;
buildAchievementUpdateRequest() {
  var o = new api.AchievementUpdateRequest();
  buildCounterAchievementUpdateRequest++;
  if (buildCounterAchievementUpdateRequest < 3) {
    o.achievementId = "foo";
    o.incrementPayload = buildGamesAchievementIncrement();
    o.kind = "foo";
    o.setStepsAtLeastPayload = buildGamesAchievementSetStepsAtLeast();
    o.updateType = "foo";
  }
  buildCounterAchievementUpdateRequest--;
  return o;
}

checkAchievementUpdateRequest(api.AchievementUpdateRequest o) {
  buildCounterAchievementUpdateRequest++;
  if (buildCounterAchievementUpdateRequest < 3) {
    unittest.expect(o.achievementId, unittest.equals('foo'));
    checkGamesAchievementIncrement(o.incrementPayload);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkGamesAchievementSetStepsAtLeast(o.setStepsAtLeastPayload);
    unittest.expect(o.updateType, unittest.equals('foo'));
  }
  buildCounterAchievementUpdateRequest--;
}

core.int buildCounterAchievementUpdateResponse = 0;
buildAchievementUpdateResponse() {
  var o = new api.AchievementUpdateResponse();
  buildCounterAchievementUpdateResponse++;
  if (buildCounterAchievementUpdateResponse < 3) {
    o.achievementId = "foo";
    o.currentState = "foo";
    o.currentSteps = 42;
    o.kind = "foo";
    o.newlyUnlocked = true;
    o.updateOccurred = true;
  }
  buildCounterAchievementUpdateResponse--;
  return o;
}

checkAchievementUpdateResponse(api.AchievementUpdateResponse o) {
  buildCounterAchievementUpdateResponse++;
  if (buildCounterAchievementUpdateResponse < 3) {
    unittest.expect(o.achievementId, unittest.equals('foo'));
    unittest.expect(o.currentState, unittest.equals('foo'));
    unittest.expect(o.currentSteps, unittest.equals(42));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.newlyUnlocked, unittest.isTrue);
    unittest.expect(o.updateOccurred, unittest.isTrue);
  }
  buildCounterAchievementUpdateResponse--;
}

core.int buildCounterAggregateStats = 0;
buildAggregateStats() {
  var o = new api.AggregateStats();
  buildCounterAggregateStats++;
  if (buildCounterAggregateStats < 3) {
    o.count = "foo";
    o.kind = "foo";
    o.max = "foo";
    o.min = "foo";
    o.sum = "foo";
  }
  buildCounterAggregateStats--;
  return o;
}

checkAggregateStats(api.AggregateStats o) {
  buildCounterAggregateStats++;
  if (buildCounterAggregateStats < 3) {
    unittest.expect(o.count, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.max, unittest.equals('foo'));
    unittest.expect(o.min, unittest.equals('foo'));
    unittest.expect(o.sum, unittest.equals('foo'));
  }
  buildCounterAggregateStats--;
}

core.int buildCounterAnonymousPlayer = 0;
buildAnonymousPlayer() {
  var o = new api.AnonymousPlayer();
  buildCounterAnonymousPlayer++;
  if (buildCounterAnonymousPlayer < 3) {
    o.avatarImageUrl = "foo";
    o.displayName = "foo";
    o.kind = "foo";
  }
  buildCounterAnonymousPlayer--;
  return o;
}

checkAnonymousPlayer(api.AnonymousPlayer o) {
  buildCounterAnonymousPlayer++;
  if (buildCounterAnonymousPlayer < 3) {
    unittest.expect(o.avatarImageUrl, unittest.equals('foo'));
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAnonymousPlayer--;
}

buildUnnamed37() {
  var o = new core.List<api.ImageAsset>();
  o.add(buildImageAsset());
  o.add(buildImageAsset());
  return o;
}

checkUnnamed37(core.List<api.ImageAsset> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkImageAsset(o[0]);
  checkImageAsset(o[1]);
}

buildUnnamed38() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed38(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed39() {
  var o = new core.List<api.Instance>();
  o.add(buildInstance());
  o.add(buildInstance());
  return o;
}

checkUnnamed39(core.List<api.Instance> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkInstance(o[0]);
  checkInstance(o[1]);
}

core.int buildCounterApplication = 0;
buildApplication() {
  var o = new api.Application();
  buildCounterApplication++;
  if (buildCounterApplication < 3) {
    o.achievementCount = 42;
    o.assets = buildUnnamed37();
    o.author = "foo";
    o.category = buildApplicationCategory();
    o.description = "foo";
    o.enabledFeatures = buildUnnamed38();
    o.id = "foo";
    o.instances = buildUnnamed39();
    o.kind = "foo";
    o.lastUpdatedTimestamp = "foo";
    o.leaderboardCount = 42;
    o.name = "foo";
    o.themeColor = "foo";
  }
  buildCounterApplication--;
  return o;
}

checkApplication(api.Application o) {
  buildCounterApplication++;
  if (buildCounterApplication < 3) {
    unittest.expect(o.achievementCount, unittest.equals(42));
    checkUnnamed37(o.assets);
    unittest.expect(o.author, unittest.equals('foo'));
    checkApplicationCategory(o.category);
    unittest.expect(o.description, unittest.equals('foo'));
    checkUnnamed38(o.enabledFeatures);
    unittest.expect(o.id, unittest.equals('foo'));
    checkUnnamed39(o.instances);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.lastUpdatedTimestamp, unittest.equals('foo'));
    unittest.expect(o.leaderboardCount, unittest.equals(42));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.themeColor, unittest.equals('foo'));
  }
  buildCounterApplication--;
}

core.int buildCounterApplicationCategory = 0;
buildApplicationCategory() {
  var o = new api.ApplicationCategory();
  buildCounterApplicationCategory++;
  if (buildCounterApplicationCategory < 3) {
    o.kind = "foo";
    o.primary = "foo";
    o.secondary = "foo";
  }
  buildCounterApplicationCategory--;
  return o;
}

checkApplicationCategory(api.ApplicationCategory o) {
  buildCounterApplicationCategory++;
  if (buildCounterApplicationCategory < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.primary, unittest.equals('foo'));
    unittest.expect(o.secondary, unittest.equals('foo'));
  }
  buildCounterApplicationCategory--;
}

core.int buildCounterApplicationVerifyResponse = 0;
buildApplicationVerifyResponse() {
  var o = new api.ApplicationVerifyResponse();
  buildCounterApplicationVerifyResponse++;
  if (buildCounterApplicationVerifyResponse < 3) {
    o.alternatePlayerId = "foo";
    o.kind = "foo";
    o.playerId = "foo";
  }
  buildCounterApplicationVerifyResponse--;
  return o;
}

checkApplicationVerifyResponse(api.ApplicationVerifyResponse o) {
  buildCounterApplicationVerifyResponse++;
  if (buildCounterApplicationVerifyResponse < 3) {
    unittest.expect(o.alternatePlayerId, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.playerId, unittest.equals('foo'));
  }
  buildCounterApplicationVerifyResponse--;
}

core.int buildCounterCategory = 0;
buildCategory() {
  var o = new api.Category();
  buildCounterCategory++;
  if (buildCounterCategory < 3) {
    o.category = "foo";
    o.experiencePoints = "foo";
    o.kind = "foo";
  }
  buildCounterCategory--;
  return o;
}

checkCategory(api.Category o) {
  buildCounterCategory++;
  if (buildCounterCategory < 3) {
    unittest.expect(o.category, unittest.equals('foo'));
    unittest.expect(o.experiencePoints, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterCategory--;
}

buildUnnamed40() {
  var o = new core.List<api.Category>();
  o.add(buildCategory());
  o.add(buildCategory());
  return o;
}

checkUnnamed40(core.List<api.Category> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCategory(o[0]);
  checkCategory(o[1]);
}

core.int buildCounterCategoryListResponse = 0;
buildCategoryListResponse() {
  var o = new api.CategoryListResponse();
  buildCounterCategoryListResponse++;
  if (buildCounterCategoryListResponse < 3) {
    o.items = buildUnnamed40();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterCategoryListResponse--;
  return o;
}

checkCategoryListResponse(api.CategoryListResponse o) {
  buildCounterCategoryListResponse++;
  if (buildCounterCategoryListResponse < 3) {
    checkUnnamed40(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterCategoryListResponse--;
}

core.int buildCounterEventBatchRecordFailure = 0;
buildEventBatchRecordFailure() {
  var o = new api.EventBatchRecordFailure();
  buildCounterEventBatchRecordFailure++;
  if (buildCounterEventBatchRecordFailure < 3) {
    o.failureCause = "foo";
    o.kind = "foo";
    o.range = buildEventPeriodRange();
  }
  buildCounterEventBatchRecordFailure--;
  return o;
}

checkEventBatchRecordFailure(api.EventBatchRecordFailure o) {
  buildCounterEventBatchRecordFailure++;
  if (buildCounterEventBatchRecordFailure < 3) {
    unittest.expect(o.failureCause, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkEventPeriodRange(o.range);
  }
  buildCounterEventBatchRecordFailure--;
}

core.int buildCounterEventChild = 0;
buildEventChild() {
  var o = new api.EventChild();
  buildCounterEventChild++;
  if (buildCounterEventChild < 3) {
    o.childId = "foo";
    o.kind = "foo";
  }
  buildCounterEventChild--;
  return o;
}

checkEventChild(api.EventChild o) {
  buildCounterEventChild++;
  if (buildCounterEventChild < 3) {
    unittest.expect(o.childId, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterEventChild--;
}

buildUnnamed41() {
  var o = new core.List<api.EventChild>();
  o.add(buildEventChild());
  o.add(buildEventChild());
  return o;
}

checkUnnamed41(core.List<api.EventChild> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEventChild(o[0]);
  checkEventChild(o[1]);
}

core.int buildCounterEventDefinition = 0;
buildEventDefinition() {
  var o = new api.EventDefinition();
  buildCounterEventDefinition++;
  if (buildCounterEventDefinition < 3) {
    o.childEvents = buildUnnamed41();
    o.description = "foo";
    o.displayName = "foo";
    o.id = "foo";
    o.imageUrl = "foo";
    o.isDefaultImageUrl = true;
    o.kind = "foo";
    o.visibility = "foo";
  }
  buildCounterEventDefinition--;
  return o;
}

checkEventDefinition(api.EventDefinition o) {
  buildCounterEventDefinition++;
  if (buildCounterEventDefinition < 3) {
    checkUnnamed41(o.childEvents);
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.imageUrl, unittest.equals('foo'));
    unittest.expect(o.isDefaultImageUrl, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.visibility, unittest.equals('foo'));
  }
  buildCounterEventDefinition--;
}

buildUnnamed42() {
  var o = new core.List<api.EventDefinition>();
  o.add(buildEventDefinition());
  o.add(buildEventDefinition());
  return o;
}

checkUnnamed42(core.List<api.EventDefinition> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEventDefinition(o[0]);
  checkEventDefinition(o[1]);
}

core.int buildCounterEventDefinitionListResponse = 0;
buildEventDefinitionListResponse() {
  var o = new api.EventDefinitionListResponse();
  buildCounterEventDefinitionListResponse++;
  if (buildCounterEventDefinitionListResponse < 3) {
    o.items = buildUnnamed42();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterEventDefinitionListResponse--;
  return o;
}

checkEventDefinitionListResponse(api.EventDefinitionListResponse o) {
  buildCounterEventDefinitionListResponse++;
  if (buildCounterEventDefinitionListResponse < 3) {
    checkUnnamed42(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterEventDefinitionListResponse--;
}

core.int buildCounterEventPeriodRange = 0;
buildEventPeriodRange() {
  var o = new api.EventPeriodRange();
  buildCounterEventPeriodRange++;
  if (buildCounterEventPeriodRange < 3) {
    o.kind = "foo";
    o.periodEndMillis = "foo";
    o.periodStartMillis = "foo";
  }
  buildCounterEventPeriodRange--;
  return o;
}

checkEventPeriodRange(api.EventPeriodRange o) {
  buildCounterEventPeriodRange++;
  if (buildCounterEventPeriodRange < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.periodEndMillis, unittest.equals('foo'));
    unittest.expect(o.periodStartMillis, unittest.equals('foo'));
  }
  buildCounterEventPeriodRange--;
}

buildUnnamed43() {
  var o = new core.List<api.EventUpdateRequest>();
  o.add(buildEventUpdateRequest());
  o.add(buildEventUpdateRequest());
  return o;
}

checkUnnamed43(core.List<api.EventUpdateRequest> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEventUpdateRequest(o[0]);
  checkEventUpdateRequest(o[1]);
}

core.int buildCounterEventPeriodUpdate = 0;
buildEventPeriodUpdate() {
  var o = new api.EventPeriodUpdate();
  buildCounterEventPeriodUpdate++;
  if (buildCounterEventPeriodUpdate < 3) {
    o.kind = "foo";
    o.timePeriod = buildEventPeriodRange();
    o.updates = buildUnnamed43();
  }
  buildCounterEventPeriodUpdate--;
  return o;
}

checkEventPeriodUpdate(api.EventPeriodUpdate o) {
  buildCounterEventPeriodUpdate++;
  if (buildCounterEventPeriodUpdate < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkEventPeriodRange(o.timePeriod);
    checkUnnamed43(o.updates);
  }
  buildCounterEventPeriodUpdate--;
}

core.int buildCounterEventRecordFailure = 0;
buildEventRecordFailure() {
  var o = new api.EventRecordFailure();
  buildCounterEventRecordFailure++;
  if (buildCounterEventRecordFailure < 3) {
    o.eventId = "foo";
    o.failureCause = "foo";
    o.kind = "foo";
  }
  buildCounterEventRecordFailure--;
  return o;
}

checkEventRecordFailure(api.EventRecordFailure o) {
  buildCounterEventRecordFailure++;
  if (buildCounterEventRecordFailure < 3) {
    unittest.expect(o.eventId, unittest.equals('foo'));
    unittest.expect(o.failureCause, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterEventRecordFailure--;
}

buildUnnamed44() {
  var o = new core.List<api.EventPeriodUpdate>();
  o.add(buildEventPeriodUpdate());
  o.add(buildEventPeriodUpdate());
  return o;
}

checkUnnamed44(core.List<api.EventPeriodUpdate> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEventPeriodUpdate(o[0]);
  checkEventPeriodUpdate(o[1]);
}

core.int buildCounterEventRecordRequest = 0;
buildEventRecordRequest() {
  var o = new api.EventRecordRequest();
  buildCounterEventRecordRequest++;
  if (buildCounterEventRecordRequest < 3) {
    o.currentTimeMillis = "foo";
    o.kind = "foo";
    o.requestId = "foo";
    o.timePeriods = buildUnnamed44();
  }
  buildCounterEventRecordRequest--;
  return o;
}

checkEventRecordRequest(api.EventRecordRequest o) {
  buildCounterEventRecordRequest++;
  if (buildCounterEventRecordRequest < 3) {
    unittest.expect(o.currentTimeMillis, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.requestId, unittest.equals('foo'));
    checkUnnamed44(o.timePeriods);
  }
  buildCounterEventRecordRequest--;
}

core.int buildCounterEventUpdateRequest = 0;
buildEventUpdateRequest() {
  var o = new api.EventUpdateRequest();
  buildCounterEventUpdateRequest++;
  if (buildCounterEventUpdateRequest < 3) {
    o.definitionId = "foo";
    o.kind = "foo";
    o.updateCount = "foo";
  }
  buildCounterEventUpdateRequest--;
  return o;
}

checkEventUpdateRequest(api.EventUpdateRequest o) {
  buildCounterEventUpdateRequest++;
  if (buildCounterEventUpdateRequest < 3) {
    unittest.expect(o.definitionId, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.updateCount, unittest.equals('foo'));
  }
  buildCounterEventUpdateRequest--;
}

buildUnnamed45() {
  var o = new core.List<api.EventBatchRecordFailure>();
  o.add(buildEventBatchRecordFailure());
  o.add(buildEventBatchRecordFailure());
  return o;
}

checkUnnamed45(core.List<api.EventBatchRecordFailure> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEventBatchRecordFailure(o[0]);
  checkEventBatchRecordFailure(o[1]);
}

buildUnnamed46() {
  var o = new core.List<api.EventRecordFailure>();
  o.add(buildEventRecordFailure());
  o.add(buildEventRecordFailure());
  return o;
}

checkUnnamed46(core.List<api.EventRecordFailure> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEventRecordFailure(o[0]);
  checkEventRecordFailure(o[1]);
}

buildUnnamed47() {
  var o = new core.List<api.PlayerEvent>();
  o.add(buildPlayerEvent());
  o.add(buildPlayerEvent());
  return o;
}

checkUnnamed47(core.List<api.PlayerEvent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPlayerEvent(o[0]);
  checkPlayerEvent(o[1]);
}

core.int buildCounterEventUpdateResponse = 0;
buildEventUpdateResponse() {
  var o = new api.EventUpdateResponse();
  buildCounterEventUpdateResponse++;
  if (buildCounterEventUpdateResponse < 3) {
    o.batchFailures = buildUnnamed45();
    o.eventFailures = buildUnnamed46();
    o.kind = "foo";
    o.playerEvents = buildUnnamed47();
  }
  buildCounterEventUpdateResponse--;
  return o;
}

checkEventUpdateResponse(api.EventUpdateResponse o) {
  buildCounterEventUpdateResponse++;
  if (buildCounterEventUpdateResponse < 3) {
    checkUnnamed45(o.batchFailures);
    checkUnnamed46(o.eventFailures);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed47(o.playerEvents);
  }
  buildCounterEventUpdateResponse--;
}

core.int buildCounterGamesAchievementIncrement = 0;
buildGamesAchievementIncrement() {
  var o = new api.GamesAchievementIncrement();
  buildCounterGamesAchievementIncrement++;
  if (buildCounterGamesAchievementIncrement < 3) {
    o.kind = "foo";
    o.requestId = "foo";
    o.steps = 42;
  }
  buildCounterGamesAchievementIncrement--;
  return o;
}

checkGamesAchievementIncrement(api.GamesAchievementIncrement o) {
  buildCounterGamesAchievementIncrement++;
  if (buildCounterGamesAchievementIncrement < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.requestId, unittest.equals('foo'));
    unittest.expect(o.steps, unittest.equals(42));
  }
  buildCounterGamesAchievementIncrement--;
}

core.int buildCounterGamesAchievementSetStepsAtLeast = 0;
buildGamesAchievementSetStepsAtLeast() {
  var o = new api.GamesAchievementSetStepsAtLeast();
  buildCounterGamesAchievementSetStepsAtLeast++;
  if (buildCounterGamesAchievementSetStepsAtLeast < 3) {
    o.kind = "foo";
    o.steps = 42;
  }
  buildCounterGamesAchievementSetStepsAtLeast--;
  return o;
}

checkGamesAchievementSetStepsAtLeast(api.GamesAchievementSetStepsAtLeast o) {
  buildCounterGamesAchievementSetStepsAtLeast++;
  if (buildCounterGamesAchievementSetStepsAtLeast < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.steps, unittest.equals(42));
  }
  buildCounterGamesAchievementSetStepsAtLeast--;
}

core.int buildCounterImageAsset = 0;
buildImageAsset() {
  var o = new api.ImageAsset();
  buildCounterImageAsset++;
  if (buildCounterImageAsset < 3) {
    o.height = 42;
    o.kind = "foo";
    o.name = "foo";
    o.url = "foo";
    o.width = 42;
  }
  buildCounterImageAsset--;
  return o;
}

checkImageAsset(api.ImageAsset o) {
  buildCounterImageAsset++;
  if (buildCounterImageAsset < 3) {
    unittest.expect(o.height, unittest.equals(42));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterImageAsset--;
}

core.int buildCounterInstance = 0;
buildInstance() {
  var o = new api.Instance();
  buildCounterInstance++;
  if (buildCounterInstance < 3) {
    o.acquisitionUri = "foo";
    o.androidInstance = buildInstanceAndroidDetails();
    o.iosInstance = buildInstanceIosDetails();
    o.kind = "foo";
    o.name = "foo";
    o.platformType = "foo";
    o.realtimePlay = true;
    o.turnBasedPlay = true;
    o.webInstance = buildInstanceWebDetails();
  }
  buildCounterInstance--;
  return o;
}

checkInstance(api.Instance o) {
  buildCounterInstance++;
  if (buildCounterInstance < 3) {
    unittest.expect(o.acquisitionUri, unittest.equals('foo'));
    checkInstanceAndroidDetails(o.androidInstance);
    checkInstanceIosDetails(o.iosInstance);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.platformType, unittest.equals('foo'));
    unittest.expect(o.realtimePlay, unittest.isTrue);
    unittest.expect(o.turnBasedPlay, unittest.isTrue);
    checkInstanceWebDetails(o.webInstance);
  }
  buildCounterInstance--;
}

core.int buildCounterInstanceAndroidDetails = 0;
buildInstanceAndroidDetails() {
  var o = new api.InstanceAndroidDetails();
  buildCounterInstanceAndroidDetails++;
  if (buildCounterInstanceAndroidDetails < 3) {
    o.enablePiracyCheck = true;
    o.kind = "foo";
    o.packageName = "foo";
    o.preferred = true;
  }
  buildCounterInstanceAndroidDetails--;
  return o;
}

checkInstanceAndroidDetails(api.InstanceAndroidDetails o) {
  buildCounterInstanceAndroidDetails++;
  if (buildCounterInstanceAndroidDetails < 3) {
    unittest.expect(o.enablePiracyCheck, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.packageName, unittest.equals('foo'));
    unittest.expect(o.preferred, unittest.isTrue);
  }
  buildCounterInstanceAndroidDetails--;
}

core.int buildCounterInstanceIosDetails = 0;
buildInstanceIosDetails() {
  var o = new api.InstanceIosDetails();
  buildCounterInstanceIosDetails++;
  if (buildCounterInstanceIosDetails < 3) {
    o.bundleIdentifier = "foo";
    o.itunesAppId = "foo";
    o.kind = "foo";
    o.preferredForIpad = true;
    o.preferredForIphone = true;
    o.supportIpad = true;
    o.supportIphone = true;
  }
  buildCounterInstanceIosDetails--;
  return o;
}

checkInstanceIosDetails(api.InstanceIosDetails o) {
  buildCounterInstanceIosDetails++;
  if (buildCounterInstanceIosDetails < 3) {
    unittest.expect(o.bundleIdentifier, unittest.equals('foo'));
    unittest.expect(o.itunesAppId, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.preferredForIpad, unittest.isTrue);
    unittest.expect(o.preferredForIphone, unittest.isTrue);
    unittest.expect(o.supportIpad, unittest.isTrue);
    unittest.expect(o.supportIphone, unittest.isTrue);
  }
  buildCounterInstanceIosDetails--;
}

core.int buildCounterInstanceWebDetails = 0;
buildInstanceWebDetails() {
  var o = new api.InstanceWebDetails();
  buildCounterInstanceWebDetails++;
  if (buildCounterInstanceWebDetails < 3) {
    o.kind = "foo";
    o.launchUrl = "foo";
    o.preferred = true;
  }
  buildCounterInstanceWebDetails--;
  return o;
}

checkInstanceWebDetails(api.InstanceWebDetails o) {
  buildCounterInstanceWebDetails++;
  if (buildCounterInstanceWebDetails < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.launchUrl, unittest.equals('foo'));
    unittest.expect(o.preferred, unittest.isTrue);
  }
  buildCounterInstanceWebDetails--;
}

core.int buildCounterLeaderboard = 0;
buildLeaderboard() {
  var o = new api.Leaderboard();
  buildCounterLeaderboard++;
  if (buildCounterLeaderboard < 3) {
    o.iconUrl = "foo";
    o.id = "foo";
    o.isIconUrlDefault = true;
    o.kind = "foo";
    o.name = "foo";
    o.order = "foo";
  }
  buildCounterLeaderboard--;
  return o;
}

checkLeaderboard(api.Leaderboard o) {
  buildCounterLeaderboard++;
  if (buildCounterLeaderboard < 3) {
    unittest.expect(o.iconUrl, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.isIconUrlDefault, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.order, unittest.equals('foo'));
  }
  buildCounterLeaderboard--;
}

core.int buildCounterLeaderboardEntry = 0;
buildLeaderboardEntry() {
  var o = new api.LeaderboardEntry();
  buildCounterLeaderboardEntry++;
  if (buildCounterLeaderboardEntry < 3) {
    o.formattedScore = "foo";
    o.formattedScoreRank = "foo";
    o.kind = "foo";
    o.player = buildPlayer();
    o.scoreRank = "foo";
    o.scoreTag = "foo";
    o.scoreValue = "foo";
    o.timeSpan = "foo";
    o.writeTimestampMillis = "foo";
  }
  buildCounterLeaderboardEntry--;
  return o;
}

checkLeaderboardEntry(api.LeaderboardEntry o) {
  buildCounterLeaderboardEntry++;
  if (buildCounterLeaderboardEntry < 3) {
    unittest.expect(o.formattedScore, unittest.equals('foo'));
    unittest.expect(o.formattedScoreRank, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkPlayer(o.player);
    unittest.expect(o.scoreRank, unittest.equals('foo'));
    unittest.expect(o.scoreTag, unittest.equals('foo'));
    unittest.expect(o.scoreValue, unittest.equals('foo'));
    unittest.expect(o.timeSpan, unittest.equals('foo'));
    unittest.expect(o.writeTimestampMillis, unittest.equals('foo'));
  }
  buildCounterLeaderboardEntry--;
}

buildUnnamed48() {
  var o = new core.List<api.Leaderboard>();
  o.add(buildLeaderboard());
  o.add(buildLeaderboard());
  return o;
}

checkUnnamed48(core.List<api.Leaderboard> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLeaderboard(o[0]);
  checkLeaderboard(o[1]);
}

core.int buildCounterLeaderboardListResponse = 0;
buildLeaderboardListResponse() {
  var o = new api.LeaderboardListResponse();
  buildCounterLeaderboardListResponse++;
  if (buildCounterLeaderboardListResponse < 3) {
    o.items = buildUnnamed48();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterLeaderboardListResponse--;
  return o;
}

checkLeaderboardListResponse(api.LeaderboardListResponse o) {
  buildCounterLeaderboardListResponse++;
  if (buildCounterLeaderboardListResponse < 3) {
    checkUnnamed48(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterLeaderboardListResponse--;
}

core.int buildCounterLeaderboardScoreRank = 0;
buildLeaderboardScoreRank() {
  var o = new api.LeaderboardScoreRank();
  buildCounterLeaderboardScoreRank++;
  if (buildCounterLeaderboardScoreRank < 3) {
    o.formattedNumScores = "foo";
    o.formattedRank = "foo";
    o.kind = "foo";
    o.numScores = "foo";
    o.rank = "foo";
  }
  buildCounterLeaderboardScoreRank--;
  return o;
}

checkLeaderboardScoreRank(api.LeaderboardScoreRank o) {
  buildCounterLeaderboardScoreRank++;
  if (buildCounterLeaderboardScoreRank < 3) {
    unittest.expect(o.formattedNumScores, unittest.equals('foo'));
    unittest.expect(o.formattedRank, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.numScores, unittest.equals('foo'));
    unittest.expect(o.rank, unittest.equals('foo'));
  }
  buildCounterLeaderboardScoreRank--;
}

buildUnnamed49() {
  var o = new core.List<api.LeaderboardEntry>();
  o.add(buildLeaderboardEntry());
  o.add(buildLeaderboardEntry());
  return o;
}

checkUnnamed49(core.List<api.LeaderboardEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLeaderboardEntry(o[0]);
  checkLeaderboardEntry(o[1]);
}

core.int buildCounterLeaderboardScores = 0;
buildLeaderboardScores() {
  var o = new api.LeaderboardScores();
  buildCounterLeaderboardScores++;
  if (buildCounterLeaderboardScores < 3) {
    o.items = buildUnnamed49();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.numScores = "foo";
    o.playerScore = buildLeaderboardEntry();
    o.prevPageToken = "foo";
  }
  buildCounterLeaderboardScores--;
  return o;
}

checkLeaderboardScores(api.LeaderboardScores o) {
  buildCounterLeaderboardScores++;
  if (buildCounterLeaderboardScores < 3) {
    checkUnnamed49(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.numScores, unittest.equals('foo'));
    checkLeaderboardEntry(o.playerScore);
    unittest.expect(o.prevPageToken, unittest.equals('foo'));
  }
  buildCounterLeaderboardScores--;
}

buildUnnamed50() {
  var o = new core.List<api.PlayerLevel>();
  o.add(buildPlayerLevel());
  o.add(buildPlayerLevel());
  return o;
}

checkUnnamed50(core.List<api.PlayerLevel> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPlayerLevel(o[0]);
  checkPlayerLevel(o[1]);
}

core.int buildCounterMetagameConfig = 0;
buildMetagameConfig() {
  var o = new api.MetagameConfig();
  buildCounterMetagameConfig++;
  if (buildCounterMetagameConfig < 3) {
    o.currentVersion = 42;
    o.kind = "foo";
    o.playerLevels = buildUnnamed50();
  }
  buildCounterMetagameConfig--;
  return o;
}

checkMetagameConfig(api.MetagameConfig o) {
  buildCounterMetagameConfig++;
  if (buildCounterMetagameConfig < 3) {
    unittest.expect(o.currentVersion, unittest.equals(42));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed50(o.playerLevels);
  }
  buildCounterMetagameConfig--;
}

core.int buildCounterNetworkDiagnostics = 0;
buildNetworkDiagnostics() {
  var o = new api.NetworkDiagnostics();
  buildCounterNetworkDiagnostics++;
  if (buildCounterNetworkDiagnostics < 3) {
    o.androidNetworkSubtype = 42;
    o.androidNetworkType = 42;
    o.iosNetworkType = 42;
    o.kind = "foo";
    o.networkOperatorCode = "foo";
    o.networkOperatorName = "foo";
    o.registrationLatencyMillis = 42;
  }
  buildCounterNetworkDiagnostics--;
  return o;
}

checkNetworkDiagnostics(api.NetworkDiagnostics o) {
  buildCounterNetworkDiagnostics++;
  if (buildCounterNetworkDiagnostics < 3) {
    unittest.expect(o.androidNetworkSubtype, unittest.equals(42));
    unittest.expect(o.androidNetworkType, unittest.equals(42));
    unittest.expect(o.iosNetworkType, unittest.equals(42));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.networkOperatorCode, unittest.equals('foo'));
    unittest.expect(o.networkOperatorName, unittest.equals('foo'));
    unittest.expect(o.registrationLatencyMillis, unittest.equals(42));
  }
  buildCounterNetworkDiagnostics--;
}

core.int buildCounterParticipantResult = 0;
buildParticipantResult() {
  var o = new api.ParticipantResult();
  buildCounterParticipantResult++;
  if (buildCounterParticipantResult < 3) {
    o.kind = "foo";
    o.participantId = "foo";
    o.placing = 42;
    o.result = "foo";
  }
  buildCounterParticipantResult--;
  return o;
}

checkParticipantResult(api.ParticipantResult o) {
  buildCounterParticipantResult++;
  if (buildCounterParticipantResult < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.participantId, unittest.equals('foo'));
    unittest.expect(o.placing, unittest.equals(42));
    unittest.expect(o.result, unittest.equals('foo'));
  }
  buildCounterParticipantResult--;
}

core.int buildCounterPeerChannelDiagnostics = 0;
buildPeerChannelDiagnostics() {
  var o = new api.PeerChannelDiagnostics();
  buildCounterPeerChannelDiagnostics++;
  if (buildCounterPeerChannelDiagnostics < 3) {
    o.bytesReceived = buildAggregateStats();
    o.bytesSent = buildAggregateStats();
    o.kind = "foo";
    o.numMessagesLost = 42;
    o.numMessagesReceived = 42;
    o.numMessagesSent = 42;
    o.numSendFailures = 42;
    o.roundtripLatencyMillis = buildAggregateStats();
  }
  buildCounterPeerChannelDiagnostics--;
  return o;
}

checkPeerChannelDiagnostics(api.PeerChannelDiagnostics o) {
  buildCounterPeerChannelDiagnostics++;
  if (buildCounterPeerChannelDiagnostics < 3) {
    checkAggregateStats(o.bytesReceived);
    checkAggregateStats(o.bytesSent);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.numMessagesLost, unittest.equals(42));
    unittest.expect(o.numMessagesReceived, unittest.equals(42));
    unittest.expect(o.numMessagesSent, unittest.equals(42));
    unittest.expect(o.numSendFailures, unittest.equals(42));
    checkAggregateStats(o.roundtripLatencyMillis);
  }
  buildCounterPeerChannelDiagnostics--;
}

core.int buildCounterPeerSessionDiagnostics = 0;
buildPeerSessionDiagnostics() {
  var o = new api.PeerSessionDiagnostics();
  buildCounterPeerSessionDiagnostics++;
  if (buildCounterPeerSessionDiagnostics < 3) {
    o.connectedTimestampMillis = "foo";
    o.kind = "foo";
    o.participantId = "foo";
    o.reliableChannel = buildPeerChannelDiagnostics();
    o.unreliableChannel = buildPeerChannelDiagnostics();
  }
  buildCounterPeerSessionDiagnostics--;
  return o;
}

checkPeerSessionDiagnostics(api.PeerSessionDiagnostics o) {
  buildCounterPeerSessionDiagnostics++;
  if (buildCounterPeerSessionDiagnostics < 3) {
    unittest.expect(o.connectedTimestampMillis, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.participantId, unittest.equals('foo'));
    checkPeerChannelDiagnostics(o.reliableChannel);
    checkPeerChannelDiagnostics(o.unreliableChannel);
  }
  buildCounterPeerSessionDiagnostics--;
}

core.int buildCounterPlayed = 0;
buildPlayed() {
  var o = new api.Played();
  buildCounterPlayed++;
  if (buildCounterPlayed < 3) {
    o.autoMatched = true;
    o.kind = "foo";
    o.timeMillis = "foo";
  }
  buildCounterPlayed--;
  return o;
}

checkPlayed(api.Played o) {
  buildCounterPlayed++;
  if (buildCounterPlayed < 3) {
    unittest.expect(o.autoMatched, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.timeMillis, unittest.equals('foo'));
  }
  buildCounterPlayed--;
}

core.int buildCounterPlayerName = 0;
buildPlayerName() {
  var o = new api.PlayerName();
  buildCounterPlayerName++;
  if (buildCounterPlayerName < 3) {
    o.familyName = "foo";
    o.givenName = "foo";
  }
  buildCounterPlayerName--;
  return o;
}

checkPlayerName(api.PlayerName o) {
  buildCounterPlayerName++;
  if (buildCounterPlayerName < 3) {
    unittest.expect(o.familyName, unittest.equals('foo'));
    unittest.expect(o.givenName, unittest.equals('foo'));
  }
  buildCounterPlayerName--;
}

core.int buildCounterPlayer = 0;
buildPlayer() {
  var o = new api.Player();
  buildCounterPlayer++;
  if (buildCounterPlayer < 3) {
    o.avatarImageUrl = "foo";
    o.bannerUrlLandscape = "foo";
    o.bannerUrlPortrait = "foo";
    o.displayName = "foo";
    o.experienceInfo = buildPlayerExperienceInfo();
    o.kind = "foo";
    o.lastPlayedWith = buildPlayed();
    o.name = buildPlayerName();
    o.originalPlayerId = "foo";
    o.playerId = "foo";
    o.profileSettings = buildProfileSettings();
    o.title = "foo";
  }
  buildCounterPlayer--;
  return o;
}

checkPlayer(api.Player o) {
  buildCounterPlayer++;
  if (buildCounterPlayer < 3) {
    unittest.expect(o.avatarImageUrl, unittest.equals('foo'));
    unittest.expect(o.bannerUrlLandscape, unittest.equals('foo'));
    unittest.expect(o.bannerUrlPortrait, unittest.equals('foo'));
    unittest.expect(o.displayName, unittest.equals('foo'));
    checkPlayerExperienceInfo(o.experienceInfo);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkPlayed(o.lastPlayedWith);
    checkPlayerName(o.name);
    unittest.expect(o.originalPlayerId, unittest.equals('foo'));
    unittest.expect(o.playerId, unittest.equals('foo'));
    checkProfileSettings(o.profileSettings);
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterPlayer--;
}

core.int buildCounterPlayerAchievement = 0;
buildPlayerAchievement() {
  var o = new api.PlayerAchievement();
  buildCounterPlayerAchievement++;
  if (buildCounterPlayerAchievement < 3) {
    o.achievementState = "foo";
    o.currentSteps = 42;
    o.experiencePoints = "foo";
    o.formattedCurrentStepsString = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.lastUpdatedTimestamp = "foo";
  }
  buildCounterPlayerAchievement--;
  return o;
}

checkPlayerAchievement(api.PlayerAchievement o) {
  buildCounterPlayerAchievement++;
  if (buildCounterPlayerAchievement < 3) {
    unittest.expect(o.achievementState, unittest.equals('foo'));
    unittest.expect(o.currentSteps, unittest.equals(42));
    unittest.expect(o.experiencePoints, unittest.equals('foo'));
    unittest.expect(o.formattedCurrentStepsString, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.lastUpdatedTimestamp, unittest.equals('foo'));
  }
  buildCounterPlayerAchievement--;
}

buildUnnamed51() {
  var o = new core.List<api.PlayerAchievement>();
  o.add(buildPlayerAchievement());
  o.add(buildPlayerAchievement());
  return o;
}

checkUnnamed51(core.List<api.PlayerAchievement> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPlayerAchievement(o[0]);
  checkPlayerAchievement(o[1]);
}

core.int buildCounterPlayerAchievementListResponse = 0;
buildPlayerAchievementListResponse() {
  var o = new api.PlayerAchievementListResponse();
  buildCounterPlayerAchievementListResponse++;
  if (buildCounterPlayerAchievementListResponse < 3) {
    o.items = buildUnnamed51();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterPlayerAchievementListResponse--;
  return o;
}

checkPlayerAchievementListResponse(api.PlayerAchievementListResponse o) {
  buildCounterPlayerAchievementListResponse++;
  if (buildCounterPlayerAchievementListResponse < 3) {
    checkUnnamed51(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterPlayerAchievementListResponse--;
}

core.int buildCounterPlayerEvent = 0;
buildPlayerEvent() {
  var o = new api.PlayerEvent();
  buildCounterPlayerEvent++;
  if (buildCounterPlayerEvent < 3) {
    o.definitionId = "foo";
    o.formattedNumEvents = "foo";
    o.kind = "foo";
    o.numEvents = "foo";
    o.playerId = "foo";
  }
  buildCounterPlayerEvent--;
  return o;
}

checkPlayerEvent(api.PlayerEvent o) {
  buildCounterPlayerEvent++;
  if (buildCounterPlayerEvent < 3) {
    unittest.expect(o.definitionId, unittest.equals('foo'));
    unittest.expect(o.formattedNumEvents, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.numEvents, unittest.equals('foo'));
    unittest.expect(o.playerId, unittest.equals('foo'));
  }
  buildCounterPlayerEvent--;
}

buildUnnamed52() {
  var o = new core.List<api.PlayerEvent>();
  o.add(buildPlayerEvent());
  o.add(buildPlayerEvent());
  return o;
}

checkUnnamed52(core.List<api.PlayerEvent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPlayerEvent(o[0]);
  checkPlayerEvent(o[1]);
}

core.int buildCounterPlayerEventListResponse = 0;
buildPlayerEventListResponse() {
  var o = new api.PlayerEventListResponse();
  buildCounterPlayerEventListResponse++;
  if (buildCounterPlayerEventListResponse < 3) {
    o.items = buildUnnamed52();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterPlayerEventListResponse--;
  return o;
}

checkPlayerEventListResponse(api.PlayerEventListResponse o) {
  buildCounterPlayerEventListResponse++;
  if (buildCounterPlayerEventListResponse < 3) {
    checkUnnamed52(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterPlayerEventListResponse--;
}

core.int buildCounterPlayerExperienceInfo = 0;
buildPlayerExperienceInfo() {
  var o = new api.PlayerExperienceInfo();
  buildCounterPlayerExperienceInfo++;
  if (buildCounterPlayerExperienceInfo < 3) {
    o.currentExperiencePoints = "foo";
    o.currentLevel = buildPlayerLevel();
    o.kind = "foo";
    o.lastLevelUpTimestampMillis = "foo";
    o.nextLevel = buildPlayerLevel();
  }
  buildCounterPlayerExperienceInfo--;
  return o;
}

checkPlayerExperienceInfo(api.PlayerExperienceInfo o) {
  buildCounterPlayerExperienceInfo++;
  if (buildCounterPlayerExperienceInfo < 3) {
    unittest.expect(o.currentExperiencePoints, unittest.equals('foo'));
    checkPlayerLevel(o.currentLevel);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.lastLevelUpTimestampMillis, unittest.equals('foo'));
    checkPlayerLevel(o.nextLevel);
  }
  buildCounterPlayerExperienceInfo--;
}

core.int buildCounterPlayerLeaderboardScore = 0;
buildPlayerLeaderboardScore() {
  var o = new api.PlayerLeaderboardScore();
  buildCounterPlayerLeaderboardScore++;
  if (buildCounterPlayerLeaderboardScore < 3) {
    o.kind = "foo";
    o.leaderboardId = "foo";
    o.publicRank = buildLeaderboardScoreRank();
    o.scoreString = "foo";
    o.scoreTag = "foo";
    o.scoreValue = "foo";
    o.socialRank = buildLeaderboardScoreRank();
    o.timeSpan = "foo";
    o.writeTimestamp = "foo";
  }
  buildCounterPlayerLeaderboardScore--;
  return o;
}

checkPlayerLeaderboardScore(api.PlayerLeaderboardScore o) {
  buildCounterPlayerLeaderboardScore++;
  if (buildCounterPlayerLeaderboardScore < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.leaderboardId, unittest.equals('foo'));
    checkLeaderboardScoreRank(o.publicRank);
    unittest.expect(o.scoreString, unittest.equals('foo'));
    unittest.expect(o.scoreTag, unittest.equals('foo'));
    unittest.expect(o.scoreValue, unittest.equals('foo'));
    checkLeaderboardScoreRank(o.socialRank);
    unittest.expect(o.timeSpan, unittest.equals('foo'));
    unittest.expect(o.writeTimestamp, unittest.equals('foo'));
  }
  buildCounterPlayerLeaderboardScore--;
}

buildUnnamed53() {
  var o = new core.List<api.PlayerLeaderboardScore>();
  o.add(buildPlayerLeaderboardScore());
  o.add(buildPlayerLeaderboardScore());
  return o;
}

checkUnnamed53(core.List<api.PlayerLeaderboardScore> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPlayerLeaderboardScore(o[0]);
  checkPlayerLeaderboardScore(o[1]);
}

core.int buildCounterPlayerLeaderboardScoreListResponse = 0;
buildPlayerLeaderboardScoreListResponse() {
  var o = new api.PlayerLeaderboardScoreListResponse();
  buildCounterPlayerLeaderboardScoreListResponse++;
  if (buildCounterPlayerLeaderboardScoreListResponse < 3) {
    o.items = buildUnnamed53();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.player = buildPlayer();
  }
  buildCounterPlayerLeaderboardScoreListResponse--;
  return o;
}

checkPlayerLeaderboardScoreListResponse(api.PlayerLeaderboardScoreListResponse o) {
  buildCounterPlayerLeaderboardScoreListResponse++;
  if (buildCounterPlayerLeaderboardScoreListResponse < 3) {
    checkUnnamed53(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkPlayer(o.player);
  }
  buildCounterPlayerLeaderboardScoreListResponse--;
}

core.int buildCounterPlayerLevel = 0;
buildPlayerLevel() {
  var o = new api.PlayerLevel();
  buildCounterPlayerLevel++;
  if (buildCounterPlayerLevel < 3) {
    o.kind = "foo";
    o.level = 42;
    o.maxExperiencePoints = "foo";
    o.minExperiencePoints = "foo";
  }
  buildCounterPlayerLevel--;
  return o;
}

checkPlayerLevel(api.PlayerLevel o) {
  buildCounterPlayerLevel++;
  if (buildCounterPlayerLevel < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.level, unittest.equals(42));
    unittest.expect(o.maxExperiencePoints, unittest.equals('foo'));
    unittest.expect(o.minExperiencePoints, unittest.equals('foo'));
  }
  buildCounterPlayerLevel--;
}

buildUnnamed54() {
  var o = new core.List<api.Player>();
  o.add(buildPlayer());
  o.add(buildPlayer());
  return o;
}

checkUnnamed54(core.List<api.Player> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPlayer(o[0]);
  checkPlayer(o[1]);
}

core.int buildCounterPlayerListResponse = 0;
buildPlayerListResponse() {
  var o = new api.PlayerListResponse();
  buildCounterPlayerListResponse++;
  if (buildCounterPlayerListResponse < 3) {
    o.items = buildUnnamed54();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterPlayerListResponse--;
  return o;
}

checkPlayerListResponse(api.PlayerListResponse o) {
  buildCounterPlayerListResponse++;
  if (buildCounterPlayerListResponse < 3) {
    checkUnnamed54(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterPlayerListResponse--;
}

core.int buildCounterPlayerScore = 0;
buildPlayerScore() {
  var o = new api.PlayerScore();
  buildCounterPlayerScore++;
  if (buildCounterPlayerScore < 3) {
    o.formattedScore = "foo";
    o.kind = "foo";
    o.score = "foo";
    o.scoreTag = "foo";
    o.timeSpan = "foo";
  }
  buildCounterPlayerScore--;
  return o;
}

checkPlayerScore(api.PlayerScore o) {
  buildCounterPlayerScore++;
  if (buildCounterPlayerScore < 3) {
    unittest.expect(o.formattedScore, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.score, unittest.equals('foo'));
    unittest.expect(o.scoreTag, unittest.equals('foo'));
    unittest.expect(o.timeSpan, unittest.equals('foo'));
  }
  buildCounterPlayerScore--;
}

buildUnnamed55() {
  var o = new core.List<api.PlayerScoreResponse>();
  o.add(buildPlayerScoreResponse());
  o.add(buildPlayerScoreResponse());
  return o;
}

checkUnnamed55(core.List<api.PlayerScoreResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPlayerScoreResponse(o[0]);
  checkPlayerScoreResponse(o[1]);
}

core.int buildCounterPlayerScoreListResponse = 0;
buildPlayerScoreListResponse() {
  var o = new api.PlayerScoreListResponse();
  buildCounterPlayerScoreListResponse++;
  if (buildCounterPlayerScoreListResponse < 3) {
    o.kind = "foo";
    o.submittedScores = buildUnnamed55();
  }
  buildCounterPlayerScoreListResponse--;
  return o;
}

checkPlayerScoreListResponse(api.PlayerScoreListResponse o) {
  buildCounterPlayerScoreListResponse++;
  if (buildCounterPlayerScoreListResponse < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed55(o.submittedScores);
  }
  buildCounterPlayerScoreListResponse--;
}

buildUnnamed56() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed56(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed57() {
  var o = new core.List<api.PlayerScore>();
  o.add(buildPlayerScore());
  o.add(buildPlayerScore());
  return o;
}

checkUnnamed57(core.List<api.PlayerScore> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPlayerScore(o[0]);
  checkPlayerScore(o[1]);
}

core.int buildCounterPlayerScoreResponse = 0;
buildPlayerScoreResponse() {
  var o = new api.PlayerScoreResponse();
  buildCounterPlayerScoreResponse++;
  if (buildCounterPlayerScoreResponse < 3) {
    o.beatenScoreTimeSpans = buildUnnamed56();
    o.formattedScore = "foo";
    o.kind = "foo";
    o.leaderboardId = "foo";
    o.scoreTag = "foo";
    o.unbeatenScores = buildUnnamed57();
  }
  buildCounterPlayerScoreResponse--;
  return o;
}

checkPlayerScoreResponse(api.PlayerScoreResponse o) {
  buildCounterPlayerScoreResponse++;
  if (buildCounterPlayerScoreResponse < 3) {
    checkUnnamed56(o.beatenScoreTimeSpans);
    unittest.expect(o.formattedScore, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.leaderboardId, unittest.equals('foo'));
    unittest.expect(o.scoreTag, unittest.equals('foo'));
    checkUnnamed57(o.unbeatenScores);
  }
  buildCounterPlayerScoreResponse--;
}

buildUnnamed58() {
  var o = new core.List<api.ScoreSubmission>();
  o.add(buildScoreSubmission());
  o.add(buildScoreSubmission());
  return o;
}

checkUnnamed58(core.List<api.ScoreSubmission> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkScoreSubmission(o[0]);
  checkScoreSubmission(o[1]);
}

core.int buildCounterPlayerScoreSubmissionList = 0;
buildPlayerScoreSubmissionList() {
  var o = new api.PlayerScoreSubmissionList();
  buildCounterPlayerScoreSubmissionList++;
  if (buildCounterPlayerScoreSubmissionList < 3) {
    o.kind = "foo";
    o.scores = buildUnnamed58();
  }
  buildCounterPlayerScoreSubmissionList--;
  return o;
}

checkPlayerScoreSubmissionList(api.PlayerScoreSubmissionList o) {
  buildCounterPlayerScoreSubmissionList++;
  if (buildCounterPlayerScoreSubmissionList < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed58(o.scores);
  }
  buildCounterPlayerScoreSubmissionList--;
}

core.int buildCounterProfileSettings = 0;
buildProfileSettings() {
  var o = new api.ProfileSettings();
  buildCounterProfileSettings++;
  if (buildCounterProfileSettings < 3) {
    o.kind = "foo";
    o.profileVisible = true;
  }
  buildCounterProfileSettings--;
  return o;
}

checkProfileSettings(api.ProfileSettings o) {
  buildCounterProfileSettings++;
  if (buildCounterProfileSettings < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.profileVisible, unittest.isTrue);
  }
  buildCounterProfileSettings--;
}

core.int buildCounterPushToken = 0;
buildPushToken() {
  var o = new api.PushToken();
  buildCounterPushToken++;
  if (buildCounterPushToken < 3) {
    o.clientRevision = "foo";
    o.id = buildPushTokenId();
    o.kind = "foo";
    o.language = "foo";
  }
  buildCounterPushToken--;
  return o;
}

checkPushToken(api.PushToken o) {
  buildCounterPushToken++;
  if (buildCounterPushToken < 3) {
    unittest.expect(o.clientRevision, unittest.equals('foo'));
    checkPushTokenId(o.id);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.language, unittest.equals('foo'));
  }
  buildCounterPushToken--;
}

core.int buildCounterPushTokenIdIos = 0;
buildPushTokenIdIos() {
  var o = new api.PushTokenIdIos();
  buildCounterPushTokenIdIos++;
  if (buildCounterPushTokenIdIos < 3) {
    o.apnsDeviceToken = "foo";
    o.apnsEnvironment = "foo";
  }
  buildCounterPushTokenIdIos--;
  return o;
}

checkPushTokenIdIos(api.PushTokenIdIos o) {
  buildCounterPushTokenIdIos++;
  if (buildCounterPushTokenIdIos < 3) {
    unittest.expect(o.apnsDeviceToken, unittest.equals('foo'));
    unittest.expect(o.apnsEnvironment, unittest.equals('foo'));
  }
  buildCounterPushTokenIdIos--;
}

core.int buildCounterPushTokenId = 0;
buildPushTokenId() {
  var o = new api.PushTokenId();
  buildCounterPushTokenId++;
  if (buildCounterPushTokenId < 3) {
    o.ios = buildPushTokenIdIos();
    o.kind = "foo";
  }
  buildCounterPushTokenId--;
  return o;
}

checkPushTokenId(api.PushTokenId o) {
  buildCounterPushTokenId++;
  if (buildCounterPushTokenId < 3) {
    checkPushTokenIdIos(o.ios);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterPushTokenId--;
}

buildUnnamed59() {
  var o = new core.List<api.QuestMilestone>();
  o.add(buildQuestMilestone());
  o.add(buildQuestMilestone());
  return o;
}

checkUnnamed59(core.List<api.QuestMilestone> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkQuestMilestone(o[0]);
  checkQuestMilestone(o[1]);
}

core.int buildCounterQuest = 0;
buildQuest() {
  var o = new api.Quest();
  buildCounterQuest++;
  if (buildCounterQuest < 3) {
    o.acceptedTimestampMillis = "foo";
    o.applicationId = "foo";
    o.bannerUrl = "foo";
    o.description = "foo";
    o.endTimestampMillis = "foo";
    o.iconUrl = "foo";
    o.id = "foo";
    o.isDefaultBannerUrl = true;
    o.isDefaultIconUrl = true;
    o.kind = "foo";
    o.lastUpdatedTimestampMillis = "foo";
    o.milestones = buildUnnamed59();
    o.name = "foo";
    o.notifyTimestampMillis = "foo";
    o.startTimestampMillis = "foo";
    o.state = "foo";
  }
  buildCounterQuest--;
  return o;
}

checkQuest(api.Quest o) {
  buildCounterQuest++;
  if (buildCounterQuest < 3) {
    unittest.expect(o.acceptedTimestampMillis, unittest.equals('foo'));
    unittest.expect(o.applicationId, unittest.equals('foo'));
    unittest.expect(o.bannerUrl, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.endTimestampMillis, unittest.equals('foo'));
    unittest.expect(o.iconUrl, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.isDefaultBannerUrl, unittest.isTrue);
    unittest.expect(o.isDefaultIconUrl, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.lastUpdatedTimestampMillis, unittest.equals('foo'));
    checkUnnamed59(o.milestones);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.notifyTimestampMillis, unittest.equals('foo'));
    unittest.expect(o.startTimestampMillis, unittest.equals('foo'));
    unittest.expect(o.state, unittest.equals('foo'));
  }
  buildCounterQuest--;
}

core.int buildCounterQuestContribution = 0;
buildQuestContribution() {
  var o = new api.QuestContribution();
  buildCounterQuestContribution++;
  if (buildCounterQuestContribution < 3) {
    o.formattedValue = "foo";
    o.kind = "foo";
    o.value = "foo";
  }
  buildCounterQuestContribution--;
  return o;
}

checkQuestContribution(api.QuestContribution o) {
  buildCounterQuestContribution++;
  if (buildCounterQuestContribution < 3) {
    unittest.expect(o.formattedValue, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterQuestContribution--;
}

core.int buildCounterQuestCriterion = 0;
buildQuestCriterion() {
  var o = new api.QuestCriterion();
  buildCounterQuestCriterion++;
  if (buildCounterQuestCriterion < 3) {
    o.completionContribution = buildQuestContribution();
    o.currentContribution = buildQuestContribution();
    o.eventId = "foo";
    o.initialPlayerProgress = buildQuestContribution();
    o.kind = "foo";
  }
  buildCounterQuestCriterion--;
  return o;
}

checkQuestCriterion(api.QuestCriterion o) {
  buildCounterQuestCriterion++;
  if (buildCounterQuestCriterion < 3) {
    checkQuestContribution(o.completionContribution);
    checkQuestContribution(o.currentContribution);
    unittest.expect(o.eventId, unittest.equals('foo'));
    checkQuestContribution(o.initialPlayerProgress);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterQuestCriterion--;
}

buildUnnamed60() {
  var o = new core.List<api.Quest>();
  o.add(buildQuest());
  o.add(buildQuest());
  return o;
}

checkUnnamed60(core.List<api.Quest> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkQuest(o[0]);
  checkQuest(o[1]);
}

core.int buildCounterQuestListResponse = 0;
buildQuestListResponse() {
  var o = new api.QuestListResponse();
  buildCounterQuestListResponse++;
  if (buildCounterQuestListResponse < 3) {
    o.items = buildUnnamed60();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterQuestListResponse--;
  return o;
}

checkQuestListResponse(api.QuestListResponse o) {
  buildCounterQuestListResponse++;
  if (buildCounterQuestListResponse < 3) {
    checkUnnamed60(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterQuestListResponse--;
}

buildUnnamed61() {
  var o = new core.List<api.QuestCriterion>();
  o.add(buildQuestCriterion());
  o.add(buildQuestCriterion());
  return o;
}

checkUnnamed61(core.List<api.QuestCriterion> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkQuestCriterion(o[0]);
  checkQuestCriterion(o[1]);
}

core.int buildCounterQuestMilestone = 0;
buildQuestMilestone() {
  var o = new api.QuestMilestone();
  buildCounterQuestMilestone++;
  if (buildCounterQuestMilestone < 3) {
    o.completionRewardData = "foo";
    o.criteria = buildUnnamed61();
    o.id = "foo";
    o.kind = "foo";
    o.state = "foo";
  }
  buildCounterQuestMilestone--;
  return o;
}

checkQuestMilestone(api.QuestMilestone o) {
  buildCounterQuestMilestone++;
  if (buildCounterQuestMilestone < 3) {
    unittest.expect(o.completionRewardData, unittest.equals('foo'));
    checkUnnamed61(o.criteria);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.state, unittest.equals('foo'));
  }
  buildCounterQuestMilestone--;
}

core.int buildCounterRevisionCheckResponse = 0;
buildRevisionCheckResponse() {
  var o = new api.RevisionCheckResponse();
  buildCounterRevisionCheckResponse++;
  if (buildCounterRevisionCheckResponse < 3) {
    o.apiVersion = "foo";
    o.kind = "foo";
    o.revisionStatus = "foo";
  }
  buildCounterRevisionCheckResponse--;
  return o;
}

checkRevisionCheckResponse(api.RevisionCheckResponse o) {
  buildCounterRevisionCheckResponse++;
  if (buildCounterRevisionCheckResponse < 3) {
    unittest.expect(o.apiVersion, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.revisionStatus, unittest.equals('foo'));
  }
  buildCounterRevisionCheckResponse--;
}

buildUnnamed62() {
  var o = new core.List<api.RoomParticipant>();
  o.add(buildRoomParticipant());
  o.add(buildRoomParticipant());
  return o;
}

checkUnnamed62(core.List<api.RoomParticipant> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRoomParticipant(o[0]);
  checkRoomParticipant(o[1]);
}

core.int buildCounterRoom = 0;
buildRoom() {
  var o = new api.Room();
  buildCounterRoom++;
  if (buildCounterRoom < 3) {
    o.applicationId = "foo";
    o.autoMatchingCriteria = buildRoomAutoMatchingCriteria();
    o.autoMatchingStatus = buildRoomAutoMatchStatus();
    o.creationDetails = buildRoomModification();
    o.description = "foo";
    o.inviterId = "foo";
    o.kind = "foo";
    o.lastUpdateDetails = buildRoomModification();
    o.participants = buildUnnamed62();
    o.roomId = "foo";
    o.roomStatusVersion = 42;
    o.status = "foo";
    o.variant = 42;
  }
  buildCounterRoom--;
  return o;
}

checkRoom(api.Room o) {
  buildCounterRoom++;
  if (buildCounterRoom < 3) {
    unittest.expect(o.applicationId, unittest.equals('foo'));
    checkRoomAutoMatchingCriteria(o.autoMatchingCriteria);
    checkRoomAutoMatchStatus(o.autoMatchingStatus);
    checkRoomModification(o.creationDetails);
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.inviterId, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkRoomModification(o.lastUpdateDetails);
    checkUnnamed62(o.participants);
    unittest.expect(o.roomId, unittest.equals('foo'));
    unittest.expect(o.roomStatusVersion, unittest.equals(42));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.variant, unittest.equals(42));
  }
  buildCounterRoom--;
}

core.int buildCounterRoomAutoMatchStatus = 0;
buildRoomAutoMatchStatus() {
  var o = new api.RoomAutoMatchStatus();
  buildCounterRoomAutoMatchStatus++;
  if (buildCounterRoomAutoMatchStatus < 3) {
    o.kind = "foo";
    o.waitEstimateSeconds = 42;
  }
  buildCounterRoomAutoMatchStatus--;
  return o;
}

checkRoomAutoMatchStatus(api.RoomAutoMatchStatus o) {
  buildCounterRoomAutoMatchStatus++;
  if (buildCounterRoomAutoMatchStatus < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.waitEstimateSeconds, unittest.equals(42));
  }
  buildCounterRoomAutoMatchStatus--;
}

core.int buildCounterRoomAutoMatchingCriteria = 0;
buildRoomAutoMatchingCriteria() {
  var o = new api.RoomAutoMatchingCriteria();
  buildCounterRoomAutoMatchingCriteria++;
  if (buildCounterRoomAutoMatchingCriteria < 3) {
    o.exclusiveBitmask = "foo";
    o.kind = "foo";
    o.maxAutoMatchingPlayers = 42;
    o.minAutoMatchingPlayers = 42;
  }
  buildCounterRoomAutoMatchingCriteria--;
  return o;
}

checkRoomAutoMatchingCriteria(api.RoomAutoMatchingCriteria o) {
  buildCounterRoomAutoMatchingCriteria++;
  if (buildCounterRoomAutoMatchingCriteria < 3) {
    unittest.expect(o.exclusiveBitmask, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.maxAutoMatchingPlayers, unittest.equals(42));
    unittest.expect(o.minAutoMatchingPlayers, unittest.equals(42));
  }
  buildCounterRoomAutoMatchingCriteria--;
}

core.int buildCounterRoomClientAddress = 0;
buildRoomClientAddress() {
  var o = new api.RoomClientAddress();
  buildCounterRoomClientAddress++;
  if (buildCounterRoomClientAddress < 3) {
    o.kind = "foo";
    o.xmppAddress = "foo";
  }
  buildCounterRoomClientAddress--;
  return o;
}

checkRoomClientAddress(api.RoomClientAddress o) {
  buildCounterRoomClientAddress++;
  if (buildCounterRoomClientAddress < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.xmppAddress, unittest.equals('foo'));
  }
  buildCounterRoomClientAddress--;
}

buildUnnamed63() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed63(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed64() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed64(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterRoomCreateRequest = 0;
buildRoomCreateRequest() {
  var o = new api.RoomCreateRequest();
  buildCounterRoomCreateRequest++;
  if (buildCounterRoomCreateRequest < 3) {
    o.autoMatchingCriteria = buildRoomAutoMatchingCriteria();
    o.capabilities = buildUnnamed63();
    o.clientAddress = buildRoomClientAddress();
    o.invitedPlayerIds = buildUnnamed64();
    o.kind = "foo";
    o.networkDiagnostics = buildNetworkDiagnostics();
    o.requestId = "foo";
    o.variant = 42;
  }
  buildCounterRoomCreateRequest--;
  return o;
}

checkRoomCreateRequest(api.RoomCreateRequest o) {
  buildCounterRoomCreateRequest++;
  if (buildCounterRoomCreateRequest < 3) {
    checkRoomAutoMatchingCriteria(o.autoMatchingCriteria);
    checkUnnamed63(o.capabilities);
    checkRoomClientAddress(o.clientAddress);
    checkUnnamed64(o.invitedPlayerIds);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkNetworkDiagnostics(o.networkDiagnostics);
    unittest.expect(o.requestId, unittest.equals('foo'));
    unittest.expect(o.variant, unittest.equals(42));
  }
  buildCounterRoomCreateRequest--;
}

buildUnnamed65() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed65(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterRoomJoinRequest = 0;
buildRoomJoinRequest() {
  var o = new api.RoomJoinRequest();
  buildCounterRoomJoinRequest++;
  if (buildCounterRoomJoinRequest < 3) {
    o.capabilities = buildUnnamed65();
    o.clientAddress = buildRoomClientAddress();
    o.kind = "foo";
    o.networkDiagnostics = buildNetworkDiagnostics();
  }
  buildCounterRoomJoinRequest--;
  return o;
}

checkRoomJoinRequest(api.RoomJoinRequest o) {
  buildCounterRoomJoinRequest++;
  if (buildCounterRoomJoinRequest < 3) {
    checkUnnamed65(o.capabilities);
    checkRoomClientAddress(o.clientAddress);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkNetworkDiagnostics(o.networkDiagnostics);
  }
  buildCounterRoomJoinRequest--;
}

buildUnnamed66() {
  var o = new core.List<api.PeerSessionDiagnostics>();
  o.add(buildPeerSessionDiagnostics());
  o.add(buildPeerSessionDiagnostics());
  return o;
}

checkUnnamed66(core.List<api.PeerSessionDiagnostics> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPeerSessionDiagnostics(o[0]);
  checkPeerSessionDiagnostics(o[1]);
}

core.int buildCounterRoomLeaveDiagnostics = 0;
buildRoomLeaveDiagnostics() {
  var o = new api.RoomLeaveDiagnostics();
  buildCounterRoomLeaveDiagnostics++;
  if (buildCounterRoomLeaveDiagnostics < 3) {
    o.androidNetworkSubtype = 42;
    o.androidNetworkType = 42;
    o.iosNetworkType = 42;
    o.kind = "foo";
    o.networkOperatorCode = "foo";
    o.networkOperatorName = "foo";
    o.peerSession = buildUnnamed66();
    o.socketsUsed = true;
  }
  buildCounterRoomLeaveDiagnostics--;
  return o;
}

checkRoomLeaveDiagnostics(api.RoomLeaveDiagnostics o) {
  buildCounterRoomLeaveDiagnostics++;
  if (buildCounterRoomLeaveDiagnostics < 3) {
    unittest.expect(o.androidNetworkSubtype, unittest.equals(42));
    unittest.expect(o.androidNetworkType, unittest.equals(42));
    unittest.expect(o.iosNetworkType, unittest.equals(42));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.networkOperatorCode, unittest.equals('foo'));
    unittest.expect(o.networkOperatorName, unittest.equals('foo'));
    checkUnnamed66(o.peerSession);
    unittest.expect(o.socketsUsed, unittest.isTrue);
  }
  buildCounterRoomLeaveDiagnostics--;
}

core.int buildCounterRoomLeaveRequest = 0;
buildRoomLeaveRequest() {
  var o = new api.RoomLeaveRequest();
  buildCounterRoomLeaveRequest++;
  if (buildCounterRoomLeaveRequest < 3) {
    o.kind = "foo";
    o.leaveDiagnostics = buildRoomLeaveDiagnostics();
    o.reason = "foo";
  }
  buildCounterRoomLeaveRequest--;
  return o;
}

checkRoomLeaveRequest(api.RoomLeaveRequest o) {
  buildCounterRoomLeaveRequest++;
  if (buildCounterRoomLeaveRequest < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkRoomLeaveDiagnostics(o.leaveDiagnostics);
    unittest.expect(o.reason, unittest.equals('foo'));
  }
  buildCounterRoomLeaveRequest--;
}

buildUnnamed67() {
  var o = new core.List<api.Room>();
  o.add(buildRoom());
  o.add(buildRoom());
  return o;
}

checkUnnamed67(core.List<api.Room> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRoom(o[0]);
  checkRoom(o[1]);
}

core.int buildCounterRoomList = 0;
buildRoomList() {
  var o = new api.RoomList();
  buildCounterRoomList++;
  if (buildCounterRoomList < 3) {
    o.items = buildUnnamed67();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterRoomList--;
  return o;
}

checkRoomList(api.RoomList o) {
  buildCounterRoomList++;
  if (buildCounterRoomList < 3) {
    checkUnnamed67(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterRoomList--;
}

core.int buildCounterRoomModification = 0;
buildRoomModification() {
  var o = new api.RoomModification();
  buildCounterRoomModification++;
  if (buildCounterRoomModification < 3) {
    o.kind = "foo";
    o.modifiedTimestampMillis = "foo";
    o.participantId = "foo";
  }
  buildCounterRoomModification--;
  return o;
}

checkRoomModification(api.RoomModification o) {
  buildCounterRoomModification++;
  if (buildCounterRoomModification < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.modifiedTimestampMillis, unittest.equals('foo'));
    unittest.expect(o.participantId, unittest.equals('foo'));
  }
  buildCounterRoomModification--;
}

core.int buildCounterRoomP2PStatus = 0;
buildRoomP2PStatus() {
  var o = new api.RoomP2PStatus();
  buildCounterRoomP2PStatus++;
  if (buildCounterRoomP2PStatus < 3) {
    o.connectionSetupLatencyMillis = 42;
    o.error = "foo";
    o.errorReason = "foo";
    o.kind = "foo";
    o.participantId = "foo";
    o.status = "foo";
    o.unreliableRoundtripLatencyMillis = 42;
  }
  buildCounterRoomP2PStatus--;
  return o;
}

checkRoomP2PStatus(api.RoomP2PStatus o) {
  buildCounterRoomP2PStatus++;
  if (buildCounterRoomP2PStatus < 3) {
    unittest.expect(o.connectionSetupLatencyMillis, unittest.equals(42));
    unittest.expect(o.error, unittest.equals('foo'));
    unittest.expect(o.errorReason, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.participantId, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.unreliableRoundtripLatencyMillis, unittest.equals(42));
  }
  buildCounterRoomP2PStatus--;
}

buildUnnamed68() {
  var o = new core.List<api.RoomP2PStatus>();
  o.add(buildRoomP2PStatus());
  o.add(buildRoomP2PStatus());
  return o;
}

checkUnnamed68(core.List<api.RoomP2PStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRoomP2PStatus(o[0]);
  checkRoomP2PStatus(o[1]);
}

core.int buildCounterRoomP2PStatuses = 0;
buildRoomP2PStatuses() {
  var o = new api.RoomP2PStatuses();
  buildCounterRoomP2PStatuses++;
  if (buildCounterRoomP2PStatuses < 3) {
    o.kind = "foo";
    o.updates = buildUnnamed68();
  }
  buildCounterRoomP2PStatuses--;
  return o;
}

checkRoomP2PStatuses(api.RoomP2PStatuses o) {
  buildCounterRoomP2PStatuses++;
  if (buildCounterRoomP2PStatuses < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed68(o.updates);
  }
  buildCounterRoomP2PStatuses--;
}

buildUnnamed69() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed69(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterRoomParticipant = 0;
buildRoomParticipant() {
  var o = new api.RoomParticipant();
  buildCounterRoomParticipant++;
  if (buildCounterRoomParticipant < 3) {
    o.autoMatched = true;
    o.autoMatchedPlayer = buildAnonymousPlayer();
    o.capabilities = buildUnnamed69();
    o.clientAddress = buildRoomClientAddress();
    o.connected = true;
    o.id = "foo";
    o.kind = "foo";
    o.leaveReason = "foo";
    o.player = buildPlayer();
    o.status = "foo";
  }
  buildCounterRoomParticipant--;
  return o;
}

checkRoomParticipant(api.RoomParticipant o) {
  buildCounterRoomParticipant++;
  if (buildCounterRoomParticipant < 3) {
    unittest.expect(o.autoMatched, unittest.isTrue);
    checkAnonymousPlayer(o.autoMatchedPlayer);
    checkUnnamed69(o.capabilities);
    checkRoomClientAddress(o.clientAddress);
    unittest.expect(o.connected, unittest.isTrue);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.leaveReason, unittest.equals('foo'));
    checkPlayer(o.player);
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterRoomParticipant--;
}

buildUnnamed70() {
  var o = new core.List<api.RoomParticipant>();
  o.add(buildRoomParticipant());
  o.add(buildRoomParticipant());
  return o;
}

checkUnnamed70(core.List<api.RoomParticipant> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkRoomParticipant(o[0]);
  checkRoomParticipant(o[1]);
}

core.int buildCounterRoomStatus = 0;
buildRoomStatus() {
  var o = new api.RoomStatus();
  buildCounterRoomStatus++;
  if (buildCounterRoomStatus < 3) {
    o.autoMatchingStatus = buildRoomAutoMatchStatus();
    o.kind = "foo";
    o.participants = buildUnnamed70();
    o.roomId = "foo";
    o.status = "foo";
    o.statusVersion = 42;
  }
  buildCounterRoomStatus--;
  return o;
}

checkRoomStatus(api.RoomStatus o) {
  buildCounterRoomStatus++;
  if (buildCounterRoomStatus < 3) {
    checkRoomAutoMatchStatus(o.autoMatchingStatus);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed70(o.participants);
    unittest.expect(o.roomId, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.statusVersion, unittest.equals(42));
  }
  buildCounterRoomStatus--;
}

core.int buildCounterScoreSubmission = 0;
buildScoreSubmission() {
  var o = new api.ScoreSubmission();
  buildCounterScoreSubmission++;
  if (buildCounterScoreSubmission < 3) {
    o.kind = "foo";
    o.leaderboardId = "foo";
    o.score = "foo";
    o.scoreTag = "foo";
    o.signature = "foo";
  }
  buildCounterScoreSubmission--;
  return o;
}

checkScoreSubmission(api.ScoreSubmission o) {
  buildCounterScoreSubmission++;
  if (buildCounterScoreSubmission < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.leaderboardId, unittest.equals('foo'));
    unittest.expect(o.score, unittest.equals('foo'));
    unittest.expect(o.scoreTag, unittest.equals('foo'));
    unittest.expect(o.signature, unittest.equals('foo'));
  }
  buildCounterScoreSubmission--;
}

core.int buildCounterSnapshot = 0;
buildSnapshot() {
  var o = new api.Snapshot();
  buildCounterSnapshot++;
  if (buildCounterSnapshot < 3) {
    o.coverImage = buildSnapshotImage();
    o.description = "foo";
    o.driveId = "foo";
    o.durationMillis = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.lastModifiedMillis = "foo";
    o.progressValue = "foo";
    o.title = "foo";
    o.type = "foo";
    o.uniqueName = "foo";
  }
  buildCounterSnapshot--;
  return o;
}

checkSnapshot(api.Snapshot o) {
  buildCounterSnapshot++;
  if (buildCounterSnapshot < 3) {
    checkSnapshotImage(o.coverImage);
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.driveId, unittest.equals('foo'));
    unittest.expect(o.durationMillis, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.lastModifiedMillis, unittest.equals('foo'));
    unittest.expect(o.progressValue, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.uniqueName, unittest.equals('foo'));
  }
  buildCounterSnapshot--;
}

core.int buildCounterSnapshotImage = 0;
buildSnapshotImage() {
  var o = new api.SnapshotImage();
  buildCounterSnapshotImage++;
  if (buildCounterSnapshotImage < 3) {
    o.height = 42;
    o.kind = "foo";
    o.mimeType = "foo";
    o.url = "foo";
    o.width = 42;
  }
  buildCounterSnapshotImage--;
  return o;
}

checkSnapshotImage(api.SnapshotImage o) {
  buildCounterSnapshotImage++;
  if (buildCounterSnapshotImage < 3) {
    unittest.expect(o.height, unittest.equals(42));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.mimeType, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterSnapshotImage--;
}

buildUnnamed71() {
  var o = new core.List<api.Snapshot>();
  o.add(buildSnapshot());
  o.add(buildSnapshot());
  return o;
}

checkUnnamed71(core.List<api.Snapshot> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSnapshot(o[0]);
  checkSnapshot(o[1]);
}

core.int buildCounterSnapshotListResponse = 0;
buildSnapshotListResponse() {
  var o = new api.SnapshotListResponse();
  buildCounterSnapshotListResponse++;
  if (buildCounterSnapshotListResponse < 3) {
    o.items = buildUnnamed71();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterSnapshotListResponse--;
  return o;
}

checkSnapshotListResponse(api.SnapshotListResponse o) {
  buildCounterSnapshotListResponse++;
  if (buildCounterSnapshotListResponse < 3) {
    checkUnnamed71(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterSnapshotListResponse--;
}

core.int buildCounterTurnBasedAutoMatchingCriteria = 0;
buildTurnBasedAutoMatchingCriteria() {
  var o = new api.TurnBasedAutoMatchingCriteria();
  buildCounterTurnBasedAutoMatchingCriteria++;
  if (buildCounterTurnBasedAutoMatchingCriteria < 3) {
    o.exclusiveBitmask = "foo";
    o.kind = "foo";
    o.maxAutoMatchingPlayers = 42;
    o.minAutoMatchingPlayers = 42;
  }
  buildCounterTurnBasedAutoMatchingCriteria--;
  return o;
}

checkTurnBasedAutoMatchingCriteria(api.TurnBasedAutoMatchingCriteria o) {
  buildCounterTurnBasedAutoMatchingCriteria++;
  if (buildCounterTurnBasedAutoMatchingCriteria < 3) {
    unittest.expect(o.exclusiveBitmask, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.maxAutoMatchingPlayers, unittest.equals(42));
    unittest.expect(o.minAutoMatchingPlayers, unittest.equals(42));
  }
  buildCounterTurnBasedAutoMatchingCriteria--;
}

buildUnnamed72() {
  var o = new core.List<api.TurnBasedMatchParticipant>();
  o.add(buildTurnBasedMatchParticipant());
  o.add(buildTurnBasedMatchParticipant());
  return o;
}

checkUnnamed72(core.List<api.TurnBasedMatchParticipant> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTurnBasedMatchParticipant(o[0]);
  checkTurnBasedMatchParticipant(o[1]);
}

buildUnnamed73() {
  var o = new core.List<api.ParticipantResult>();
  o.add(buildParticipantResult());
  o.add(buildParticipantResult());
  return o;
}

checkUnnamed73(core.List<api.ParticipantResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkParticipantResult(o[0]);
  checkParticipantResult(o[1]);
}

core.int buildCounterTurnBasedMatch = 0;
buildTurnBasedMatch() {
  var o = new api.TurnBasedMatch();
  buildCounterTurnBasedMatch++;
  if (buildCounterTurnBasedMatch < 3) {
    o.applicationId = "foo";
    o.autoMatchingCriteria = buildTurnBasedAutoMatchingCriteria();
    o.creationDetails = buildTurnBasedMatchModification();
    o.data = buildTurnBasedMatchData();
    o.description = "foo";
    o.inviterId = "foo";
    o.kind = "foo";
    o.lastUpdateDetails = buildTurnBasedMatchModification();
    o.matchId = "foo";
    o.matchNumber = 42;
    o.matchVersion = 42;
    o.participants = buildUnnamed72();
    o.pendingParticipantId = "foo";
    o.previousMatchData = buildTurnBasedMatchData();
    o.rematchId = "foo";
    o.results = buildUnnamed73();
    o.status = "foo";
    o.userMatchStatus = "foo";
    o.variant = 42;
    o.withParticipantId = "foo";
  }
  buildCounterTurnBasedMatch--;
  return o;
}

checkTurnBasedMatch(api.TurnBasedMatch o) {
  buildCounterTurnBasedMatch++;
  if (buildCounterTurnBasedMatch < 3) {
    unittest.expect(o.applicationId, unittest.equals('foo'));
    checkTurnBasedAutoMatchingCriteria(o.autoMatchingCriteria);
    checkTurnBasedMatchModification(o.creationDetails);
    checkTurnBasedMatchData(o.data);
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.inviterId, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkTurnBasedMatchModification(o.lastUpdateDetails);
    unittest.expect(o.matchId, unittest.equals('foo'));
    unittest.expect(o.matchNumber, unittest.equals(42));
    unittest.expect(o.matchVersion, unittest.equals(42));
    checkUnnamed72(o.participants);
    unittest.expect(o.pendingParticipantId, unittest.equals('foo'));
    checkTurnBasedMatchData(o.previousMatchData);
    unittest.expect(o.rematchId, unittest.equals('foo'));
    checkUnnamed73(o.results);
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.userMatchStatus, unittest.equals('foo'));
    unittest.expect(o.variant, unittest.equals(42));
    unittest.expect(o.withParticipantId, unittest.equals('foo'));
  }
  buildCounterTurnBasedMatch--;
}

buildUnnamed74() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed74(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterTurnBasedMatchCreateRequest = 0;
buildTurnBasedMatchCreateRequest() {
  var o = new api.TurnBasedMatchCreateRequest();
  buildCounterTurnBasedMatchCreateRequest++;
  if (buildCounterTurnBasedMatchCreateRequest < 3) {
    o.autoMatchingCriteria = buildTurnBasedAutoMatchingCriteria();
    o.invitedPlayerIds = buildUnnamed74();
    o.kind = "foo";
    o.requestId = "foo";
    o.variant = 42;
  }
  buildCounterTurnBasedMatchCreateRequest--;
  return o;
}

checkTurnBasedMatchCreateRequest(api.TurnBasedMatchCreateRequest o) {
  buildCounterTurnBasedMatchCreateRequest++;
  if (buildCounterTurnBasedMatchCreateRequest < 3) {
    checkTurnBasedAutoMatchingCriteria(o.autoMatchingCriteria);
    checkUnnamed74(o.invitedPlayerIds);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.requestId, unittest.equals('foo'));
    unittest.expect(o.variant, unittest.equals(42));
  }
  buildCounterTurnBasedMatchCreateRequest--;
}

core.int buildCounterTurnBasedMatchData = 0;
buildTurnBasedMatchData() {
  var o = new api.TurnBasedMatchData();
  buildCounterTurnBasedMatchData++;
  if (buildCounterTurnBasedMatchData < 3) {
    o.data = "foo";
    o.dataAvailable = true;
    o.kind = "foo";
  }
  buildCounterTurnBasedMatchData--;
  return o;
}

checkTurnBasedMatchData(api.TurnBasedMatchData o) {
  buildCounterTurnBasedMatchData++;
  if (buildCounterTurnBasedMatchData < 3) {
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.dataAvailable, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterTurnBasedMatchData--;
}

core.int buildCounterTurnBasedMatchDataRequest = 0;
buildTurnBasedMatchDataRequest() {
  var o = new api.TurnBasedMatchDataRequest();
  buildCounterTurnBasedMatchDataRequest++;
  if (buildCounterTurnBasedMatchDataRequest < 3) {
    o.data = "foo";
    o.kind = "foo";
  }
  buildCounterTurnBasedMatchDataRequest--;
  return o;
}

checkTurnBasedMatchDataRequest(api.TurnBasedMatchDataRequest o) {
  buildCounterTurnBasedMatchDataRequest++;
  if (buildCounterTurnBasedMatchDataRequest < 3) {
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterTurnBasedMatchDataRequest--;
}

buildUnnamed75() {
  var o = new core.List<api.TurnBasedMatch>();
  o.add(buildTurnBasedMatch());
  o.add(buildTurnBasedMatch());
  return o;
}

checkUnnamed75(core.List<api.TurnBasedMatch> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTurnBasedMatch(o[0]);
  checkTurnBasedMatch(o[1]);
}

core.int buildCounterTurnBasedMatchList = 0;
buildTurnBasedMatchList() {
  var o = new api.TurnBasedMatchList();
  buildCounterTurnBasedMatchList++;
  if (buildCounterTurnBasedMatchList < 3) {
    o.items = buildUnnamed75();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterTurnBasedMatchList--;
  return o;
}

checkTurnBasedMatchList(api.TurnBasedMatchList o) {
  buildCounterTurnBasedMatchList++;
  if (buildCounterTurnBasedMatchList < 3) {
    checkUnnamed75(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterTurnBasedMatchList--;
}

core.int buildCounterTurnBasedMatchModification = 0;
buildTurnBasedMatchModification() {
  var o = new api.TurnBasedMatchModification();
  buildCounterTurnBasedMatchModification++;
  if (buildCounterTurnBasedMatchModification < 3) {
    o.kind = "foo";
    o.modifiedTimestampMillis = "foo";
    o.participantId = "foo";
  }
  buildCounterTurnBasedMatchModification--;
  return o;
}

checkTurnBasedMatchModification(api.TurnBasedMatchModification o) {
  buildCounterTurnBasedMatchModification++;
  if (buildCounterTurnBasedMatchModification < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.modifiedTimestampMillis, unittest.equals('foo'));
    unittest.expect(o.participantId, unittest.equals('foo'));
  }
  buildCounterTurnBasedMatchModification--;
}

core.int buildCounterTurnBasedMatchParticipant = 0;
buildTurnBasedMatchParticipant() {
  var o = new api.TurnBasedMatchParticipant();
  buildCounterTurnBasedMatchParticipant++;
  if (buildCounterTurnBasedMatchParticipant < 3) {
    o.autoMatched = true;
    o.autoMatchedPlayer = buildAnonymousPlayer();
    o.id = "foo";
    o.kind = "foo";
    o.player = buildPlayer();
    o.status = "foo";
  }
  buildCounterTurnBasedMatchParticipant--;
  return o;
}

checkTurnBasedMatchParticipant(api.TurnBasedMatchParticipant o) {
  buildCounterTurnBasedMatchParticipant++;
  if (buildCounterTurnBasedMatchParticipant < 3) {
    unittest.expect(o.autoMatched, unittest.isTrue);
    checkAnonymousPlayer(o.autoMatchedPlayer);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkPlayer(o.player);
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterTurnBasedMatchParticipant--;
}

core.int buildCounterTurnBasedMatchRematch = 0;
buildTurnBasedMatchRematch() {
  var o = new api.TurnBasedMatchRematch();
  buildCounterTurnBasedMatchRematch++;
  if (buildCounterTurnBasedMatchRematch < 3) {
    o.kind = "foo";
    o.previousMatch = buildTurnBasedMatch();
    o.rematch = buildTurnBasedMatch();
  }
  buildCounterTurnBasedMatchRematch--;
  return o;
}

checkTurnBasedMatchRematch(api.TurnBasedMatchRematch o) {
  buildCounterTurnBasedMatchRematch++;
  if (buildCounterTurnBasedMatchRematch < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkTurnBasedMatch(o.previousMatch);
    checkTurnBasedMatch(o.rematch);
  }
  buildCounterTurnBasedMatchRematch--;
}

buildUnnamed76() {
  var o = new core.List<api.ParticipantResult>();
  o.add(buildParticipantResult());
  o.add(buildParticipantResult());
  return o;
}

checkUnnamed76(core.List<api.ParticipantResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkParticipantResult(o[0]);
  checkParticipantResult(o[1]);
}

core.int buildCounterTurnBasedMatchResults = 0;
buildTurnBasedMatchResults() {
  var o = new api.TurnBasedMatchResults();
  buildCounterTurnBasedMatchResults++;
  if (buildCounterTurnBasedMatchResults < 3) {
    o.data = buildTurnBasedMatchDataRequest();
    o.kind = "foo";
    o.matchVersion = 42;
    o.results = buildUnnamed76();
  }
  buildCounterTurnBasedMatchResults--;
  return o;
}

checkTurnBasedMatchResults(api.TurnBasedMatchResults o) {
  buildCounterTurnBasedMatchResults++;
  if (buildCounterTurnBasedMatchResults < 3) {
    checkTurnBasedMatchDataRequest(o.data);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.matchVersion, unittest.equals(42));
    checkUnnamed76(o.results);
  }
  buildCounterTurnBasedMatchResults--;
}

buildUnnamed77() {
  var o = new core.List<api.TurnBasedMatch>();
  o.add(buildTurnBasedMatch());
  o.add(buildTurnBasedMatch());
  return o;
}

checkUnnamed77(core.List<api.TurnBasedMatch> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTurnBasedMatch(o[0]);
  checkTurnBasedMatch(o[1]);
}

core.int buildCounterTurnBasedMatchSync = 0;
buildTurnBasedMatchSync() {
  var o = new api.TurnBasedMatchSync();
  buildCounterTurnBasedMatchSync++;
  if (buildCounterTurnBasedMatchSync < 3) {
    o.items = buildUnnamed77();
    o.kind = "foo";
    o.moreAvailable = true;
    o.nextPageToken = "foo";
  }
  buildCounterTurnBasedMatchSync--;
  return o;
}

checkTurnBasedMatchSync(api.TurnBasedMatchSync o) {
  buildCounterTurnBasedMatchSync++;
  if (buildCounterTurnBasedMatchSync < 3) {
    checkUnnamed77(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.moreAvailable, unittest.isTrue);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterTurnBasedMatchSync--;
}

buildUnnamed78() {
  var o = new core.List<api.ParticipantResult>();
  o.add(buildParticipantResult());
  o.add(buildParticipantResult());
  return o;
}

checkUnnamed78(core.List<api.ParticipantResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkParticipantResult(o[0]);
  checkParticipantResult(o[1]);
}

core.int buildCounterTurnBasedMatchTurn = 0;
buildTurnBasedMatchTurn() {
  var o = new api.TurnBasedMatchTurn();
  buildCounterTurnBasedMatchTurn++;
  if (buildCounterTurnBasedMatchTurn < 3) {
    o.data = buildTurnBasedMatchDataRequest();
    o.kind = "foo";
    o.matchVersion = 42;
    o.pendingParticipantId = "foo";
    o.results = buildUnnamed78();
  }
  buildCounterTurnBasedMatchTurn--;
  return o;
}

checkTurnBasedMatchTurn(api.TurnBasedMatchTurn o) {
  buildCounterTurnBasedMatchTurn++;
  if (buildCounterTurnBasedMatchTurn < 3) {
    checkTurnBasedMatchDataRequest(o.data);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.matchVersion, unittest.equals(42));
    unittest.expect(o.pendingParticipantId, unittest.equals('foo'));
    checkUnnamed78(o.results);
  }
  buildCounterTurnBasedMatchTurn--;
}


main() {
  unittest.group("obj-schema-AchievementDefinition", () {
    unittest.test("to-json--from-json", () {
      var o = buildAchievementDefinition();
      var od = new api.AchievementDefinition.fromJson(o.toJson());
      checkAchievementDefinition(od);
    });
  });


  unittest.group("obj-schema-AchievementDefinitionsListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAchievementDefinitionsListResponse();
      var od = new api.AchievementDefinitionsListResponse.fromJson(o.toJson());
      checkAchievementDefinitionsListResponse(od);
    });
  });


  unittest.group("obj-schema-AchievementIncrementResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAchievementIncrementResponse();
      var od = new api.AchievementIncrementResponse.fromJson(o.toJson());
      checkAchievementIncrementResponse(od);
    });
  });


  unittest.group("obj-schema-AchievementRevealResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAchievementRevealResponse();
      var od = new api.AchievementRevealResponse.fromJson(o.toJson());
      checkAchievementRevealResponse(od);
    });
  });


  unittest.group("obj-schema-AchievementSetStepsAtLeastResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAchievementSetStepsAtLeastResponse();
      var od = new api.AchievementSetStepsAtLeastResponse.fromJson(o.toJson());
      checkAchievementSetStepsAtLeastResponse(od);
    });
  });


  unittest.group("obj-schema-AchievementUnlockResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAchievementUnlockResponse();
      var od = new api.AchievementUnlockResponse.fromJson(o.toJson());
      checkAchievementUnlockResponse(od);
    });
  });


  unittest.group("obj-schema-AchievementUpdateMultipleRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAchievementUpdateMultipleRequest();
      var od = new api.AchievementUpdateMultipleRequest.fromJson(o.toJson());
      checkAchievementUpdateMultipleRequest(od);
    });
  });


  unittest.group("obj-schema-AchievementUpdateMultipleResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAchievementUpdateMultipleResponse();
      var od = new api.AchievementUpdateMultipleResponse.fromJson(o.toJson());
      checkAchievementUpdateMultipleResponse(od);
    });
  });


  unittest.group("obj-schema-AchievementUpdateRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAchievementUpdateRequest();
      var od = new api.AchievementUpdateRequest.fromJson(o.toJson());
      checkAchievementUpdateRequest(od);
    });
  });


  unittest.group("obj-schema-AchievementUpdateResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAchievementUpdateResponse();
      var od = new api.AchievementUpdateResponse.fromJson(o.toJson());
      checkAchievementUpdateResponse(od);
    });
  });


  unittest.group("obj-schema-AggregateStats", () {
    unittest.test("to-json--from-json", () {
      var o = buildAggregateStats();
      var od = new api.AggregateStats.fromJson(o.toJson());
      checkAggregateStats(od);
    });
  });


  unittest.group("obj-schema-AnonymousPlayer", () {
    unittest.test("to-json--from-json", () {
      var o = buildAnonymousPlayer();
      var od = new api.AnonymousPlayer.fromJson(o.toJson());
      checkAnonymousPlayer(od);
    });
  });


  unittest.group("obj-schema-Application", () {
    unittest.test("to-json--from-json", () {
      var o = buildApplication();
      var od = new api.Application.fromJson(o.toJson());
      checkApplication(od);
    });
  });


  unittest.group("obj-schema-ApplicationCategory", () {
    unittest.test("to-json--from-json", () {
      var o = buildApplicationCategory();
      var od = new api.ApplicationCategory.fromJson(o.toJson());
      checkApplicationCategory(od);
    });
  });


  unittest.group("obj-schema-ApplicationVerifyResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildApplicationVerifyResponse();
      var od = new api.ApplicationVerifyResponse.fromJson(o.toJson());
      checkApplicationVerifyResponse(od);
    });
  });


  unittest.group("obj-schema-Category", () {
    unittest.test("to-json--from-json", () {
      var o = buildCategory();
      var od = new api.Category.fromJson(o.toJson());
      checkCategory(od);
    });
  });


  unittest.group("obj-schema-CategoryListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildCategoryListResponse();
      var od = new api.CategoryListResponse.fromJson(o.toJson());
      checkCategoryListResponse(od);
    });
  });


  unittest.group("obj-schema-EventBatchRecordFailure", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventBatchRecordFailure();
      var od = new api.EventBatchRecordFailure.fromJson(o.toJson());
      checkEventBatchRecordFailure(od);
    });
  });


  unittest.group("obj-schema-EventChild", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventChild();
      var od = new api.EventChild.fromJson(o.toJson());
      checkEventChild(od);
    });
  });


  unittest.group("obj-schema-EventDefinition", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventDefinition();
      var od = new api.EventDefinition.fromJson(o.toJson());
      checkEventDefinition(od);
    });
  });


  unittest.group("obj-schema-EventDefinitionListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventDefinitionListResponse();
      var od = new api.EventDefinitionListResponse.fromJson(o.toJson());
      checkEventDefinitionListResponse(od);
    });
  });


  unittest.group("obj-schema-EventPeriodRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventPeriodRange();
      var od = new api.EventPeriodRange.fromJson(o.toJson());
      checkEventPeriodRange(od);
    });
  });


  unittest.group("obj-schema-EventPeriodUpdate", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventPeriodUpdate();
      var od = new api.EventPeriodUpdate.fromJson(o.toJson());
      checkEventPeriodUpdate(od);
    });
  });


  unittest.group("obj-schema-EventRecordFailure", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventRecordFailure();
      var od = new api.EventRecordFailure.fromJson(o.toJson());
      checkEventRecordFailure(od);
    });
  });


  unittest.group("obj-schema-EventRecordRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventRecordRequest();
      var od = new api.EventRecordRequest.fromJson(o.toJson());
      checkEventRecordRequest(od);
    });
  });


  unittest.group("obj-schema-EventUpdateRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventUpdateRequest();
      var od = new api.EventUpdateRequest.fromJson(o.toJson());
      checkEventUpdateRequest(od);
    });
  });


  unittest.group("obj-schema-EventUpdateResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventUpdateResponse();
      var od = new api.EventUpdateResponse.fromJson(o.toJson());
      checkEventUpdateResponse(od);
    });
  });


  unittest.group("obj-schema-GamesAchievementIncrement", () {
    unittest.test("to-json--from-json", () {
      var o = buildGamesAchievementIncrement();
      var od = new api.GamesAchievementIncrement.fromJson(o.toJson());
      checkGamesAchievementIncrement(od);
    });
  });


  unittest.group("obj-schema-GamesAchievementSetStepsAtLeast", () {
    unittest.test("to-json--from-json", () {
      var o = buildGamesAchievementSetStepsAtLeast();
      var od = new api.GamesAchievementSetStepsAtLeast.fromJson(o.toJson());
      checkGamesAchievementSetStepsAtLeast(od);
    });
  });


  unittest.group("obj-schema-ImageAsset", () {
    unittest.test("to-json--from-json", () {
      var o = buildImageAsset();
      var od = new api.ImageAsset.fromJson(o.toJson());
      checkImageAsset(od);
    });
  });


  unittest.group("obj-schema-Instance", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstance();
      var od = new api.Instance.fromJson(o.toJson());
      checkInstance(od);
    });
  });


  unittest.group("obj-schema-InstanceAndroidDetails", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceAndroidDetails();
      var od = new api.InstanceAndroidDetails.fromJson(o.toJson());
      checkInstanceAndroidDetails(od);
    });
  });


  unittest.group("obj-schema-InstanceIosDetails", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceIosDetails();
      var od = new api.InstanceIosDetails.fromJson(o.toJson());
      checkInstanceIosDetails(od);
    });
  });


  unittest.group("obj-schema-InstanceWebDetails", () {
    unittest.test("to-json--from-json", () {
      var o = buildInstanceWebDetails();
      var od = new api.InstanceWebDetails.fromJson(o.toJson());
      checkInstanceWebDetails(od);
    });
  });


  unittest.group("obj-schema-Leaderboard", () {
    unittest.test("to-json--from-json", () {
      var o = buildLeaderboard();
      var od = new api.Leaderboard.fromJson(o.toJson());
      checkLeaderboard(od);
    });
  });


  unittest.group("obj-schema-LeaderboardEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildLeaderboardEntry();
      var od = new api.LeaderboardEntry.fromJson(o.toJson());
      checkLeaderboardEntry(od);
    });
  });


  unittest.group("obj-schema-LeaderboardListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildLeaderboardListResponse();
      var od = new api.LeaderboardListResponse.fromJson(o.toJson());
      checkLeaderboardListResponse(od);
    });
  });


  unittest.group("obj-schema-LeaderboardScoreRank", () {
    unittest.test("to-json--from-json", () {
      var o = buildLeaderboardScoreRank();
      var od = new api.LeaderboardScoreRank.fromJson(o.toJson());
      checkLeaderboardScoreRank(od);
    });
  });


  unittest.group("obj-schema-LeaderboardScores", () {
    unittest.test("to-json--from-json", () {
      var o = buildLeaderboardScores();
      var od = new api.LeaderboardScores.fromJson(o.toJson());
      checkLeaderboardScores(od);
    });
  });


  unittest.group("obj-schema-MetagameConfig", () {
    unittest.test("to-json--from-json", () {
      var o = buildMetagameConfig();
      var od = new api.MetagameConfig.fromJson(o.toJson());
      checkMetagameConfig(od);
    });
  });


  unittest.group("obj-schema-NetworkDiagnostics", () {
    unittest.test("to-json--from-json", () {
      var o = buildNetworkDiagnostics();
      var od = new api.NetworkDiagnostics.fromJson(o.toJson());
      checkNetworkDiagnostics(od);
    });
  });


  unittest.group("obj-schema-ParticipantResult", () {
    unittest.test("to-json--from-json", () {
      var o = buildParticipantResult();
      var od = new api.ParticipantResult.fromJson(o.toJson());
      checkParticipantResult(od);
    });
  });


  unittest.group("obj-schema-PeerChannelDiagnostics", () {
    unittest.test("to-json--from-json", () {
      var o = buildPeerChannelDiagnostics();
      var od = new api.PeerChannelDiagnostics.fromJson(o.toJson());
      checkPeerChannelDiagnostics(od);
    });
  });


  unittest.group("obj-schema-PeerSessionDiagnostics", () {
    unittest.test("to-json--from-json", () {
      var o = buildPeerSessionDiagnostics();
      var od = new api.PeerSessionDiagnostics.fromJson(o.toJson());
      checkPeerSessionDiagnostics(od);
    });
  });


  unittest.group("obj-schema-Played", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayed();
      var od = new api.Played.fromJson(o.toJson());
      checkPlayed(od);
    });
  });


  unittest.group("obj-schema-PlayerName", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerName();
      var od = new api.PlayerName.fromJson(o.toJson());
      checkPlayerName(od);
    });
  });


  unittest.group("obj-schema-Player", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayer();
      var od = new api.Player.fromJson(o.toJson());
      checkPlayer(od);
    });
  });


  unittest.group("obj-schema-PlayerAchievement", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerAchievement();
      var od = new api.PlayerAchievement.fromJson(o.toJson());
      checkPlayerAchievement(od);
    });
  });


  unittest.group("obj-schema-PlayerAchievementListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerAchievementListResponse();
      var od = new api.PlayerAchievementListResponse.fromJson(o.toJson());
      checkPlayerAchievementListResponse(od);
    });
  });


  unittest.group("obj-schema-PlayerEvent", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerEvent();
      var od = new api.PlayerEvent.fromJson(o.toJson());
      checkPlayerEvent(od);
    });
  });


  unittest.group("obj-schema-PlayerEventListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerEventListResponse();
      var od = new api.PlayerEventListResponse.fromJson(o.toJson());
      checkPlayerEventListResponse(od);
    });
  });


  unittest.group("obj-schema-PlayerExperienceInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerExperienceInfo();
      var od = new api.PlayerExperienceInfo.fromJson(o.toJson());
      checkPlayerExperienceInfo(od);
    });
  });


  unittest.group("obj-schema-PlayerLeaderboardScore", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerLeaderboardScore();
      var od = new api.PlayerLeaderboardScore.fromJson(o.toJson());
      checkPlayerLeaderboardScore(od);
    });
  });


  unittest.group("obj-schema-PlayerLeaderboardScoreListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerLeaderboardScoreListResponse();
      var od = new api.PlayerLeaderboardScoreListResponse.fromJson(o.toJson());
      checkPlayerLeaderboardScoreListResponse(od);
    });
  });


  unittest.group("obj-schema-PlayerLevel", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerLevel();
      var od = new api.PlayerLevel.fromJson(o.toJson());
      checkPlayerLevel(od);
    });
  });


  unittest.group("obj-schema-PlayerListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerListResponse();
      var od = new api.PlayerListResponse.fromJson(o.toJson());
      checkPlayerListResponse(od);
    });
  });


  unittest.group("obj-schema-PlayerScore", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerScore();
      var od = new api.PlayerScore.fromJson(o.toJson());
      checkPlayerScore(od);
    });
  });


  unittest.group("obj-schema-PlayerScoreListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerScoreListResponse();
      var od = new api.PlayerScoreListResponse.fromJson(o.toJson());
      checkPlayerScoreListResponse(od);
    });
  });


  unittest.group("obj-schema-PlayerScoreResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerScoreResponse();
      var od = new api.PlayerScoreResponse.fromJson(o.toJson());
      checkPlayerScoreResponse(od);
    });
  });


  unittest.group("obj-schema-PlayerScoreSubmissionList", () {
    unittest.test("to-json--from-json", () {
      var o = buildPlayerScoreSubmissionList();
      var od = new api.PlayerScoreSubmissionList.fromJson(o.toJson());
      checkPlayerScoreSubmissionList(od);
    });
  });


  unittest.group("obj-schema-ProfileSettings", () {
    unittest.test("to-json--from-json", () {
      var o = buildProfileSettings();
      var od = new api.ProfileSettings.fromJson(o.toJson());
      checkProfileSettings(od);
    });
  });


  unittest.group("obj-schema-PushToken", () {
    unittest.test("to-json--from-json", () {
      var o = buildPushToken();
      var od = new api.PushToken.fromJson(o.toJson());
      checkPushToken(od);
    });
  });


  unittest.group("obj-schema-PushTokenIdIos", () {
    unittest.test("to-json--from-json", () {
      var o = buildPushTokenIdIos();
      var od = new api.PushTokenIdIos.fromJson(o.toJson());
      checkPushTokenIdIos(od);
    });
  });


  unittest.group("obj-schema-PushTokenId", () {
    unittest.test("to-json--from-json", () {
      var o = buildPushTokenId();
      var od = new api.PushTokenId.fromJson(o.toJson());
      checkPushTokenId(od);
    });
  });


  unittest.group("obj-schema-Quest", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuest();
      var od = new api.Quest.fromJson(o.toJson());
      checkQuest(od);
    });
  });


  unittest.group("obj-schema-QuestContribution", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuestContribution();
      var od = new api.QuestContribution.fromJson(o.toJson());
      checkQuestContribution(od);
    });
  });


  unittest.group("obj-schema-QuestCriterion", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuestCriterion();
      var od = new api.QuestCriterion.fromJson(o.toJson());
      checkQuestCriterion(od);
    });
  });


  unittest.group("obj-schema-QuestListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuestListResponse();
      var od = new api.QuestListResponse.fromJson(o.toJson());
      checkQuestListResponse(od);
    });
  });


  unittest.group("obj-schema-QuestMilestone", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuestMilestone();
      var od = new api.QuestMilestone.fromJson(o.toJson());
      checkQuestMilestone(od);
    });
  });


  unittest.group("obj-schema-RevisionCheckResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildRevisionCheckResponse();
      var od = new api.RevisionCheckResponse.fromJson(o.toJson());
      checkRevisionCheckResponse(od);
    });
  });


  unittest.group("obj-schema-Room", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoom();
      var od = new api.Room.fromJson(o.toJson());
      checkRoom(od);
    });
  });


  unittest.group("obj-schema-RoomAutoMatchStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoomAutoMatchStatus();
      var od = new api.RoomAutoMatchStatus.fromJson(o.toJson());
      checkRoomAutoMatchStatus(od);
    });
  });


  unittest.group("obj-schema-RoomAutoMatchingCriteria", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoomAutoMatchingCriteria();
      var od = new api.RoomAutoMatchingCriteria.fromJson(o.toJson());
      checkRoomAutoMatchingCriteria(od);
    });
  });


  unittest.group("obj-schema-RoomClientAddress", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoomClientAddress();
      var od = new api.RoomClientAddress.fromJson(o.toJson());
      checkRoomClientAddress(od);
    });
  });


  unittest.group("obj-schema-RoomCreateRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoomCreateRequest();
      var od = new api.RoomCreateRequest.fromJson(o.toJson());
      checkRoomCreateRequest(od);
    });
  });


  unittest.group("obj-schema-RoomJoinRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoomJoinRequest();
      var od = new api.RoomJoinRequest.fromJson(o.toJson());
      checkRoomJoinRequest(od);
    });
  });


  unittest.group("obj-schema-RoomLeaveDiagnostics", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoomLeaveDiagnostics();
      var od = new api.RoomLeaveDiagnostics.fromJson(o.toJson());
      checkRoomLeaveDiagnostics(od);
    });
  });


  unittest.group("obj-schema-RoomLeaveRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoomLeaveRequest();
      var od = new api.RoomLeaveRequest.fromJson(o.toJson());
      checkRoomLeaveRequest(od);
    });
  });


  unittest.group("obj-schema-RoomList", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoomList();
      var od = new api.RoomList.fromJson(o.toJson());
      checkRoomList(od);
    });
  });


  unittest.group("obj-schema-RoomModification", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoomModification();
      var od = new api.RoomModification.fromJson(o.toJson());
      checkRoomModification(od);
    });
  });


  unittest.group("obj-schema-RoomP2PStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoomP2PStatus();
      var od = new api.RoomP2PStatus.fromJson(o.toJson());
      checkRoomP2PStatus(od);
    });
  });


  unittest.group("obj-schema-RoomP2PStatuses", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoomP2PStatuses();
      var od = new api.RoomP2PStatuses.fromJson(o.toJson());
      checkRoomP2PStatuses(od);
    });
  });


  unittest.group("obj-schema-RoomParticipant", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoomParticipant();
      var od = new api.RoomParticipant.fromJson(o.toJson());
      checkRoomParticipant(od);
    });
  });


  unittest.group("obj-schema-RoomStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildRoomStatus();
      var od = new api.RoomStatus.fromJson(o.toJson());
      checkRoomStatus(od);
    });
  });


  unittest.group("obj-schema-ScoreSubmission", () {
    unittest.test("to-json--from-json", () {
      var o = buildScoreSubmission();
      var od = new api.ScoreSubmission.fromJson(o.toJson());
      checkScoreSubmission(od);
    });
  });


  unittest.group("obj-schema-Snapshot", () {
    unittest.test("to-json--from-json", () {
      var o = buildSnapshot();
      var od = new api.Snapshot.fromJson(o.toJson());
      checkSnapshot(od);
    });
  });


  unittest.group("obj-schema-SnapshotImage", () {
    unittest.test("to-json--from-json", () {
      var o = buildSnapshotImage();
      var od = new api.SnapshotImage.fromJson(o.toJson());
      checkSnapshotImage(od);
    });
  });


  unittest.group("obj-schema-SnapshotListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSnapshotListResponse();
      var od = new api.SnapshotListResponse.fromJson(o.toJson());
      checkSnapshotListResponse(od);
    });
  });


  unittest.group("obj-schema-TurnBasedAutoMatchingCriteria", () {
    unittest.test("to-json--from-json", () {
      var o = buildTurnBasedAutoMatchingCriteria();
      var od = new api.TurnBasedAutoMatchingCriteria.fromJson(o.toJson());
      checkTurnBasedAutoMatchingCriteria(od);
    });
  });


  unittest.group("obj-schema-TurnBasedMatch", () {
    unittest.test("to-json--from-json", () {
      var o = buildTurnBasedMatch();
      var od = new api.TurnBasedMatch.fromJson(o.toJson());
      checkTurnBasedMatch(od);
    });
  });


  unittest.group("obj-schema-TurnBasedMatchCreateRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildTurnBasedMatchCreateRequest();
      var od = new api.TurnBasedMatchCreateRequest.fromJson(o.toJson());
      checkTurnBasedMatchCreateRequest(od);
    });
  });


  unittest.group("obj-schema-TurnBasedMatchData", () {
    unittest.test("to-json--from-json", () {
      var o = buildTurnBasedMatchData();
      var od = new api.TurnBasedMatchData.fromJson(o.toJson());
      checkTurnBasedMatchData(od);
    });
  });


  unittest.group("obj-schema-TurnBasedMatchDataRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildTurnBasedMatchDataRequest();
      var od = new api.TurnBasedMatchDataRequest.fromJson(o.toJson());
      checkTurnBasedMatchDataRequest(od);
    });
  });


  unittest.group("obj-schema-TurnBasedMatchList", () {
    unittest.test("to-json--from-json", () {
      var o = buildTurnBasedMatchList();
      var od = new api.TurnBasedMatchList.fromJson(o.toJson());
      checkTurnBasedMatchList(od);
    });
  });


  unittest.group("obj-schema-TurnBasedMatchModification", () {
    unittest.test("to-json--from-json", () {
      var o = buildTurnBasedMatchModification();
      var od = new api.TurnBasedMatchModification.fromJson(o.toJson());
      checkTurnBasedMatchModification(od);
    });
  });


  unittest.group("obj-schema-TurnBasedMatchParticipant", () {
    unittest.test("to-json--from-json", () {
      var o = buildTurnBasedMatchParticipant();
      var od = new api.TurnBasedMatchParticipant.fromJson(o.toJson());
      checkTurnBasedMatchParticipant(od);
    });
  });


  unittest.group("obj-schema-TurnBasedMatchRematch", () {
    unittest.test("to-json--from-json", () {
      var o = buildTurnBasedMatchRematch();
      var od = new api.TurnBasedMatchRematch.fromJson(o.toJson());
      checkTurnBasedMatchRematch(od);
    });
  });


  unittest.group("obj-schema-TurnBasedMatchResults", () {
    unittest.test("to-json--from-json", () {
      var o = buildTurnBasedMatchResults();
      var od = new api.TurnBasedMatchResults.fromJson(o.toJson());
      checkTurnBasedMatchResults(od);
    });
  });


  unittest.group("obj-schema-TurnBasedMatchSync", () {
    unittest.test("to-json--from-json", () {
      var o = buildTurnBasedMatchSync();
      var od = new api.TurnBasedMatchSync.fromJson(o.toJson());
      checkTurnBasedMatchSync(od);
    });
  });


  unittest.group("obj-schema-TurnBasedMatchTurn", () {
    unittest.test("to-json--from-json", () {
      var o = buildTurnBasedMatchTurn();
      var od = new api.TurnBasedMatchTurn.fromJson(o.toJson());
      checkTurnBasedMatchTurn(od);
    });
  });


  unittest.group("resource-AchievementDefinitionsResourceApi", () {
    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.AchievementDefinitionsResourceApi res = new api.GamesApi(mock).achievementDefinitions;
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("achievements"));
        pathOffset += 12;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAchievementDefinitionsListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(consistencyToken: arg_consistencyToken, language: arg_language, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.AchievementDefinitionsListResponse response) {
        checkAchievementDefinitionsListResponse(response);
      })));
    });

  });


  unittest.group("resource-AchievementsResourceApi", () {
    unittest.test("method--increment", () {

      var mock = new HttpServerMock();
      api.AchievementsResourceApi res = new api.GamesApi(mock).achievements;
      var arg_achievementId = "foo";
      var arg_stepsToIncrement = 42;
      var arg_consistencyToken = "foo";
      var arg_requestId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("achievements/"));
        pathOffset += 13;
        index = path.indexOf("/increment", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_achievementId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/increment"));
        pathOffset += 10;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.int.parse(queryMap["stepsToIncrement"].first), unittest.equals(arg_stepsToIncrement));
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["requestId"].first, unittest.equals(arg_requestId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAchievementIncrementResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.increment(arg_achievementId, arg_stepsToIncrement, consistencyToken: arg_consistencyToken, requestId: arg_requestId).then(unittest.expectAsync(((api.AchievementIncrementResponse response) {
        checkAchievementIncrementResponse(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.AchievementsResourceApi res = new api.GamesApi(mock).achievements;
      var arg_playerId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_state = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("players/"));
        pathOffset += 8;
        index = path.indexOf("/achievements", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_playerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/achievements"));
        pathOffset += 13;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["state"].first, unittest.equals(arg_state));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPlayerAchievementListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_playerId, consistencyToken: arg_consistencyToken, language: arg_language, maxResults: arg_maxResults, pageToken: arg_pageToken, state: arg_state).then(unittest.expectAsync(((api.PlayerAchievementListResponse response) {
        checkPlayerAchievementListResponse(response);
      })));
    });

    unittest.test("method--reveal", () {

      var mock = new HttpServerMock();
      api.AchievementsResourceApi res = new api.GamesApi(mock).achievements;
      var arg_achievementId = "foo";
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("achievements/"));
        pathOffset += 13;
        index = path.indexOf("/reveal", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_achievementId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/reveal"));
        pathOffset += 7;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAchievementRevealResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.reveal(arg_achievementId, consistencyToken: arg_consistencyToken).then(unittest.expectAsync(((api.AchievementRevealResponse response) {
        checkAchievementRevealResponse(response);
      })));
    });

    unittest.test("method--setStepsAtLeast", () {

      var mock = new HttpServerMock();
      api.AchievementsResourceApi res = new api.GamesApi(mock).achievements;
      var arg_achievementId = "foo";
      var arg_steps = 42;
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("achievements/"));
        pathOffset += 13;
        index = path.indexOf("/setStepsAtLeast", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_achievementId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("/setStepsAtLeast"));
        pathOffset += 16;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.int.parse(queryMap["steps"].first), unittest.equals(arg_steps));
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAchievementSetStepsAtLeastResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.setStepsAtLeast(arg_achievementId, arg_steps, consistencyToken: arg_consistencyToken).then(unittest.expectAsync(((api.AchievementSetStepsAtLeastResponse response) {
        checkAchievementSetStepsAtLeastResponse(response);
      })));
    });

    unittest.test("method--unlock", () {

      var mock = new HttpServerMock();
      api.AchievementsResourceApi res = new api.GamesApi(mock).achievements;
      var arg_achievementId = "foo";
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("achievements/"));
        pathOffset += 13;
        index = path.indexOf("/unlock", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_achievementId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/unlock"));
        pathOffset += 7;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAchievementUnlockResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.unlock(arg_achievementId, consistencyToken: arg_consistencyToken).then(unittest.expectAsync(((api.AchievementUnlockResponse response) {
        checkAchievementUnlockResponse(response);
      })));
    });

    unittest.test("method--updateMultiple", () {

      var mock = new HttpServerMock();
      api.AchievementsResourceApi res = new api.GamesApi(mock).achievements;
      var arg_request = buildAchievementUpdateMultipleRequest();
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AchievementUpdateMultipleRequest.fromJson(json);
        checkAchievementUpdateMultipleRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 27), unittest.equals("achievements/updateMultiple"));
        pathOffset += 27;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAchievementUpdateMultipleResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.updateMultiple(arg_request, consistencyToken: arg_consistencyToken).then(unittest.expectAsync(((api.AchievementUpdateMultipleResponse response) {
        checkAchievementUpdateMultipleResponse(response);
      })));
    });

  });


  unittest.group("resource-ApplicationsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.ApplicationsResourceApi res = new api.GamesApi(mock).applications;
      var arg_applicationId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_platformType = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("applications/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_applicationId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(queryMap["platformType"].first, unittest.equals(arg_platformType));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildApplication());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_applicationId, consistencyToken: arg_consistencyToken, language: arg_language, platformType: arg_platformType).then(unittest.expectAsync(((api.Application response) {
        checkApplication(response);
      })));
    });

    unittest.test("method--played", () {

      var mock = new HttpServerMock();
      api.ApplicationsResourceApi res = new api.GamesApi(mock).applications;
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 19), unittest.equals("applications/played"));
        pathOffset += 19;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.played(consistencyToken: arg_consistencyToken).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--verify", () {

      var mock = new HttpServerMock();
      api.ApplicationsResourceApi res = new api.GamesApi(mock).applications;
      var arg_applicationId = "foo";
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("applications/"));
        pathOffset += 13;
        index = path.indexOf("/verify", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_applicationId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/verify"));
        pathOffset += 7;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildApplicationVerifyResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.verify(arg_applicationId, consistencyToken: arg_consistencyToken).then(unittest.expectAsync(((api.ApplicationVerifyResponse response) {
        checkApplicationVerifyResponse(response);
      })));
    });

  });


  unittest.group("resource-EventsResourceApi", () {
    unittest.test("method--listByPlayer", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.GamesApi(mock).events;
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("events"));
        pathOffset += 6;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPlayerEventListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.listByPlayer(consistencyToken: arg_consistencyToken, language: arg_language, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.PlayerEventListResponse response) {
        checkPlayerEventListResponse(response);
      })));
    });

    unittest.test("method--listDefinitions", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.GamesApi(mock).events;
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("eventDefinitions"));
        pathOffset += 16;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEventDefinitionListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.listDefinitions(consistencyToken: arg_consistencyToken, language: arg_language, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.EventDefinitionListResponse response) {
        checkEventDefinitionListResponse(response);
      })));
    });

    unittest.test("method--record", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.GamesApi(mock).events;
      var arg_request = buildEventRecordRequest();
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.EventRecordRequest.fromJson(json);
        checkEventRecordRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("events"));
        pathOffset += 6;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEventUpdateResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.record(arg_request, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.EventUpdateResponse response) {
        checkEventUpdateResponse(response);
      })));
    });

  });


  unittest.group("resource-LeaderboardsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.LeaderboardsResourceApi res = new api.GamesApi(mock).leaderboards;
      var arg_leaderboardId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("leaderboards/"));
        pathOffset += 13;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_leaderboardId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildLeaderboard());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_leaderboardId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.Leaderboard response) {
        checkLeaderboard(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.LeaderboardsResourceApi res = new api.GamesApi(mock).leaderboards;
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("leaderboards"));
        pathOffset += 12;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildLeaderboardListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(consistencyToken: arg_consistencyToken, language: arg_language, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.LeaderboardListResponse response) {
        checkLeaderboardListResponse(response);
      })));
    });

  });


  unittest.group("resource-MetagameResourceApi", () {
    unittest.test("method--getMetagameConfig", () {

      var mock = new HttpServerMock();
      api.MetagameResourceApi res = new api.GamesApi(mock).metagame;
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 14), unittest.equals("metagameConfig"));
        pathOffset += 14;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildMetagameConfig());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getMetagameConfig(consistencyToken: arg_consistencyToken).then(unittest.expectAsync(((api.MetagameConfig response) {
        checkMetagameConfig(response);
      })));
    });

    unittest.test("method--listCategoriesByPlayer", () {

      var mock = new HttpServerMock();
      api.MetagameResourceApi res = new api.GamesApi(mock).metagame;
      var arg_playerId = "foo";
      var arg_collection = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("players/"));
        pathOffset += 8;
        index = path.indexOf("/categories/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_playerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("/categories/"));
        pathOffset += 12;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_collection"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCategoryListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.listCategoriesByPlayer(arg_playerId, arg_collection, consistencyToken: arg_consistencyToken, language: arg_language, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.CategoryListResponse response) {
        checkCategoryListResponse(response);
      })));
    });

  });


  unittest.group("resource-PlayersResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.PlayersResourceApi res = new api.GamesApi(mock).players;
      var arg_playerId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("players/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_playerId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPlayer());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_playerId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.Player response) {
        checkPlayer(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.PlayersResourceApi res = new api.GamesApi(mock).players;
      var arg_collection = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 19), unittest.equals("players/me/players/"));
        pathOffset += 19;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_collection"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPlayerListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_collection, consistencyToken: arg_consistencyToken, language: arg_language, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.PlayerListResponse response) {
        checkPlayerListResponse(response);
      })));
    });

  });


  unittest.group("resource-PushtokensResourceApi", () {
    unittest.test("method--remove", () {

      var mock = new HttpServerMock();
      api.PushtokensResourceApi res = new api.GamesApi(mock).pushtokens;
      var arg_request = buildPushTokenId();
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.PushTokenId.fromJson(json);
        checkPushTokenId(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("pushtokens/remove"));
        pathOffset += 17;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.remove(arg_request, consistencyToken: arg_consistencyToken).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.PushtokensResourceApi res = new api.GamesApi(mock).pushtokens;
      var arg_request = buildPushToken();
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.PushToken.fromJson(json);
        checkPushToken(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("pushtokens"));
        pathOffset += 10;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, consistencyToken: arg_consistencyToken).then(unittest.expectAsync((_) {}));
    });

  });


  unittest.group("resource-QuestMilestonesResourceApi", () {
    unittest.test("method--claim", () {

      var mock = new HttpServerMock();
      api.QuestMilestonesResourceApi res = new api.GamesApi(mock).questMilestones;
      var arg_questId = "foo";
      var arg_milestoneId = "foo";
      var arg_requestId = "foo";
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("quests/"));
        pathOffset += 7;
        index = path.indexOf("/milestones/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_questId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("/milestones/"));
        pathOffset += 12;
        index = path.indexOf("/claim", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_milestoneId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/claim"));
        pathOffset += 6;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["requestId"].first, unittest.equals(arg_requestId));
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.claim(arg_questId, arg_milestoneId, arg_requestId, consistencyToken: arg_consistencyToken).then(unittest.expectAsync((_) {}));
    });

  });


  unittest.group("resource-QuestsResourceApi", () {
    unittest.test("method--accept", () {

      var mock = new HttpServerMock();
      api.QuestsResourceApi res = new api.GamesApi(mock).quests;
      var arg_questId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("quests/"));
        pathOffset += 7;
        index = path.indexOf("/accept", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_questId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/accept"));
        pathOffset += 7;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildQuest());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.accept(arg_questId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.Quest response) {
        checkQuest(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.QuestsResourceApi res = new api.GamesApi(mock).quests;
      var arg_playerId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("players/"));
        pathOffset += 8;
        index = path.indexOf("/quests", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_playerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/quests"));
        pathOffset += 7;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildQuestListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_playerId, consistencyToken: arg_consistencyToken, language: arg_language, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.QuestListResponse response) {
        checkQuestListResponse(response);
      })));
    });

  });


  unittest.group("resource-RevisionsResourceApi", () {
    unittest.test("method--check", () {

      var mock = new HttpServerMock();
      api.RevisionsResourceApi res = new api.GamesApi(mock).revisions;
      var arg_clientRevision = "foo";
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 15), unittest.equals("revisions/check"));
        pathOffset += 15;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["clientRevision"].first, unittest.equals(arg_clientRevision));
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildRevisionCheckResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.check(arg_clientRevision, consistencyToken: arg_consistencyToken).then(unittest.expectAsync(((api.RevisionCheckResponse response) {
        checkRevisionCheckResponse(response);
      })));
    });

  });


  unittest.group("resource-RoomsResourceApi", () {
    unittest.test("method--create", () {

      var mock = new HttpServerMock();
      api.RoomsResourceApi res = new api.GamesApi(mock).rooms;
      var arg_request = buildRoomCreateRequest();
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.RoomCreateRequest.fromJson(json);
        checkRoomCreateRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("rooms/create"));
        pathOffset += 12;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildRoom());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.create(arg_request, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.Room response) {
        checkRoom(response);
      })));
    });

    unittest.test("method--decline", () {

      var mock = new HttpServerMock();
      api.RoomsResourceApi res = new api.GamesApi(mock).rooms;
      var arg_roomId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("rooms/"));
        pathOffset += 6;
        index = path.indexOf("/decline", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_roomId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/decline"));
        pathOffset += 8;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildRoom());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.decline(arg_roomId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.Room response) {
        checkRoom(response);
      })));
    });

    unittest.test("method--dismiss", () {

      var mock = new HttpServerMock();
      api.RoomsResourceApi res = new api.GamesApi(mock).rooms;
      var arg_roomId = "foo";
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("rooms/"));
        pathOffset += 6;
        index = path.indexOf("/dismiss", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_roomId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/dismiss"));
        pathOffset += 8;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.dismiss(arg_roomId, consistencyToken: arg_consistencyToken).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.RoomsResourceApi res = new api.GamesApi(mock).rooms;
      var arg_roomId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("rooms/"));
        pathOffset += 6;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_roomId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildRoom());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_roomId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.Room response) {
        checkRoom(response);
      })));
    });

    unittest.test("method--join", () {

      var mock = new HttpServerMock();
      api.RoomsResourceApi res = new api.GamesApi(mock).rooms;
      var arg_request = buildRoomJoinRequest();
      var arg_roomId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.RoomJoinRequest.fromJson(json);
        checkRoomJoinRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("rooms/"));
        pathOffset += 6;
        index = path.indexOf("/join", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_roomId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("/join"));
        pathOffset += 5;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildRoom());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.join(arg_request, arg_roomId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.Room response) {
        checkRoom(response);
      })));
    });

    unittest.test("method--leave", () {

      var mock = new HttpServerMock();
      api.RoomsResourceApi res = new api.GamesApi(mock).rooms;
      var arg_request = buildRoomLeaveRequest();
      var arg_roomId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.RoomLeaveRequest.fromJson(json);
        checkRoomLeaveRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("rooms/"));
        pathOffset += 6;
        index = path.indexOf("/leave", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_roomId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/leave"));
        pathOffset += 6;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildRoom());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.leave(arg_request, arg_roomId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.Room response) {
        checkRoom(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.RoomsResourceApi res = new api.GamesApi(mock).rooms;
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("rooms"));
        pathOffset += 5;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildRoomList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(consistencyToken: arg_consistencyToken, language: arg_language, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.RoomList response) {
        checkRoomList(response);
      })));
    });

    unittest.test("method--reportStatus", () {

      var mock = new HttpServerMock();
      api.RoomsResourceApi res = new api.GamesApi(mock).rooms;
      var arg_request = buildRoomP2PStatuses();
      var arg_roomId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.RoomP2PStatuses.fromJson(json);
        checkRoomP2PStatuses(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("rooms/"));
        pathOffset += 6;
        index = path.indexOf("/reportstatus", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_roomId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/reportstatus"));
        pathOffset += 13;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildRoomStatus());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.reportStatus(arg_request, arg_roomId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.RoomStatus response) {
        checkRoomStatus(response);
      })));
    });

  });


  unittest.group("resource-ScoresResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.ScoresResourceApi res = new api.GamesApi(mock).scores;
      var arg_playerId = "foo";
      var arg_leaderboardId = "foo";
      var arg_timeSpan = "foo";
      var arg_consistencyToken = "foo";
      var arg_includeRankType = "foo";
      var arg_language = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("players/"));
        pathOffset += 8;
        index = path.indexOf("/leaderboards/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_playerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 14), unittest.equals("/leaderboards/"));
        pathOffset += 14;
        index = path.indexOf("/scores/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_leaderboardId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/scores/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_timeSpan"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["includeRankType"].first, unittest.equals(arg_includeRankType));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPlayerLeaderboardScoreListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_playerId, arg_leaderboardId, arg_timeSpan, consistencyToken: arg_consistencyToken, includeRankType: arg_includeRankType, language: arg_language, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.PlayerLeaderboardScoreListResponse response) {
        checkPlayerLeaderboardScoreListResponse(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.ScoresResourceApi res = new api.GamesApi(mock).scores;
      var arg_leaderboardId = "foo";
      var arg_collection = "foo";
      var arg_timeSpan = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("leaderboards/"));
        pathOffset += 13;
        index = path.indexOf("/scores/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_leaderboardId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/scores/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_collection"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["timeSpan"].first, unittest.equals(arg_timeSpan));
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildLeaderboardScores());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_leaderboardId, arg_collection, arg_timeSpan, consistencyToken: arg_consistencyToken, language: arg_language, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.LeaderboardScores response) {
        checkLeaderboardScores(response);
      })));
    });

    unittest.test("method--listWindow", () {

      var mock = new HttpServerMock();
      api.ScoresResourceApi res = new api.GamesApi(mock).scores;
      var arg_leaderboardId = "foo";
      var arg_collection = "foo";
      var arg_timeSpan = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_resultsAbove = 42;
      var arg_returnTopIfAbsent = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("leaderboards/"));
        pathOffset += 13;
        index = path.indexOf("/window/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_leaderboardId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/window/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_collection"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["timeSpan"].first, unittest.equals(arg_timeSpan));
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["resultsAbove"].first), unittest.equals(arg_resultsAbove));
        unittest.expect(queryMap["returnTopIfAbsent"].first, unittest.equals("$arg_returnTopIfAbsent"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildLeaderboardScores());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.listWindow(arg_leaderboardId, arg_collection, arg_timeSpan, consistencyToken: arg_consistencyToken, language: arg_language, maxResults: arg_maxResults, pageToken: arg_pageToken, resultsAbove: arg_resultsAbove, returnTopIfAbsent: arg_returnTopIfAbsent).then(unittest.expectAsync(((api.LeaderboardScores response) {
        checkLeaderboardScores(response);
      })));
    });

    unittest.test("method--submit", () {

      var mock = new HttpServerMock();
      api.ScoresResourceApi res = new api.GamesApi(mock).scores;
      var arg_leaderboardId = "foo";
      var arg_score = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_scoreTag = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("leaderboards/"));
        pathOffset += 13;
        index = path.indexOf("/scores", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_leaderboardId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/scores"));
        pathOffset += 7;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["score"].first, unittest.equals(arg_score));
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(queryMap["scoreTag"].first, unittest.equals(arg_scoreTag));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPlayerScoreResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.submit(arg_leaderboardId, arg_score, consistencyToken: arg_consistencyToken, language: arg_language, scoreTag: arg_scoreTag).then(unittest.expectAsync(((api.PlayerScoreResponse response) {
        checkPlayerScoreResponse(response);
      })));
    });

    unittest.test("method--submitMultiple", () {

      var mock = new HttpServerMock();
      api.ScoresResourceApi res = new api.GamesApi(mock).scores;
      var arg_request = buildPlayerScoreSubmissionList();
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.PlayerScoreSubmissionList.fromJson(json);
        checkPlayerScoreSubmissionList(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 19), unittest.equals("leaderboards/scores"));
        pathOffset += 19;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPlayerScoreListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.submitMultiple(arg_request, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.PlayerScoreListResponse response) {
        checkPlayerScoreListResponse(response);
      })));
    });

  });


  unittest.group("resource-SnapshotsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.SnapshotsResourceApi res = new api.GamesApi(mock).snapshots;
      var arg_snapshotId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("snapshots/"));
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_snapshotId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSnapshot());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_snapshotId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.Snapshot response) {
        checkSnapshot(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.SnapshotsResourceApi res = new api.GamesApi(mock).snapshots;
      var arg_playerId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("players/"));
        pathOffset += 8;
        index = path.indexOf("/snapshots", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_playerId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/snapshots"));
        pathOffset += 10;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSnapshotListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_playerId, consistencyToken: arg_consistencyToken, language: arg_language, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.SnapshotListResponse response) {
        checkSnapshotListResponse(response);
      })));
    });

  });


  unittest.group("resource-TurnBasedMatchesResourceApi", () {
    unittest.test("method--cancel", () {

      var mock = new HttpServerMock();
      api.TurnBasedMatchesResourceApi res = new api.GamesApi(mock).turnBasedMatches;
      var arg_matchId = "foo";
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("turnbasedmatches/"));
        pathOffset += 17;
        index = path.indexOf("/cancel", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_matchId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/cancel"));
        pathOffset += 7;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.cancel(arg_matchId, consistencyToken: arg_consistencyToken).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--create", () {

      var mock = new HttpServerMock();
      api.TurnBasedMatchesResourceApi res = new api.GamesApi(mock).turnBasedMatches;
      var arg_request = buildTurnBasedMatchCreateRequest();
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.TurnBasedMatchCreateRequest.fromJson(json);
        checkTurnBasedMatchCreateRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 23), unittest.equals("turnbasedmatches/create"));
        pathOffset += 23;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTurnBasedMatch());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.create(arg_request, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.TurnBasedMatch response) {
        checkTurnBasedMatch(response);
      })));
    });

    unittest.test("method--decline", () {

      var mock = new HttpServerMock();
      api.TurnBasedMatchesResourceApi res = new api.GamesApi(mock).turnBasedMatches;
      var arg_matchId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("turnbasedmatches/"));
        pathOffset += 17;
        index = path.indexOf("/decline", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_matchId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/decline"));
        pathOffset += 8;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTurnBasedMatch());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.decline(arg_matchId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.TurnBasedMatch response) {
        checkTurnBasedMatch(response);
      })));
    });

    unittest.test("method--dismiss", () {

      var mock = new HttpServerMock();
      api.TurnBasedMatchesResourceApi res = new api.GamesApi(mock).turnBasedMatches;
      var arg_matchId = "foo";
      var arg_consistencyToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("turnbasedmatches/"));
        pathOffset += 17;
        index = path.indexOf("/dismiss", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_matchId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/dismiss"));
        pathOffset += 8;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.dismiss(arg_matchId, consistencyToken: arg_consistencyToken).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--finish", () {

      var mock = new HttpServerMock();
      api.TurnBasedMatchesResourceApi res = new api.GamesApi(mock).turnBasedMatches;
      var arg_request = buildTurnBasedMatchResults();
      var arg_matchId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.TurnBasedMatchResults.fromJson(json);
        checkTurnBasedMatchResults(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("turnbasedmatches/"));
        pathOffset += 17;
        index = path.indexOf("/finish", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_matchId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/finish"));
        pathOffset += 7;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTurnBasedMatch());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.finish(arg_request, arg_matchId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.TurnBasedMatch response) {
        checkTurnBasedMatch(response);
      })));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.TurnBasedMatchesResourceApi res = new api.GamesApi(mock).turnBasedMatches;
      var arg_matchId = "foo";
      var arg_consistencyToken = "foo";
      var arg_includeMatchData = true;
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("turnbasedmatches/"));
        pathOffset += 17;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_matchId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["includeMatchData"].first, unittest.equals("$arg_includeMatchData"));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTurnBasedMatch());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_matchId, consistencyToken: arg_consistencyToken, includeMatchData: arg_includeMatchData, language: arg_language).then(unittest.expectAsync(((api.TurnBasedMatch response) {
        checkTurnBasedMatch(response);
      })));
    });

    unittest.test("method--join", () {

      var mock = new HttpServerMock();
      api.TurnBasedMatchesResourceApi res = new api.GamesApi(mock).turnBasedMatches;
      var arg_matchId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("turnbasedmatches/"));
        pathOffset += 17;
        index = path.indexOf("/join", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_matchId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("/join"));
        pathOffset += 5;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTurnBasedMatch());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.join(arg_matchId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.TurnBasedMatch response) {
        checkTurnBasedMatch(response);
      })));
    });

    unittest.test("method--leave", () {

      var mock = new HttpServerMock();
      api.TurnBasedMatchesResourceApi res = new api.GamesApi(mock).turnBasedMatches;
      var arg_matchId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("turnbasedmatches/"));
        pathOffset += 17;
        index = path.indexOf("/leave", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_matchId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/leave"));
        pathOffset += 6;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTurnBasedMatch());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.leave(arg_matchId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.TurnBasedMatch response) {
        checkTurnBasedMatch(response);
      })));
    });

    unittest.test("method--leaveTurn", () {

      var mock = new HttpServerMock();
      api.TurnBasedMatchesResourceApi res = new api.GamesApi(mock).turnBasedMatches;
      var arg_matchId = "foo";
      var arg_matchVersion = 42;
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_pendingParticipantId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("turnbasedmatches/"));
        pathOffset += 17;
        index = path.indexOf("/leaveTurn", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_matchId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/leaveTurn"));
        pathOffset += 10;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.int.parse(queryMap["matchVersion"].first), unittest.equals(arg_matchVersion));
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(queryMap["pendingParticipantId"].first, unittest.equals(arg_pendingParticipantId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTurnBasedMatch());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.leaveTurn(arg_matchId, arg_matchVersion, consistencyToken: arg_consistencyToken, language: arg_language, pendingParticipantId: arg_pendingParticipantId).then(unittest.expectAsync(((api.TurnBasedMatch response) {
        checkTurnBasedMatch(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.TurnBasedMatchesResourceApi res = new api.GamesApi(mock).turnBasedMatches;
      var arg_consistencyToken = "foo";
      var arg_includeMatchData = true;
      var arg_language = "foo";
      var arg_maxCompletedMatches = 42;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("turnbasedmatches"));
        pathOffset += 16;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["includeMatchData"].first, unittest.equals("$arg_includeMatchData"));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxCompletedMatches"].first), unittest.equals(arg_maxCompletedMatches));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTurnBasedMatchList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(consistencyToken: arg_consistencyToken, includeMatchData: arg_includeMatchData, language: arg_language, maxCompletedMatches: arg_maxCompletedMatches, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.TurnBasedMatchList response) {
        checkTurnBasedMatchList(response);
      })));
    });

    unittest.test("method--rematch", () {

      var mock = new HttpServerMock();
      api.TurnBasedMatchesResourceApi res = new api.GamesApi(mock).turnBasedMatches;
      var arg_matchId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      var arg_requestId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("turnbasedmatches/"));
        pathOffset += 17;
        index = path.indexOf("/rematch", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_matchId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/rematch"));
        pathOffset += 8;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(queryMap["requestId"].first, unittest.equals(arg_requestId));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTurnBasedMatchRematch());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.rematch(arg_matchId, consistencyToken: arg_consistencyToken, language: arg_language, requestId: arg_requestId).then(unittest.expectAsync(((api.TurnBasedMatchRematch response) {
        checkTurnBasedMatchRematch(response);
      })));
    });

    unittest.test("method--sync", () {

      var mock = new HttpServerMock();
      api.TurnBasedMatchesResourceApi res = new api.GamesApi(mock).turnBasedMatches;
      var arg_consistencyToken = "foo";
      var arg_includeMatchData = true;
      var arg_language = "foo";
      var arg_maxCompletedMatches = 42;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("turnbasedmatches/sync"));
        pathOffset += 21;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["includeMatchData"].first, unittest.equals("$arg_includeMatchData"));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));
        unittest.expect(core.int.parse(queryMap["maxCompletedMatches"].first), unittest.equals(arg_maxCompletedMatches));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTurnBasedMatchSync());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.sync(consistencyToken: arg_consistencyToken, includeMatchData: arg_includeMatchData, language: arg_language, maxCompletedMatches: arg_maxCompletedMatches, maxResults: arg_maxResults, pageToken: arg_pageToken).then(unittest.expectAsync(((api.TurnBasedMatchSync response) {
        checkTurnBasedMatchSync(response);
      })));
    });

    unittest.test("method--takeTurn", () {

      var mock = new HttpServerMock();
      api.TurnBasedMatchesResourceApi res = new api.GamesApi(mock).turnBasedMatches;
      var arg_request = buildTurnBasedMatchTurn();
      var arg_matchId = "foo";
      var arg_consistencyToken = "foo";
      var arg_language = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.TurnBasedMatchTurn.fromJson(json);
        checkTurnBasedMatchTurn(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("games/v1/"));
        pathOffset += 9;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("turnbasedmatches/"));
        pathOffset += 17;
        index = path.indexOf("/turn", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_matchId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("/turn"));
        pathOffset += 5;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["consistencyToken"].first, unittest.equals(arg_consistencyToken));
        unittest.expect(queryMap["language"].first, unittest.equals(arg_language));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildTurnBasedMatch());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.takeTurn(arg_request, arg_matchId, consistencyToken: arg_consistencyToken, language: arg_language).then(unittest.expectAsync(((api.TurnBasedMatch response) {
        checkTurnBasedMatch(response);
      })));
    });

  });


}

