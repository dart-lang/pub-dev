#!/usr/bin/env python

import datetime
import unittest

from google.appengine.ext import ndb
from google.appengine.ext.ndb import metadata

class NormalModel(ndb.Model):
  boolProp = ndb.BooleanProperty()
  intProp = ndb.IntegerProperty()
  stringProp = ndb.StringProperty()
  keyProp = ndb.KeyProperty()
  blobProp = ndb.BlobProperty()
  dateProp = ndb.DateTimeProperty()

  stringListProp = ndb.StringProperty(repeated = True)


class ExpandoModel(ndb.Expando):
  boolProp = ndb.BooleanProperty()
  intProp = ndb.IntegerProperty()
  stringProp = ndb.StringProperty()
  keyProp = ndb.KeyProperty()
  blobProp = ndb.BlobProperty()
  dateProp = ndb.DateTimeProperty()

  stringListProp = ndb.StringProperty(repeated = True)

def verifyData(model, num):
  assert model.boolProp == (num % 2 == 0)
  assert model.intProp == num + 42
  assert model.stringProp == 'foobar %d' % num
  assert model.keyProp == ndb.Key('NormalModel', num + 10)
  assert model.blobProp == '\x01\x02\x03\x04%d' % num

  # Different
  assert model.dateProp == datetime.datetime(2014, 12, 31, num)

  assert model.stringListProp
  stringList = model.stringListProp
  assert len(stringList) == 3
  assert stringList[0] == 'a%d' % num
  assert stringList[1] == 'b%d' % num
  assert stringList[2] == 'c%d' % num

def fillData(model, num):
  model.boolProp = (num % 2 == 0)
  model.intProp = num + 42
  model.stringProp = 'foobar %d' % num
  model.keyProp = ndb.Key('NormalModel', num + 10)
  model.blobProp = '\x01\x02\x03\x04%d' % num
  model.dateProp = datetime.datetime(2014, 12, 31, num)
  model.stringListProp = ['a%d' % num, 'b%d' % num, 'c%d' % num]


def debug_showKinds():
  print 'kinds:'
  for key in metadata.get_kinds():
    print '   - ', key

def runTests(writing_mode):
  key = ndb.Key('NormalModel', 99)
  ekey = ndb.Key('ExpandoModel', 102, parent=key)

  if writing_mode:
    model = NormalModel(key=key)
    em = ExpandoModel(key=ekey)

    fillData(model, 1)
    fillData(em, 5)

    model.put()
    em.put()

  if not writing_mode:
    models = NormalModel.query(NormalModel.key == key).fetch()
    ems = ExpandoModel.query(ExpandoModel.key == ekey).fetch()

    for m, id, i in [(models, 99, 1),
                     (ems, 102, 5)]:
      assert len(m) == 1
      model = m[0]
      assert model
      assert model.key.id() == id
      verifyData(model, i)
    assert ems[0].key.parent() == key

  print 'All tests ran'

