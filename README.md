# Godot 3 2D Day/Night Cycle

![Godot v3.x](https://img.shields.io/badge/Godot-v3.x-%23478cbf?logo=godot-engine&logoColor=white&style=flat-square) ![GitHub release (latest by date)](https://img.shields.io/github/v/release/hiulit/Godot-3-2D-Day-Night-Cycle?&style=flat-square) ![GitHub license](https://img.shields.io/github/license/hiulit/Godot-3-2D-Day-Night-Cycle?&style=flat-square)

A 2D ☀️ Day / 🌔 Night cycle using `CanvasModulate` and a moon light effect using `Light2D`.

![Godot 3 2D Day/Night Cycle Banner](example_images/godot_3_2D_day_night_cycle_banner.jpg)

## Examples

![Cycle without the moon light](example_images/day_night_cycle_godot_3-no-moon.gif)

*Cycle without the moon light.*

![Cycle with the moon light static](example_images/day_night_cycle_godot_3-with-moon.gif)

*Cycle with the moon light static.*

![Cycle with the moon light moving](example_images/day_night_cycle_godot_3-with-moving-moon.gif)

*Cycle with the moon light moving.*
## 🛠️ Setup

- Clone the repository or [download](https://github.com/hiulit/Godot-3-2D-Day-Night-Cycle/archive/master.zip) it in a ZIP file.
- Copy the following files and folders to your project:
    - `Time.gd` file (`day_night_cycle/src/Singletons/Time.gd`).
    - `DayNightCycle` folder (`day_night_cycle/src/DayNightCycle`).
    - `MoonLight` folder (`day_night_cycle/src/MoonLight`).
    - `DebugOverlay` folder (`day_night_cycle/src/DebugOverlay`).

## 📑 Documentation

- [Time](docs/TIME.md)
- [DayNightCycle](docs/DAY_NIGHT_CYCLE.md)
- [MoonLight](docs/MOON_LIGHT.md)
- [DebugOverlay](docs/DEBUG_OVERLAY.md)

## 🚀 Usage

- [Prerequisites](#prerequisites)
- [Add a simple cycle](#add-a-simple-cycle)
- [Add a cycle with a moon light](#add-a-cycle-with-a-moon-light)
- [Add a delay between cycles](#add-a-delay-between-cycles)
- [Add a debug overlay](#add-a-debug-overlay)

### Prerequisites

Add the `Time` singleton:

- Go to `Project` -> `Project Settings`.
- Go to the `AutoLoad` tab.
- Add the `Time.gd` file.
- Enable it.

![Enable the Time.gd singleton](example_images/enable_time_singleton.png)

Change the `Time` [parameters](docs/TIME.md#parameters) to your liking.

### Add a simple cycle

Instance the `DayNightCycle` node in the root scene.

```
Node
├── TileMap
├── Player
├── OtherStuff
└── DayNightCycle
```

Change the `DayNightCycle` [parameters](docs/DAY_NIGHT_CYCLE.md#parameters) to your liking.

### Add a cycle with a moon light

Instance the `DayNightCycle` node and the `MoonLight` node in the root scene.

```
Node
├── TileMap
├── Player
├── OtherStuff
├── DayNightCycle
└── MoonLight
```

[Sync](docs/MOON_LIGHT.md#cycle-sync-node-path) the `MoonLight` with the `DayNightCycle`.

The `MoonLight` can be static or [moving](docs/MOON_LIGHT.md#move) in sync with a `DayNightCycle`.

Change the `DayNightCycle` [parameters](docs/DAY_NIGHT_CYCLE.md#parameters) and the `MoonLight` [parameters](docs/MOON_LIGHT.md#parameters) to your liking.

### Add a delay between cycles

- Create a `CanvasLayer` for the background and set its `layer` to `-1`.
- Instance the `DayNightCycle` node in the background `CanvasLayer` previously created.
- Instance another `DayNightCycle` node in the root scene and add a [delay](docs/DAY_NIGHT_CYCLE.md#delay).
- Instance the `MoonLight` in the root scene and [sync it](docs/MOON_LIGHT.md#cycle-sync-node-path) to the `DayNightCycle` node with a delay.

Something like this:

```
Node
├── CanvasLayer (layer = -1)
│   └── BackgroundSprite
│   └── DayNightCycleBackground (delay = 0)
├── TileMap
├── Player
├── OtherStuff
└── DayNightCycleForeground (delay = 1800)
└── MoonLight (cycle_sync_node_path = DayNightCycleForeground)
```

This will create the effect that the background starts changing before the foreground.

### Add a debug overlay

Test the passing of time, the cycles and the moon light.

![Debugg overlay example](example_images/debug_overlay_example.png)

- Create a `CanvasLayer` and set its `layer` to `1`.
- Instance the `DebugOverlay` node.

Something like this:

```
Node
├── TileMap
├── Player
├── OtherStuff
├── DayNightCycle
├── MoonLight
└── CanvasLayer (layer = 1)
    └── DebugOverlay
```

## 🗒️ Changelog

See [CHANGELOG](/CHANGELOG.md).

## 👤 Author

**hiulit**

- Twitter: [@hiulit](https://twitter.com/hiulit)
- GitHub: [@hiulit](https://github.com/kefhiulitranabg)

## 🤝 Contributing

Feel free to:

- [Open an issue](https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/issues) if you find a bug.
- [Create a pull request](https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/pulls) if you have a new cool feature to add to the project.
- [Start a new discussion]() about a feature request.

## 🙌 Supporting this project

If you love this project or find it helpful, please consider supporting it through any size donations to help make it better ❤️.

[![Become a patron](https://img.shields.io/badge/Become_a_patron-ff424d?logo=Patreon&style=for-the-badge&logoColor=white)](https://www.patreon.com/hiulit)

[![Suppor me on Ko-Fi](https://img.shields.io/badge/Support_me_on_Ko--fi-F16061?logo=Ko-fi&style=for-the-badge&logoColor=white)](https://ko-fi.com/F2F7136ND)

[![Buy me a coffee](https://img.shields.io/badge/Buy_me_a_coffee-FFDD00?logo=buy-me-a-coffee&style=for-the-badge&logoColor=black)](https://www.buymeacoffee.com/hiulit)

[![Donate Paypal](https://img.shields.io/badge/PayPal-00457C?logo=PayPal&style=for-the-badge&label=Donate)](https://www.paypal.com/paypalme/hiulit)

If you can't, consider sharing it with the world...

[![](https://img.shields.io/badge/Share_on_Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/intent/tweet?url=https%3A%2F%2Fgithub.com%2Fhiulit%2FGodot-3-2D-Day-Night-Cycle&text=%22Godot%203%202D%20Day%2FNight%20Cycle%22%3A%20A%202D%20%E2%98%80%EF%B8%8F%20Day%20%2F%20%F0%9F%8C%94%20Night%20cycle%20using%20CanvasModulate%20and%20a%20moon%20light%20effect%20using%20Light2D)

... or giving it a [star ⭐️](https://github.com/hiulit/Godot-3-2D-Day-Night-Cycle/stargazers).

## 👏 Credits

Thanks to:

- [Solo CodeNet](https://twitter.com/codenetsolo) - For the [YouTube video tutorial](https://www.youtube.com/watch?v=sz8fyzvB6q0) that inspired this project.
- [Terkwood](https://github.com/Terkwood) - For helping with an issue about comparison operators in the cycle state.
- [Mitch Curtis](https://github.com/mitchcurtis) - For an amazing PR ([#4](https://github.com/hiulit/Godot-3-2D-Day-Night-Cycle/pull/4)) that helped improve the project big time.
- [Luis Zuno](https://twitter.com/ansimuz) - For creating the [Sunny Land](https://opengameart.org/content/sunny-land-2d-pixel-art-pack) assets.
- [Twemoji](https://twemoji.twitter.com/) - For the emojis.
- **Andrea Calabró** - For creating the Godot logo.


## 📝 Licenses

- Source code: [MIT License](/LICENSE).
- Emojis: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
- Godot logo: [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/).
- Sunny Land assets: [Public domain](https://creativecommons.org/publicdomain/zero/1.0/deed).

