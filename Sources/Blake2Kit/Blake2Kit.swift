import Foundation
import Blake2C

public enum Blake2 {
    public static func blake2s(data: Data, key: Data? = nil, outputLength: Int = Blake2sConstant.outBytes) -> Data? {
        guard outputLength >= 0 && outputLength <= Blake2sConstant.outBytes else { return nil }
        
        var hash = Data(count: outputLength)

        let result = hash.withUnsafeMutableBytes { outPtr in
            data.withUnsafeBytes { inPtr in
                if let key = key {
                    key.withUnsafeBytes { keyPtr in
                        Blake2C.blake2s(outPtr.baseAddress, outputLength, inPtr.baseAddress, data.count, keyPtr.baseAddress, key.count)
                    }
                } else {
                    Blake2C.blake2s(outPtr.baseAddress, outputLength, inPtr.baseAddress, data.count, nil, 0)
                }
            }
        }

        return result == 0 ? hash : nil
    }
    
    public static func blake2b(data: Data, key: Data? = nil, outputLength: Int = Blake2bConstant.outBytes) -> Data? {
        guard outputLength >= 0 && outputLength <= Blake2bConstant.outBytes else { return nil }
        
        var hash = Data(count: outputLength)

        let result = hash.withUnsafeMutableBytes { outPtr in
            data.withUnsafeBytes { inPtr in
                if let key = key {
                    key.withUnsafeBytes { keyPtr in
                        Blake2C.blake2b(outPtr.baseAddress, outputLength, inPtr.baseAddress, data.count, keyPtr.baseAddress, key.count)
                    }
                } else {
                    Blake2C.blake2b(outPtr.baseAddress, outputLength, inPtr.baseAddress, data.count, nil, 0)
                }
            }
        }

        return result == 0 ? hash : nil
    }

    
    public struct Blake2sConstant {
        public static let blockBytes = Int(Blake2C.BLAKE2S_BLOCKBYTES.rawValue)
        public static let outBytes = Int(Blake2C.BLAKE2S_OUTBYTES.rawValue)
        public static let keyBytes = Int(Blake2C.BLAKE2S_KEYBYTES.rawValue)
        public static let saltBytes = Int(Blake2C.BLAKE2S_SALTBYTES.rawValue)
        public static let personalBytes = Int(Blake2C.BLAKE2S_PERSONALBYTES.rawValue)
    }
    
    public struct Blake2bConstant {
        public static let blockBytes = Int(Blake2C.BLAKE2B_BLOCKBYTES.rawValue)
        public static let outBytes = Int(Blake2C.BLAKE2B_OUTBYTES.rawValue)
        public static let keyBytes = Int(Blake2C.BLAKE2B_KEYBYTES.rawValue)
        public static let saltBytes = Int(Blake2C.BLAKE2B_SALTBYTES.rawValue)
        public static let personalBytes = Int(Blake2C.BLAKE2B_PERSONALBYTES.rawValue)
    }
}
