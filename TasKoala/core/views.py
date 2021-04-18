""" This module includes the TasKoala's views.

Here are the functions and general logic of the project.

"""

import time

from rest_framework import status
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.exceptions import TokenError
from rest_framework_simplejwt.tokens import RefreshToken

from TasKoala.core.serializers import *


class SignUpView(APIView):
    """Add a user to the system (Sign Up):
        Doesn't requires token authentication i.e. every guest user is able to access this view.
            (that's why we separated this view from User view).
        Obviously the super user (admin) will be created by createsuperuser command.

    """
    permission_classes = (AllowAny,)

    def post(self, request):

        # Separating User Serializer and MyUser serializer to be more specific in each of them
        # and avoid more nested serializer
        user_serializer = UserSerializer(data=request.data)
        result = {}
        if user_serializer.is_valid():
            user = user_serializer.save()

            # Pass user as a parameter to MyUser serializer to get save and make that one-to-one relation work
            my_user_serializer = MyUserSerializer(data={'user': user.id})

            if my_user_serializer.is_valid():
                my_user = my_user_serializer.save()
                my_user.save()
            else:
                result['response'] = my_user_serializer.errors
                return Response(data=result, status=status.HTTP_200_OK)

        else:
            result['response'] = user_serializer.errors
            return Response(data=result, status=status.HTTP_200_OK)

        result['response'] = "user successfully signed up."
        result['username'] = user.username
        result['first_name'] = user.first_name
        result['last_name'] = user.last_name

        return Response(data=result, status=status.HTTP_200_OK)


class LogoutView(APIView):
    """Log out from account:
        Requires token authentication.
    """
    permission_classes = (IsAuthenticated,)

    def post(self, request):
        try:
            # Get the refresh token from the request and add it to the black list table.
            refresh_token = request.data["refresh_token"]
            token = RefreshToken(refresh_token)
            token.blacklist()

            return Response(data={"response": "token added to black list"},
                            status=status.HTTP_205_RESET_CONTENT)
        except TokenError:
            return Response(data={"response": "token has been black listed already"})
        except Exception as e:
            return Response(data={"response": "something went wrong !"},
                            status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class RequestToBeMember(APIView):
    """Request to be a member of an organization.
        (edit user_type of a user)

       Requires Token Authentication to get the user from it.
    """
    permission_classes = (IsAuthenticated,)

    def put(self, request):
        try:
            # Get the refresh token from the request and add it to the black list table.
            pass

            return Response(data={"response": "your request has been sent, wait for the validation"},
                            status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        except Exception as e:
            return Response(data={"response": "something went wrong !"},
                            status=status.HTTP_500_INTERNAL_SERVER_ERROR)
