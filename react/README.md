## preact_redux

A React/Redux SPA using the [Preact](https://preactjs.com) library.
Preact is a Fast 3kB alternative to React with the same modern API.
The amber backend serves both html and json.  Also includes a JWT authorisation
pipe in src/pipes.  Create a new amber app with this template with these commands;


```
amber new mynewapp -r react_preact_redux
cd mynewapp
# Default main.bundle.js contains React example for these components, Try them!
amber g scaffold Category title:string user_id
amber g scaffold Product title:string description:text category:reference user_id
amber g scaffold Comment body:text product:reference user_id
amber g auth User
```

### Notes

1. `yarn` or `npm` install issue warnings about unmet dependencies for react. This
is normal as react is provided by preact via the preact-compat shim. **This recipe is using react-route v2 yet**, migration to v4 is work in progress.
2. Remove the Authenticate pipe from `config/routes.cr` after generating the auth plugin.  
3. Uncomment AuthenticateJWT pipe from `config/routes.cr` if authentication is required.
4. If you're using [JWT](https://jwt.io/) then an `user_id` field is required on your **models**, **param validators** and **migrations** to render `edit` and `delete` buttons according to `current_user`.
5. By default this recipe doesn't provide a form to generate the JSON Web Token, but just to sign in. To generate a token you can use https://jwt.io/ or create your own form using JWT package, with your `secret_key_base` inside your `config/enviroments/development.yml` file and a valid email. Try `amber db seed` and email `admin@example.com`.
6. If you're getting "Could not load..." error then ensure your models URLs are inside `REGEX_PATHS` in `pipes/authenticate_jwt.cr`.
