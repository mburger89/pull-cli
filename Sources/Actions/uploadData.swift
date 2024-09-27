import Foundation

func uploadComicData(file: String, url: String, datatype: String) {
	var comic_list: [Data] = []
	let encoder = JSONEncoder()
	if datatype == "lunar" {
		//var comicsList: [LunarComic] = []
		do {
			let contents = try String(contentsOf: URL(fileURLWithPath: file))
			let decoder = JSONDecoder()
			guard let fileData = contents.data(using: .utf8) else { return }
			let jsonData: [LunarComic] = try decoder.decode([LunarComic].self, from: fileData)
			for i in 0...jsonData.count {
				guard let comicJSON = try? encoder.encode(jsonData[i]) else { return }
				comic_list.append(comicJSON)
			}
		} catch {
			print(error)
		}
	}
	if datatype == "diamond" {
		do {
			let contents = try String(contentsOf: URL(fileURLWithPath: file))
			let decoder = JSONDecoder()
			guard let fileData = contents.data(using: .utf8) else { return }
			let jsonData: [DiamondComic] = try decoder.decode([DiamondComic].self, from: fileData)
			for i in 0...jsonData.count {
				guard let comicJSON = try? encoder.encode(jsonData[i]) else { return }
				comic_list.append(comicJSON)
			}
		} catch {
			print(error)
		}
	}

	// upload all comics to the server
	var request = URLRequest(url: URL(string: url)!)
	request.httpMethod = "POST"
	request.setValue("application/json", forHTTPHeaderField: "Content-Type")
	for i in 0...comic_list.count {
		request.httpBody = comic_list[i]
		let sema = DispatchSemaphore(value: 0)
		let task = URLSession.shared.dataTask(with: request) {
			data, response, error in
			if let strData = String(data: data!, encoding: .utf8) {
				print(strData)
			}
			sema.signal()
		}
		task.resume()
		sema.wait()
	}
}
