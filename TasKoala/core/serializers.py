"""This module includes all the serializers
    that are needed to make the Views tasks easier and cleaner.

"""

import validators
from django.db.models import Q
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


class EmployeeSerializer(serializers.ModelSerializer):
    def save(self, **kwargs):
        my_emp = Employee(user=self.validated_data['user'])

        my_emp.save()
        return my_emp

    class Meta:
        model = Employee
        fields = ('user',)


# I defined my own serializers to work with nested Models (they don't inherit from ModelSerializer)
# because ModelSerializer doesn't let you work with more than one Model
class RequestToBeMemberSerializer:
    def save(self, data):
        organization = Organization.objects.get(name=data["organization"])

        req_type = RequestType.objects.get(name="join_" + data["position"])

        # Find this Employee based on request.user (built-in User)
        employee = Employee.objects.get(user=data['user'])

        request = Request(title="join_as_" + data["position"],
                          request_type=req_type,
                          request_sender=employee.id,
                          requested_organization=organization)
        request.save()
        return True


class RequestToPromotionSerializer:
    def save(self, employee):
        req_type = RequestType.objects.get(name="promotion_employee_manager")

        # Find this Staff based on the employee and request.user (built-in User)
        staff = Staff.objects.get(employee=Employee.objects.get(user=employee))

        request = Request(title="promotion",
                          request_type=req_type,
                          request_sender=staff.id)

        request.save()

        return True


class RequestSerializer:
    def get(self, data):
        results = []

        # Find and return all the requests based on user_type
        if data['user_type'] == "admin":
            requests = Request.objects.filter(Q(request_type_id=2) | Q(request_type_id=3), request_result=None)
            for request in requests:
                if request.request_type.id == 2:
                    """This is a join (employee->staff(manager)) request
                        so we should search in the Employee table based on request_sender field
                        (the id in request_sender field is an Employee's id)
                    """
                    request_sender = Employee.objects.get(id=request.request_sender)
                    results.append({"id": request.id,
                                    "title": request.title,
                                    "request_sender": {"id": request_sender.id,
                                                       "username": request_sender.user.username,
                                                       "name": request_sender.user.first_name + " " + request_sender.user.last_name

                                                       },
                                    "created_at": request.created_at.strftime("%Y-%m-%d %H:%M:%S"),
                                    # Filled when the request is join
                                    "organization": request.requested_organization.name

                                    })

                else:  # request_type == 3
                    """This is a changing position (staff(employee)->staff(manager)) request
                        so we should search in the Staff table based on request_sender field
                        (the id in request_sender field is a Staff's id)
                    """
                    request_sender = Staff.objects.get(id=request.request_sender)

                    results.append({"id": request.id,
                                    "title": request.title,
                                    "request_sender": {"id": request_sender.id,
                                                       "username": request_sender.employee.user.username,
                                                       "name": request_sender.employee.user.first_name + " " +
                                                               request_sender.employee.user.last_name

                                                       },
                                    "created_at": request.created_at.strftime("%Y-%m-%d %H:%M:%S")
                                    })

        elif data['user_type'] == "manager":
            """These are join (employee->staff(employee)) requests.
                Only Managers of the requested_organization handle these requests
                so we should search in the Employee table based on request_sender field
                (the id in request_sender field is an Employee's id)
            """

            # Get the manager_id (staff_id) from Employee based on the built-in User
            manager = Staff.objects.get(employee=Employee.objects.get(user=data['user']))

            # Only Get the Requests from the Manager's Organization
            requests = Request.objects.filter(request_type_id=1, request_result=None,
                                              requested_organization_id=manager.organization.id)
            for request in requests:
                request_sender = Employee.objects.get(id=request.request_sender)

                results.append({"id": request.id,
                                "title": request.title,
                                "request_sender": {"id": request_sender.id,
                                                   "username": request_sender.user.username,
                                                   "name": request_sender.user.first_name + " " + request_sender.user.last_name

                                                   },
                                "created_at": request.created_at.strftime("%Y-%m-%d %H:%M:%S"),
                                # Filled only when the request is join
                                "organization": request.requested_organization.name

                                })
        return results

    def set_response(self, data):
        request = Request.objects.get(id=data['request_id'])
        request.request_result = data['response']

        if data['response'] is True:
            if data['user_type'] == "admin":  # Handle request types 2,3 (join as manager and promotion)
                request.request_receiver = data['user'].id
                request.save()

                if request.request_type.id == 2:
                    employee = Employee.objects.get(id=request.request_sender)

                    # Create a new Staff as a manager
                    staff = Staff(employee=employee,
                                  organization=request.requested_organization,
                                  request=request,
                                  staff_type="manager")
                    staff.save()

                elif request.request_type.id == 3:
                    # Find the given staff in the request
                    # And update its staff_type from employee to manager
                    staff = Staff.objects.get(id=request.request_sender)
                    staff.staff_type = "manager"
                    staff.save()

            elif data['user_type'] == "manager":  # Handle request type 1 (join as employee)
                # Find the manager's (staff) id and set its id as request_receiver
                manager = Staff.objects.get(employee=Employee.objects.get(user=data['user']))

                request.request_receiver = manager.id
                request.save()

                employee = Employee.objects.get(id=request.request_sender)

                # Create a new Staff as a employee
                staff = Staff(employee=employee,
                              organization=request.requested_organization,
                              request=request,
                              staff_type="employee")
                staff.save()

        else:  # Set the response giver id to request_receiver and save it
            if data['user_type'] == "admin":
                request.request_receiver = data['user'].id
                request.save()

            elif data['user_type'] == "manager":
                manager = Staff.objects.get(employee=Employee.objects.get(user=data['user']))

                request.request_receiver = manager.id
                request.save()

        return True

# class TaskSerializer:
#     def save(self, data):
#         # Find the user(built-in) and based on that, find the employee (because they have one-to-one relation)
#         # And then find who (staff) wants to create this task or do this task
#         task_creator = Staff.objects.get(employee=Employee.objects.get(user=data.user))
#         task_operator = Staff.objects.get(employee=Employee.objects.get(user=data['operator_id']))
#
#         task = Task(title=data['title'],
#                     description=data['description'],
#                     creator=task_creator,
#                     operator=task_operator,
#                     deadline=datetime.datetime.strptime(data['deadline'], "%Y-%m-%d %H:%M:%S")
#                     )
#
#         task.save()
#
#         return True
