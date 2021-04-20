"""This module includes the Permissions for each API
    ( I didn't have enough time to implement all of the permissions...)
"""

from rest_framework import permissions

from TasKoala.core.models import *


class EmployeeViewPermission(permissions.BasePermission):
    """Global permission check for the user type.
        (only managers can get all employees info)
    """

    def has_permission(self, request, view):
        try:
            staff = Staff.objects.get(employee=Employee.objects.get(user=request.user))

            if staff.staff_type == "employee":
                return False
            elif staff.staff_type == "manager":
                return True

        except Staff.DoesNotExist:  # Just a simple Employee (he's not a staff)
            return False


class OrganizationViewPermission(permissions.BasePermission):
    """Global permission check for the user type.
        (only admins can create organizations)
    """

    def has_permission(self, request, view):
        if request.user.is_superuser is True:
            return True
        else:
            return False
