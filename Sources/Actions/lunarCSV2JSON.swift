import Foundation
import RegexBuilder

func convertDate(str: String) -> String {
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "MM/dd/yyyy"
	guard let d = dateFormatter.date(from: str) else {
		return String(Date().ISO8601Format())
	}
	return String(d.ISO8601Format())
}

func lunarCsvtojson(file: String) {
	var comicsList: [LunarComic] = []
	do {
		let contents = try String(contentsOf: URL(fileURLWithPath: file)).utf8
		let lines = String(contents).split(separator: "\r\n")
		let values = Array(lines[1...])
		// create the json objects
		for item in values {
			let reg = try Regex("\",")
			let row = item.split(separator: reg).map {
				String($0).replacingOccurrences(of: "\"", with: "")
			}
			let comicBook: LunarComic = LunarComic(
				id: UUID(),
				Code: row[0],
				AlternateLunarCode: row[1],
				Title: row[2],
				MainDesc: row[3],
				IssueNumber: Int(row[4]) ?? 0,
				MaxIssue: Double(row[5]) ?? 0.0,
				ItemCategory: Int(row[6]) ?? 0,
				ProductCategory: row[7],
				SeriesCode: Int(row[8]) ?? 0,
				Retail: Double(row[9]) ?? 0.0,
				DiscountCode: row[10],
				Publisher: row[11],
				UPC: Int(row[12]) ?? 0,
				ISBN: Int(row[13]) ?? 0,
				EAN: Int(row[14]) ?? 0,
				Writer: (String(row[15])).split(separator: ",").map {
					String($0.trimmingPrefix(" "))
				},
				Artist: (String(row[16])).split(separator: ",").map {
					String($0.trimmingPrefix(" "))
				},
				CoverArtist: row[17],
				InitialOrderDue: (convertDate(str: row[18])),
				FOCDate: (convertDate(str: row[19])),
				InStoreDate: (convertDate(str: row[20])),
				ParentCode: row[21],
				PageNumber: Int(row[22]) ?? 0,
				NumberOfPages: Int(row[23]) ?? 0,
				UnitWeight: Double(row[24]) ?? 0.0,
				Mature: (row[25] == "N" ? true : false),
				Adult: (row[26] == "N" ? true : false),
				O_A: (row[27] == "N" ? true : false),
				OrderFormNotes: row[28],
				Description: row[29],
				Color: row[30],
				VariantType: row[31],
				VariantDescription: row[32],
				VariantNumber: Int(row[33]) ?? 0,
				Printing: Int(row[34]) ?? 0,
				CoverType: row[35],
				PublishingGroup: row[36],
				ImprintCode: row[37],
				SubImprintGroup: row[38],
				FormatCode: row[39],
				PaperCode: row[40],
				CoverCode: row[41],
				BindingCode: row[42],
				TrimCode: row[43],
				TrimSize: row[44],
				CartonCount: Int(row[45]) ?? 0,
				Rating: row[46],
				TradeDress: row[47],
				Popup: row[48],
				Sequence: row[49],
				PublisherCode: row[50],
				T_Number: row[51],
				PublisherSeriesCode: row[52],
				ImageUrl: URL(string: row[53])!,
				Returnable: row[54],
				ReturnWindow: row[55]
			)
			// add to comic book list
			comicsList.append(comicBook)
		}
	} catch {
		print(error)
	}
	var jsonfile: URL
	let encoder = JSONEncoder()
	encoder.outputFormatting = .prettyPrinted
	do {
		jsonfile = try FileManager.default.url(
			for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
		jsonfile.append(
			component:
				"comic_data_\((file.split(separator: "/").last ?? "1").split(separator: ".")[0]).json"
		)
	} catch {
		fatalError("Coudn't create file: \(error.localizedDescription)")
	}
	do {
		print("Wrtining Json File")
		try encoder.encode(comicsList).write(to: jsonfile)
	} catch {
		print("Couldn’t save new entry to \(file), \(error.localizedDescription)")
	}
}
