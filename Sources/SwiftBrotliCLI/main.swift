import ArgumentParser
import Foundation
import SwiftBrotli

struct SwiftBrotliCommand: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Brotli")
    
    @Flag(name: .shortAndLong, default: false, inversion: .prefixedNo, exclusivity: .exclusive, help: "Decompress the data")
    var decompress: Bool

    @Option(name: .shortAndLong, default: Brotli.defaultQuality, help: "Quality of compression")
    var quality: Int32
    
    @Option(name: .shortAndLong, help: "Output path")
    var output: String?
    
    @Option(name: .shortAndLong, default: .generic, help: "Compression mode (text, generic or font)")
    var mode: CompressionMode
    
    @Argument(help: "Input path")
    var input: String
    
    func run() throws {
        let brotli = Brotli()
        
        let url = URL(fileURLWithPath: input)
        
        guard let data = try? Data(contentsOf: url) else {
            throw NSError(domain: "", code: 0, userInfo: [:])
        }
        
        let result: Data = decompress ? try brotli.decompress(data).get() : try brotli.compress(data, quality: quality, mode: .generic).get()
        
        let output = self.output.flatMap(URL.init(fileURLWithPath:)) ?? (decompress ? url.deletingPathExtension() : url.appendingPathExtension("br"))
        
        try result.write(to: output)
    }
}

extension SwiftBrotliCommand {
    enum CompressionMode: String, ExpressibleByArgument {
        case text
        case generic
        case font
        
        var brotliMode: Brotli.EncoderMode {
            switch self {
            case .font:
                return .font
            case .generic:
                return .generic
            case .text:
                return .text
            }
        }
    }
}

SwiftBrotliCommand.main()
