import Foundation
import Blake2C

public enum Blake2 {
    public class SequentialBlake2s {
        private let state: UnsafeMutablePointer<Blake2C.blake2s_state>
        private let outputLength: Int
        
        public init?(outputLength: Int = Blake2.Blake2sConstant.outBytes) {
            guard outputLength >= 0 && outputLength <= Blake2sConstant.outBytes else { return nil }
            self.outputLength = outputLength
            self.state = UnsafeMutablePointer<Blake2C.blake2s_state>.allocate(capacity: 1)
            Blake2C.blake2s_init(state, size_t(outputLength))
        }
        
        public func update(_ data: Data) {
            data.withUnsafeBytes { dataPtr in
                guard let baseAddress = dataPtr.baseAddress else { return }
                Blake2C.blake2s_update(state, UnsafeMutableRawPointer(mutating: baseAddress), size_t(data.count))
            }
        }
        
        public func final() -> Data {
            var output = Data(count: outputLength)
            output.withUnsafeMutableBytes { buffer in
                guard let baseAddress = buffer.baseAddress else { return }
                Blake2C.blake2s_final(state, baseAddress, size_t(outputLength))
            }
            return output
        }
        
        deinit {
            state.deallocate()
        }
    }
    
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
