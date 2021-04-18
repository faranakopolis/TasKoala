""" This module includes the TasKoala's models
     based on the database design.

    I extended Django's built-in User class to be like my own Users (Employee and Admin)

"""

import datetime

from django.contrib.auth.models import User, AbstractUser, AbstractBaseUser

from django.db import models


class Admin(models.Model):
    """Although I used one-to-one relation to extend the built-in User
        but I must say this solution is not a good way of doing this (database and performance wise)
        we could write the whole user management on our own so we wouldn't need a built-in Django user.
        (but obviously there wasn't enough time for that)

        This opinion also stands for Employee Model.
    """
    id = models.AutoField(primary_key=True)
    user = models.OneToOneField(User, on_delete=models.DO_NOTHING)

    class Meta:
        db_table = 'admin'


class Employee(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.OneToOneField(User, on_delete=models.DO_NOTHING)

    class Meta:
        db_table = 'employee'


class Organization(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50, null=False)
    creator = models.ForeignKey(Admin, on_delete=models.DO_NOTHING)
    description = models.CharField(max_length=500)
    created_at = models.DateTimeField(default=datetime.datetime.now())

    class Meta:
        db_table = "organization"


class RequestType(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=30, null=False)
    description = models.CharField(max_length=500)

    class Meta:
        db_table = "request_type"


class Request(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=50, null=False)
    request_type = models.ForeignKey(RequestType, related_name="request_type", on_delete=models.DO_NOTHING, null=False)
    request_sender = models.IntegerField()
    request_receiver = models.IntegerField(default=None,
                                           null=True)  # This field will be filled after replying to a request.
    requested_organization = models.ForeignKey(Organization, related_name="requested_organization", on_delete=models.DO_NOTHING,
                                               null=True)  # This field would be None if the request_type is promotion.
    request_result = models.BooleanField(default=False, null=False)
    description = models.CharField(max_length=500)
    created_at = models.DateTimeField(default=datetime.datetime.now())

    class Meta:
        db_table = "request"


class Staff(models.Model):
    """Employees whom their join request to an organization is accepted will stored in this Model.
        (organization's employees and employees)

    """
    id = models.AutoField(primary_key=True)
    employee = models.ForeignKey(Employee, related_name="employee", on_delete=models.DO_NOTHING, null=False)
    organization = models.ForeignKey(Organization, related_name="organization", on_delete=models.DO_NOTHING, null=False)
    request = models.ForeignKey(Request, related_name="join_request", on_delete=models.DO_NOTHING, null=False)
    is_active = models.BooleanField(default=True, null=False)
    created_at = models.DateTimeField(default=datetime.datetime.now())

    class Meta:
        db_table = "staff"


class Task(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=50, null=False)
    description = models.CharField(max_length=500)
    creator = models.ForeignKey(Staff, related_name="task_creator", on_delete=models.DO_NOTHING, null=False)
    operator = models.ForeignKey(Staff, related_name="task_operator", on_delete=models.DO_NOTHING, null=False)
    is_done = models.BooleanField(default=False)
    done_time = models.DateTimeField()
    deadline = models.DateTimeField(null=False)
    created_at = models.DateTimeField(default=datetime.datetime.now())

    class Meta:
        db_table = "task"
