import Foundation
import RegexBuilder

func decodeDiamond(file: String) {
	var comicList: [DiamondComic] = []
	do {
		let contents = try String(contentsOf: URL(fileURLWithPath: file)).utf8
		let lines = String(contents).split(separator: "\r\n")
		let body = Array(lines[1...])
		let reg = try Regex("\\t{1}")
		for item in body {
			let row = item.split(separator: reg, omittingEmptySubsequences: false)
			let comic: DiamondComic = DiamondComic(
				id: UUID(),
				code: String(row[0]),
				stock_no: Int(row[1]) ?? 0,
				parent_item_no_alt: String(row[2]),
				bounce_use_item: String(row[3]),
				full_title: String(row[4]),
				main_desc: String(row[5]),
				variant_desc: String(row[6]),
				series_code: Int(row[7]) ?? 0,
				issue_no: Int(row[8]) ?? 0,
				issue_seq_no: Int(row[9]) ?? 0,
				volume_tag: String(row[10]),
				max_issue: Float(row[11]) ?? 0.0,
				price: Float(row[12]) ?? 0.00,
				publisher: String(row[13]),
				upc_no: Int(row[14]) ?? 0,
				short_isbn_no: Int(row[15]) ?? 0,
				ean_no: Int(row[16]) ?? 0,
				cards_per_pack: Int(row[17]) ?? 0,
				pack_per_box: Int(row[18]) ?? 0,
				box_per_case: Int(row[19]) ?? 0,
				discount_code: String(row[20]),
				increment: String(row[21]),
				prnt_date: String(row[22]),
				FOC_vender: String(row[23]),
				ship_date: String(row[24]),
				srp: Float(row[25]) ?? 0.0,
				catergory: Int(row[26]) ?? 0,
				genre: String(row[27]),
				brand_code: String(row[28]),
				mature: String(row[29]),
				adult: String(row[30]),
				oa: String(row[31]),
				caut1: String(row[32]),
				caut2: String(row[33]),
				caut3: String(row[34]),
				resol: String(row[35]),
				note_price: String(row[36]),
				order_from_notes: String(row[37]),
				page: Int(row[38]) ?? 0,
				writer: (String(row[39])).split(separator: ",").map {
					String($0.trimmingPrefix(" "))
				},
				artist: (String(row[40])).split(separator: ",").map {
					String($0.trimmingPrefix(" "))
				},
				cover: (String(row[41])).split(separator: ",").map {
					String($0.trimmingPrefix(" "))
				},
				colorist: (String(row[42])).split(separator: ",").map {
					String($0.trimmingPrefix(" "))
				},
				alliance_sku: Int(row[43]) ?? 0,
				FOC_date: String(row[44]),
				offered_date: String(row[45]),
				number_of_pages: Int(row[46]) ?? 0,
				unit_weight: Float(row[47]) ?? 0.0,
				unit_length: Float(row[48]) ?? 0.0,
				unit_width: Float(row[49]) ?? 0.0,
				unit_height: Float(row[50]) ?? 0.0,
				case_weight: Float(row[51]) ?? 0.0,
				case_length: Float(row[52]) ?? 0.0,
				case_width: Float(row[53]) ?? 0.0,
				case_height: Float(row[54]) ?? 0.0
			)
			comicList.append(comic)
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
		try encoder.encode(comicList).write(to: jsonfile)
		print(
			"Json File Written comic_data_\((file.split(separator: "/").last ?? "1").split(separator: ".")[0]).json"
		)
	} catch {
		print("Couldn’t save new entry to \(file), \(error.localizedDescription)")
	}
}
