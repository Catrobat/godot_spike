# Development Setup

## Install All Development Dependencies

- Godot
- rust (ideally latest stable version via rustup)
- mold (distro repositories)
- just (cargo install)
  IMPORTANT: Needs to be in the path!
- gdtoolkit (distro repos / pip install)
  IMPORTANT: Binaries of this toolkit need to be in the path!

Recommended:
- pre-commit

For Windows Builds:
- mingw-w64 (or mingw-w64-gcc)

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


# Development

![alt text](https://preview.redd.it/gdstyle-naming-convention-and-code-order-cheat-sheet-i-made-v0-fja8svy2b9y91.png?width=1080&crop=smart&auto=webp&s=fac15d4f4d9eda59223391acbe89623d5b8a77d8)
