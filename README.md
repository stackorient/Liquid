# Liquid

<img src="liquid_ui/assets/logo_big.png" height="150">

## Build fast, responsive, cross platform apps with Liquid.

Liquid is an open source UI toolkit for developing cross platform apps in **[Flutter](https://flutter.dev/docs)**. Quickly create apps for Android, IOS, Web or Desktop with our powerful grid system, text processor, forms, extensive prebuilt components and dozens utilities.

## Visit [Liquid Expo and Documentation](http://liquid.stackorient.com/)
#MadeWithLiquid

## Salient Features
- Powerful grid system that support upto 12 column
- Extensive array of UI Elements ( With more than 1000+ configuration )
- A powerful **text processor** to use CSS like text styling in flutter
- Liquid Form (support all html form features)
- Responive utilities to use with non-liquid components
- Stable and optmized for Web
- And More to explore 😁

## Getting Started

Step 1: Add liquid to **pubspec.yaml**

```yaml

dependencies:
  flutter:
    sdk: flutter
    
  liquid_ui: <latest-version>
```

Step 2: Wrap Your **MaterialApp** widget with **LiquidApp**

```dart
import 'package:liquid_ui/liquid_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiquidApp(
      materialApp: MaterialApp(...)
    );
  }
} 
```

Step 3: Visit [Liquid Expo](http://liquid.stackorient.com/) for demo and tutorials.

## Note
Liquid is compatible with **MaterialApp** for now. **LiquidCupertinoApp** will be available in next major update

## Authors
- [Raj Singh](https://www.linkedin.com/in/raj457036/)
- [Pulkit Nanda](https://www.linkedin.com/in/pulkit-nanda/)
