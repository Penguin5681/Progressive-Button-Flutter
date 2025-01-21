# Progressive Button

A customizable Flutter button widget with built-in loading and progress indicators.

## Features
- Customizable width and height
- Built-in loading animation
- Progress indicator with percentage
- Circular progress indicator (optional)
- Stretches to full width (optional)
- Estimated time-based progress simulation
- Success and failure callbacks
- Completion callback
- Elevation and shadow color customization
- Haptic feedback (optional)
- Custom audio effect on button press

## Parameters

| Parameter               | Type                       | Default Value                           | Description                                           |
|-------------------------|----------------------------|-----------------------------------------|-------------------------------------------------------|
| `text`                  | `String`                   | Required                                | The text to display on the button                     |
| `onPressed`             | `Future<void> Function()`  | Required                                | The async function to execute when button is pressed  |
| `onSuccess`             | `Future<void> Function()?` | `null`                                  | Callback function to execute on success               |
| `onFailure`             | `Future<void> Function()?` | `null`                                  | Callback function to execute on failure               |
| `onComplete`            | `Future<void> Function()?` | `null`                                  | Callback function to execute on completion            |
| `estimatedTime`         | `Duration`                 | Required                                | Expected duration of the async operation              |
| `width`                 | `double`                   | `200`                                   | Width of the button (ignored if `stretched` is true)  |
| `height`                | `double`                   | `40`                                    | Height of the button                                  |
| `backgroundColor`       | `Color`                    | `Color(0xFFADD8E6)`                     | Background color of the button                        |
| `progressColor`         | `Color`                    | `Color(0xFF87CEEB)`                     | Color of the progress indicator                       |
| `showCircularIndicator` | `bool`                     | `true`                                  | Whether to show the circular loading indicator        |
| `progressCap`           | `double`                   | `0.9`                                   | Maximum progress value before completion (0.0 to 1.0) |
| `stretched`             | `bool`                     | `false`                                 | Whether the button should stretch to full width       |
| `textStyle`             | `TextStyle`                | `TextStyle(...)`                        | Text style of the button text                         |
| `borderRadius`          | `BorderRadius`             | `BorderRadius.all(Radius.circular(20))` | Border radius of the button                           |
| `elevation`             | `double`                   | Required                                | Elevation of the button                               |
| `shadowColor`           | `Color`                    | `Colors.transparent`                    | Shadow color of the button                            |
| `enableHapticFeedback`  | `bool`                     | `true`                                  | Whether to enable haptic feedback on button press     |
| `audioAssetPath`        | `String?`                  | `null`                                  | Path for custom audio effect                          |
| `volume`                | `double`                   | `1.0`                                   | Volume for the audio effect                           |

## Usage

```dart
// Fixed width button
ProgressiveButtonFlutter(
  text: "Submit",
  onPressed: () async => await submitData(),
  estimatedTime: Duration(seconds: 2),
);

// Full width button
ProgressiveButtonFlutter(
  text: "Submit",
  onPressed: () async => await submitData(),
  estimatedTime: Duration(seconds: 2),
  stretched: true,
);

// Custom styled button
ProgressiveButtonFlutter(
  text: "Submit",
  onPressed: () async => await submitData(),
  estimatedTime: Duration(seconds: 3),
  width: 250,
  height: 50,
  backgroundColor: Colors.blue,
  progressColor: Colors.lightBlue,
  showCircularIndicator: false,
  progressCap: 0.8,
  audioAssetPath: 'assets/audio/pop_effect.wav',
  volume: 0.5,
);
```

## 🚀Showcase

![demo](https://s13.gifyu.com/images/SelEy.gif)](https://gifyu.com/image/SelEy)

