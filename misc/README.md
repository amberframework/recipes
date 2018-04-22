

## modular

A recipe that organises controller, model and views into modules e.g.

- src/modules
- src/modules/post
- src/modules/post/edit.slang
- src/modules/post/_form.slang
- src/modules/post/post_controller.cr
- src/modules/post/show.slang
- src/modules/post/post.cr
- src/modules/post/index.slang
- src/modules/post/new.slang

Create a new amber app with this template with the command;

```
amber new mynewapp -r misc/modular
```
