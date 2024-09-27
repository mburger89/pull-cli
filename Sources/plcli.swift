// The Swift Programming Language
// https://docs.swift.org/swift-book
import ArgumentParser
import Foundation

@main
struct plCSVParse: ParsableCommand {
	static let configuration = CommandConfiguration(
		abstract: "Comic book data processor utility",
		subcommands: [lunar.self, upload.self, diamond.self])
	struct lunar: ParsableCommand {
		@Option(name: .shortAndLong, help: "Specify file in lunar format to convert")
		var file: String
		mutating func run() {
			lunarCsvtojson(file: file)
		}
	}
	struct upload: ParsableCommand {
		@Option(name: .shortAndLong, help: "Specify file to convert")
		var file: String
		@Option(name: .shortAndLong, help: "Specify the url to upload to")
		var url: String
		@Option(name: .shortAndLong, help: "Specify the type of data, ie lunar or diamond")
		var type: String
		mutating func run() {
			uploadComicData(file: file, url: url, datatype: type)
		}
	}
	struct diamond: ParsableCommand {
		@Option(name: .shortAndLong, help: "Specify file in diamond format to convert")
		var file: String
		mutating func run() {
			decodeDiamond(file: file)
		}
	}
}
