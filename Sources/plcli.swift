// The Swift Programming Language
// https://docs.swift.org/swift-book
import ArgumentParser
import SwiftCSV
import Foundation
import RegexBuilder

@main
struct plCSVParse: ParsableCommand {
    @Option(help: "Specify file to convert")
    public var file:String

    public func run() throws {
        var comicsList: [[String: String]] = []
        do {
            let contents = try String(contentsOf: URL(fileURLWithPath: file)).utf8
            let lines = String(contents).split(separator:"\r\n")
            let values = Array(lines[1...])
            let headers = lines[0].split(separator: ",")
            // create the json objects
            for item in values {
                var comic: [String:String] = [:]
                let reg = try Regex("\",")
                let row = item.split(separator: reg)
                for (i, e) in headers.enumerated() {
                    comic.updateValue(String(row[i]).replacingOccurrences(of: "\"", with: ""), forKey: String(e))
                }
                comicsList.append(comic)
            }
        } catch {
            print(error)
        }
        // convert strings to int, floats etc.. if the are different from string
        var comicProcessed: [[String: Codable]] = []
		let floatPattern = Regex {
			OneOrMore(.digit)
			"."
			OneOrMore(.digit)
		}
		let digitPattern = Regex { OneOrMore(.digit) }
		let Oa = Regex{"O/A"}
		let rating = Regex{"Mature|Adult"}
		let dates = Regex {
			OneOrMore(.digit)
			"/"
			OneOrMore(.digit)
			"/"
			OneOrMore(.digit)
		}
		let imgUrl = Regex {
		  "https://"
			OneOrMore(.word)
			"."
			OneOrMore(.word)
			".com"
			OneOrMore(.anyNonNewline)
		}
		for com in comicsList {
		    var comic: [String: Codable] = [:]
			for key in com.keys {
				switch (com[key]) {
					case let f where (((com[key])?.wholeMatch(of: floatPattern)) != nil):
					   comic[key] = Float(f!)
					case let d where (((com[key])?.wholeMatch(of: digitPattern)) != nil):
					   comic[key] = Int(d!)
					case let oa where (((com[key])?.wholeMatch(of: Oa)) != nil):
					   if oa! == "N" {
					        comic["O_A"] = false
						} else {
						    comic["O_A"] = true
						}
					case let oa where (((com[key])?.wholeMatch(of: rating)) != nil):
					   if oa! == "N" {
					        comic[key] = false
						} else {
						    comic[key] = true
						}
					case let dt where (((com[key])?.wholeMatch(of: dates)) != nil):
					    let dateFormatter = DateFormatter()
						dateFormatter.dateFormat = "MM/dd/yyyy"
						let d = dateFormatter.date(from: dt!)
						comic[key] = d
					case let img where (((com[key])?.wholeMatch(of: imgUrl)) != nil):
					   let imgu = URL(string: img!)
						comic[key] = imgu
					case .none:
						continue
					case .some(_):
						comic[key] = com[key]
				}
			}
			comicProcessed.append(comic)
		}
		//print(comicProcessed[0])
		var jsonfile: URL
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		do {
		  jsonfile = try FileManager.default.url(for: .desktopDirectory, in: .userDomainMask,appropriateFor: nil, create: true)
		} catch {
		  fatalError("Coudn't create file: \(error.localizedDescription)")
		}
		do {
		  print("Wrtining Json File")
		  try encoder.encode(comicProcessed).write(to: jsonfile)
		} catch {
		  print("Couldn’t save new entry to \(file), \(error.localizedDescription)")
		}

    }
}
