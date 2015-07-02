# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import DataMigration
from django.db import models

class Migration(DataMigration):

    def forwards(self, orm):
        "Write your forwards methods here."
        # Note: Don't use "from appname.models import ModelName".
        # Use orm.ModelName to refer to models in this application,
        # and orm['appname.ModelName'] for models in other applications.
        orm.Department.objects.create(name='Default')

    def backwards(self, orm):
        "Write your backwards methods here."
        orm.Department.objects.filter(name='Default').delete()

    models = {
        u'core.application': {
            'Meta': {'ordering': "['name']", 'unique_together': "(('department', 'name'),)", 'object_name': 'Application'},
            'department': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'applications'", 'to': u"orm['core.Department']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '128'})
        },
        u'core.department': {
            'Meta': {'ordering': "['name']", 'object_name': 'Department'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '128'})
        },
        u'core.environment': {
            'Meta': {'ordering': "['name']", 'unique_together': "(('application', 'name'),)", 'object_name': 'Environment'},
            'application': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'environments'", 'to': u"orm['core.Application']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_production': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '128'})
        },
        u'core.server': {
            'Meta': {'ordering': "['name']", 'unique_together': "(('environment', 'name'),)", 'object_name': 'Server'},
            'environment': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'servers'", 'to': u"orm['core.Environment']"}),
            'host': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'method': ('django.db.models.fields.IntegerField', [], {'default': '2'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            'port': ('django.db.models.fields.IntegerField', [], {'default': '22'}),
            'roles': ('django.db.models.fields.related.ManyToManyField', [], {'related_name': "'servers'", 'symmetrical': 'False', 'to': u"orm['core.ServerRole']"}),
            'user': ('django.db.models.fields.CharField', [], {'max_length': '128'})
        },
        u'core.serverauthentication': {
            'Meta': {'object_name': 'ServerAuthentication'},
            'password': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'server': ('django.db.models.fields.related.OneToOneField', [], {'to': u"orm['core.Server']", 'unique': 'True', 'primary_key': 'True'})
        },
        u'core.serverrole': {
            'Meta': {'unique_together': "(('department', 'name'),)", 'object_name': 'ServerRole'},
            'department': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'serverroles'", 'to': u"orm['core.Department']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '32'})
        }
    }

    complete_apps = ['core']
    symmetrical = True
