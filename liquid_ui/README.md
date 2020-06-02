# Liquid

<img src="assets/logo_big.png" height="150">

## Build fast, responsive, cross platform apps with Liquid.

Liquid is an open source UI toolkit for developing cross platform apps using **[Flutter](https://flutter.dev/docs)**. Quickly create apps for Andorid, IOS, Web or Desktop with our powerful grid system, text processor, extensive prebuilt components and utilities.

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

---

# 1. Introduction
Liquid is divied into 3 sub-libraries
 - Liquid Base - holds layout, theme, extensions, text processor, etc.
 - Liquid Components - holds components like buttons, scrollspy, dropdown, form, etc.
 - Liquid Core - holds validators for LForm.


# 2. Layout

## [Breakpoints](https://pub.dev/documentation/liquid_ui/latest/liquid/LBreakPoint-class.html)
Breakpoints are the point in which your sites/apps content will respond to provide the user with the best possible layout to consume the information.

### Liquid support 5 breakpoints
|Breakpoint| Width     | Devices                                   |
|----------|-----------|-------------------------------------------|
| xs       | < 576px   | mobile (**portrait**)                     |
| sm       | >= 576px  | mobile (**landscape**)                    |
| md       | >= 768px  | tablet (**portrait**)                     |
| lg       | >= 992px  | tablet (**landscape**) laptop (**small**) |
| xl       | >= 1200px | Desktop laptop(**large**)                 |

## Layout Mechanism
Liquid has 4 Layout Building mechanism
1. [**Responsive Builder**](#rbuild)
2. [**Responsive Columns**](#rcols)
   - [**Rows**](#lrow)
   - [**Columns**](#lrow)
3. [**Responsive Container**](#rcont)
4. [**Responsive Utilities**](#rutil)


### <a name="rbuild"></a> 1. [Responisve Builder](https://pub.dev/documentation/liquid_ui/latest/liquid/LResponsiveBuilder-class.html)

A builder that builds its childrens based on active breakpoints. 

```dart
LResponsiveBuilder(
  onXS: (context) => buildOnXS(context), // required
  onSM: (context) => buildOnSM(context), // build only on SM breakpoint
  onMD: (context) => buildOnMD(context), // build only on MD breakpoint
  onLG: (context) => buildOnLG(context), // build only on LG breakpoint
  onXL: (context) => buildOnXL(context), // build only on XL breakpoint
)
```

**NOTE**: [LResponsiveBuilder](https://pub.dev/documentation/liquid_ui/latest/liquid/LResponsiveBuilder-class.html) will build **onXS** by default for other breakpoints if they are not defined.

**NOTE**: By default [LResponsiveBuilder](https://pub.dev/documentation/liquid_ui/latest/liquid/LResponsiveBuilder-class.html) will use parents width to determine the active breakpoint.

### To use screen width instead of parent width to determine breakpoint

```dart
LResponsiveBuilder(
  ... // builders
  useMediaQuery: true, // this will make responsive builder to use screen width to build layout
)
```

**Note**: Responsive builder helps to build layout based on screen size but its too much work to build layout for 5 breakpoints. use **Responisve Columns** to build responsive layout in liquid.

### <a name="rcols"></a> 2. [Responisve Columns](https://pub.dev/documentation/liquid_ui/latest/liquid/LResponsiveBuilder-class.html)

Liquid comes with [**Rows (LRow)**](https://pub.dev/documentation/liquid_ui/latest/liquid/LRow/LRow.html) and [**Columns (LColumn)**](https://pub.dev/documentation/liquid_ui/latest/liquid/LColumn/LColumn.html) which helps to create a responsive grid thats layout their children according to active breakpoint.

#### <a name="lrow"></a> Rows (LRow)
LRow is a responsive layout component in liquid that accepts a list of columns.
It can change its axis based on breakpoint by using [axis](https://pub.dev/documentation/liquid_ui/latest/liquid/LRowAxis-class.html) property. 

```dart
LRow(
  columns: <LColumn>[
    ... //list of columns
  ]
)
```

[LRow](https://pub.dev/documentation/liquid_ui/latest/liquid/LRow-class.html) support maximum of 12 columns in [fixedSize](https://pub.dev/documentation/liquid_ui/latest/liquid/LRow/mode.html) mode (default mode). i.e, if on a particular breakpoint the sum of all the column span is greater than 12 than mode will be changed to [ratio](https://pub.dev/documentation/liquid_ui/latest/liquid/LRow/mode.html).

```dart
LRow(
  columns: <LColumn>[
    LColumn( // first column
      lg: 8, // span to 8 column space in lg
      xl: 6, // span to 6 column space in xl
      children: <Widget>[...]
    ),
    LColumn( // second column
      lg: 4, // span to 4 column space in lg
      xl: 3, // span to 3 column space in xl
      children: <Widget>[...] 
    ),
  ]
)
```

LRow support **2 mode** to render its columns.
- fixedSize (columns will takes exact span space)
- ratio (uses ratio/percentage to determine available space)

```dart
LRow(
  mode: LGridMode.ratio
  columns: <LColumn>[
    LColumn( // first column
      lg: 8, // takes ~53% space in lg
      xl: 6, // takes ~50% space in xl
      children: <Widget>[...]
    ),
    LColumn( // second column
      lg: 4, // takes ~26% space in lg
      xl: 3, // takes ~25% space in xl
      children: <Widget>[...] 
    ),
    LColumn( // third column
      lg: 3, // takes ~26% space in lg
      xl: 3, // takes ~25% space in xl
      children: <Widget>[...] 
    ),
  ]
)
```

**Gutters**
The space between columns is known as gutter

default: **5px**

```dart
LRow(
  gutter: 10.0, // add 10px space between columns
  columns: <LColumn>[
    ... //list of columns
  ]
)
```

**Margin**
The space around the row

default: *bottom margin equals to* **gutter/2**

**NOTE**: by default LRow is in horizontal axis except in **xs** breakpoint which is vertical. you can change this using [axis](https://pub.dev/documentation/liquid_ui/latest/liquid/LRowAxis-class.html) property of **LRow**

#### Hiding a column on particular breakpoint

You can prevent a column from rendering on breakpoint by using [visibility](https://pub.dev/documentation/liquid_ui/latest/liquid/LBoxVisibility-class.html) property of **LColumn**

```dart
LRow(
  columns: <LColumn>[
    LColumn( // first column
      lg: 8, // span to 8 column space in lg
      xl: 6, // span to 6 column space in xl
      children: <Widget>[...]
    ),
    LColumn( // second column
      visibility: LBoxVisibility.belowXL(false),
      xl: 3, // span to 6 column space in xl
      children: <Widget>[...]
    ),
    LColumn( // third column
      lg: 4, // span to 4 column space in lg
      xl: 3, // span to 3 column space in xl
      children: <Widget>[...] 
    ),
  ]
)
```

In above code, the **second column** will not render on **XS, SM, MD and LG** breakpoints.

### <a name="rcont"></a> 3. [Responisve Container (LBox and LAnimatedBox)](https://pub.dev/documentation/liquid_ui/latest/liquid/LBox-class.html)

Liquid comes with a container that can change its property based on breakpoint. properties like alignment, height, width, decoration, visibility, padding and margin.

### [LBox](https://pub.dev/documentation/liquid_ui/latest/liquid/LBox/LBox.html)
Creates a widget that combines common painting, positioning, rendering and sizing widgets according to breakpoint.

```dart
LBox(
  visibility: LBoxVisibility(
    xs: false, // will not render child in XS breakpoint
    sm: false, // will not render child in SM breakpoint
  ),
  height: LBoxDimension( // height based on active breakpoint
    xs: 250.0,
    sm: 280.0,
    md: 350.0,
    lg: 450.0,
    xl: 500.0,
  ),
  padding: LBoxEdgeInsets( // padding based on active breakpoint
    lg: EdgeInsets.all(10.0),
    xl: EdgeInsets.all(20.0),
  ),
  child: Image.network("https://source.unsplash.com/random/"), // child widget
)
```

### [LAnimatedBox](https://pub.dev/documentation/liquid_ui/latest/liquid/LAnimatedBox/LAnimatedBox.html)

Animated version of [LBox](https://pub.dev/documentation/liquid_ui/latest/liquid/LBox/LBox.html) that animate any change in box property.

```dart
LAnimatedBox(
  //duration: Duration(milliseconds: 150), //default
  //curve: Curves.linear, //default
  visibility: LBoxVisibility(
    xs: false, // will not render child in XS breakpoint
    sm: false, // will not render child in SM breakpoint
  ),
  height: LBoxDimension( // height based on active breakpoint
    xs: 250.0,
    sm: 280.0,
    md: 350.0,
    lg: 450.0,
    xl: 500.0,
  ),
  padding: LBoxEdgeInsets( // padding based on active breakpoint
    lg: EdgeInsets.all(10.0),
    xl: EdgeInsets.all(20.0),
  ),
  child: Image.network("https://source.unsplash.com/random/"), // child widget
)
```

### <a name="rutil"></a> 1. [Responisve Utilities](https://pub.dev/documentation/liquid_ui/latest/liquid/MediaQueryDataExtension.html)

To know the currently active breakpoint use **MediaQuery**

#### To know if a particular breakpoint is active use
```dart
MediaQuery.of(context).isXS // true if XS is active

MediaQuery.of(context).isSM // true if SM is active

MediaQuery.of(context).isMD // true if MD is active

MediaQuery.of(context).isLG // true if LG is active

MediaQuery.of(context).isXL // true if XL is active

```

#### To get active breakpoint use

```dart
MediaQuery.of(context).activeBreakpoint // active breakpoint
```
#### Using Utilities

**Example 1. Build child based on active breakpoint**

```dart
final mq = MediaQuery.of(context);

Container(
  child: mq.isXS || mq.isSM ? buildWidget() : buildAnotherWidget(),
)
```

**Example 2. Get different values based on active breakpoint**

```dart
// This class will produce value based on active breakpoint
class ResponsiveValue<T> {
  final BuildContext context;
  final T xs, sm, md, lg, xl;

  const ResponsiveValue(
    this.context,{
    this.xs, 
    this.sm, 
    this.md, 
    this.lg, 
    this.xl
  });

  T getActiveValue(LBreakPoint breakPoint) {
    switch (breakPoint) {
      case LBreakPoint.xl:
        return xl;
      case LBreakPoint.lg:
        return lg;
      case LBreakPoint.md:
        return md;
      case LBreakPoint.sm:
        return sm;
      case LBreakPoint.xs:
      default:
        return xs;
    }
  }

  T get value => getActiveValue(MediaQuery.of(context).activeBreakpoint);
}

...

final String forSmallDevices = "This message is for \l.bold{small} devices";
final String forLargeDevices = "This message is for \l.bold{larger} devices";

@override
Widget build(BuildContext context) {
  return LText(
    ResponsiveValue<String>(
      context,
      // for smaller devices
      xs: forSmallDevices,
      sm: forSmallDevices,
      md: forSmallDevices,

      // for larger devices
      lg: forLargeDevices,
      xl: forLargeDevices,
    ).value,
  );
}
```

# 3. LText

### Visit [Liquid Expo](https://liquid.stackorient.com) or download [Android App](https://play.google.com/store/apps/details?id=com.stackorient.liquid_expo) for more details and tutorials.

Liquid's text processor helps to use css like style classes to style your inline text elements.

```dart
LText(
  "This message is \l.bold.underline{Important}."
)
```
# 4. Liquid Components

### Visit [Liquid Expo](https://liquid.stackorient.com) or download [Android App](https://play.google.com/store/apps/details?id=com.stackorient.liquid_expo) for live demo and tutorials.

# 5. [Liquid Forms](https://pub.dev/documentation/liquid_ui/latest/liquid/LForm/LForm.html)
Forms in liquid is highly inspired by html form also they are much effecient than normal flutter forms.

### Visit [Liquid Expo](https://liquid.stackorient.com) or download [Android App](https://play.google.com/store/apps/details?id=com.stackorient.liquid_expo) for form tutorials and documentation

## Read complete documnetation [HERE](https://pub.dev/documentation/liquid_ui/latest/liquid/liquid-library.html) 
## For live demo visit  [Liquid Expo](https://liquid.stackorient.com) or download [Liquid Expo App](https://play.google.com/store/apps/details?id=com.stackorient.liquid_expo)