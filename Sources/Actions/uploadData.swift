import Foundation

func sendComic(serverURL: String, comic: LunarComic) async {
	let encoder = JSONEncoder()
	guard let comicJSON = try? encoder.encode(comic) else { return }
	guard let url = URL(string: serverURL) else {
		print("Incalid Url")
		return
	}
	var req = URLRequest(url: url)
	req.setValue("application/json", forHTTPHeaderField: "Content-Type")
	req.httpMethod = "POST"
	do {
		let (data, res) = try await URLSession.shared.upload(for: req, from: comicJSON)
		guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200 else {
			print("rquest returned non 200 response")
			return
		}
		print("Sucess")
		print(String(data: data, encoding: .utf8)!)
	} catch {
		print(error)
	}
}

func uploadComicData(file: String, url: String) {
	var comicsList: [LunarComic] = []
	do {
		let contents = try String(contentsOf: URL(fileURLWithPath: file))
		let decoder = JSONDecoder()
		guard let fileData = contents.data(using: .utf8) else { return }
		let jsonData: [LunarComic] = try decoder.decode([LunarComic].self, from: fileData)
		comicsList = jsonData
	} catch {
		print(error)
	}
	// upload all comics to the server
	var request = URLRequest(url: URL(string: url)!)
	request.httpMethod = "POST"
	request.setValue("application/json", forHTTPHeaderField: "Content-Type")
	let encoder = JSONEncoder()
	for i in 0...comicsList.count {
		guard let comicJSON = try? encoder.encode(comicsList[i]) else { return }
		request.httpBody = comicJSON
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
