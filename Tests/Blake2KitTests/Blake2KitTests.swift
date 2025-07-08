import Testing
import Foundation
@testable import Blake2Kit

@Test func testBlake2s() async throws {
    let message = "Hello, world!".data(using: .utf8)!
    let expectedLength = Blake2.Blake2sConstant.outBytes
    
    let hash = Blake2.blake2s(data: message, outputLength: expectedLength)
    
    #expect(hash != nil)
    #expect(hash?.count == expectedLength)
    #expect(hash!.hexString() == "30d8777f0e178582ec8cd2fcdc18af57c828ee2f89e978df52c8e7af078bd5cf")
}

@Test func testBlake2sWithTooSmallHashOutput() async throws {
    let message = "Hello, world!".data(using: .utf8)!
    let expectedLength = 0
    
    let hash = Blake2.blake2s(data: message, outputLength: expectedLength)
    
    #expect(hash == nil)
}

@Test func testBlake2sWithTooLargeHashOutput() async throws {
    let message = "Hello, world!".data(using: .utf8)!
    let expectedLength = 33
    
    let hash = Blake2.blake2s(data: message, outputLength: expectedLength)
    
    #expect(hash == nil)
}

@Test func testBlake2sWithKey() async throws {
    let message = "Hello, world!".data(using: .utf8)!
    let key = "Some key!".data(using: .utf8)!
    let expectedLength = Blake2.Blake2sConstant.outBytes
    
    let hash = Blake2.blake2s(data: message, key: key, outputLength: expectedLength)
    
    #expect(hash != nil)
    #expect(hash?.count == expectedLength)
    #expect(hash!.hexString() == "a15a9d01347bb830f351be0d08787f62c56a6c58cb94db499c79bfda8fc641d1")
}

@Test func testBlake2sWithTooLongKey() async throws {
    let message = "Hello, world!".data(using: .utf8)!
    let tooLongKey = "123456789012345678901234567890123".data(using: .utf8)!
    
    let hash = Blake2.blake2s(data: message, key: tooLongKey)
    
    #expect(hash == nil)
}

@Test func testBlake2b() async throws {
    let message = "Hello, world!".data(using: .utf8)!
    let expectedLength = Blake2.Blake2bConstant.outBytes
    
    let hash = Blake2.blake2b(data: message, outputLength: expectedLength)
    
    #expect(hash != nil)
    #expect(hash?.count == expectedLength)
    #expect(hash!.hexString() == "a2764d133a16816b5847a737a786f2ece4c148095c5faa73e24b4cc5d666c3e45ec271504e14dc6127ddfce4e144fb23b91a6f7b04b53d695502290722953b0f")
}

@Test func testBlake2bWithTooSmallHashOutput() async throws {
    let message = "Hello, world!".data(using: .utf8)!
    let expectedLength = 0
    
    let hash = Blake2.blake2b(data: message, outputLength: expectedLength)
    
    #expect(hash == nil)
}

@Test func testBlake2bWithTooLargeHashOutput() async throws {
    let message = "Hello, world!".data(using: .utf8)!
    let expectedLength = 65
    
    let hash = Blake2.blake2b(data: message, outputLength: expectedLength)
    
    #expect(hash == nil)
}
@Test func testBlake2bWithKey() async throws {
    let message = "Hello, world!".data(using: .utf8)!
    let key = "Some key!".data(using: .utf8)!
    let expectedLength = Blake2.Blake2bConstant.outBytes
    
    let hash = Blake2.blake2b(data: message, key: key, outputLength: expectedLength)
    
    #expect(hash != nil)
    #expect(hash?.count == expectedLength)
    #expect(hash!.hexString() == "e70e6cc23f851a606ba4d517c2a80dfeb443dd2768d978dc99ef0289f4b76affb06560e8861ff43da5bd7a8625c7c3048f73a366b32b1685874627d895143536")
}

@Test func testBlake2bWithTooLongKey() async throws {
    let message = "Hello, world!".data(using: .utf8)!
    let tooLongKey = "12345678901234567890123456789012345678901234567890123456789012345".data(using: .utf8)!
    
    let hash = Blake2.blake2b(data: message, key: tooLongKey)
    
    #expect(hash == nil)
}

@Test func testSequentialBlake2s() async throws {
    let message = "Hello, world!".data(using: .utf8)!
    let expectedLength = Blake2.Blake2sConstant.outBytes
    let hash1 = Blake2.blake2s(data: message, outputLength: expectedLength)
    
    let sequentialBlake2s = Blake2.SequentialBlake2s(outputLength: expectedLength)
    sequentialBlake2s?.update(message)
    let hash2 = sequentialBlake2s?.final()
    
    #expect(hash1 != nil)
    #expect(hash1?.count == expectedLength)
    #expect(hash1!.hexString() == "30d8777f0e178582ec8cd2fcdc18af57c828ee2f89e978df52c8e7af078bd5cf")
    #expect(hash2 != nil)
    #expect(hash2?.count == expectedLength)
    #expect(hash1 == hash2)
}

@Test func testSequentialBlake2sSequence() async throws {
    let message = "Hello, world!".data(using: .utf8)!
    let expectedLength = Blake2.Blake2sConstant.outBytes
    let hash1 = Blake2.blake2s(data: message, outputLength: expectedLength)
    
    let sequentialBlake2s = Blake2.SequentialBlake2s(outputLength: expectedLength)
    sequentialBlake2s?.update("Hello, ".data(using: .utf8)!)
    sequentialBlake2s?.update("world!".data(using: .utf8)!)
    let hash2 = sequentialBlake2s?.final()
    
    #expect(hash1 != nil)
    #expect(hash1?.count == expectedLength)
    #expect(hash1!.hexString() == "30d8777f0e178582ec8cd2fcdc18af57c828ee2f89e978df52c8e7af078bd5cf")
    #expect(hash2 != nil)
    #expect(hash2?.count == expectedLength)
    #expect(hash1 == hash2)
}

fileprivate extension Data {
    func hexString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

