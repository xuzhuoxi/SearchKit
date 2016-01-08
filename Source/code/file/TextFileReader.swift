//
//  TextFileReader.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/29.
//
//

import Foundation

public class TextFileReader {
    private let path : String!
    private let chunkSize: Int = 4096

    public var encoding: NSStringEncoding
    public var atEOF: Bool = false
    
    let fileHandle: NSFileHandle!
    let buffer: NSMutableData!
    let delimData: NSData!
    
    public init(path: String, encoding: NSStringEncoding = NSUTF8StringEncoding, delimiter: String = "\n") {
        self.path = path
        self.encoding = encoding
        self.fileHandle = NSFileHandle(forReadingAtPath: path)
        self.delimData = delimiter.dataUsingEncoding(encoding)
        self.buffer = NSMutableData(capacity: chunkSize)
    }
    
    public func nextLine() -> String? {
        if atEOF {
            return nil
        }
        
        // Read data chunks from file until a line delimiter is found.
        var range = buffer.rangeOfData(delimData, options: [], range: NSMakeRange(0, buffer.length))
        while range.location == NSNotFound {
            let tmpData = fileHandle.readDataOfLength(chunkSize)
            if tmpData.length == 0 {
                // EOF or read error.
                atEOF = true
                if buffer.length > 0 {
                    // Buffer contains last line in file (not terminated by delimiter).
                    let line = NSString(data: buffer, encoding: encoding)
                    
                    buffer.length = 0
                    return line as String?
                }
                // No more lines.
                return nil
            }
            buffer.appendData(tmpData)
            range = buffer.rangeOfData(delimData, options: [], range: NSMakeRange(0, buffer.length))
        }
        
        // Convert complete line (excluding the delimiter) to a string.
        let line = NSString(data: buffer.subdataWithRange(NSMakeRange(0, range.location)),
            encoding: encoding)
        // Remove line (and the delimiter) from the buffer.
        let cleaningRange = NSMakeRange(0, range.location + range.length)
        buffer.replaceBytesInRange(cleaningRange, withBytes: nil, length: 0)
        
        return line as? String
    }
    
    deinit {
        fileHandle?.closeFile()
    }
}


//public init?(
//    path: Path,
//    delimiter: String = "\n",
//    encoding: NSStringEncoding = NSUTF8StringEncoding,
//    chunkSize: Int = 4096
//    ) {
//        self.chunkSize = chunkSize
//        self.encoding = encoding
//        
//        guard let fileHandle = path.fileHandleForReading,
//            delimData = delimiter.dataUsingEncoding(encoding),
//            buffer = NSMutableData(capacity: chunkSize) else {
//                self.fileHandle = nil
//                self.delimData = nil
//                self.buffer = nil
//                return nil
//        }
//        self.fileHandle = fileHandle
//        self.delimData = delimData
//        self.buffer = buffer
//}