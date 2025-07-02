# Blake2Kit

[![Release](https://github.com/Wanwire/Blake2Kit/actions/workflows/release.yml/badge.svg)](https://github.com/Wanwire/Blake2Kit/actions/workflows/release.yml)

[Download](https://github.com/Wanwire/Blake2Kit/releases/latest "download latest release")

### Usage
```swift
import Blake2Kit

let data = "Hello, world!".data(using: .utf8)!
let hash = Blake2.blake2s(data: data)

```

