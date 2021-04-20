
## Database

### User, Employee, Staff

As explained in the code, in order to create the Employee model, I extended the Django built-in User.

However, for the following reasons I decided to keep my Admin data in The Django built-in User table:
- The Admin is created by the `createsuperuser` command.
- To retrieve an Admin I can simply check the _is_superuser_ column in the User table but to retrieve a non Admin user (employee,staff_employee,staff_manager) checking this column wouldn't be enough.

To understand all the roles in the system we simply trace the foreign_keys through the User, Employee and staff tables.

For example when a guest user signups in TasKoala, its will be store in the User table with `is_superuser=False` and also its user_id will be stored in the Employee table and an `employee_id` will be given to it too.

As soon as an Employee's join request gets accepted, the 

Therefore, for example if i was trying to get a task_operator's first_name I should do the followings:
