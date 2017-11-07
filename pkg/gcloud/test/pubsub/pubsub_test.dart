// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:unittest/unittest.dart';

import 'package:gcloud/pubsub.dart';

import 'package:googleapis_beta/pubsub/v1beta2.dart' as pubsub;

import '../common.dart';
import '../common_e2e.dart';

const String HOSTNAME = 'pubsub.googleapis.com';
const String ROOT_PATH = '/v1beta2/';

MockClient mockClient() => new MockClient(HOSTNAME, ROOT_PATH);

main() {
  group('api', () {
    var badTopicNames = [
      'projects/',
      'projects/topics',
      'projects/$PROJECT',
      'projects/$PROJECT/',
      'projects/${PROJECT}/topics',
      'projects/${PROJECT}/topics/'
    ];

    var badSubscriptionNames = [
      'projects/',
      'projects/subscriptions',
      'projects/$PROJECT',
      'projects/$PROJECT/',
      'projects/${PROJECT}/subscriptions',
      'projects/${PROJECT}/subscriptions/'
    ];

    group('topic', () {
      var name = 'test-topic';
      var absoluteName = 'projects/$PROJECT/topics/test-topic';

      test('create', () {
        var mock = mockClient();
        mock.register(
            'PUT',
            'projects/$PROJECT/topics/test-topic',
            expectAsync((request) {
              var requestTopic =
                  new pubsub.Topic.fromJson(JSON.decode(request.body));
              expect(requestTopic.name, absoluteName);
              return mock.respond(new pubsub.Topic()..name = absoluteName);
            }, count: 2));

        var api = new PubSub(mock, PROJECT);
        return api.createTopic(name).then(expectAsync((topic) {
          expect(topic.name, name);
          expect(topic.project, PROJECT);
          expect(topic.absoluteName, absoluteName);
          return api.createTopic(absoluteName).then(expectAsync((topic) {
            expect(topic.name, name);
            expect(topic.absoluteName, absoluteName);
          }));
        }));
      });

      test('create-error', () {
        var mock = mockClient();
        var api = new PubSub(mock, PROJECT);
        badTopicNames.forEach((name) {
          expect(() => api.createTopic(name), throwsArgumentError);
        });
        badSubscriptionNames.forEach((name) {
          expect(() => api.createTopic(name), throwsArgumentError);
        });
      });

      test('delete', () {
        var mock = mockClient();
        mock.register(
            'DELETE',
            'projects/test-project/topics/test-topic',
            expectAsync((request) {
              expect(request.body.length, 0);
              return mock.respondEmpty();
            }, count: 2));

        var api = new PubSub(mock, PROJECT);
        return api.deleteTopic(name).then(expectAsync((result) {
          expect(result, isNull);
          return api.deleteTopic(absoluteName).then(expectAsync((topic) {
            expect(result, isNull);
          }));
        }));
      });

      test('delete-error', () {
        var mock = mockClient();
        var api = new PubSub(mock, PROJECT);
        badTopicNames.forEach((name) {
          expect(() => api.deleteTopic(name), throwsArgumentError);
        });
        badSubscriptionNames.forEach((name) {
          expect(() => api.deleteTopic(name), throwsArgumentError);
        });
      });

      test('lookup', () {
        var mock = mockClient();
        mock.register(
            'GET',
            'projects/test-project/topics/test-topic',
            expectAsync((request) {
              expect(request.body.length, 0);
              return mock.respond(new pubsub.Topic()..name = absoluteName);
            }, count: 2));

        var api = new PubSub(mock, PROJECT);
        return api.lookupTopic(name).then(expectAsync((topic) {
          expect(topic.name, name);
          expect(topic.project, PROJECT);
          expect(topic.absoluteName, absoluteName);
          return api.lookupTopic(absoluteName).then(expectAsync((topic) {
            expect(topic.name, name);
            expect(topic.absoluteName, absoluteName);
          }));
        }));
      });

      test('lookup-error', () {
        var mock = mockClient();
        var api = new PubSub(mock, PROJECT);
        badTopicNames.forEach((name) {
          expect(() => api.lookupTopic(name), throwsArgumentError);
        });
        badSubscriptionNames.forEach((name) {
          expect(() => api.lookupTopic(name), throwsArgumentError);
        });
      });

      group('query', () {
        addTopics(pubsub.ListTopicsResponse response, int first, int count) {
          response.topics = [];
          for (int i = 0; i < count; i++) {
            response.topics
                .add(new pubsub.Topic()..name = 'topic-${first + i}');
          }
        }

        // Mock that expect/generates [n] topics in pages of page size
        // [pageSize].
        registerQueryMock(mock, n, pageSize, [totalCalls]) {
          var totalPages = (n + pageSize - 1) ~/ pageSize;
          // No items still generate one request.
          if (totalPages == 0) totalPages = 1;
          // Can pass in total calls if this mock is overwritten before all
          // expected pages are done, e.g. when testing errors.
          if (totalCalls == null) {
            totalCalls = totalPages;
          }
          var pageCount = 0;
          mock.register(
              'GET',
              'projects/$PROJECT/topics',
              expectAsync((request) {
                pageCount++;
                expect(request.url.queryParameters['pageSize'], '$pageSize');
                expect(request.body.length, 0);
                if (pageCount > 1) {
                  expect(request.url.queryParameters['pageToken'], 'next-page');
                }

                var response = new pubsub.ListTopicsResponse();
                var first = (pageCount - 1) * pageSize + 1;
                if (pageCount < totalPages) {
                  response.nextPageToken = 'next-page';
                  addTopics(response, first, pageSize);
                } else {
                  addTopics(response, first, n - (totalPages - 1) * pageSize);
                }
                return mock.respond(response);
              }, count: totalCalls));
        }

        group('list', () {
          Future q(count) {
            var mock = mockClient();
            registerQueryMock(mock, count, 50);

            var api = new PubSub(mock, PROJECT);
            return api
                .listTopics()
                .listen(expectAsync((_) => null, count: count))
                .asFuture();
          }

          test('simple', () {
            return q(0)
                .then((_) => q(1))
                .then((_) => q(1))
                .then((_) => q(49))
                .then((_) => q(50))
                .then((_) => q(51))
                .then((_) => q(99))
                .then((_) => q(100))
                .then((_) => q(101))
                .then((_) => q(170));
          });

          test('immediate-pause-resume', () {
            var mock = mockClient();
            registerQueryMock(mock, 70, 50);

            var api = new PubSub(mock, PROJECT);
            api.listTopics().listen(expectAsync(((_) => null), count: 70),
                onDone: expectAsync(() => null))
              ..pause()
              ..resume()
              ..pause()
              ..resume();
          });

          test('pause-resume', () {
            var mock = mockClient();
            registerQueryMock(mock, 70, 50);

            var api = new PubSub(mock, PROJECT);
            var count = 0;
            var subscription;
            subscription = api.listTopics().listen(
                expectAsync(((_) {
                  subscription
                    ..pause()
                    ..resume()
                    ..pause();
                  if ((count % 2) == 0) {
                    subscription.resume();
                  } else {
                    scheduleMicrotask(() => subscription.resume());
                  }
                  return null;
                }), count: 70),
                onDone: expectAsync(() => null))
              ..pause();
            scheduleMicrotask(() => subscription.resume());
          });

          test('immediate-cancel', () {
            var mock = mockClient();
            registerQueryMock(mock, 70, 50, 1);

            var api = new PubSub(mock, PROJECT);
            api.listTopics().listen((_) => throw 'Unexpected',
                onDone: () => throw 'Unexpected')
              ..cancel();
          });

          test('cancel', () {
            var mock = mockClient();
            registerQueryMock(mock, 170, 50, 1);

            var api = new PubSub(mock, PROJECT);
            var subscription;
            subscription = api.listTopics().listen(
                expectAsync((_) => subscription.cancel()),
                onDone: () => throw 'Unexpected');
          });

          test('error', () {
            runTest(bool withPause) {
              // Test error on first GET request.
              var mock = mockClient();
              mock.register('GET', 'projects/$PROJECT/topics',
                  expectAsync((request) {
                return mock.respondError(500);
              }));
              var api = new PubSub(mock, PROJECT);
              var subscription;
              subscription = api.listTopics().listen((_) => throw 'Unexpected',
                  onDone: expectAsync(() => null),
                  onError:
                      expectAsync((e) => e is pubsub.DetailedApiRequestError));
              if (withPause) {
                subscription.pause();
                scheduleMicrotask(() => subscription.resume());
              }
            }

            runTest(false);
            runTest(true);
          });

          test('error-2', () {
            // Test error on second GET request.
            void runTest(bool withPause) {
              var mock = mockClient();
              registerQueryMock(mock, 51, 50, 1);

              var api = new PubSub(mock, PROJECT);

              int count = 0;
              var subscription;
              subscription = api.listTopics().listen(
                  expectAsync(((_) {
                    count++;
                    if (count == 50) {
                      if (withPause) {
                        subscription.pause();
                        scheduleMicrotask(() => subscription.resume());
                      }
                      mock.clear();
                      mock.register('GET', 'projects/$PROJECT/topics',
                          expectAsync((request) {
                        return mock.respondError(500);
                      }));
                    }
                    return null;
                  }), count: 50),
                  onDone: expectAsync(() => null),
                  onError:
                      expectAsync((e) => e is pubsub.DetailedApiRequestError));
            }

            runTest(false);
            runTest(true);
          });
        });

        group('page', () {
          test('empty', () {
            var mock = mockClient();
            registerQueryMock(mock, 0, 50);

            var api = new PubSub(mock, PROJECT);
            return api.pageTopics().then(expectAsync((page) {
              expect(page.items.length, 0);
              expect(page.isLast, isTrue);
              expect(page.next(), completion(isNull));

              mock.clear();
              registerQueryMock(mock, 0, 20);
              return api.pageTopics(pageSize: 20).then(expectAsync((page) {
                expect(page.items.length, 0);
                expect(page.isLast, isTrue);
                expect(page.next(), completion(isNull));
              }));
            }));
          });

          test('single', () {
            var mock = mockClient();
            registerQueryMock(mock, 10, 50);

            var api = new PubSub(mock, PROJECT);
            return api.pageTopics().then(expectAsync((page) {
              expect(page.items.length, 10);
              expect(page.isLast, isTrue);
              expect(page.next(), completion(isNull));

              mock.clear();
              registerQueryMock(mock, 20, 20);
              return api.pageTopics(pageSize: 20).then(expectAsync((page) {
                expect(page.items.length, 20);
                expect(page.isLast, isTrue);
                expect(page.next(), completion(isNull));
              }));
            }));
          });

          test('multiple', () {
            runTest(n, pageSize) {
              var totalPages = (n + pageSize - 1) ~/ pageSize;
              var pageCount = 0;

              var completer = new Completer();
              var mock = mockClient();
              registerQueryMock(mock, n, pageSize);

              handlePage(page) {
                pageCount++;
                expect(page.isLast, pageCount == totalPages);
                expect(page.items.length,
                    page.isLast ? n - (totalPages - 1) * pageSize : pageSize);
                page.next().then(expectAsync((page) {
                  if (page != null) {
                    handlePage(page);
                  } else {
                    expect(pageCount, totalPages);
                    completer.complete();
                  }
                }));
              }

              var api = new PubSub(mock, PROJECT);
              api.pageTopics(pageSize: pageSize).then(expectAsync(handlePage));

              return completer.future;
            }

            return runTest(70, 50)
                .then((_) => runTest(99, 1))
                .then((_) => runTest(99, 50))
                .then((_) => runTest(99, 98))
                .then((_) => runTest(99, 99))
                .then((_) => runTest(99, 100))
                .then((_) => runTest(100, 1))
                .then((_) => runTest(100, 50))
                .then((_) => runTest(100, 100))
                .then((_) => runTest(101, 50));
          });
        });
      });
    });

    group('subscription', () {
      var name = 'test-subscription';
      var absoluteName = 'projects/$PROJECT/subscriptions/test-subscription';
      var topicName = 'test-topic';
      var absoluteTopicName = 'projects/$PROJECT/topics/test-topic';

      test('create', () {
        var mock = mockClient();
        mock.register(
            'PUT',
            'projects/$PROJECT/subscriptions',
            expectAsync((request) {
              var requestSubscription =
                  new pubsub.Subscription.fromJson(JSON.decode(request.body));
              expect(requestSubscription.name, absoluteName);
              return mock
                  .respond(new pubsub.Subscription()..name = absoluteName);
            }, count: 2));

        var api = new PubSub(mock, PROJECT);
        return api
            .createSubscription(name, topicName)
            .then(expectAsync((subscription) {
          expect(subscription.name, name);
          expect(subscription.absoluteName, absoluteName);
          return api
              .createSubscription(absoluteName, absoluteTopicName)
              .then(expectAsync((subscription) {
            expect(subscription.name, name);
            expect(subscription.project, PROJECT);
            expect(subscription.absoluteName, absoluteName);
          }));
        }));
      });

      test('create-error', () {
        var mock = mockClient();
        var api = new PubSub(mock, PROJECT);
        badSubscriptionNames.forEach((name) {
          expect(() => api.createSubscription(name, 'test-topic'),
              throwsArgumentError);
        });
        badTopicNames.forEach((name) {
          expect(() => api.createSubscription('test-subscription', name),
              throwsArgumentError);
        });
      });

      test('delete', () {
        var mock = mockClient();
        mock.register(
            'DELETE',
            'projects/$PROJECT/subscriptions',
            expectAsync((request) {
              expect(request.body.length, 0);
              return mock.respondEmpty();
            }, count: 2));

        var api = new PubSub(mock, PROJECT);
        return api.deleteSubscription(name).then(expectAsync((result) {
          expect(result, isNull);
          return api.deleteSubscription(absoluteName).then(expectAsync((topic) {
            expect(result, isNull);
          }));
        }));
      });

      test('delete-error', () {
        var mock = mockClient();
        var api = new PubSub(mock, PROJECT);
        badSubscriptionNames.forEach((name) {
          expect(() => api.deleteSubscription(name), throwsArgumentError);
        });
        badTopicNames.forEach((name) {
          expect(() => api.deleteSubscription(name), throwsArgumentError);
        });
      });

      test('lookup', () {
        var mock = mockClient();
        mock.register(
            'GET',
            new RegExp('projects/$PROJECT/subscriptions'),
            expectAsync((request) {
              expect(request.body.length, 0);
              return mock
                  .respond(new pubsub.Subscription()..name = absoluteName);
            }, count: 2));

        var api = new PubSub(mock, PROJECT);
        return api.lookupSubscription(name).then(expectAsync((subscription) {
          expect(subscription.name, name);
          expect(subscription.absoluteName, absoluteName);
          return api
              .lookupSubscription(absoluteName)
              .then(expectAsync((subscription) {
            expect(subscription.name, name);
            expect(subscription.project, PROJECT);
            expect(subscription.absoluteName, absoluteName);
          }));
        }));
      });

      test('lookup-error', () {
        var mock = mockClient();
        var api = new PubSub(mock, PROJECT);
        badSubscriptionNames.forEach((name) {
          expect(() => api.lookupSubscription(name), throwsArgumentError);
        });
        badTopicNames.forEach((name) {
          expect(() => api.lookupSubscription(name), throwsArgumentError);
        });
      });

      group('query', () {
        addSubscriptions(
            pubsub.ListSubscriptionsResponse response, int first, int count) {
          response.subscriptions = [];
          for (int i = 0; i < count; i++) {
            response.subscriptions.add(
                new pubsub.Subscription()..name = 'subscription-${first + i}');
          }
        }

        // Mock that expect/generates [n] subscriptions in pages of page size
        // [pageSize].
        registerQueryMock(mock, n, pageSize, {String topic, int totalCalls}) {
          var totalPages = (n + pageSize - 1) ~/ pageSize;
          // No items still generate one request.
          if (totalPages == 0) totalPages = 1;
          // Can pass in total calls if this mock is overwritten before all
          // expected pages are done, e.g. when testing errors.
          if (totalCalls == null) {
            totalCalls = totalPages;
          }
          var pageCount = 0;
          mock.register(
              'GET',
              'projects/$PROJECT/subscriptions',
              expectAsync((request) {
                pageCount++;
                expect(request.url.queryParameters['pageSize'], '$pageSize');
                expect(request.body.length, 0);
                if (pageCount > 1) {
                  expect(request.url.queryParameters['pageToken'], 'next-page');
                }

                var response = new pubsub.ListSubscriptionsResponse();
                var first = (pageCount - 1) * pageSize + 1;
                if (pageCount < totalPages) {
                  response.nextPageToken = 'next-page';
                  addSubscriptions(response, first, pageSize);
                } else {
                  addSubscriptions(
                      response, first, n - (totalPages - 1) * pageSize);
                }
                return mock.respond(response);
              }, count: totalCalls));
        }

        group('list', () {
          Future q(topic, count) {
            var mock = mockClient();
            registerQueryMock(mock, count, 50, topic: topic);

            var api = new PubSub(mock, PROJECT);
            return api
                .listSubscriptions(topic)
                .listen(expectAsync((_) => null, count: count))
                .asFuture();
          }

          test('simple', () {
            return q(null, 0)
                .then((_) => q('topic', 0))
                .then((_) => q(null, 1))
                .then((_) => q('topic', 1))
                .then((_) => q(null, 10))
                .then((_) => q('topic', 10))
                .then((_) => q(null, 49))
                .then((_) => q('topic', 49))
                .then((_) => q(null, 50))
                .then((_) => q('topic', 50))
                .then((_) => q(null, 51))
                .then((_) => q('topic', 51))
                .then((_) => q(null, 99))
                .then((_) => q('topic', 99))
                .then((_) => q(null, 100))
                .then((_) => q('topic', 100))
                .then((_) => q(null, 101))
                .then((_) => q('topic', 101))
                .then((_) => q(null, 170))
                .then((_) => q('topic', 170));
          });

          test('immediate-pause-resume', () {
            var mock = mockClient();
            registerQueryMock(mock, 70, 50);

            var api = new PubSub(mock, PROJECT);
            api.listSubscriptions().listen(
                expectAsync(((_) => null), count: 70),
                onDone: expectAsync(() => null))
              ..pause()
              ..resume()
              ..pause()
              ..resume();
          });

          test('pause-resume', () {
            var mock = mockClient();
            registerQueryMock(mock, 70, 50);

            var api = new PubSub(mock, PROJECT);
            var count = 0;
            var subscription;
            subscription = api.listSubscriptions().listen(
                expectAsync(((_) {
                  subscription
                    ..pause()
                    ..resume()
                    ..pause();
                  if ((count % 2) == 0) {
                    subscription.resume();
                  } else {
                    scheduleMicrotask(() => subscription.resume());
                  }
                  return null;
                }), count: 70),
                onDone: expectAsync(() => null))
              ..pause();
            scheduleMicrotask(() => subscription.resume());
          });

          test('immediate-cancel', () {
            var mock = mockClient();
            registerQueryMock(mock, 70, 50, totalCalls: 1);

            var api = new PubSub(mock, PROJECT);
            api.listSubscriptions().listen((_) => throw 'Unexpected',
                onDone: () => throw 'Unexpected')
              ..cancel();
          });

          test('cancel', () {
            var mock = mockClient();
            registerQueryMock(mock, 170, 50, totalCalls: 1);

            var api = new PubSub(mock, PROJECT);
            var subscription;
            subscription = api.listSubscriptions().listen(
                expectAsync((_) => subscription.cancel()),
                onDone: () => throw 'Unexpected');
          });

          test('error', () {
            runTest(bool withPause) {
              // Test error on first GET request.
              var mock = mockClient();
              mock.register('GET', 'projects/$PROJECT/subscriptions',
                  expectAsync((request) {
                return mock.respondError(500);
              }));
              var api = new PubSub(mock, PROJECT);
              var subscription;
              subscription = api.listSubscriptions().listen(
                  (_) => throw 'Unexpected',
                  onDone: expectAsync(() => null),
                  onError:
                      expectAsync((e) => e is pubsub.DetailedApiRequestError));
              if (withPause) {
                subscription.pause();
                scheduleMicrotask(() => subscription.resume());
              }
            }

            runTest(false);
            runTest(true);
          });

          test('error-2', () {
            runTest(bool withPause) {
              // Test error on second GET request.
              var mock = mockClient();
              registerQueryMock(mock, 51, 50, totalCalls: 1);

              var api = new PubSub(mock, PROJECT);

              int count = 0;
              var subscription;
              subscription = api.listSubscriptions().listen(
                  expectAsync(((_) {
                    count++;
                    if (count == 50) {
                      if (withPause) {
                        subscription.pause();
                        scheduleMicrotask(() => subscription.resume());
                      }
                      mock.clear();
                      mock.register('GET', 'projects/$PROJECT/subscriptions',
                          expectAsync((request) {
                        return mock.respondError(500);
                      }));
                    }
                    return null;
                  }), count: 50),
                  onDone: expectAsync(() => null),
                  onError:
                      expectAsync((e) => e is pubsub.DetailedApiRequestError));
            }

            runTest(false);
            runTest(true);
          });
        });

        group('page', () {
          emptyTest(String topic) {
            var mock = mockClient();
            registerQueryMock(mock, 0, 50, topic: topic);

            var api = new PubSub(mock, PROJECT);
            return api.pageSubscriptions(topic: topic).then(expectAsync((page) {
              expect(page.items.length, 0);
              expect(page.isLast, isTrue);
              expect(page.next(), completion(isNull));

              mock.clear();
              registerQueryMock(mock, 0, 20, topic: topic);
              return api
                  .pageSubscriptions(topic: topic, pageSize: 20)
                  .then(expectAsync((page) {
                expect(page.items.length, 0);
                expect(page.isLast, isTrue);
                expect(page.next(), completion(isNull));
              }));
            }));
          }

          test('empty', () {
            emptyTest(null);
            emptyTest('topic');
          });

          singleTest(String topic) {
            var mock = mockClient();
            registerQueryMock(mock, 10, 50, topic: topic);

            var api = new PubSub(mock, PROJECT);
            return api.pageSubscriptions(topic: topic).then(expectAsync((page) {
              expect(page.items.length, 10);
              expect(page.isLast, isTrue);
              expect(page.next(), completion(isNull));

              mock.clear();
              registerQueryMock(mock, 20, 20, topic: topic);
              return api
                  .pageSubscriptions(topic: topic, pageSize: 20)
                  .then(expectAsync((page) {
                expect(page.items.length, 20);
                expect(page.isLast, isTrue);
                expect(page.next(), completion(isNull));
              }));
            }));
          }

          test('single', () {
            singleTest(null);
            singleTest('topic');
          });

          multipleTest(n, pageSize, topic) {
            var totalPages = (n + pageSize - 1) ~/ pageSize;
            var pageCount = 0;

            var completer = new Completer();
            var mock = mockClient();
            registerQueryMock(mock, n, pageSize, topic: topic);

            handlingPage(page) {
              pageCount++;
              expect(page.isLast, pageCount == totalPages);
              expect(page.items.length,
                  page.isLast ? n - (totalPages - 1) * pageSize : pageSize);
              page.next().then((page) {
                if (page != null) {
                  handlingPage(page);
                } else {
                  expect(pageCount, totalPages);
                  completer.complete();
                }
              });
            }

            var api = new PubSub(mock, PROJECT);
            api
                .pageSubscriptions(topic: topic, pageSize: pageSize)
                .then(handlingPage);

            return completer.future;
          }

          test('multiple', () {
            return multipleTest(70, 50, null)
                .then((_) => multipleTest(99, 1, null))
                .then((_) => multipleTest(99, 50, null))
                .then((_) => multipleTest(99, 98, null))
                .then((_) => multipleTest(99, 99, null))
                .then((_) => multipleTest(99, 100, null))
                .then((_) => multipleTest(100, 1, null))
                .then((_) => multipleTest(100, 50, null))
                .then((_) => multipleTest(100, 100, null))
                .then((_) => multipleTest(101, 50, null))
                .then((_) => multipleTest(70, 50, 'topic'))
                .then((_) => multipleTest(99, 1, 'topic'))
                .then((_) => multipleTest(99, 50, 'topic'))
                .then((_) => multipleTest(99, 98, 'topic'))
                .then((_) => multipleTest(99, 99, 'topic'))
                .then((_) => multipleTest(99, 100, 'topic'))
                .then((_) => multipleTest(100, 1, 'topic'))
                .then((_) => multipleTest(100, 50, 'topic'))
                .then((_) => multipleTest(100, 100, 'topic'))
                .then((_) => multipleTest(101, 50, 'topic'));
          });
        });
      });
    });
  });

  group('topic', () {
    var name = 'test-topic';
    var absoluteName = 'projects/$PROJECT/topics/test-topic';
    var message = 'Hello, world!';
    var messageBytes = UTF8.encode(message);
    var messageBase64 = BASE64.encode(messageBytes);
    var attributes = {'a': '1', 'b': 'text'};

    registerLookup(mock) {
      mock.register('GET', absoluteName, expectAsync((request) {
        expect(request.body.length, 0);
        return mock.respond(new pubsub.Topic()..name = absoluteName);
      }));
    }

    registerPublish(mock, count, fn) {
      mock.register(
          'POST',
          'projects/test-project/topics/test-topic:publish',
          expectAsync((request) {
            var publishRequest =
                new pubsub.PublishRequest.fromJson(JSON.decode(request.body));
            return fn(publishRequest);
          }, count: count));
    }

    test('publish', () {
      var mock = mockClient();
      registerLookup(mock);

      var api = new PubSub(mock, PROJECT);
      return api.lookupTopic(name).then(expectAsync((topic) {
        mock.clear();
        registerPublish(mock, 4, ((request) {
          expect(request.messages.length, 1);
          expect(request.messages[0].data, messageBase64);
          expect(request.messages[0].attributes, isNull);
          return mock.respond(new pubsub.PublishResponse()..messageIds = ['0']);
        }));

        return topic.publishString(message).then(expectAsync((result) {
          expect(result, isNull);
          return topic.publishBytes(messageBytes).then(expectAsync((result) {
            expect(result, isNull);
            return topic
                .publish(new Message.withString(message))
                .then(expectAsync((result) {
              expect(result, isNull);
              return topic
                  .publish(new Message.withBytes(messageBytes))
                  .then(expectAsync((result) {
                expect(result, isNull);
              }));
            }));
          }));
        }));
      }));
    });

    test('publish-with-attributes', () {
      var mock = mockClient();
      registerLookup(mock);

      var api = new PubSub(mock, PROJECT);
      return api.lookupTopic(name).then(expectAsync((topic) {
        mock.clear();
        registerPublish(mock, 4, ((request) {
          expect(request.messages.length, 1);
          expect(request.messages[0].data, messageBase64);
          expect(request.messages[0].attributes, isNotNull);
          expect(request.messages[0].attributes.length, attributes.length);
          expect(request.messages[0].attributes, attributes);
          return mock.respond(new pubsub.PublishResponse()..messageIds = ['0']);
        }));

        return topic
            .publishString(message, attributes: attributes)
            .then(expectAsync((result) {
          expect(result, isNull);
          return topic
              .publishBytes(messageBytes, attributes: attributes)
              .then(expectAsync((result) {
            expect(result, isNull);
            return topic
                .publish(
                    new Message.withString(message, attributes: attributes))
                .then(expectAsync((result) {
              expect(result, isNull);
              return topic
                  .publish(new Message.withBytes(messageBytes,
                      attributes: attributes))
                  .then(expectAsync((result) {
                expect(result, isNull);
              }));
            }));
          }));
        }));
      }));
    });

    test('delete', () {
      var mock = mockClient();
      mock.register('GET', absoluteName, expectAsync((request) {
        expect(request.body.length, 0);
        return mock.respond(new pubsub.Topic()..name = absoluteName);
      }));

      var api = new PubSub(mock, PROJECT);
      return api.lookupTopic(name).then(expectAsync((topic) {
        expect(topic.name, name);
        expect(topic.absoluteName, absoluteName);

        mock.register('DELETE', absoluteName, expectAsync((request) {
          expect(request.body.length, 0);
          return mock.respondEmpty();
        }));

        return topic.delete().then(expectAsync((result) {
          expect(result, isNull);
        }));
      }));
    });
  });

  group('subscription', () {
    var name = 'test-subscription';
    var absoluteName = 'projects/$PROJECT/subscriptions/test-subscription';

    test('delete', () {
      var mock = mockClient();
      mock.register('GET', absoluteName, expectAsync((request) {
        expect(request.body.length, 0);
        return mock.respond(new pubsub.Topic()..name = absoluteName);
      }));

      var api = new PubSub(mock, PROJECT);
      return api.lookupSubscription(name).then(expectAsync((subscription) {
        expect(subscription.name, name);
        expect(subscription.absoluteName, absoluteName);

        mock.register('DELETE', absoluteName, expectAsync((request) {
          expect(request.body.length, 0);
          return mock.respondEmpty();
        }));

        return subscription.delete().then(expectAsync((result) {
          expect(result, isNull);
        }));
      }));
    });
  });

  group('push', () {
    var relativeSubscriptionName = 'sgjesse-managed-vm/test-push-subscription';
    var absoluteSubscriptionName = '/subscriptions/$relativeSubscriptionName';

    test('event', () {
      var requestBody = '''
{
  "message": {
    "data":"SGVsbG8sIHdvcmxkIDMwIG9mIDUwIQ==",
    "labels": [
      {
        "key":"messageNo",
        "numValue":"30"
      },
      {
        "key":"test",
        "strValue":"hello"
      }
    ]
  },
  "subscription":"$absoluteSubscriptionName"
}
''';
      var event = new PushEvent.fromJson(requestBody);
      expect(event.message.asString, "Hello, world 30 of 50!");
      expect(event.message.attributes['messageNo'], '30');
      expect(event.message.attributes['test'], 'hello');
      expect(event.subscriptionName, absoluteSubscriptionName);
    });

    test('event-short-subscription-name', () {
      var requestBody = '''
{
  "message": {
    "data":"SGVsbG8sIHdvcmxkIDMwIG9mIDUwIQ==",
    "labels": [
      {
        "key":"messageNo",
        "numValue":30
      },
      {
        "key":"test",
        "strValue":"hello"
      }
    ]
  },
  "subscription":"$relativeSubscriptionName"
}
''';
      var event = new PushEvent.fromJson(requestBody);
      expect(event.message.asString, "Hello, world 30 of 50!");
      expect(event.message.attributes['messageNo'], 30);
      expect(event.message.attributes['test'], 'hello');
      expect(event.subscriptionName, absoluteSubscriptionName);
    });
  });
}
