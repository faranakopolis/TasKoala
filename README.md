# **TasKoala**

### Manage your Tasks like a Koala...
### easy peasy ;)

![logo_gray](https://github.com/maripillon/TasKoala/blob/master/Logo/Logo_gray.png?raw=true)

**TasKoala** Is a task management system for organizations, including following APIs:

    - Creating account for each user.
    - Request to join an organization as staff (employee or manager)
    - Request for promotion.
    - Create and assign tasks.
    - ...


## APIs

You can download and use the export file of TasKoala Postman's collection [here](https://github.com/maripillon/TasKoala/tree/master/files/postman).

For example:
`/api/v01/admin/create-organization/`

This API requires Token Authentication, and you can only use this API through the POST method. You also need to pass a JSON in the body request like below:

`{"name": "organization name", "description": "organization description"}`


