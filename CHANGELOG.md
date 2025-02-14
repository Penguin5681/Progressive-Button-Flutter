## 0.0.1

### Initial Release

- Customizable width and height
- Built-in loading animation
- Progress indicator with percentage
- Circular progress indicator (optional)
- Stretches to full width (optional)
- Estimated time-based progress simulation

## 0.0.2

### Typo Fixes

- Fixed the typo from Awesome Button to Progressive Button

## 1.0.0

### Added
- `onSuccess` callback to execute on successful completion of the button action.
- `onFailure` callback to execute on failure of the button action.
- `onComplete` callback to execute on completion of the button action.
- `elevation` parameter to customize the elevation of the button.
- `shadowColor` parameter to customize the shadow color of the button.
- `enableHapticFeedback` parameter to enable or disable haptic feedback on button press.
- `gradient` parameter to define custom gradient styles.
- `progressGradient` parameter to define custom gradient styles for the progress indicator.

### Updated
- Documentation in `README.md` to include new parameters and features.

## 1.1.0

### Added
- `audioAssetPath` parameter to specify the path for a custom audio effect.
- `volume` parameter to set the volume for the audio effect.

### Updated
- `ProgressiveButtonFlutter` now supports playing custom audio effects when the button is pressed.
- Improved error handling and debugging for audio playback issues.

## 1.2.0

### Added
- `isEnabled` parameter to control whether the button is enabled or disabled.
- Button opacity changes to 0.5 when disabled.

### Updated
- Documentation in `README.md` to include the `isEnabled` parameter.
