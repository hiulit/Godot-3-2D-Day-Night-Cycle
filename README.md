# Godot 3 2D Day/Night Cycle

![Godot v3.x](https://img.shields.io/badge/Godot-v3.x-%23478cbf?logo=godot-engine&logoColor=white) ![GitHub release (latest by date)](https://img.shields.io/github/v/release/hiulit/Godot-3-2D-Day-Night-Cycle) [![GitHub license](https://img.shields.io/github/license/hiulit/Godot-3-2D-Day-Night-Cycle)](https://github.com/hiulit/Godot-3-2D-Day-Night-Cycle/blob/master/LICENSE)

A 2D ☀️ Day / 🌔 Night cycle using `CanvasModulate` and a moon light effect using `Light2D`.

![Godot 3 2D Day/Night Cycle](example_images/godot_3_2D_day_night_cycle.jpg)

## Examples

![Godot 3 2D Day/Night Cycle GIF](example_images/day_night_cycle_godot_3-no-moon.gif)

*Cycle without the moon light.*

![Godot 3 2D Day/Night Cycle GIF](example_images/day_night_cycle_godot_3-with-moon.gif)

*Cycle with the moon light.*

![Godot 3 2D Day/Night Cycle GIF](example_images/day_night_cycle_godot_3-with-moving-moon.gif)


*Cycle with the moon light moving.*
## Installation

- [Download](https://github.com/hiulit/Godot-3-2D-Day-Night-Cycle/archive/master.zip) the repository ZIP file.
- Copy the **Time** singleton in your project and [enable](https://docs.godotengine.org/en/stable/getting_started/step_by_step/singletons_autoload.html) it.
    - `src/singletons/Time.gd`
- Copy the **Day/Night Cycle** folder in your project.
    - `src/day_night_cycle`
- Copy **Moon** folder in your project.
    - `src/moon`
- Copy the **Debug overlay** folder in your project.
    - `src/debug_overlay`
## Usage



### Tips

Instance one `DayNightCycle.tscn` in your background scene and another `DayNightCycle.tscn` in your main scene or level scene, etc. and set the **Day start hour** in the background scene a little after than the **Day start hour** in the main scene to have the effect that the background starts changing before the foreground.

```
Main
├── Background
│   └── DayNightCycle
├── Player
├── OtherStuff
└── DayNightCycle
```

#### Example

* Background scene - **Day start hour**: 10.2
* Main scene - **Day start hour**: 10

... XXX ...

## 📑 Documentation

- [Day/Night Cycle](docs/DAY_NIGHT_CYCLE.md)
- [Moon](docs/MOON.md)
- [Time](docs/TIME.md)

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

If this project helped you, please consider supporting it through any size donations ❤️.

[![patreon](https://c5.patreon.com/external/logo/become_a_patron_button.png)](https://www.patreon.com/hiulit)

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/F2F7136ND)

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/paypalme/hiulit)

Or just drop a star ⭐️.


## 👏 Credits

Thanks to:

- **Solo CodeNet** for the [YouTube video tutorial](https://www.youtube.com/watch?v=sz8fyzvB6q0) that inspired me.
- [Terkwood](https://github.com/Terkwood) - For helping with an issue about comparison operators in the cycle state.
- [Twemoji](https://twemoji.twitter.com/) - For the emojis.
- **Andrea Calabró** - For creating the Godot logo.


## 📝 Licenses

- Source code: [MIT License](/LICENSE).
- Emojis: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
- Godot logo: [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/).


