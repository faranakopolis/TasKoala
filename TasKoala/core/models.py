""" This module includes the TasKoala's models
     based on the database design.

    I extended Django's built-in User class to be like my own User (MyUser)

"""

import datetime

from django.contrib.auth.models import User, AbstractUser, AbstractBaseUser

from django.db import models


class UserType(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=30, null=False)
    description = models.CharField(max_length=500)
    created_at = models.DateTimeField(default=datetime.datetime.now())

    class Meta:
        db_table = "user_type"


class Organization(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50, null=False)
    description = models.CharField(max_length=500)
    created_at = models.DateTimeField(default=datetime.datetime.now())

    class Meta:
        db_table = "organization"


class MyUser(models.Model):
    """Although I used one-to-one relation to extend the built-in User
        but I must say this solution is not a good way of doing this (database and performance wise)
        we could write the whole user management on our own so we wouldn't need a built-in Django user.
    """
    user = models.OneToOneField(User, on_delete=models.DO_NOTHING)
    user_type = models.ForeignKey(UserType, related_name="user_type", on_delete=models.DO_NOTHING, null=False)
    organization = models.ForeignKey(Organization, related_name="organization", on_delete=models.DO_NOTHING,
                                     default=None, null=True)

    class Meta:
        db_table = 'my_user'


class RequestType(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=30, null=False)
    description = models.CharField(max_length=500)
    created_at = models.DateTimeField(default=datetime.datetime.now())

    class Meta:
        db_table = "request_type"


class Request(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=50, null=False)
    request_type = models.ForeignKey(RequestType, related_name="request_type", on_delete=models.DO_NOTHING, null=False)
    request_sender = models.ForeignKey(User, related_name="request_sender", on_delete=models.DO_NOTHING, null=False)
    description = models.CharField(max_length=500)
    created_at = models.DateTimeField(default=datetime.datetime.now())

    class Meta:
        db_table = "request"


class ResponseModel(models.Model):
    id = models.AutoField(primary_key=True)
    response_giver = models.ForeignKey(User, related_name="response_giver", on_delete=models.DO_NOTHING,
                                       null=False)
    request = models.OneToOneField(Request, related_name="request", on_delete=models.DO_NOTHING, null=False)
    response_answer = models.BooleanField(null=False)
    description = models.CharField(max_length=500)
    created_at = models.DateTimeField(default=datetime.datetime.now())

    class Meta:
        db_table = "response"


class Task(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=50, null=False)
    description = models.CharField(max_length=500)
    creator = models.ForeignKey(User, related_name="task_creator", on_delete=models.DO_NOTHING, null=False)
    operator = models.ForeignKey(User, related_name="task_operator", on_delete=models.DO_NOTHING, null=False)
    is_done = models.BooleanField(default=False)
    done_time = models.DateTimeField()
    deadline = models.DateTimeField(null=False)
    created_at = models.DateTimeField(default=datetime.datetime.now())

    class Meta:
        db_table = "task"
