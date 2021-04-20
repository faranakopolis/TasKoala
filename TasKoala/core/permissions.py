from rest_framework import permissions

from TasKoala.core.models import *


class GetEmployeePermission(permissions.BasePermission):
    """Global permission check for the user type.
        (only managers can get all employees info)
    """

    def has_permission(self, request, view):
        try:
            staff = Staff.objects.filter(employee=Employee.objects.get(user=request.user))
            if staff.staff_type == "employee":
                return False
            elif staff.staff_type == "manager":
                return True
        except Staff.DoesNotExist:
            return False
