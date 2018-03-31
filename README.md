# Code generation recipes for the [Amber Web Framework](https://amberframework.org)

Amber generators can use a recipe to generate your application, and scaffold your
application with controllers, models and views.  Using a recipe you can get started
with an amber application that extends or modifies the standard built in generator
or provides additional features.  For example you might want an API application
that only renders JSON or use React or AngularJS for views.

To create an amberframework application from a recipe type;
```sh
amber new <appname> -r <recipe>
```
to create a new amber app from the given named recipe in a folder with the given appname.

The given recipe can be either
- a recipe from this repository
- a directory with an application template

Read the **Recipes** section in the [online guides](https://amberframework.org/guides)
for more information.

## Contributed recipes

Contributors create recipes and publish a zip file of the recipe.
The recipe zip file should be added to the repository in a sub folder named after
the contributor's github login name e.g.

**damianham/default.zip**

To create a new amber app from this recipe at the command line type
```sh
amber new newapp -r damianham/default
```
to create a new amber app from the recipe at damianham/default.zip in the
folder newapp.  recipes should contain the following templates:

- app
- controller
- model
- scaffold

## Using a template in a local folder
You can use a local folder as the source template for a new amber application e.g.
```sh
mkdir default_recipe
wget https://raw.githubusercontent.com/amberframework/recipes/master/damianham/default.zip
unzip -d default_recipe default.zip
amber new newapp -r default_recipe
```

The result of which is equivalent to
```sh
amber new newapp -r damianham/default
```

## Available Recipes

Read [Contributions](https://github.com/amberframework/recipes/blob/master/Contributions.md)
to see a list of available app recipes.  Each recipe contributor provides additional
information in their own Readme.

## Recipe issues

If you notice a problem with a recipe please contact the recipe contributor directly
rather than raise an issue.  You can visit the contributor's github account at
```
https://github.com/{contributor_name}
```

## Notes to Contributors

Please include a README.md in your recipe folder that describes your recipe(s) in detail
and an entry in the Contributions.md listing the recipes in your folder with some useful keywords
for each recipe to aid searching.

Recipes use the [Liquid template language](https://github.com/TechMagister/liquid.cr).
The file extension should be **.liquid** but if you prefer shorter 3 letter file extensions
you can also use **.lqd** which is an unknown or unnassigned file extension.  To create a
new recipe fork https://github.com/amberframework/recipes, clone your fork, create a new
sub folder with your github username,
extract an existing recipe, make your modifications and create a zip file and README.md
in your sub folder.  Don't forget to add an entry to Contributions.md about your recipe.

Many Thanks.
