import Foundation

struct DiamondComic: Codable {
	let id: UUID
	var code: String
	var stock_no: Int
	var parent_item_no_alt: String
	var bounce_use_item: String
	var full_title: String
	var main_desc: String
	var variant_desc: String
	var series_code: Int
	var issue_no: Int
	var issue_seq_no: Int
	var volume_tag: String
	var max_issue: Float
	var price: Float
	var publisher: String
	var upc_no: Int
	var short_isbn_no: Int
	var ean_no: Int
	var cards_per_pack: Int
	var pack_per_box: Int
	var box_per_case: Int
	var discount_code: String
	var increment: String
	var prnt_date: String
	var FOC_vender: String
	var ship_date: String
	var srp: Float
	var catergory: Int
	var genre: String
	var brand_code: String
	var mature: String
	var adult: String
	var oa: String
	var caut1: String
	var caut2: String
	var caut3: String
	var resol: String
	var note_price: String
	var order_from_notes: String
	var page: Int
	var writer: [String]
	var artist: [String]
	var cover: [String]
	var colorist: [String]
	var alliance_sku: Int
	var FOC_date: String
	var offered_date: String
	var number_of_pages: Int
	var unit_weight: Float
	var unit_length: Float
	var unit_width: Float
	var unit_height: Float
	var case_weight: Float
	var case_length: Float
	var case_width: Float
	var case_height: Float
}
