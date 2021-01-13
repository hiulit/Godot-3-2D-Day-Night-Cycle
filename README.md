# Godot 3 2D Day/Night Cycle

<img alt="Godot v3.x" src="https://img.shields.io/badge/Godot-v3.x-%23478cbf?logo=godot-engine&logoColor=white&style=flat-square" />
<img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/hiulit/Godot-3-2D-Day-Night-Cycle?&style=flat-square" />
<img alt="GitHub license" src="https://img.shields.io/github/license/hiulit/Godot-3-2D-Day-Night-Cycle?&style=flat-square" />

A 2D ☀️ Day / 🌔 Night cycle using `CanvasModulate` and a moon light effect using `Light2D`.

![Godot 3 2D Day/Night Cycle Banner](example_images/godot_3_2D_day_night_cycle_banner.jpg)

## Examples

![Cycle without the moon light](example_images/day_night_cycle_godot_3-no-moon.gif)

*Cycle without the moon light.*

![Cycle with the moon light static](example_images/day_night_cycle_godot_3-with-moon.gif)

*Cycle with the moon light static.*

![Cycle with the moon light moving](example_images/day_night_cycle_godot_3-with-moving-moon.gif)

*Cycle with the moon light moving.*
## 🛠️ Installation

- [Download](https://github.com/hiulit/Godot-3-2D-Day-Night-Cycle/archive/master.zip) the repository ZIP file.
- Copy the **Time** singleton in your project and [enable](https://docs.godotengine.org/en/stable/getting_started/step_by_step/singletons_autoload.html) it.
    - `src/singletons/Time.gd`
- Copy the **Day/Night Cycle** folder in your project.
    - `src/day_night_cycle`
- Copy **Moon** folder in your project.
    - `src/moon`
- Copy the **Debug overlay** folder in your project.
    - `src/debug_overlay`

... XXX ... ... XXX ... ... XXX ...

## 🚀 Usage

- Instance `day_night_cycle.tscn` (you may have to attach `day_night_cycle.gd` to it as a script)
- 

### Tips

Instance one `DayNightCycle.tscn` in your background scene and another `DayNightCycle.tscn` in your main scene or level scene, etc. and set the **Day start hour** in the background scene a little after than the **Day start hour** in the main scene to have the effect that the background starts changing before the foreground.

```
Node
├── CanvasLayer
│   └── DayNightCycle
├── Player
├── OtherStuff
└── DayNightCycle
```

#### Example

* Background scene - **Day start hour**: 10.2
* Main scene - **Day start hour**: 10

... XXX ... ... XXX ... ... XXX ...

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

If you love this project, please consider supporting it through any size donations to help make it better ❤️

[![Become a patron](https://img.shields.io/badge/Become_a_patron-ff424d?logo=Patreon&style=for-the-badge&logoColor=white)](https://www.patreon.com/hiulit)

[![Suppor me on Ko-Fi](https://img.shields.io/badge/Support_me_on_Ko--fi-F16061?logo=Ko-fi&style=for-the-badge&logoColor=white)](https://ko-fi.com/F2F7136ND)

[![Buy me a coffee](https://img.shields.io/badge/Buy_me_a_coffee-FFDD00?logo=buy-me-a-coffee&style=for-the-badge&logoColor=black)](https://www.buymeacoffee.com/hiulit)

[![Donate Paypal](https://img.shields.io/badge/PayPal-00457C?logo=PayPal&style=for-the-badge&label=Donate)](https://www.paypal.com/paypalme/hiulit)

share it with the world

[![](https://img.shields.io/badge/Share_on_Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/intent/tweet?url=https%3A%2F%2Fgithub.com%2Fhiulit%2FGodot-3-2D-Day-Night-Cycle&text=%22Godot%203%202D%20Day%2FNight%20Cycle%22%3A%20A%202D%20%E2%98%80%EF%B8%8F%20Day%20%2F%20%F0%9F%8C%94%20Night%20cycle%20using%20CanvasModulate%20and%20a%20moon%20light%20effect%20using%20Light2D)


or give it a [star ⭐️](https://github.com/hiulit/Godot-3-2D-Day-Night-Cycle/stargazers).

## 👏 Credits

Thanks to:

- [Solo CodeNet](https://twitter.com/codenetsolo) - For the [YouTube video tutorial](https://www.youtube.com/watch?v=sz8fyzvB6q0) that inspired this project.
- [Terkwood](https://github.com/Terkwood) - For helping with an issue about comparison operators in the cycle state.
- [Mitch Curtis](https://github.com/mitchcurtis) - For an amazing PR ([#4](https://github.com/hiulit/Godot-3-2D-Day-Night-Cycle/pull/4)) that helped improve the project big time.
- [Twemoji](https://twemoji.twitter.com/) - For the emojis.
- **Andrea Calabró** - For creating the Godot logo.


## 📝 Licenses

- Source code: [MIT License](/LICENSE).
- Emojis: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
- Godot logo: [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/).


