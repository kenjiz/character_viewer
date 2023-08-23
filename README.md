# Character Viewer

A simple 2-in-1 app that fetches characters from The Simpsons and The Wire from `api.duckduckgo.com`. Demonstrating the power of **Flutter Flavors** for creating multi apps in one codebase.

#### Note:

- **Only android supported by now.** - _Not yet tested on IOS._
- Splash screen and icon customization for each app will support soon.

### Installation

Make sure you have a working flutter installation. Clone this repo via `git clone`. Get necessary package via `flutter pub get` .

- To run the Simpsons Character Viewer App. Simply run:
  `flutter run --flavor simpsons_viewer --target lib/main_simpsons.dart`
- For The Wire Character Viewer. Run:
  `flutter run --flavor wire_viewer --target lib/main_wire.dart.dart`

_If problem occurs while running. Just simply `flutter clean`._

### Screenshot

**Wire Viewer App**

    ```

<figure>
    <img src="https://i.ibb.co/9Zqjj0V/the-wire-demo.gif"
         alt="The Wire Screenshot" width="250"/>
</figure>
	```

**Simpsons Viewer App**

    ```

<figure>
    <img src="https://i.ibb.co/Lrh4rMr/simpsons-demo.gif"
         alt="Simpsons Screenshot" width="250" />
</figure>
	```
