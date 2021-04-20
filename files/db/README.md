
## Database

### User, Employee, Staff

As explained in the code, in order to create the Employee model, I extended the Django built-in User.

However, for the following reasons I decided to keep my Admin data in The Django built-in User table:
- The Admin is created by the `createsuperuser` command.
- To retrieve an Admin I can simply check the _is_superuser_ column in the User table but to retrieve a non Admin user (_employee, staff_employee, staff_manager_) checking this column wouldn't be enough.

Therefore, to understand all the roles in the system we simply trace the foreign keys through the *User*, *Employee* and *Staff* tables.

For example when a guest user signups in TasKoala, its main data will be stored in the User table with `is_superuser=False` and also its `user_id` will be stored in the Employee table along an `id`.

As soon as an Employee's join request gets accepted, one record will be added to the Staff table with a given `organization_id` and `staff_type` (manager or employee).

### Request

As you can see in the picture, the two columns `request_sender` and `request_receiver` may seem to be two foreign keys but they're not !

They are just two simple integers. It's because until we can't specify the `request_type` and `request_sender` there's no way to tell that who is the one receiving this request !
So we just consider them as integers to see which of these tables we're going to seach into (the *Admin*, *Staff* or the *Employee* table)

