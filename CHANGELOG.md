# CHANGELOG

## [Unreleased]

* Up to date

## [2.0.0] - 2019-04-05

### Added

* `Moon.tscn` and `Moon.gd`.
* Better documentation explaining how to use the new **Moon**.
* Exported the color variables so they can be used right from the Inspector.
* New exported variables for cycle states: `dawn_state_start_hour`, `day_state_start_hour`, `dusk_state_start_hour` and `night_state_start_hour`.

### Changed

* `enum` cycle states now has a name: `cycle_state`.
* More readable debug outputs.

### Fixed

* Use exclusive comparison operator for end of cycle: `<=` for `<`. Thanks to [Terkwood](https://github.com/Terkwood).

## [1.0.0] - 2019-01-31

* Released [1.0.0](https://github.com/hiulit/Godot-3-2D-Day-Night-Cycle/releases/tag/v1.0.0)