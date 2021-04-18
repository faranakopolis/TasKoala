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

    path('api/v01/user/signup/', SignUpView.as_view(), name='user_register'),

    path('api/v01/user/login/', TokenObtainPairView.as_view(), name='user_get_token'),
    path('api/v01/user/token/refresh/', TokenRefreshView.as_view(), name='user_token_refresh'),
    path('api/v01/user/logout/', LogoutView.as_view(), name='user_logout'),

    path('api/v01/user/requestToBeMember/', RequestToBeMember.as_view(), name='request_to_be_an_org_member'),

]
