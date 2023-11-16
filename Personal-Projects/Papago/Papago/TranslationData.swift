//
//  TranslationData.swift
//  Papago
//
//  Created by Minjae Kim on 11/13/23.
//

import Foundation

enum DecodeError: Error {
	case doNotDecoded
}
/**
 http 통신할 때
 1. 해당 api 요구사항에 맞게 헤더를 심어주고
 2.
 */
class PapagoStore: ObservableObject {
	@Published var languageArray = LaunguageCode.allCases.map {
		if $0 == .korean {
			return Language(languageCode: $0, language: $0.language, isSource: true)
		}
		if $0 == .english {
			return Language(languageCode: $0, language: $0.language, isTarget: true)
		}
		return Language(languageCode: $0, language: $0.language)
	}
	
	@Published var sourceIndex: Int = 0
	@Published var targetIndex: Int = 1
	
	@Published var source: String = "ko"
	@Published var target: String = "en"
	@Published var text: String = ""
	/**
	 source - 원본 언어(source language)의 언어 코드
	 target - 목적 언어(target language)의 언어 코드
	 text - 번역할 텍스트. 1회 호출 시 최대 5,000자까지 번역할 수 있습니다.
	 */
	func requestTranslation(source: String, target: String, text: String) async -> String {
		let apiURL = "https://openapi.naver.com/v1/papago/n2mt"          // url 정의
		let contentType = "application/x-www-form-urlencoded"            // 받아올 떄 필요한 ContenType 정의
		let clientID = Secret.clientID.rawValue                          // clientID 정의
		let clientSecret = Secret.clientSecret.rawValue                  // clientSecret 정의
		let parameter = "source=\(source)&target=\(target)&text=\(text)" // 마지막으로 http 통신 통해서 보내줄 parameter 정의
		let data = parameter.data(using: .utf8)
		
		guard let url = URL(string: apiURL) else { return "" }           // URL 타입이 optional 이기에 guard문을 통해 옵셔널 바인딩
		var requestURL = URLRequest(url: url)                            // request 할 때 필요한 url 정의
		requestURL.httpMethod = "POST"                                   // api request 요구 시 그 쪽에서 요구되는 http 메서드 정의 (httpMethod의 default 값을 'GET')
		requestURL.addValue(contentType, forHTTPHeaderField: "Content-Type")
		requestURL.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
		requestURL.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret") // addValue를 통해 헤더 필드값 정의
		requestURL.httpBody = data // http request 요청 메시지의 본문을 정의
		// 여기까지가 헤더 심는 부분
		
		/**
		 # api에 request하는 부분
		 -  URLSession 클래스는 url을 통해 데이터를 다운받아오기 위한 api를 제공
		 - data(for: URLRequest) 메서드는 async한 메서드이기에 await 키워드를 사용해주어야하며
		 - Data, URLResponse 값을 리턴해주며 nil을 리턴해줄 가능성이 있어 try? 를 사용해주고 guard문을 통해 옵셔널 바인딩
		 */
		guard let requestData = try? await URLSession.shared.data(for: requestURL) else { return "" }
		
		do {
			
			let tranlationData: Translation = try decodeData(requestData.0) // decodeData가 에러를 throw할 수 있어 try 구문 사용
			print(tranlationData)
			return tranlationData.message.result.translatedText             // 에러가 없을 시 번역된 텍스트를 리턴
			
		} catch DecodeError.doNotDecoded {
			print("디코딩 에러")
			return ""
		} catch {
			print("언노운 에러")
			return ""
		}
	}
	
	func decodeData(_ data: Data) throws -> Translation {
		// Data타입으로 받아온 data를 JSONDecode.decode를 통해 디코딩
		// 디코딩 실패하면 에러를 throw
		guard let translationData = try? JSONDecoder().decode(Translation.self, from: data) else { throw DecodeError.doNotDecoded }
		return translationData // 에러 없으면 디코딩해서 받아온 데이터를 리턴
	}
}

/*
 네트워크 통신 참고코드
 func fetchData() async throws -> SampleJsonData {
		 
		 enum FetchError: Error {
			 case requestFailed, decodeFailed
		 }
		 
		 let url: URL = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
		 guard let request = try? await URLSession.shared.data(from: url) else { throw FetchError.requestFailed }
		 let decoder: JSONDecoder = JSONDecoder()
		 guard let jsonData = try? decoder.decode(SampleJsonData.self, from: request.0) else { throw FetchError.decodeFailed }
		 
		 return jsonData
	 }
 */
