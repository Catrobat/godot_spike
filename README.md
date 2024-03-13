# Development Setup

## Install All Development Dependencies

- Godot
- rust (ideally latest stable version via rustup)
- just
- gdtoolkit
  IMPORTANT: Needs to be in the path!
- pre-commit

## Set up the Repository

```
just setup
```

This command will
- check whether all development dependencies are present and in $PATH
- generate development signing keys for Android
- install pre-commit hooks (automatic formatting and linting before a commit)
- install the necessary rust components


### Manual Steps


#### Keystore
You need to set your android keystore to this file in godot.
See: 

https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html#setting-it-up-in-godot

#### GDFormatter

Enable in the project settings.


## Exporting Project

In order to export the created project you need to download the template. There is a link under `Project -> Export...` if you don't have it installed yet.

