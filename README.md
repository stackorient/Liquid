# Liquid

<img src="liquid_ui/assets/logo_big.png" height="150">

## Build fast, responsive, cross platform apps with Liquid.

Liquid is an open source UI toolkit for developing cross platform apps using **[Flutter](https://flutter.dev/docs)**. Quickly create a apps for Andorid, IOS, Web or Desktop with our powerful grid system, powerful text processor, extensive prebuilt components and a lot utilities.

## Visit [Liquid Expo and Documentation](http://liquid.stackorient.com/)
Made with Liquid #MadeWithLiquid

## Salient Features
- Powerful grid system that support 12 column
- Extensive array of UI Elements ( With more than 1000+ configuration )
- A powerful Text Processor to use CSS like text styling in flutter
- Powerful form features (support all html form features)
- Responive Utilities to use with non liquid components
- Stable and Optmized for Web
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