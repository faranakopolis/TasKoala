"""This module includes all the serializers
    that are needed to make the Views tasks easier and cleaner.

"""

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

    def get(self, data):

        # Check if the user is an admin (superuser) and return the info right away
        if data['user'].is_superuser is True:
            result = {"id": data['user'].id,
                      "username": data['user'].username,
                      "name": data['user'].first_name + " " + data['user'].last_name,
                      "user_type": "admin"
                      }

        else:  # The user is not Admin
            # Check if the user is a staff or a simple employee
            try:
                employee = Employee.objects.get(user=data['user'])
                staff = Staff.objects.get(employee=employee)
                result = {"user_id": data['user'].id,
                          "employee_id": employee.id,
                          "staff_id": staff.id,
                          "username": staff.employee.user.username,
                          "name": staff.employee.user.first_name + " " + staff.employee.user.last_name,
                          "user_type": "staff",
                          "staff_type": staff.staff_type
                          }

            except Staff.DoesNotExist:  # The user is a Simple Employee (not in an organization)
                employee = Employee.objects.get(user=data['user'])
                result = {"user_id": data['user'].id,
                          "employee_id": employee.id,
                          "username": employee.user.username,
                          "name": employee.user.first_name + " " + employee.user.last_name,
                          "user_type": "employee",
                          }

        return result


class EmployeeSerializer(serializers.ModelSerializer):
    def save(self, **kwargs):
        my_emp = Employee(user=self.validated_data['user'])

        my_emp.save()
        return my_emp

    class Meta:
        model = Employee
        fields = ('user',)

    def get(self, data):
        results = []

        # Find the manager based on Employee and based on request.user (built-in User)
        manager = Staff.objects.get(employee=Employee.objects.get(user=data['user']))
        employees = Staff.objects.filter(organization=manager.organization, staff_type="employee")

        for staff_employee in employees:
            results.append({"staff_employee_id": staff_employee.id,
                            "username": staff_employee.employee.user.username,
                            "name": staff_employee.employee.user.first_name + " " +
                                    staff_employee.employee.user.last_name,
                            "joined_organization_at": staff_employee.created_at.strftime("%Y-%m-%d %H:%M:%S")
                            })
        return results


class OrganizationSerializer(serializers.ModelSerializer):
    def save(self, **kwargs):
        org = Organization(name=self.validated_data['name'],
                           description=self.validated_data['description'],
                           creator_id=self.validated_data['creator'].id)

        org.save()
        return org

    class Meta:
        model = Organization
        fields = ('name', 'description', 'creator')


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
        is_admin = is_manager = False

        # Find the user kind (manager or admin)
        if data['user'].is_superuser is True:
            is_admin = True
        else:
            is_manager = True

        # Find and return all the requests based on is_admin and is_manager
        if is_admin is True:
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

        elif is_manager is True:
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

        is_admin = is_manager = False

        # Find the user kind (manager or admin)
        if data['user'].is_superuser is True:
            is_admin = True
        else:
            is_manager = True
        print(data, is_manager, is_admin)
        if data['response'] is True:
            if is_admin is True:  # Handle request types 2,3 (join as manager and promotion)
                request.request_receiver = data['user'].id
                request.save()

                if request.request_type.id == 2:
                    employee = Employee.objects.get(id=request.request_sender)

                    # Check if the employee has been added as an active staff before
                    # to prevent working actively for two organizations
                    try:
                        obj = Staff.objects.get(employee=employee)

                        # This employee was some organization's staff before
                        # Check to see if he's active in that organization or not
                        if obj.is_active is False and obj.organization != request.requested_organization:
                            staff = Staff(employee=employee,
                                          organization=request.requested_organization,
                                          request=request,
                                          staff_type="manager")
                            staff.save()

                    except Staff.DoesNotExist:
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

            elif is_manager is True:  # Handle request type 1 (join as employee)
                # Find the manager's (staff) id and set its id as request_receiver
                manager = Staff.objects.get(employee=Employee.objects.get(user=data['user']))

                request.request_receiver = manager.id
                request.save()

                employee = Employee.objects.get(id=request.request_sender)

                # Check if the employee has been added as an active staff before
                # to prevent working actively for two organizations
                try:
                    obj = Staff.objects.get(employee=employee)
                    print(obj)
                    # This employee was some organization's staff before
                    # Check to see if he's active in that organization or not
                    if obj.is_active is False and obj.organization != request.requested_organization:
                        staff = Staff(employee=employee,
                                      organization=request.requested_organization,
                                      request=request,
                                      staff_type="employee")
                        staff.save()

                except Staff.DoesNotExist:
                    # Create a new Staff as a employee
                    staff = Staff(employee=employee,
                                  organization=request.requested_organization,
                                  request=request,
                                  staff_type="employee")
                    staff.save()

        else:  # Set the response giver id to request_receiver and save it
            if is_admin is True:
                request.request_receiver = data['user'].id
                request.save()

            elif is_manager is True:
                manager = Staff.objects.get(employee=Employee.objects.get(user=data['user']))

                request.request_receiver = manager.id
                request.save()

        return True


class TaskSerializer:
    def save(self, data):
        # Find the user(built-in) and based on that, find the employee (because they have one-to-one relation)
        # And then find who (staff) wants to create this task or do this task
        task_creator = Staff.objects.get(employee=Employee.objects.get(user=data['user']))
        task_operator = Staff.objects.get(id=data['operator_id'])

        task = Task(title=data['title'],
                    description=data['description'],
                    creator=task_creator,
                    operator=task_operator,
                    deadline=datetime.datetime.strptime(data['deadline'], "%Y-%m-%d %H:%M:%S")
                    )

        task.save()

        return True

    def get(self, data):
        results = []

        staff = Staff.objects.get(employee=Employee.objects.get(user=data['user']))

        # The manger got here through the first url or the second one
        if staff.staff_type == "manager":

            if data['employee_id'] is None:  # Get all the employees tasks made by the manager
                tasks = Task.objects.filter(creator=staff)

                for task in tasks:
                    # Check if the done_time is None to set a proper value to it
                    if task.done_time is None:
                        done_time = None
                    else:
                        done_time = task.done_time.strftime("%Y-%m-%d %H:%M:%S")

                    results.append({"title": task.title,
                                    "description": task.description,
                                    "operator": {"id": task.operator.id,
                                                 "username": task.operator.employee.user.username,
                                                 "name": task.operator.employee.user.first_name + " " +
                                                         task.operator.employee.user.last_name},
                                    "is_done": task.is_done,
                                    "done_time": done_time,
                                    "deadline": task.deadline.strftime("%Y-%m-%d %H:%M:%S"),
                                    "created_at": task.created_at.strftime("%Y-%m-%d %H:%M:%S")
                                    })

            else:  # Get the given employee's tasks based on the employee_id.

                tasks = Task.objects.filter(creator=staff, operator_id=data["employee_id"])

                for task in tasks:
                    if task.done_time is None:
                        done_time = None
                    else:
                        done_time = task.done_time.strftime("%Y-%m-%d %H:%M:%S")

                    results.append({"title": task.title,
                                    "description": task.description,
                                    "is_done": task.is_done,
                                    "done_time": done_time,
                                    "deadline": task.deadline.strftime("%Y-%m-%d %H:%M:%S"),
                                    "created_at": task.created_at.strftime("%Y-%m-%d %H:%M:%S")
                                    })

        elif staff.staff_type == "employee":
            tasks = Task.objects.filter(operator=staff)

            for task in tasks:
                if task.done_time is None:
                    done_time = None
                else:
                    done_time = task.done_time.strftime("%Y-%m-%d %H:%M:%S")

                results.append({"title": task.title,
                                "description": task.description,
                                "is_done": task.is_done,
                                "done_time": done_time,
                                "deadline": task.deadline.strftime("%Y-%m-%d %H:%M:%S"),
                                "created_at": task.created_at.strftime("%Y-%m-%d %H:%M:%S")
                                })

        # Sort the tasks based on the deadline time
        results.sort(key=lambda item: item['deadline'], reverse=False)

        return results
