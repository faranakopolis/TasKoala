
## Database

As explained in the code, in order to create the Employee model, I extended the Django built-in User.

However, for the following reasons I decided to keep my Admin data in The Django built-in User table:
- The Admin is created by the `createsuperuser` command.
- To retrieve an Admin I can simply check the _is_superuser_ column in the User table.

