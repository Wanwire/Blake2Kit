# Blake2Kit

[Download](https://github.com/Wanwire/Blake2Kit/releases/latest "download latest release")

### Usage
```swift
import Blake2Kit

let data = "Hello, world!".data(using: .utf8)!
let hash = Blake2.blake2s(data: data)

if let sequentialBlake2s = Blake2.SequentialBlake2s() {
    sequentialBlake2s.update("Hello, ".data(using: .utf8)!)
    sequentialBlake2s.update("world!".data(using: .utf8)!)
    let hash2 = sequentialBlake2s.final()

    print("\(hash1) == \(hash2)")
}

```

