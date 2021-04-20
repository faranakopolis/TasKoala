"""TasKoala
Is a task management system for organizations including following use-cases(APIs):
    - Creating account for each user.
    - Request to be some organization's employee.
    - Request to change your position.
    - Create and assign tasks.
    - ...
With TasKoala, manage your tasks like a Koala...easy peasy ;)

Author: Maripillon (Faranak Heydari)
"""

from django.contrib import admin
from django.urls import path

from TasKoala.core.views import *
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

urlpatterns = [
    path('admin/', admin.site.urls),

    path('api/v01/employee/signup/', SignUpView.as_view(), name='employee_register'),
    # Every User can use these three APIs
    path('api/v01/user/login/', TokenObtainPairView.as_view(), name='user_get_token'),
    path('api/v01/user/token/refresh/', TokenRefreshView.as_view(), name='user_token_refresh'),
    path('api/v01/user/logout/', LogoutView.as_view(), name='user_logout'),

    path('api/v01/user/get-info/', UserView.as_view(), name='get_a_user_information'),

    path('api/v01/employee/request/<str:request_type>/', RequestView.as_view(),
         name='request_to_be_an_org_member_or_get_promotion'),
    # You can get user_type from get_info API:
    # if it's staff and staff_type is manager then pass ../manager/.. as user_type here
    # and if it's an admin then pass ../admin/..
    path('api/v01/<str:user_type>/requests/', RequestView.as_view(),
         name='get_requests_by_admin_or_manager'),
    path('api/v01/<str:user_type>/request/set-response/<int:request_id>', RequestView.as_view(),
         name='give_response_to_a_request_by_admin_or_manager'),

    path('api/v01/manager/create-task/', TaskView.as_view(), name='create_a_task'),
    path('api/v01/<str:staff_type>/tasks/', TaskView.as_view(), name='get_all_tasks_based_on_staff_type'),
    path('api/v01/manager/tasks/<int:employee_id>', TaskView.as_view(), name='get_a_given_employee_tasks'),

    path('api/v01/manager/employees/', EmployeeView.as_view(), name='get_all_employees_by_manager'),
]
