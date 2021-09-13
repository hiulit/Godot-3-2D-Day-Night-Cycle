# Debug Overlay

**Extends**: `PopupPanel`

## Table of contents

### Variables

- [moon_light_node_path](#moon_light_node_path)
- [show](#show)

## Variables

### moon_light_node_path

If a `MoonLight` node is assigned,  a **Show moon** checkbox will appear in the debug overlay to enable/disable the moon.

```gdscript
export (NodePath) var moon_light_node_path
```

|Name|Type|Default|
|:-|:-|:-|
|`moon_light_node_path`|`NodePath`|-|

### show

Enables/disables the debug overlay.

```gdscript
export (bool) var show = true
```

|Name|Type|Default|
|:-|:-|:-|
|`show`|`bool`|`true`|

Powered by [GDScriptify](https://github.com/hiulit/gdscriptify).
