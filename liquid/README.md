# Liquid

<img src="../assets/logo_big.png" height="150">

## Build fast, responsive, cross platform apps with Liquid.

Liquid is an open source UI toolkit for developing cross platform apps using **[Flutter](https://flutter.dev/docs)**. Quickly create a apps for Andorid, IOS, Web or Desktop with our powerful grid system, powerful text processor, extensive prebuilt components and a lot utilities.

## Liquid Expo and Documentation
### Liquid's Documentaion made with liquid

## Getting Started

Step 1: Add liquid to **pubspec.yaml**

```yaml

dependencies:
  flutter:
    sdk: flutter
    
  liquid: <latest-version>   # for beta channel
  liquid: <latest-version>-stable # for stable channel   

```

Step 2: Wrap Your toppest widget with **LiquidApp**

```dart
import 'package:liquid/liquid.dart';

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
      title: 'My New Liquid App',
      home: MyHomePage(),
    );
  }
} 
```

Step 3: Visit Liquid Expo for demo and tutorials.

## Note
Liquid is build to support flutter web and since Flutter web is in **BETA**, to use liquid on web switch to beta.

## Authors
- [Raj Singh](https://www.linkedin.com/in/raj457036/)
- [Pulkit Nanda](https://www.linkedin.com/in/pulkit-nanda/)