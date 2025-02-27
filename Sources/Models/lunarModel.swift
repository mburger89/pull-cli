import Foundation

struct LunarComic: Codable {
	let id: UUID
	var Code: String
	var AlternateLunarCode: String
	var Title: String
	var MainDesc: String
	var IssueNumber: Int
	var MaxIssue: Double
	var ItemCategory: Int
	var ProductCategory: String
	var SeriesCode: Int
	var Retail: Double
	var DiscountCode: String
	var Publisher: String
	var UPC: Int
	var ISBN: Int
	var EAN: Int
	var Writer: [String]
	var Artist: [String]
	var CoverArtist: String
	var InitialOrderDue: String
	var FOCDate: String
	var InStoreDate: String
	var ParentCode: String
	var PageNumber: Int
	var NumberOfPages: Int
	var UnitWeight: Double
	var Mature: Bool
	var Adult: Bool
	var O_A: Bool
	var OrderFormNotes: String
	var Description: String
	var Color: String
	var VariantType: String
	var VariantDescription: String
	var VariantNumber: Int
	var Printing: Int
	var CoverType: String
	var PublishingGroup: String
	var ImprintCode: String
	var SubImprintGroup: String
	var FormatCode: String
	var PaperCode: String
	var CoverCode: String
	var BindingCode: String
	var TrimCode: String
	var TrimSize: String
	var CartonCount: Int
	var Rating: String
	var TradeDress: String
	var Popup: String
	var Sequence: String
	var PublisherCode: String
	var T_Number: String
	var PublisherSeriesCode: String
	var ImageUrl: URL
	var Returnable: String
	var ReturnWindow: String
}
