"""This module includes all the serializers
    that are needed to make the Views tasks easier and cleaner.

"""

import validators
from rest_framework import serializers

from TasKoala.core.models import *


class UserSerializer(serializers.ModelSerializer):

    def save(self, **kwargs):
        user = User(
            username=self.validated_data['username'],
            first_name=self.validated_data['first_name'],
            last_name=self.validated_data['last_name'],

        )

        password = self.validated_data['password']
        user.set_password(password)
        user.save()
        return user

    class Meta:
        model = User
        fields = ('username', 'password', 'first_name', 'last_name')
        extra_kwargs = {
            'password': {'write_only': True}
        }


class MyUserSerializer(serializers.ModelSerializer):
    def save(self, **kwargs):
        print(self.validated_data['user'])
        print(type(self.validated_data['user']))
        custom_user = MyUser(user_type=UserType.objects.get(name='employee'),
                             user=self.validated_data['user'])

        custom_user.save()
        return custom_user

    class Meta:
        model = MyUser
        fields = ('user',)


# I defined my own serializers to work with nested Models (they don't inherit from ModelSerializer)
# because ModelSerializer doesn't let you work with more than one Model
class RequestToBeMemberSerializer:
    def save(self, data):
        return True
