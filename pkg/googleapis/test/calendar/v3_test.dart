library googleapis.calendar.v3.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/calendar/v3.dart' as api;

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

buildUnnamed996() {
  var o = new core.List<api.AclRule>();
  o.add(buildAclRule());
  o.add(buildAclRule());
  return o;
}

checkUnnamed996(core.List<api.AclRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAclRule(o[0]);
  checkAclRule(o[1]);
}

core.int buildCounterAcl = 0;
buildAcl() {
  var o = new api.Acl();
  buildCounterAcl++;
  if (buildCounterAcl < 3) {
    o.etag = "foo";
    o.items = buildUnnamed996();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.nextSyncToken = "foo";
  }
  buildCounterAcl--;
  return o;
}

checkAcl(api.Acl o) {
  buildCounterAcl++;
  if (buildCounterAcl < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed996(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.nextSyncToken, unittest.equals('foo'));
  }
  buildCounterAcl--;
}

core.int buildCounterAclRuleScope = 0;
buildAclRuleScope() {
  var o = new api.AclRuleScope();
  buildCounterAclRuleScope++;
  if (buildCounterAclRuleScope < 3) {
    o.type = "foo";
    o.value = "foo";
  }
  buildCounterAclRuleScope--;
  return o;
}

checkAclRuleScope(api.AclRuleScope o) {
  buildCounterAclRuleScope++;
  if (buildCounterAclRuleScope < 3) {
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterAclRuleScope--;
}

core.int buildCounterAclRule = 0;
buildAclRule() {
  var o = new api.AclRule();
  buildCounterAclRule++;
  if (buildCounterAclRule < 3) {
    o.etag = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.role = "foo";
    o.scope = buildAclRuleScope();
  }
  buildCounterAclRule--;
  return o;
}

checkAclRule(api.AclRule o) {
  buildCounterAclRule++;
  if (buildCounterAclRule < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.role, unittest.equals('foo'));
    checkAclRuleScope(o.scope);
  }
  buildCounterAclRule--;
}

core.int buildCounterCalendar = 0;
buildCalendar() {
  var o = new api.Calendar();
  buildCounterCalendar++;
  if (buildCounterCalendar < 3) {
    o.description = "foo";
    o.etag = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.location = "foo";
    o.summary = "foo";
    o.timeZone = "foo";
  }
  buildCounterCalendar--;
  return o;
}

checkCalendar(api.Calendar o) {
  buildCounterCalendar++;
  if (buildCounterCalendar < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.etag, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.location, unittest.equals('foo'));
    unittest.expect(o.summary, unittest.equals('foo'));
    unittest.expect(o.timeZone, unittest.equals('foo'));
  }
  buildCounterCalendar--;
}

buildUnnamed997() {
  var o = new core.List<api.CalendarListEntry>();
  o.add(buildCalendarListEntry());
  o.add(buildCalendarListEntry());
  return o;
}

checkUnnamed997(core.List<api.CalendarListEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCalendarListEntry(o[0]);
  checkCalendarListEntry(o[1]);
}

core.int buildCounterCalendarList = 0;
buildCalendarList() {
  var o = new api.CalendarList();
  buildCounterCalendarList++;
  if (buildCounterCalendarList < 3) {
    o.etag = "foo";
    o.items = buildUnnamed997();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.nextSyncToken = "foo";
  }
  buildCounterCalendarList--;
  return o;
}

checkCalendarList(api.CalendarList o) {
  buildCounterCalendarList++;
  if (buildCounterCalendarList < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed997(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.nextSyncToken, unittest.equals('foo'));
  }
  buildCounterCalendarList--;
}

buildUnnamed998() {
  var o = new core.List<api.EventReminder>();
  o.add(buildEventReminder());
  o.add(buildEventReminder());
  return o;
}

checkUnnamed998(core.List<api.EventReminder> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEventReminder(o[0]);
  checkEventReminder(o[1]);
}

buildUnnamed999() {
  var o = new core.List<api.CalendarNotification>();
  o.add(buildCalendarNotification());
  o.add(buildCalendarNotification());
  return o;
}

checkUnnamed999(core.List<api.CalendarNotification> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCalendarNotification(o[0]);
  checkCalendarNotification(o[1]);
}

core.int buildCounterCalendarListEntryNotificationSettings = 0;
buildCalendarListEntryNotificationSettings() {
  var o = new api.CalendarListEntryNotificationSettings();
  buildCounterCalendarListEntryNotificationSettings++;
  if (buildCounterCalendarListEntryNotificationSettings < 3) {
    o.notifications = buildUnnamed999();
  }
  buildCounterCalendarListEntryNotificationSettings--;
  return o;
}

checkCalendarListEntryNotificationSettings(api.CalendarListEntryNotificationSettings o) {
  buildCounterCalendarListEntryNotificationSettings++;
  if (buildCounterCalendarListEntryNotificationSettings < 3) {
    checkUnnamed999(o.notifications);
  }
  buildCounterCalendarListEntryNotificationSettings--;
}

core.int buildCounterCalendarListEntry = 0;
buildCalendarListEntry() {
  var o = new api.CalendarListEntry();
  buildCounterCalendarListEntry++;
  if (buildCounterCalendarListEntry < 3) {
    o.accessRole = "foo";
    o.backgroundColor = "foo";
    o.colorId = "foo";
    o.defaultReminders = buildUnnamed998();
    o.deleted = true;
    o.description = "foo";
    o.etag = "foo";
    o.foregroundColor = "foo";
    o.hidden = true;
    o.id = "foo";
    o.kind = "foo";
    o.location = "foo";
    o.notificationSettings = buildCalendarListEntryNotificationSettings();
    o.primary = true;
    o.selected = true;
    o.summary = "foo";
    o.summaryOverride = "foo";
    o.timeZone = "foo";
  }
  buildCounterCalendarListEntry--;
  return o;
}

checkCalendarListEntry(api.CalendarListEntry o) {
  buildCounterCalendarListEntry++;
  if (buildCounterCalendarListEntry < 3) {
    unittest.expect(o.accessRole, unittest.equals('foo'));
    unittest.expect(o.backgroundColor, unittest.equals('foo'));
    unittest.expect(o.colorId, unittest.equals('foo'));
    checkUnnamed998(o.defaultReminders);
    unittest.expect(o.deleted, unittest.isTrue);
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.etag, unittest.equals('foo'));
    unittest.expect(o.foregroundColor, unittest.equals('foo'));
    unittest.expect(o.hidden, unittest.isTrue);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.location, unittest.equals('foo'));
    checkCalendarListEntryNotificationSettings(o.notificationSettings);
    unittest.expect(o.primary, unittest.isTrue);
    unittest.expect(o.selected, unittest.isTrue);
    unittest.expect(o.summary, unittest.equals('foo'));
    unittest.expect(o.summaryOverride, unittest.equals('foo'));
    unittest.expect(o.timeZone, unittest.equals('foo'));
  }
  buildCounterCalendarListEntry--;
}

core.int buildCounterCalendarNotification = 0;
buildCalendarNotification() {
  var o = new api.CalendarNotification();
  buildCounterCalendarNotification++;
  if (buildCounterCalendarNotification < 3) {
    o.method = "foo";
    o.type = "foo";
  }
  buildCounterCalendarNotification--;
  return o;
}

checkCalendarNotification(api.CalendarNotification o) {
  buildCounterCalendarNotification++;
  if (buildCounterCalendarNotification < 3) {
    unittest.expect(o.method, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterCalendarNotification--;
}

buildUnnamed1000() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed1000(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterChannel = 0;
buildChannel() {
  var o = new api.Channel();
  buildCounterChannel++;
  if (buildCounterChannel < 3) {
    o.address = "foo";
    o.expiration = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.params = buildUnnamed1000();
    o.payload = true;
    o.resourceId = "foo";
    o.resourceUri = "foo";
    o.token = "foo";
    o.type = "foo";
  }
  buildCounterChannel--;
  return o;
}

checkChannel(api.Channel o) {
  buildCounterChannel++;
  if (buildCounterChannel < 3) {
    unittest.expect(o.address, unittest.equals('foo'));
    unittest.expect(o.expiration, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed1000(o.params);
    unittest.expect(o.payload, unittest.isTrue);
    unittest.expect(o.resourceId, unittest.equals('foo'));
    unittest.expect(o.resourceUri, unittest.equals('foo'));
    unittest.expect(o.token, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterChannel--;
}

core.int buildCounterColorDefinition = 0;
buildColorDefinition() {
  var o = new api.ColorDefinition();
  buildCounterColorDefinition++;
  if (buildCounterColorDefinition < 3) {
    o.background = "foo";
    o.foreground = "foo";
  }
  buildCounterColorDefinition--;
  return o;
}

checkColorDefinition(api.ColorDefinition o) {
  buildCounterColorDefinition++;
  if (buildCounterColorDefinition < 3) {
    unittest.expect(o.background, unittest.equals('foo'));
    unittest.expect(o.foreground, unittest.equals('foo'));
  }
  buildCounterColorDefinition--;
}

buildUnnamed1001() {
  var o = new core.Map<core.String, api.ColorDefinition>();
  o["x"] = buildColorDefinition();
  o["y"] = buildColorDefinition();
  return o;
}

checkUnnamed1001(core.Map<core.String, api.ColorDefinition> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkColorDefinition(o["x"]);
  checkColorDefinition(o["y"]);
}

buildUnnamed1002() {
  var o = new core.Map<core.String, api.ColorDefinition>();
  o["x"] = buildColorDefinition();
  o["y"] = buildColorDefinition();
  return o;
}

checkUnnamed1002(core.Map<core.String, api.ColorDefinition> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkColorDefinition(o["x"]);
  checkColorDefinition(o["y"]);
}

core.int buildCounterColors = 0;
buildColors() {
  var o = new api.Colors();
  buildCounterColors++;
  if (buildCounterColors < 3) {
    o.calendar = buildUnnamed1001();
    o.event = buildUnnamed1002();
    o.kind = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
  }
  buildCounterColors--;
  return o;
}

checkColors(api.Colors o) {
  buildCounterColors++;
  if (buildCounterColors < 3) {
    checkUnnamed1001(o.calendar);
    checkUnnamed1002(o.event);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
  }
  buildCounterColors--;
}

core.int buildCounterError = 0;
buildError() {
  var o = new api.Error();
  buildCounterError++;
  if (buildCounterError < 3) {
    o.domain = "foo";
    o.reason = "foo";
  }
  buildCounterError--;
  return o;
}

checkError(api.Error o) {
  buildCounterError++;
  if (buildCounterError < 3) {
    unittest.expect(o.domain, unittest.equals('foo'));
    unittest.expect(o.reason, unittest.equals('foo'));
  }
  buildCounterError--;
}

buildUnnamed1003() {
  var o = new core.List<api.EventAttachment>();
  o.add(buildEventAttachment());
  o.add(buildEventAttachment());
  return o;
}

checkUnnamed1003(core.List<api.EventAttachment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEventAttachment(o[0]);
  checkEventAttachment(o[1]);
}

buildUnnamed1004() {
  var o = new core.List<api.EventAttendee>();
  o.add(buildEventAttendee());
  o.add(buildEventAttendee());
  return o;
}

checkUnnamed1004(core.List<api.EventAttendee> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEventAttendee(o[0]);
  checkEventAttendee(o[1]);
}

core.int buildCounterEventCreator = 0;
buildEventCreator() {
  var o = new api.EventCreator();
  buildCounterEventCreator++;
  if (buildCounterEventCreator < 3) {
    o.displayName = "foo";
    o.email = "foo";
    o.id = "foo";
    o.self = true;
  }
  buildCounterEventCreator--;
  return o;
}

checkEventCreator(api.EventCreator o) {
  buildCounterEventCreator++;
  if (buildCounterEventCreator < 3) {
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.email, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.self, unittest.isTrue);
  }
  buildCounterEventCreator--;
}

buildUnnamed1005() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed1005(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

buildUnnamed1006() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed1006(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterEventExtendedProperties = 0;
buildEventExtendedProperties() {
  var o = new api.EventExtendedProperties();
  buildCounterEventExtendedProperties++;
  if (buildCounterEventExtendedProperties < 3) {
    o.private = buildUnnamed1005();
    o.shared = buildUnnamed1006();
  }
  buildCounterEventExtendedProperties--;
  return o;
}

checkEventExtendedProperties(api.EventExtendedProperties o) {
  buildCounterEventExtendedProperties++;
  if (buildCounterEventExtendedProperties < 3) {
    checkUnnamed1005(o.private);
    checkUnnamed1006(o.shared);
  }
  buildCounterEventExtendedProperties--;
}

buildUnnamed1007() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed1007(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterEventGadget = 0;
buildEventGadget() {
  var o = new api.EventGadget();
  buildCounterEventGadget++;
  if (buildCounterEventGadget < 3) {
    o.display = "foo";
    o.height = 42;
    o.iconLink = "foo";
    o.link = "foo";
    o.preferences = buildUnnamed1007();
    o.title = "foo";
    o.type = "foo";
    o.width = 42;
  }
  buildCounterEventGadget--;
  return o;
}

checkEventGadget(api.EventGadget o) {
  buildCounterEventGadget++;
  if (buildCounterEventGadget < 3) {
    unittest.expect(o.display, unittest.equals('foo'));
    unittest.expect(o.height, unittest.equals(42));
    unittest.expect(o.iconLink, unittest.equals('foo'));
    unittest.expect(o.link, unittest.equals('foo'));
    checkUnnamed1007(o.preferences);
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.width, unittest.equals(42));
  }
  buildCounterEventGadget--;
}

core.int buildCounterEventOrganizer = 0;
buildEventOrganizer() {
  var o = new api.EventOrganizer();
  buildCounterEventOrganizer++;
  if (buildCounterEventOrganizer < 3) {
    o.displayName = "foo";
    o.email = "foo";
    o.id = "foo";
    o.self = true;
  }
  buildCounterEventOrganizer--;
  return o;
}

checkEventOrganizer(api.EventOrganizer o) {
  buildCounterEventOrganizer++;
  if (buildCounterEventOrganizer < 3) {
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.email, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.self, unittest.isTrue);
  }
  buildCounterEventOrganizer--;
}

buildUnnamed1008() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1008(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1009() {
  var o = new core.List<api.EventReminder>();
  o.add(buildEventReminder());
  o.add(buildEventReminder());
  return o;
}

checkUnnamed1009(core.List<api.EventReminder> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEventReminder(o[0]);
  checkEventReminder(o[1]);
}

core.int buildCounterEventReminders = 0;
buildEventReminders() {
  var o = new api.EventReminders();
  buildCounterEventReminders++;
  if (buildCounterEventReminders < 3) {
    o.overrides = buildUnnamed1009();
    o.useDefault = true;
  }
  buildCounterEventReminders--;
  return o;
}

checkEventReminders(api.EventReminders o) {
  buildCounterEventReminders++;
  if (buildCounterEventReminders < 3) {
    checkUnnamed1009(o.overrides);
    unittest.expect(o.useDefault, unittest.isTrue);
  }
  buildCounterEventReminders--;
}

core.int buildCounterEventSource = 0;
buildEventSource() {
  var o = new api.EventSource();
  buildCounterEventSource++;
  if (buildCounterEventSource < 3) {
    o.title = "foo";
    o.url = "foo";
  }
  buildCounterEventSource--;
  return o;
}

checkEventSource(api.EventSource o) {
  buildCounterEventSource++;
  if (buildCounterEventSource < 3) {
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterEventSource--;
}

core.int buildCounterEvent = 0;
buildEvent() {
  var o = new api.Event();
  buildCounterEvent++;
  if (buildCounterEvent < 3) {
    o.anyoneCanAddSelf = true;
    o.attachments = buildUnnamed1003();
    o.attendees = buildUnnamed1004();
    o.attendeesOmitted = true;
    o.colorId = "foo";
    o.created = core.DateTime.parse("2002-02-27T14:01:02");
    o.creator = buildEventCreator();
    o.description = "foo";
    o.end = buildEventDateTime();
    o.endTimeUnspecified = true;
    o.etag = "foo";
    o.extendedProperties = buildEventExtendedProperties();
    o.gadget = buildEventGadget();
    o.guestsCanInviteOthers = true;
    o.guestsCanModify = true;
    o.guestsCanSeeOtherGuests = true;
    o.hangoutLink = "foo";
    o.htmlLink = "foo";
    o.iCalUID = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.location = "foo";
    o.locked = true;
    o.organizer = buildEventOrganizer();
    o.originalStartTime = buildEventDateTime();
    o.privateCopy = true;
    o.recurrence = buildUnnamed1008();
    o.recurringEventId = "foo";
    o.reminders = buildEventReminders();
    o.sequence = 42;
    o.source = buildEventSource();
    o.start = buildEventDateTime();
    o.status = "foo";
    o.summary = "foo";
    o.transparency = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
    o.visibility = "foo";
  }
  buildCounterEvent--;
  return o;
}

checkEvent(api.Event o) {
  buildCounterEvent++;
  if (buildCounterEvent < 3) {
    unittest.expect(o.anyoneCanAddSelf, unittest.isTrue);
    checkUnnamed1003(o.attachments);
    checkUnnamed1004(o.attendees);
    unittest.expect(o.attendeesOmitted, unittest.isTrue);
    unittest.expect(o.colorId, unittest.equals('foo'));
    unittest.expect(o.created, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    checkEventCreator(o.creator);
    unittest.expect(o.description, unittest.equals('foo'));
    checkEventDateTime(o.end);
    unittest.expect(o.endTimeUnspecified, unittest.isTrue);
    unittest.expect(o.etag, unittest.equals('foo'));
    checkEventExtendedProperties(o.extendedProperties);
    checkEventGadget(o.gadget);
    unittest.expect(o.guestsCanInviteOthers, unittest.isTrue);
    unittest.expect(o.guestsCanModify, unittest.isTrue);
    unittest.expect(o.guestsCanSeeOtherGuests, unittest.isTrue);
    unittest.expect(o.hangoutLink, unittest.equals('foo'));
    unittest.expect(o.htmlLink, unittest.equals('foo'));
    unittest.expect(o.iCalUID, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.location, unittest.equals('foo'));
    unittest.expect(o.locked, unittest.isTrue);
    checkEventOrganizer(o.organizer);
    checkEventDateTime(o.originalStartTime);
    unittest.expect(o.privateCopy, unittest.isTrue);
    checkUnnamed1008(o.recurrence);
    unittest.expect(o.recurringEventId, unittest.equals('foo'));
    checkEventReminders(o.reminders);
    unittest.expect(o.sequence, unittest.equals(42));
    checkEventSource(o.source);
    checkEventDateTime(o.start);
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.summary, unittest.equals('foo'));
    unittest.expect(o.transparency, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.visibility, unittest.equals('foo'));
  }
  buildCounterEvent--;
}

core.int buildCounterEventAttachment = 0;
buildEventAttachment() {
  var o = new api.EventAttachment();
  buildCounterEventAttachment++;
  if (buildCounterEventAttachment < 3) {
    o.fileId = "foo";
    o.fileUrl = "foo";
    o.iconLink = "foo";
    o.mimeType = "foo";
    o.title = "foo";
  }
  buildCounterEventAttachment--;
  return o;
}

checkEventAttachment(api.EventAttachment o) {
  buildCounterEventAttachment++;
  if (buildCounterEventAttachment < 3) {
    unittest.expect(o.fileId, unittest.equals('foo'));
    unittest.expect(o.fileUrl, unittest.equals('foo'));
    unittest.expect(o.iconLink, unittest.equals('foo'));
    unittest.expect(o.mimeType, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
  }
  buildCounterEventAttachment--;
}

core.int buildCounterEventAttendee = 0;
buildEventAttendee() {
  var o = new api.EventAttendee();
  buildCounterEventAttendee++;
  if (buildCounterEventAttendee < 3) {
    o.additionalGuests = 42;
    o.comment = "foo";
    o.displayName = "foo";
    o.email = "foo";
    o.id = "foo";
    o.optional = true;
    o.organizer = true;
    o.resource = true;
    o.responseStatus = "foo";
    o.self = true;
  }
  buildCounterEventAttendee--;
  return o;
}

checkEventAttendee(api.EventAttendee o) {
  buildCounterEventAttendee++;
  if (buildCounterEventAttendee < 3) {
    unittest.expect(o.additionalGuests, unittest.equals(42));
    unittest.expect(o.comment, unittest.equals('foo'));
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.email, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.optional, unittest.isTrue);
    unittest.expect(o.organizer, unittest.isTrue);
    unittest.expect(o.resource, unittest.isTrue);
    unittest.expect(o.responseStatus, unittest.equals('foo'));
    unittest.expect(o.self, unittest.isTrue);
  }
  buildCounterEventAttendee--;
}

core.int buildCounterEventDateTime = 0;
buildEventDateTime() {
  var o = new api.EventDateTime();
  buildCounterEventDateTime++;
  if (buildCounterEventDateTime < 3) {
    o.date = core.DateTime.parse("2002-02-27T14:01:02Z");
    o.dateTime = core.DateTime.parse("2002-02-27T14:01:02");
    o.timeZone = "foo";
  }
  buildCounterEventDateTime--;
  return o;
}

checkEventDateTime(api.EventDateTime o) {
  buildCounterEventDateTime++;
  if (buildCounterEventDateTime < 3) {
    unittest.expect(o.date, unittest.equals(core.DateTime.parse("2002-02-27T00:00:00")));
    unittest.expect(o.dateTime, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.timeZone, unittest.equals('foo'));
  }
  buildCounterEventDateTime--;
}

core.int buildCounterEventReminder = 0;
buildEventReminder() {
  var o = new api.EventReminder();
  buildCounterEventReminder++;
  if (buildCounterEventReminder < 3) {
    o.method = "foo";
    o.minutes = 42;
  }
  buildCounterEventReminder--;
  return o;
}

checkEventReminder(api.EventReminder o) {
  buildCounterEventReminder++;
  if (buildCounterEventReminder < 3) {
    unittest.expect(o.method, unittest.equals('foo'));
    unittest.expect(o.minutes, unittest.equals(42));
  }
  buildCounterEventReminder--;
}

buildUnnamed1010() {
  var o = new core.List<api.EventReminder>();
  o.add(buildEventReminder());
  o.add(buildEventReminder());
  return o;
}

checkUnnamed1010(core.List<api.EventReminder> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEventReminder(o[0]);
  checkEventReminder(o[1]);
}

buildUnnamed1011() {
  var o = new core.List<api.Event>();
  o.add(buildEvent());
  o.add(buildEvent());
  return o;
}

checkUnnamed1011(core.List<api.Event> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEvent(o[0]);
  checkEvent(o[1]);
}

core.int buildCounterEvents = 0;
buildEvents() {
  var o = new api.Events();
  buildCounterEvents++;
  if (buildCounterEvents < 3) {
    o.accessRole = "foo";
    o.defaultReminders = buildUnnamed1010();
    o.description = "foo";
    o.etag = "foo";
    o.items = buildUnnamed1011();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.nextSyncToken = "foo";
    o.summary = "foo";
    o.timeZone = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
  }
  buildCounterEvents--;
  return o;
}

checkEvents(api.Events o) {
  buildCounterEvents++;
  if (buildCounterEvents < 3) {
    unittest.expect(o.accessRole, unittest.equals('foo'));
    checkUnnamed1010(o.defaultReminders);
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed1011(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.nextSyncToken, unittest.equals('foo'));
    unittest.expect(o.summary, unittest.equals('foo'));
    unittest.expect(o.timeZone, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
  }
  buildCounterEvents--;
}

buildUnnamed1012() {
  var o = new core.List<api.TimePeriod>();
  o.add(buildTimePeriod());
  o.add(buildTimePeriod());
  return o;
}

checkUnnamed1012(core.List<api.TimePeriod> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTimePeriod(o[0]);
  checkTimePeriod(o[1]);
}

buildUnnamed1013() {
  var o = new core.List<api.Error>();
  o.add(buildError());
  o.add(buildError());
  return o;
}

checkUnnamed1013(core.List<api.Error> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkError(o[0]);
  checkError(o[1]);
}

core.int buildCounterFreeBusyCalendar = 0;
buildFreeBusyCalendar() {
  var o = new api.FreeBusyCalendar();
  buildCounterFreeBusyCalendar++;
  if (buildCounterFreeBusyCalendar < 3) {
    o.busy = buildUnnamed1012();
    o.errors = buildUnnamed1013();
  }
  buildCounterFreeBusyCalendar--;
  return o;
}

checkFreeBusyCalendar(api.FreeBusyCalendar o) {
  buildCounterFreeBusyCalendar++;
  if (buildCounterFreeBusyCalendar < 3) {
    checkUnnamed1012(o.busy);
    checkUnnamed1013(o.errors);
  }
  buildCounterFreeBusyCalendar--;
}

buildUnnamed1014() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1014(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1015() {
  var o = new core.List<api.Error>();
  o.add(buildError());
  o.add(buildError());
  return o;
}

checkUnnamed1015(core.List<api.Error> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkError(o[0]);
  checkError(o[1]);
}

core.int buildCounterFreeBusyGroup = 0;
buildFreeBusyGroup() {
  var o = new api.FreeBusyGroup();
  buildCounterFreeBusyGroup++;
  if (buildCounterFreeBusyGroup < 3) {
    o.calendars = buildUnnamed1014();
    o.errors = buildUnnamed1015();
  }
  buildCounterFreeBusyGroup--;
  return o;
}

checkFreeBusyGroup(api.FreeBusyGroup o) {
  buildCounterFreeBusyGroup++;
  if (buildCounterFreeBusyGroup < 3) {
    checkUnnamed1014(o.calendars);
    checkUnnamed1015(o.errors);
  }
  buildCounterFreeBusyGroup--;
}

buildUnnamed1016() {
  var o = new core.List<api.FreeBusyRequestItem>();
  o.add(buildFreeBusyRequestItem());
  o.add(buildFreeBusyRequestItem());
  return o;
}

checkUnnamed1016(core.List<api.FreeBusyRequestItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFreeBusyRequestItem(o[0]);
  checkFreeBusyRequestItem(o[1]);
}

core.int buildCounterFreeBusyRequest = 0;
buildFreeBusyRequest() {
  var o = new api.FreeBusyRequest();
  buildCounterFreeBusyRequest++;
  if (buildCounterFreeBusyRequest < 3) {
    o.calendarExpansionMax = 42;
    o.groupExpansionMax = 42;
    o.items = buildUnnamed1016();
    o.timeMax = core.DateTime.parse("2002-02-27T14:01:02");
    o.timeMin = core.DateTime.parse("2002-02-27T14:01:02");
    o.timeZone = "foo";
  }
  buildCounterFreeBusyRequest--;
  return o;
}

checkFreeBusyRequest(api.FreeBusyRequest o) {
  buildCounterFreeBusyRequest++;
  if (buildCounterFreeBusyRequest < 3) {
    unittest.expect(o.calendarExpansionMax, unittest.equals(42));
    unittest.expect(o.groupExpansionMax, unittest.equals(42));
    checkUnnamed1016(o.items);
    unittest.expect(o.timeMax, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.timeMin, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.timeZone, unittest.equals('foo'));
  }
  buildCounterFreeBusyRequest--;
}

core.int buildCounterFreeBusyRequestItem = 0;
buildFreeBusyRequestItem() {
  var o = new api.FreeBusyRequestItem();
  buildCounterFreeBusyRequestItem++;
  if (buildCounterFreeBusyRequestItem < 3) {
    o.id = "foo";
  }
  buildCounterFreeBusyRequestItem--;
  return o;
}

checkFreeBusyRequestItem(api.FreeBusyRequestItem o) {
  buildCounterFreeBusyRequestItem++;
  if (buildCounterFreeBusyRequestItem < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
  }
  buildCounterFreeBusyRequestItem--;
}

buildUnnamed1017() {
  var o = new core.Map<core.String, api.FreeBusyCalendar>();
  o["x"] = buildFreeBusyCalendar();
  o["y"] = buildFreeBusyCalendar();
  return o;
}

checkUnnamed1017(core.Map<core.String, api.FreeBusyCalendar> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFreeBusyCalendar(o["x"]);
  checkFreeBusyCalendar(o["y"]);
}

buildUnnamed1018() {
  var o = new core.Map<core.String, api.FreeBusyGroup>();
  o["x"] = buildFreeBusyGroup();
  o["y"] = buildFreeBusyGroup();
  return o;
}

checkUnnamed1018(core.Map<core.String, api.FreeBusyGroup> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFreeBusyGroup(o["x"]);
  checkFreeBusyGroup(o["y"]);
}

core.int buildCounterFreeBusyResponse = 0;
buildFreeBusyResponse() {
  var o = new api.FreeBusyResponse();
  buildCounterFreeBusyResponse++;
  if (buildCounterFreeBusyResponse < 3) {
    o.calendars = buildUnnamed1017();
    o.groups = buildUnnamed1018();
    o.kind = "foo";
    o.timeMax = core.DateTime.parse("2002-02-27T14:01:02");
    o.timeMin = core.DateTime.parse("2002-02-27T14:01:02");
  }
  buildCounterFreeBusyResponse--;
  return o;
}

checkFreeBusyResponse(api.FreeBusyResponse o) {
  buildCounterFreeBusyResponse++;
  if (buildCounterFreeBusyResponse < 3) {
    checkUnnamed1017(o.calendars);
    checkUnnamed1018(o.groups);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.timeMax, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.timeMin, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
  }
  buildCounterFreeBusyResponse--;
}

core.int buildCounterSetting = 0;
buildSetting() {
  var o = new api.Setting();
  buildCounterSetting++;
  if (buildCounterSetting < 3) {
    o.etag = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.value = "foo";
  }
  buildCounterSetting--;
  return o;
}

checkSetting(api.Setting o) {
  buildCounterSetting++;
  if (buildCounterSetting < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterSetting--;
}

buildUnnamed1019() {
  var o = new core.List<api.Setting>();
  o.add(buildSetting());
  o.add(buildSetting());
  return o;
}

checkUnnamed1019(core.List<api.Setting> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSetting(o[0]);
  checkSetting(o[1]);
}

core.int buildCounterSettings = 0;
buildSettings() {
  var o = new api.Settings();
  buildCounterSettings++;
  if (buildCounterSettings < 3) {
    o.etag = "foo";
    o.items = buildUnnamed1019();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.nextSyncToken = "foo";
  }
  buildCounterSettings--;
  return o;
}

checkSettings(api.Settings o) {
  buildCounterSettings++;
  if (buildCounterSettings < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed1019(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.nextSyncToken, unittest.equals('foo'));
  }
  buildCounterSettings--;
}

core.int buildCounterTimePeriod = 0;
buildTimePeriod() {
  var o = new api.TimePeriod();
  buildCounterTimePeriod++;
  if (buildCounterTimePeriod < 3) {
    o.end = core.DateTime.parse("2002-02-27T14:01:02");
    o.start = core.DateTime.parse("2002-02-27T14:01:02");
  }
  buildCounterTimePeriod--;
  return o;
}

checkTimePeriod(api.TimePeriod o) {
  buildCounterTimePeriod++;
  if (buildCounterTimePeriod < 3) {
    unittest.expect(o.end, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.start, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
  }
  buildCounterTimePeriod--;
}

buildUnnamed1020() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1020(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1021() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1021(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1022() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1022(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1023() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1023(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}


main() {
  unittest.group("obj-schema-Acl", () {
    unittest.test("to-json--from-json", () {
      var o = buildAcl();
      var od = new api.Acl.fromJson(o.toJson());
      checkAcl(od);
    });
  });


  unittest.group("obj-schema-AclRuleScope", () {
    unittest.test("to-json--from-json", () {
      var o = buildAclRuleScope();
      var od = new api.AclRuleScope.fromJson(o.toJson());
      checkAclRuleScope(od);
    });
  });


  unittest.group("obj-schema-AclRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildAclRule();
      var od = new api.AclRule.fromJson(o.toJson());
      checkAclRule(od);
    });
  });


  unittest.group("obj-schema-Calendar", () {
    unittest.test("to-json--from-json", () {
      var o = buildCalendar();
      var od = new api.Calendar.fromJson(o.toJson());
      checkCalendar(od);
    });
  });


  unittest.group("obj-schema-CalendarList", () {
    unittest.test("to-json--from-json", () {
      var o = buildCalendarList();
      var od = new api.CalendarList.fromJson(o.toJson());
      checkCalendarList(od);
    });
  });


  unittest.group("obj-schema-CalendarListEntryNotificationSettings", () {
    unittest.test("to-json--from-json", () {
      var o = buildCalendarListEntryNotificationSettings();
      var od = new api.CalendarListEntryNotificationSettings.fromJson(o.toJson());
      checkCalendarListEntryNotificationSettings(od);
    });
  });


  unittest.group("obj-schema-CalendarListEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildCalendarListEntry();
      var od = new api.CalendarListEntry.fromJson(o.toJson());
      checkCalendarListEntry(od);
    });
  });


  unittest.group("obj-schema-CalendarNotification", () {
    unittest.test("to-json--from-json", () {
      var o = buildCalendarNotification();
      var od = new api.CalendarNotification.fromJson(o.toJson());
      checkCalendarNotification(od);
    });
  });


  unittest.group("obj-schema-Channel", () {
    unittest.test("to-json--from-json", () {
      var o = buildChannel();
      var od = new api.Channel.fromJson(o.toJson());
      checkChannel(od);
    });
  });


  unittest.group("obj-schema-ColorDefinition", () {
    unittest.test("to-json--from-json", () {
      var o = buildColorDefinition();
      var od = new api.ColorDefinition.fromJson(o.toJson());
      checkColorDefinition(od);
    });
  });


  unittest.group("obj-schema-Colors", () {
    unittest.test("to-json--from-json", () {
      var o = buildColors();
      var od = new api.Colors.fromJson(o.toJson());
      checkColors(od);
    });
  });


  unittest.group("obj-schema-Error", () {
    unittest.test("to-json--from-json", () {
      var o = buildError();
      var od = new api.Error.fromJson(o.toJson());
      checkError(od);
    });
  });


  unittest.group("obj-schema-EventCreator", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventCreator();
      var od = new api.EventCreator.fromJson(o.toJson());
      checkEventCreator(od);
    });
  });


  unittest.group("obj-schema-EventExtendedProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventExtendedProperties();
      var od = new api.EventExtendedProperties.fromJson(o.toJson());
      checkEventExtendedProperties(od);
    });
  });


  unittest.group("obj-schema-EventGadget", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventGadget();
      var od = new api.EventGadget.fromJson(o.toJson());
      checkEventGadget(od);
    });
  });


  unittest.group("obj-schema-EventOrganizer", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventOrganizer();
      var od = new api.EventOrganizer.fromJson(o.toJson());
      checkEventOrganizer(od);
    });
  });


  unittest.group("obj-schema-EventReminders", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventReminders();
      var od = new api.EventReminders.fromJson(o.toJson());
      checkEventReminders(od);
    });
  });


  unittest.group("obj-schema-EventSource", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventSource();
      var od = new api.EventSource.fromJson(o.toJson());
      checkEventSource(od);
    });
  });


  unittest.group("obj-schema-Event", () {
    unittest.test("to-json--from-json", () {
      var o = buildEvent();
      var od = new api.Event.fromJson(o.toJson());
      checkEvent(od);
    });
  });


  unittest.group("obj-schema-EventAttachment", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventAttachment();
      var od = new api.EventAttachment.fromJson(o.toJson());
      checkEventAttachment(od);
    });
  });


  unittest.group("obj-schema-EventAttendee", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventAttendee();
      var od = new api.EventAttendee.fromJson(o.toJson());
      checkEventAttendee(od);
    });
  });


  unittest.group("obj-schema-EventDateTime", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventDateTime();
      var od = new api.EventDateTime.fromJson(o.toJson());
      checkEventDateTime(od);
    });
  });


  unittest.group("obj-schema-EventReminder", () {
    unittest.test("to-json--from-json", () {
      var o = buildEventReminder();
      var od = new api.EventReminder.fromJson(o.toJson());
      checkEventReminder(od);
    });
  });


  unittest.group("obj-schema-Events", () {
    unittest.test("to-json--from-json", () {
      var o = buildEvents();
      var od = new api.Events.fromJson(o.toJson());
      checkEvents(od);
    });
  });


  unittest.group("obj-schema-FreeBusyCalendar", () {
    unittest.test("to-json--from-json", () {
      var o = buildFreeBusyCalendar();
      var od = new api.FreeBusyCalendar.fromJson(o.toJson());
      checkFreeBusyCalendar(od);
    });
  });


  unittest.group("obj-schema-FreeBusyGroup", () {
    unittest.test("to-json--from-json", () {
      var o = buildFreeBusyGroup();
      var od = new api.FreeBusyGroup.fromJson(o.toJson());
      checkFreeBusyGroup(od);
    });
  });


  unittest.group("obj-schema-FreeBusyRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildFreeBusyRequest();
      var od = new api.FreeBusyRequest.fromJson(o.toJson());
      checkFreeBusyRequest(od);
    });
  });


  unittest.group("obj-schema-FreeBusyRequestItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildFreeBusyRequestItem();
      var od = new api.FreeBusyRequestItem.fromJson(o.toJson());
      checkFreeBusyRequestItem(od);
    });
  });


  unittest.group("obj-schema-FreeBusyResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildFreeBusyResponse();
      var od = new api.FreeBusyResponse.fromJson(o.toJson());
      checkFreeBusyResponse(od);
    });
  });


  unittest.group("obj-schema-Setting", () {
    unittest.test("to-json--from-json", () {
      var o = buildSetting();
      var od = new api.Setting.fromJson(o.toJson());
      checkSetting(od);
    });
  });


  unittest.group("obj-schema-Settings", () {
    unittest.test("to-json--from-json", () {
      var o = buildSettings();
      var od = new api.Settings.fromJson(o.toJson());
      checkSettings(od);
    });
  });


  unittest.group("obj-schema-TimePeriod", () {
    unittest.test("to-json--from-json", () {
      var o = buildTimePeriod();
      var od = new api.TimePeriod.fromJson(o.toJson());
      checkTimePeriod(od);
    });
  });


  unittest.group("resource-AclResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.AclResourceApi res = new api.CalendarApi(mock).acl;
      var arg_calendarId = "foo";
      var arg_ruleId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/acl/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("/acl/"));
        pathOffset += 5;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_ruleId"));

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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_calendarId, arg_ruleId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.AclResourceApi res = new api.CalendarApi(mock).acl;
      var arg_calendarId = "foo";
      var arg_ruleId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/acl/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("/acl/"));
        pathOffset += 5;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_ruleId"));

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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAclRule());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_calendarId, arg_ruleId).then(unittest.expectAsync(((api.AclRule response) {
        checkAclRule(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.AclResourceApi res = new api.CalendarApi(mock).acl;
      var arg_request = buildAclRule();
      var arg_calendarId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AclRule.fromJson(json);
        checkAclRule(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/acl", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 4), unittest.equals("/acl"));
        pathOffset += 4;

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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAclRule());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_calendarId).then(unittest.expectAsync(((api.AclRule response) {
        checkAclRule(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.AclResourceApi res = new api.CalendarApi(mock).acl;
      var arg_calendarId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_showDeleted = true;
      var arg_syncToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/acl", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 4), unittest.equals("/acl"));
        pathOffset += 4;

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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["showDeleted"].first, unittest.equals("$arg_showDeleted"));
        unittest.expect(queryMap["syncToken"].first, unittest.equals(arg_syncToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAcl());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_calendarId, maxResults: arg_maxResults, pageToken: arg_pageToken, showDeleted: arg_showDeleted, syncToken: arg_syncToken).then(unittest.expectAsync(((api.Acl response) {
        checkAcl(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.AclResourceApi res = new api.CalendarApi(mock).acl;
      var arg_request = buildAclRule();
      var arg_calendarId = "foo";
      var arg_ruleId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AclRule.fromJson(json);
        checkAclRule(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/acl/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("/acl/"));
        pathOffset += 5;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_ruleId"));

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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAclRule());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_calendarId, arg_ruleId).then(unittest.expectAsync(((api.AclRule response) {
        checkAclRule(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.AclResourceApi res = new api.CalendarApi(mock).acl;
      var arg_request = buildAclRule();
      var arg_calendarId = "foo";
      var arg_ruleId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.AclRule.fromJson(json);
        checkAclRule(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/acl/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("/acl/"));
        pathOffset += 5;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_ruleId"));

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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildAclRule());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_calendarId, arg_ruleId).then(unittest.expectAsync(((api.AclRule response) {
        checkAclRule(response);
      })));
    });

    unittest.test("method--watch", () {

      var mock = new HttpServerMock();
      api.AclResourceApi res = new api.CalendarApi(mock).acl;
      var arg_request = buildChannel();
      var arg_calendarId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_showDeleted = true;
      var arg_syncToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Channel.fromJson(json);
        checkChannel(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/acl/watch", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/acl/watch"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["showDeleted"].first, unittest.equals("$arg_showDeleted"));
        unittest.expect(queryMap["syncToken"].first, unittest.equals(arg_syncToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildChannel());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.watch(arg_request, arg_calendarId, maxResults: arg_maxResults, pageToken: arg_pageToken, showDeleted: arg_showDeleted, syncToken: arg_syncToken).then(unittest.expectAsync(((api.Channel response) {
        checkChannel(response);
      })));
    });

  });


  unittest.group("resource-CalendarListResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.CalendarListResourceApi res = new api.CalendarApi(mock).calendarList;
      var arg_calendarId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("users/me/calendarList/"));
        pathOffset += 22;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));

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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_calendarId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.CalendarListResourceApi res = new api.CalendarApi(mock).calendarList;
      var arg_calendarId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("users/me/calendarList/"));
        pathOffset += 22;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));

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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCalendarListEntry());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_calendarId).then(unittest.expectAsync(((api.CalendarListEntry response) {
        checkCalendarListEntry(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.CalendarListResourceApi res = new api.CalendarApi(mock).calendarList;
      var arg_request = buildCalendarListEntry();
      var arg_colorRgbFormat = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.CalendarListEntry.fromJson(json);
        checkCalendarListEntry(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("users/me/calendarList"));
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
        unittest.expect(queryMap["colorRgbFormat"].first, unittest.equals("$arg_colorRgbFormat"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCalendarListEntry());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, colorRgbFormat: arg_colorRgbFormat).then(unittest.expectAsync(((api.CalendarListEntry response) {
        checkCalendarListEntry(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.CalendarListResourceApi res = new api.CalendarApi(mock).calendarList;
      var arg_maxResults = 42;
      var arg_minAccessRole = "foo";
      var arg_pageToken = "foo";
      var arg_showDeleted = true;
      var arg_showHidden = true;
      var arg_syncToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 21), unittest.equals("users/me/calendarList"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["minAccessRole"].first, unittest.equals(arg_minAccessRole));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["showDeleted"].first, unittest.equals("$arg_showDeleted"));
        unittest.expect(queryMap["showHidden"].first, unittest.equals("$arg_showHidden"));
        unittest.expect(queryMap["syncToken"].first, unittest.equals(arg_syncToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCalendarList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(maxResults: arg_maxResults, minAccessRole: arg_minAccessRole, pageToken: arg_pageToken, showDeleted: arg_showDeleted, showHidden: arg_showHidden, syncToken: arg_syncToken).then(unittest.expectAsync(((api.CalendarList response) {
        checkCalendarList(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.CalendarListResourceApi res = new api.CalendarApi(mock).calendarList;
      var arg_request = buildCalendarListEntry();
      var arg_calendarId = "foo";
      var arg_colorRgbFormat = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.CalendarListEntry.fromJson(json);
        checkCalendarListEntry(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("users/me/calendarList/"));
        pathOffset += 22;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));

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
        unittest.expect(queryMap["colorRgbFormat"].first, unittest.equals("$arg_colorRgbFormat"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCalendarListEntry());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_calendarId, colorRgbFormat: arg_colorRgbFormat).then(unittest.expectAsync(((api.CalendarListEntry response) {
        checkCalendarListEntry(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.CalendarListResourceApi res = new api.CalendarApi(mock).calendarList;
      var arg_request = buildCalendarListEntry();
      var arg_calendarId = "foo";
      var arg_colorRgbFormat = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.CalendarListEntry.fromJson(json);
        checkCalendarListEntry(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 22), unittest.equals("users/me/calendarList/"));
        pathOffset += 22;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));

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
        unittest.expect(queryMap["colorRgbFormat"].first, unittest.equals("$arg_colorRgbFormat"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCalendarListEntry());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_calendarId, colorRgbFormat: arg_colorRgbFormat).then(unittest.expectAsync(((api.CalendarListEntry response) {
        checkCalendarListEntry(response);
      })));
    });

    unittest.test("method--watch", () {

      var mock = new HttpServerMock();
      api.CalendarListResourceApi res = new api.CalendarApi(mock).calendarList;
      var arg_request = buildChannel();
      var arg_maxResults = 42;
      var arg_minAccessRole = "foo";
      var arg_pageToken = "foo";
      var arg_showDeleted = true;
      var arg_showHidden = true;
      var arg_syncToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Channel.fromJson(json);
        checkChannel(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 27), unittest.equals("users/me/calendarList/watch"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["minAccessRole"].first, unittest.equals(arg_minAccessRole));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["showDeleted"].first, unittest.equals("$arg_showDeleted"));
        unittest.expect(queryMap["showHidden"].first, unittest.equals("$arg_showHidden"));
        unittest.expect(queryMap["syncToken"].first, unittest.equals(arg_syncToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildChannel());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.watch(arg_request, maxResults: arg_maxResults, minAccessRole: arg_minAccessRole, pageToken: arg_pageToken, showDeleted: arg_showDeleted, showHidden: arg_showHidden, syncToken: arg_syncToken).then(unittest.expectAsync(((api.Channel response) {
        checkChannel(response);
      })));
    });

  });


  unittest.group("resource-CalendarsResourceApi", () {
    unittest.test("method--clear", () {

      var mock = new HttpServerMock();
      api.CalendarsResourceApi res = new api.CalendarApi(mock).calendars;
      var arg_calendarId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/clear", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/clear"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.clear(arg_calendarId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.CalendarsResourceApi res = new api.CalendarApi(mock).calendars;
      var arg_calendarId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));

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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_calendarId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.CalendarsResourceApi res = new api.CalendarApi(mock).calendars;
      var arg_calendarId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));

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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCalendar());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_calendarId).then(unittest.expectAsync(((api.Calendar response) {
        checkCalendar(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.CalendarsResourceApi res = new api.CalendarApi(mock).calendars;
      var arg_request = buildCalendar();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Calendar.fromJson(json);
        checkCalendar(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("calendars"));
        pathOffset += 9;

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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCalendar());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request).then(unittest.expectAsync(((api.Calendar response) {
        checkCalendar(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.CalendarsResourceApi res = new api.CalendarApi(mock).calendars;
      var arg_request = buildCalendar();
      var arg_calendarId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Calendar.fromJson(json);
        checkCalendar(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));

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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCalendar());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_calendarId).then(unittest.expectAsync(((api.Calendar response) {
        checkCalendar(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.CalendarsResourceApi res = new api.CalendarApi(mock).calendars;
      var arg_request = buildCalendar();
      var arg_calendarId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Calendar.fromJson(json);
        checkCalendar(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));

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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCalendar());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_calendarId).then(unittest.expectAsync(((api.Calendar response) {
        checkCalendar(response);
      })));
    });

  });


  unittest.group("resource-ChannelsResourceApi", () {
    unittest.test("method--stop", () {

      var mock = new HttpServerMock();
      api.ChannelsResourceApi res = new api.CalendarApi(mock).channels;
      var arg_request = buildChannel();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Channel.fromJson(json);
        checkChannel(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("channels/stop"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.stop(arg_request).then(unittest.expectAsync((_) {}));
    });

  });


  unittest.group("resource-ColorsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.ColorsResourceApi res = new api.CalendarApi(mock).colors;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("colors"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildColors());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get().then(unittest.expectAsync(((api.Colors response) {
        checkColors(response);
      })));
    });

  });


  unittest.group("resource-EventsResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.CalendarApi(mock).events;
      var arg_calendarId = "foo";
      var arg_eventId = "foo";
      var arg_sendNotifications = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/events/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/events/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_eventId"));

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
        unittest.expect(queryMap["sendNotifications"].first, unittest.equals("$arg_sendNotifications"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_calendarId, arg_eventId, sendNotifications: arg_sendNotifications).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.CalendarApi(mock).events;
      var arg_calendarId = "foo";
      var arg_eventId = "foo";
      var arg_alwaysIncludeEmail = true;
      var arg_maxAttendees = 42;
      var arg_timeZone = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/events/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/events/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_eventId"));

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
        unittest.expect(queryMap["alwaysIncludeEmail"].first, unittest.equals("$arg_alwaysIncludeEmail"));
        unittest.expect(core.int.parse(queryMap["maxAttendees"].first), unittest.equals(arg_maxAttendees));
        unittest.expect(queryMap["timeZone"].first, unittest.equals(arg_timeZone));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEvent());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_calendarId, arg_eventId, alwaysIncludeEmail: arg_alwaysIncludeEmail, maxAttendees: arg_maxAttendees, timeZone: arg_timeZone).then(unittest.expectAsync(((api.Event response) {
        checkEvent(response);
      })));
    });

    unittest.test("method--import", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.CalendarApi(mock).events;
      var arg_request = buildEvent();
      var arg_calendarId = "foo";
      var arg_supportsAttachments = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Event.fromJson(json);
        checkEvent(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/events/import", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 14), unittest.equals("/events/import"));
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
        unittest.expect(queryMap["supportsAttachments"].first, unittest.equals("$arg_supportsAttachments"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEvent());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.import(arg_request, arg_calendarId, supportsAttachments: arg_supportsAttachments).then(unittest.expectAsync(((api.Event response) {
        checkEvent(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.CalendarApi(mock).events;
      var arg_request = buildEvent();
      var arg_calendarId = "foo";
      var arg_maxAttendees = 42;
      var arg_sendNotifications = true;
      var arg_supportsAttachments = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Event.fromJson(json);
        checkEvent(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/events", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/events"));
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
        unittest.expect(core.int.parse(queryMap["maxAttendees"].first), unittest.equals(arg_maxAttendees));
        unittest.expect(queryMap["sendNotifications"].first, unittest.equals("$arg_sendNotifications"));
        unittest.expect(queryMap["supportsAttachments"].first, unittest.equals("$arg_supportsAttachments"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEvent());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_calendarId, maxAttendees: arg_maxAttendees, sendNotifications: arg_sendNotifications, supportsAttachments: arg_supportsAttachments).then(unittest.expectAsync(((api.Event response) {
        checkEvent(response);
      })));
    });

    unittest.test("method--instances", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.CalendarApi(mock).events;
      var arg_calendarId = "foo";
      var arg_eventId = "foo";
      var arg_alwaysIncludeEmail = true;
      var arg_maxAttendees = 42;
      var arg_maxResults = 42;
      var arg_originalStart = "foo";
      var arg_pageToken = "foo";
      var arg_showDeleted = true;
      var arg_timeMax = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_timeMin = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_timeZone = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/events/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/events/"));
        pathOffset += 8;
        index = path.indexOf("/instances", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_eventId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/instances"));
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
        unittest.expect(queryMap["alwaysIncludeEmail"].first, unittest.equals("$arg_alwaysIncludeEmail"));
        unittest.expect(core.int.parse(queryMap["maxAttendees"].first), unittest.equals(arg_maxAttendees));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["originalStart"].first, unittest.equals(arg_originalStart));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["showDeleted"].first, unittest.equals("$arg_showDeleted"));
        unittest.expect(core.DateTime.parse(queryMap["timeMax"].first), unittest.equals(arg_timeMax));
        unittest.expect(core.DateTime.parse(queryMap["timeMin"].first), unittest.equals(arg_timeMin));
        unittest.expect(queryMap["timeZone"].first, unittest.equals(arg_timeZone));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEvents());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.instances(arg_calendarId, arg_eventId, alwaysIncludeEmail: arg_alwaysIncludeEmail, maxAttendees: arg_maxAttendees, maxResults: arg_maxResults, originalStart: arg_originalStart, pageToken: arg_pageToken, showDeleted: arg_showDeleted, timeMax: arg_timeMax, timeMin: arg_timeMin, timeZone: arg_timeZone).then(unittest.expectAsync(((api.Events response) {
        checkEvents(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.CalendarApi(mock).events;
      var arg_calendarId = "foo";
      var arg_alwaysIncludeEmail = true;
      var arg_iCalUID = "foo";
      var arg_maxAttendees = 42;
      var arg_maxResults = 42;
      var arg_orderBy = "foo";
      var arg_pageToken = "foo";
      var arg_privateExtendedProperty = buildUnnamed1020();
      var arg_q = "foo";
      var arg_sharedExtendedProperty = buildUnnamed1021();
      var arg_showDeleted = true;
      var arg_showHiddenInvitations = true;
      var arg_singleEvents = true;
      var arg_syncToken = "foo";
      var arg_timeMax = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_timeMin = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_timeZone = "foo";
      var arg_updatedMin = core.DateTime.parse("2002-02-27T14:01:02");
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/events", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/events"));
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
        unittest.expect(queryMap["alwaysIncludeEmail"].first, unittest.equals("$arg_alwaysIncludeEmail"));
        unittest.expect(queryMap["iCalUID"].first, unittest.equals(arg_iCalUID));
        unittest.expect(core.int.parse(queryMap["maxAttendees"].first), unittest.equals(arg_maxAttendees));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["orderBy"].first, unittest.equals(arg_orderBy));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["privateExtendedProperty"], unittest.equals(arg_privateExtendedProperty));
        unittest.expect(queryMap["q"].first, unittest.equals(arg_q));
        unittest.expect(queryMap["sharedExtendedProperty"], unittest.equals(arg_sharedExtendedProperty));
        unittest.expect(queryMap["showDeleted"].first, unittest.equals("$arg_showDeleted"));
        unittest.expect(queryMap["showHiddenInvitations"].first, unittest.equals("$arg_showHiddenInvitations"));
        unittest.expect(queryMap["singleEvents"].first, unittest.equals("$arg_singleEvents"));
        unittest.expect(queryMap["syncToken"].first, unittest.equals(arg_syncToken));
        unittest.expect(core.DateTime.parse(queryMap["timeMax"].first), unittest.equals(arg_timeMax));
        unittest.expect(core.DateTime.parse(queryMap["timeMin"].first), unittest.equals(arg_timeMin));
        unittest.expect(queryMap["timeZone"].first, unittest.equals(arg_timeZone));
        unittest.expect(core.DateTime.parse(queryMap["updatedMin"].first), unittest.equals(arg_updatedMin));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEvents());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_calendarId, alwaysIncludeEmail: arg_alwaysIncludeEmail, iCalUID: arg_iCalUID, maxAttendees: arg_maxAttendees, maxResults: arg_maxResults, orderBy: arg_orderBy, pageToken: arg_pageToken, privateExtendedProperty: arg_privateExtendedProperty, q: arg_q, sharedExtendedProperty: arg_sharedExtendedProperty, showDeleted: arg_showDeleted, showHiddenInvitations: arg_showHiddenInvitations, singleEvents: arg_singleEvents, syncToken: arg_syncToken, timeMax: arg_timeMax, timeMin: arg_timeMin, timeZone: arg_timeZone, updatedMin: arg_updatedMin).then(unittest.expectAsync(((api.Events response) {
        checkEvents(response);
      })));
    });

    unittest.test("method--move", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.CalendarApi(mock).events;
      var arg_calendarId = "foo";
      var arg_eventId = "foo";
      var arg_destination = "foo";
      var arg_sendNotifications = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/events/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/events/"));
        pathOffset += 8;
        index = path.indexOf("/move", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_eventId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("/move"));
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
        unittest.expect(queryMap["destination"].first, unittest.equals(arg_destination));
        unittest.expect(queryMap["sendNotifications"].first, unittest.equals("$arg_sendNotifications"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEvent());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.move(arg_calendarId, arg_eventId, arg_destination, sendNotifications: arg_sendNotifications).then(unittest.expectAsync(((api.Event response) {
        checkEvent(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.CalendarApi(mock).events;
      var arg_request = buildEvent();
      var arg_calendarId = "foo";
      var arg_eventId = "foo";
      var arg_alwaysIncludeEmail = true;
      var arg_maxAttendees = 42;
      var arg_sendNotifications = true;
      var arg_supportsAttachments = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Event.fromJson(json);
        checkEvent(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/events/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/events/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_eventId"));

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
        unittest.expect(queryMap["alwaysIncludeEmail"].first, unittest.equals("$arg_alwaysIncludeEmail"));
        unittest.expect(core.int.parse(queryMap["maxAttendees"].first), unittest.equals(arg_maxAttendees));
        unittest.expect(queryMap["sendNotifications"].first, unittest.equals("$arg_sendNotifications"));
        unittest.expect(queryMap["supportsAttachments"].first, unittest.equals("$arg_supportsAttachments"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEvent());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_calendarId, arg_eventId, alwaysIncludeEmail: arg_alwaysIncludeEmail, maxAttendees: arg_maxAttendees, sendNotifications: arg_sendNotifications, supportsAttachments: arg_supportsAttachments).then(unittest.expectAsync(((api.Event response) {
        checkEvent(response);
      })));
    });

    unittest.test("method--quickAdd", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.CalendarApi(mock).events;
      var arg_calendarId = "foo";
      var arg_text = "foo";
      var arg_sendNotifications = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/events/quickAdd", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 16), unittest.equals("/events/quickAdd"));
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
        unittest.expect(queryMap["text"].first, unittest.equals(arg_text));
        unittest.expect(queryMap["sendNotifications"].first, unittest.equals("$arg_sendNotifications"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEvent());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.quickAdd(arg_calendarId, arg_text, sendNotifications: arg_sendNotifications).then(unittest.expectAsync(((api.Event response) {
        checkEvent(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.CalendarApi(mock).events;
      var arg_request = buildEvent();
      var arg_calendarId = "foo";
      var arg_eventId = "foo";
      var arg_alwaysIncludeEmail = true;
      var arg_maxAttendees = 42;
      var arg_sendNotifications = true;
      var arg_supportsAttachments = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Event.fromJson(json);
        checkEvent(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/events/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/events/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_eventId"));

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
        unittest.expect(queryMap["alwaysIncludeEmail"].first, unittest.equals("$arg_alwaysIncludeEmail"));
        unittest.expect(core.int.parse(queryMap["maxAttendees"].first), unittest.equals(arg_maxAttendees));
        unittest.expect(queryMap["sendNotifications"].first, unittest.equals("$arg_sendNotifications"));
        unittest.expect(queryMap["supportsAttachments"].first, unittest.equals("$arg_supportsAttachments"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildEvent());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_calendarId, arg_eventId, alwaysIncludeEmail: arg_alwaysIncludeEmail, maxAttendees: arg_maxAttendees, sendNotifications: arg_sendNotifications, supportsAttachments: arg_supportsAttachments).then(unittest.expectAsync(((api.Event response) {
        checkEvent(response);
      })));
    });

    unittest.test("method--watch", () {

      var mock = new HttpServerMock();
      api.EventsResourceApi res = new api.CalendarApi(mock).events;
      var arg_request = buildChannel();
      var arg_calendarId = "foo";
      var arg_alwaysIncludeEmail = true;
      var arg_iCalUID = "foo";
      var arg_maxAttendees = 42;
      var arg_maxResults = 42;
      var arg_orderBy = "foo";
      var arg_pageToken = "foo";
      var arg_privateExtendedProperty = buildUnnamed1022();
      var arg_q = "foo";
      var arg_sharedExtendedProperty = buildUnnamed1023();
      var arg_showDeleted = true;
      var arg_showHiddenInvitations = true;
      var arg_singleEvents = true;
      var arg_syncToken = "foo";
      var arg_timeMax = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_timeMin = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_timeZone = "foo";
      var arg_updatedMin = core.DateTime.parse("2002-02-27T14:01:02");
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Channel.fromJson(json);
        checkChannel(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("calendars/"));
        pathOffset += 10;
        index = path.indexOf("/events/watch", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_calendarId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/events/watch"));
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
        unittest.expect(queryMap["alwaysIncludeEmail"].first, unittest.equals("$arg_alwaysIncludeEmail"));
        unittest.expect(queryMap["iCalUID"].first, unittest.equals(arg_iCalUID));
        unittest.expect(core.int.parse(queryMap["maxAttendees"].first), unittest.equals(arg_maxAttendees));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["orderBy"].first, unittest.equals(arg_orderBy));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["privateExtendedProperty"], unittest.equals(arg_privateExtendedProperty));
        unittest.expect(queryMap["q"].first, unittest.equals(arg_q));
        unittest.expect(queryMap["sharedExtendedProperty"], unittest.equals(arg_sharedExtendedProperty));
        unittest.expect(queryMap["showDeleted"].first, unittest.equals("$arg_showDeleted"));
        unittest.expect(queryMap["showHiddenInvitations"].first, unittest.equals("$arg_showHiddenInvitations"));
        unittest.expect(queryMap["singleEvents"].first, unittest.equals("$arg_singleEvents"));
        unittest.expect(queryMap["syncToken"].first, unittest.equals(arg_syncToken));
        unittest.expect(core.DateTime.parse(queryMap["timeMax"].first), unittest.equals(arg_timeMax));
        unittest.expect(core.DateTime.parse(queryMap["timeMin"].first), unittest.equals(arg_timeMin));
        unittest.expect(queryMap["timeZone"].first, unittest.equals(arg_timeZone));
        unittest.expect(core.DateTime.parse(queryMap["updatedMin"].first), unittest.equals(arg_updatedMin));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildChannel());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.watch(arg_request, arg_calendarId, alwaysIncludeEmail: arg_alwaysIncludeEmail, iCalUID: arg_iCalUID, maxAttendees: arg_maxAttendees, maxResults: arg_maxResults, orderBy: arg_orderBy, pageToken: arg_pageToken, privateExtendedProperty: arg_privateExtendedProperty, q: arg_q, sharedExtendedProperty: arg_sharedExtendedProperty, showDeleted: arg_showDeleted, showHiddenInvitations: arg_showHiddenInvitations, singleEvents: arg_singleEvents, syncToken: arg_syncToken, timeMax: arg_timeMax, timeMin: arg_timeMin, timeZone: arg_timeZone, updatedMin: arg_updatedMin).then(unittest.expectAsync(((api.Channel response) {
        checkChannel(response);
      })));
    });

  });


  unittest.group("resource-FreebusyResourceApi", () {
    unittest.test("method--query", () {

      var mock = new HttpServerMock();
      api.FreebusyResourceApi res = new api.CalendarApi(mock).freebusy;
      var arg_request = buildFreeBusyRequest();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.FreeBusyRequest.fromJson(json);
        checkFreeBusyRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("freeBusy"));
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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildFreeBusyResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.query(arg_request).then(unittest.expectAsync(((api.FreeBusyResponse response) {
        checkFreeBusyResponse(response);
      })));
    });

  });


  unittest.group("resource-SettingsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.SettingsResourceApi res = new api.CalendarApi(mock).settings;
      var arg_setting = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 18), unittest.equals("users/me/settings/"));
        pathOffset += 18;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_setting"));

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


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSetting());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_setting).then(unittest.expectAsync(((api.Setting response) {
        checkSetting(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.SettingsResourceApi res = new api.CalendarApi(mock).settings;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_syncToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 17), unittest.equals("users/me/settings"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["syncToken"].first, unittest.equals(arg_syncToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildSettings());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(maxResults: arg_maxResults, pageToken: arg_pageToken, syncToken: arg_syncToken).then(unittest.expectAsync(((api.Settings response) {
        checkSettings(response);
      })));
    });

    unittest.test("method--watch", () {

      var mock = new HttpServerMock();
      api.SettingsResourceApi res = new api.CalendarApi(mock).settings;
      var arg_request = buildChannel();
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_syncToken = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Channel.fromJson(json);
        checkChannel(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12), unittest.equals("calendar/v3/"));
        pathOffset += 12;
        unittest.expect(path.substring(pathOffset, pathOffset + 23), unittest.equals("users/me/settings/watch"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["syncToken"].first, unittest.equals(arg_syncToken));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildChannel());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.watch(arg_request, maxResults: arg_maxResults, pageToken: arg_pageToken, syncToken: arg_syncToken).then(unittest.expectAsync(((api.Channel response) {
        checkChannel(response);
      })));
    });

  });


}

