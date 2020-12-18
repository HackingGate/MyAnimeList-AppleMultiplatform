# MyAnimeList-AppleMultiplatform
Unofficial MyAnimeList app for Apple TV, iPhone, iPad and Mac rewritten in SwiftUI (previous was TVML/TVJS)

### Requirements

- Xcode 12
- tvOS 14 or iOS 14 or macOS 11

### Dependencies

- [SwiftUIFlux](https://github.com/Dimillian/SwiftUIFlux): A very naive implementation of Redux using Combine BindableObject to serve as an example
- [JikanSwift](https://github.com/HackingGate/JikanSwift): 
Jikan Swift wrapper
- [MALSyncSwift](https://github.com/HackingGate/MALSyncSwift): MALSync Api Swift wrapper
- [CrunchyrollSwift](https://github.com/HackingGate/CrunchyrollSwift): Crunchyroll Swift wrapper unofficial
- [Kingfisher](https://github.com/onevcat/Kingfisher): A lightweight, pure-Swift library for downloading and caching images from the web.

### Development

The project use SwiftUI and SwiftUIFlux.

You can learn SwiftUIFlux and SwiftUI with [MovieSwiftUI](https://github.com/Dimillian/MovieSwiftUI).

Swift packages made for this porject are intergrated as git submodules. Once the sub packages are well developed. I'll consider to change it back to the way to install a SwiftPM that everybody know.

Example to clone with submodules:

```sh
$ git clone --recurse-submodules
```

Example to install submodules if you didn't use above command:

```sh
$ git submodule update --init --recursive
```

### Screenshots

![TV_Home.png](https://github.com/HackingGate/MyAnimeList-AppleMultiplatform/raw/main/Screenshots/TV_Home.png)
![TV_Detail.png](https://github.com/HackingGate/MyAnimeList-AppleMultiplatform/raw/main/Screenshots/TV_Detail.png)
