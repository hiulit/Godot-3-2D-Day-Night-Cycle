# CHANGELOG

## [Unreleased]

* Up to date.

## [3.0.0] - 2021-01-15

**NOTE**: This release contain breaking changes!

### Added

- Moved the time-specific code into a **Time** singleton.
- Add a **debug overlay** that shows:
    - A slider to change the time manually.
    - A checkbox to freeze/unfreeze the time.
    - A checkbox to show/hide the moon light.
    - The current time.
    - The current date.
    - The current period.
    - The FPS.
- The moon light can be static or moving.

### Changed

- `DayNightCycle` is just tweening the cycles.
- The `delay` variable of `DayNightCycle` must be set in in-game seconds.
- `MoonLight` must be sync with a `DayNightCycle`.

## [2.1.2] - 2019-10-07

### Added

- New parameter: `on`. Enables/disables the node.
- New function `obj_exists()` to check if an object has been deleted.
- Added a `ColorRect` as background to appreciate the cycles and the Moon better.

### Fixed

- The Moon wasn't moving properly.

## [2.1.1] - 2019-06-12

### Added

- Check if `Global.Moon` exists instead of commenting the code that changes the Moon's state.

## [2.1.0] - 2019-05-06

### Added

- New exported variables: `move`. Enables/disables the Moon movement.

### Changed

- New `light.png`.
- `state_night_start_hour` from `18` to `19` in `DayNightCycle.gd`.

## [2.0.0] - 2019-04-17

### Added

- `Moon.tscn` and `Moon.gd`. 
- Better documentation explaining how to use the new **Moon**.
- New exported variables so they can be used right from the Inspector:
    - Day: `day_duration` and `day_start_number`.
    - Colors: `color_dawn`, `color_day`, `color_dusk` and `color_night`.
    - Cycle states: `state_dawn_start_hour`, `state_day_start_hour`, `state_dusk_start_hour`, `state_night_start_hour` and `state_transition_duration`.
    - Debug mode: `debug_mode`.

### Changed

- `enum` cycle states now has a name: `cycle_state`.
- More readable debug outputs.

### Fixed

- Use exclusive comparison operator for end of cycle: `<=` for `<`. Thanks to [Terkwood](https://github.com/Terkwood).

## [1.0.0] - 2019-01-31

- Released [1.0.0](https://github.com/hiulit/Godot-3-2D-Day-Night-Cycle/releases/tag/v1.0.0)