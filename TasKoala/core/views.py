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
            employee_serializer = EmployeeSerializer(data={'user': user.id})

            if employee_serializer.is_valid():
                emp = employee_serializer.save()
            else:
                result['response'] = employee_serializer.errors
                return Response(data=result, status=status.HTTP_400_BAD_REQUEST)

        else:
            result['response'] = user_serializer.errors
            return Response(data=result, status=status.HTTP_400_BAD_REQUEST)

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


class RequestView(APIView):
    permission_classes = (IsAuthenticated,)

    def post(self, request, request_type=None):
        if request_type == "join":
            """Request to be a member of an organization.
                    (send a request and wait for validation)
                """
            try:
                data = request.data
                data['user'] = request.user
                serializer = RequestToBeMemberSerializer()
                serializer.save(data)

                return Response(data={"response": "your request has been sent, wait for the validation"},
                                status=status.HTTP_200_OK)
            except Exception as e:
                return Response(data={"response": "something went wrong !"},
                                status=status.HTTP_500_INTERNAL_SERVER_ERROR)

        elif request_type == "promotion":
            """Request to be change a position from employee to manager.
                        (send a request and wait for validation)
                    """
            try:

                serializer = RequestToPromotionSerializer()
                serializer.save(request.user)

                return Response(data={"response": "your request has been sent, wait for the validation"},
                                status=status.HTTP_200_OK)
            except Exception as e:
                return Response(data={"response": "something went wrong !"},
                                status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def get(self, request, user_type=None):
        """Get requests by admin or manager(based on user_type).
        """
        try:
            data = dict()
            data['user_type'] = user_type
            data['user'] = request.user
            serializer = RequestSerializer()
            requests = serializer.get(data)

            return Response(data={"result": requests},
                            status=status.HTTP_200_OK)
        except Exception as e:
            return Response(data={"response": "something went wrong !"},
                            status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def put(self, request, user_type=None, request_id=None):
        """Give response to a given request by admin or manager.
            """
        try:
            data = request.data
            data['user_type'] = user_type
            data['request_id'] = request_id
            data['user'] = request.user
            serializer = RequestSerializer()
            result = serializer.set_response(data)

            return Response(data={"result": "request response has been sent and changes has been made"},
                            status=status.HTTP_205_RESET_CONTENT)
        except Exception as e:
            return Response(data={"response": "something went wrong !"},
                            status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class TaskView(APIView):
    permission_classes = (IsAuthenticated,)

    def post(self, request):
        """Create a Task by manager and assign it to an employee.

           Requires Token Authentication to get the manager from it.
        """
        try:
            data = request.data
            data['user'] = request.user

            serializer = TaskSerializer()
            serializer.save(data)

            return Response(data={"response": "Task created successfully"},
                            status=status.HTTP_200_OK)
        except Exception as e:
            return Response(data={"response": "something went wrong !"},
                            status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def get(self, request, staff_type=None, employee_id=None):
        """Get Tasks based on two parameters:
            staff_type:
                -manager:
                    employee_id==None: get all employees tasks which made by the manager.
                    employee_id!=None: get a given employee's tasks.
                -employee:
                    get the token owner's (employee's) tasks.
        """
        try:
            data = request.data
            data['user'] = request.user
            data['employee_id'] = employee_id
            data['staff_type'] = staff_type

            serializer = TaskSerializer()
            tasks = serializer.get(data)

            return Response(data=tasks, status=status.HTTP_200_OK)
        except Exception as e:
            return Response(data={"response": "something went wrong !"},
                            status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class EmployeeView(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        """Get all employees of an organization by one of its managers.
        """
        try:
            data = request.data
            data['user'] = request.user

            serializer = EmployeeSerializer()
            employees = serializer.get(data)

            return Response(data=employees, status=status.HTTP_200_OK)
        except Exception as e:
            return Response(data={"response": "something went wrong !"},
                            status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class UserView(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        """Get a given user's info.
        """
        try:
            data = request.data
            data['user'] = request.user

            serializer = UserSerializer()
            user_info = serializer.get(data)

            return Response(data=user_info, status=status.HTTP_200_OK)
        except Exception as e:
            raise e
            return Response(data={"response": "something went wrong !"},
                            status=status.HTTP_500_INTERNAL_SERVER_ERROR)
