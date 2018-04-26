
## preact_redux

A React/Redux SPA using the [Preact](https://preactjs.com) library.
Preact is a Fast 3kB alternative to React with the same modern API.
The amber backend serves both html and json.  Also includes a JWT authorisation
pipe in src/pipes.  Create a new amber app with this template with these commands;

```
amber new mynewapp -r react/preact_redux
cd mynewapp
amber g auth User
```
Notes:  yarn or npm install issue warnings about unmet dependencies for react.  this
is normal as react is provided by preact via the preact-compat shim.  Remove the
Authenticate pipe from config/routes.cr after generating the auth plugin.  Remove the
AuthenticateJWT pipe from config/routes.cr if authentication is not required.
