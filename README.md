# Development Setup

## Install All Development Dependencies

- Godot \
  IMPORTANT: Needs to be in the path!
- rust (ideally latest stable version via rustup)
- just (cargo install just) \
- gdtoolkit (pip install gdtoolkit) \
  IMPORTANT: Needs to be in the path!
- pre-commit (pip install pre-commit)
- sh: included in Git Bash for Windows. \
  IMPORTANT: Needs to be in the path!

For Windows Builds:
- mingw-w64, taken from here [MinGW](https://github.com/mstorsjo/llvm-mingw/releases) \
  IMPORTANT: Needs to be in the path!

For Linux Builds:
- mold (distro repositories) recommended

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

#### Plugins

You need to enable all the plugins, which we ship by default under `Project -> Project Settings... -> Plugins -> Check Status Enable`. 


## Exporting Project

In order to export the created project you need to download the template. There is a link under `Project -> Export...` if you don't have it installed yet.


# Development

![alt text](https://preview.redd.it/gdstyle-naming-convention-and-code-order-cheat-sheet-i-made-v0-fja8svy2b9y91.png?width=1080&crop=smart&auto=webp&s=fac15d4f4d9eda59223391acbe89623d5b8a77d8)
