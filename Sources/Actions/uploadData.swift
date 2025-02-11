import Foundation

func uploadComicData(file: String, url: String, datatype: String) {
	var comic_list: [Data] = []
	let encoder: JSONEncoder = JSONEncoder()
	if datatype == "lunar" {
		//var comicsList: [LunarComic] = []
		do {
			let contents: String = try String(contentsOf: URL(fileURLWithPath: file))
			let decoder: JSONDecoder = JSONDecoder()
			guard let fileData: Data = contents.data(using: .utf8) else { return }
			let jsonData: [LunarComic] = try decoder.decode([LunarComic].self, from: fileData)
			for i: Int in 0...jsonData.count {
				guard let comicJSON: Data = try? encoder.encode(jsonData[i]) else { return }
				comic_list.append(comicJSON)
			}
		} catch {
			print(error)
		}
	}
	if datatype == "diamond" {
		do {
			let contents: String = try String(contentsOf: URL(fileURLWithPath: file))
			let decoder: JSONDecoder = JSONDecoder()
			guard let fileData: Data = contents.data(using: .utf8) else { return }
			let jsonData: [DiamondComic] = try decoder.decode([DiamondComic].self, from: fileData)
			for i: Int in 0...jsonData.count {
				guard let comicJSON: Data = try? encoder.encode(jsonData[i]) else { return }
				comic_list.append(comicJSON)
			}
		} catch {
			print(error)
		}
	}

	// upload all comics to the server
	var request: URLRequest = URLRequest(url: URL(string: url)!)
	request.httpMethod = "POST"
	request.setValue("application/json", forHTTPHeaderField: "Content-Type")
	for i: Int in 0...comic_list.count {
		request.httpBody = comic_list[i]
		let sema: DispatchSemaphore = DispatchSemaphore(value: 0)
		let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) {
			data, response, error in
			if let strData: String = String(data: data!, encoding: .utf8) {
				print(strData)
			}
			sema.signal()
		}
		task.resume()
		sema.wait()
	}
}
