# CHANGELOG

## [Unreleased]

* Up to date.

## [2.1.0] - 2019-05-06

### Added

* New exported variables: `move`. Enables/disables the Moon movement.

### Changed

* New `light.png`.
* `state_night_start_hour` from `18` to `19` in `DayNightCycle.gd`.

## [2.0.0] - 2019-04-17

### Added

* `Moon.tscn` and `Moon.gd`. 
* Better documentation explaining how to use the new **Moon**.
* New exported variables so they can be used right from the Inspector:
    * Day: `day_duration` and `day_start_number`.
    * Colors: `color_dawn`, `color_day`, `color_dusk` and `color_night`.
    * Cycle states: `state_dawn_start_hour`, `state_day_start_hour`, `state_dusk_start_hour`, `state_night_start_hour` and `state_transition_duration`.
    * Debug mode: `debug_mode`.

### Changed

* `enum` cycle states now has a name: `cycle_state`.
* More readable debug outputs.

### Fixed

* Use exclusive comparison operator for end of cycle: `<=` for `<`. Thanks to [Terkwood](https://github.com/Terkwood).

## [1.0.0] - 2019-01-31

* Released [1.0.0](https://github.com/hiulit/Godot-3-2D-Day-Night-Cycle/releases/tag/v1.0.0)