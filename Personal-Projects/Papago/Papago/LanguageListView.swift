//
//  SourceLanguageListView.swift
//  Papago
//
//  Created by Minjae Kim on 11/15/23.
//

import SwiftUI

struct LanguageListView: View {
	
	@EnvironmentObject var papagoStore: PapagoStore
	@Binding var isShow: Bool
	let method: String
	
	var body: some View {
		NavigationStack {
			List(0..<papagoStore.languageArray.count, id: \.self) { i in
				if method == "입력" {
					if papagoStore.languageArray[i].isSource {
						SourceLanguageListButton(isShow: $isShow, index: i, foregroundHexCode: "#FFFFFF", listRowBacgroundHexCode: "#2F3651")
					}
					
					if !papagoStore.languageArray[i].isSource {
						SourceLanguageListButton(isShow: $isShow, index: i, foregroundHexCode: "#8EBBFF", listRowBacgroundHexCode: "#2F3651")
					}
				}
				if method == "번역" {
					if papagoStore.languageArray[i].isTarget {
						TargetLanguageListButton(isShow: $isShow, index: i, foregroundHexCode: "#FFFFFF", listRowBacgroundHexCode: "#2F3651")
					}
					
					if !papagoStore.languageArray[i].isTarget {
						TargetLanguageListButton(isShow: $isShow, index: i, foregroundHexCode: "#8EBBFF", listRowBacgroundHexCode: "#2F3651")
					}
				}
			}
			.background(Color.init(hex: "#24293E"))
			.scrollContentBackground(.hidden)
			
			.toolbar() {
				ToolbarItem(placement: .topBarLeading) {
					Button {
						self.isShow.toggle()
					} label: {
						Image(systemName: "xmark")
							.foregroundStyle(Color.init(hex: "#8EBBFF"))
					}
				}
				
				ToolbarItem(placement: .principal) {
					Text("이 언어로 \(method)").foregroundStyle(Color.init(hex: "#8EBBFF"))
				}
			}
			.toolbarBackground(Color.init(hex: "#24293E"), for: .navigationBar)
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

struct SourceLanguageListButton: View {
	
	@EnvironmentObject var papagoStore: PapagoStore
	
	@Binding var isShow: Bool
	
	let index: Int
	let foregroundHexCode: String
	let listRowBacgroundHexCode: String
	
	var body: some View {
		Button {
			swapLanguage(newSourceIndex: index)
			isShow.toggle()
		} label: {
			Text(papagoStore.languageArray[index].language)
		}
		.foregroundStyle(Color.init(hex: foregroundHexCode))
		.listRowBackground(Color.init(hex: listRowBacgroundHexCode))
	}
	
	private func swapLanguage(newSourceIndex i: Int) {
		
		// 새로 선택한 source 언어가 target으로 선택된 언어라면
		// source 언어와 target 언어를 swap
		if papagoStore.languageArray[i].isTarget {
			dump("select new source language is target laguage")
			swapSourceTarget()
			
		} else {
			// 새로 선택한 source 언어가 target으로 선택된 언어가 아니라면
			// 원래 source 언어를 해제하며 새로 선택된 source 언어로 재설정
			dump("select new source language")
			swapSourceLanguage(newSourceIndex: i)
		}
		dump(papagoStore.languageArray[papagoStore.sourceIndex])
	}
	
	private func swapSourceLanguage(newSourceIndex i: Int) {
		papagoStore.languageArray[papagoStore.sourceIndex].isSource.toggle() // 원래 source 언어 flag 프로퍼티를 false
		
		papagoStore.languageArray[i].isSource.toggle() // 새로운 source 언어 flag 프로퍼티를 true
		papagoStore.source = papagoStore.languageArray[i].languageCode.rawValue // 새로 들어온 source 언어를 source 언어 저장 프로퍼티에 저장
		papagoStore.sourceIndex = i // 새로 들어온 source언어의 인덱스를 저장 프로퍼티에 저장
	}
	
	private func swapSourceTarget() {
		// source에 해당하는 언어를 target으로 스왑
		papagoStore.languageArray[papagoStore.sourceIndex].isSource.toggle()
		papagoStore.languageArray[papagoStore.sourceIndex].isTarget.toggle()
		papagoStore.source = papagoStore.languageArray[papagoStore.targetIndex].languageCode.rawValue
		
		// target에 해당하는 언어를 source으로 스왑
		papagoStore.languageArray[papagoStore.targetIndex].isSource.toggle()
		papagoStore.languageArray[papagoStore.targetIndex].isTarget.toggle()
		papagoStore.target = papagoStore.languageArray[papagoStore.sourceIndex].languageCode.rawValue
		
		// 배열에서 source와 target에 접근하기 위한 index를 서로 swap
		(papagoStore.sourceIndex, papagoStore.targetIndex) = (papagoStore.targetIndex, papagoStore.sourceIndex)
	}
}

struct TargetLanguageListButton: View {
	
	@EnvironmentObject var papagoStore: PapagoStore
	
	@Binding var isShow: Bool
	
	let index: Int
	let foregroundHexCode: String
	let listRowBacgroundHexCode: String
	
	var body: some View {
		Button {
			swapLanguage(newTargetIndex: index)
			isShow.toggle()
		} label: {
			Text(papagoStore.languageArray[index].language)
		}
		.foregroundStyle(Color.init(hex: foregroundHexCode))
		.listRowBackground(Color.init(hex: listRowBacgroundHexCode))
	}
	
	private func swapLanguage(newTargetIndex i: Int) {
		
		// 새로 선택한 target 언어가 source으로 선택된 언어라면
		// source 언어와 target 언어를 swap
		if papagoStore.languageArray[i].isSource {
			dump("select new target language is source laguage")
			swapSourceTarget()
		} else {
			// 새로 선택한 target 언어가 source으로 선택된 언어가 아니라면
			// 원래 target 언어를 해제하며 새로 선택된 target 언어로 재설정
			dump("select new target language")
			swapTargetLanguage(newTargetIndex: i)
		}
		dump(papagoStore.languageArray[papagoStore.targetIndex])
	}
	
	private func swapTargetLanguage(newTargetIndex i: Int) {
		papagoStore.languageArray[papagoStore.targetIndex].isTarget.toggle() // 원래 target 언어 flag 프로퍼티를 false
		
		papagoStore.languageArray[i].isTarget.toggle() // 새로운 target 언어 flag 프로퍼티를 true
		papagoStore.target = papagoStore.languageArray[i].languageCode.rawValue // 새로 들어온 target 언어를 target 언어 저장 프로퍼티에 저장
		papagoStore.targetIndex = i // 새로 들어온 target언어의 인덱스를 저장 프로퍼티에 저장
	}
	
	private func swapSourceTarget() {
		// source에 해당하는 언어를 target으로 스왑
		papagoStore.languageArray[papagoStore.sourceIndex].isSource.toggle()
		papagoStore.languageArray[papagoStore.sourceIndex].isTarget.toggle()
		papagoStore.source = papagoStore.languageArray[papagoStore.targetIndex].languageCode.rawValue
		
		// target에 해당하는 언어를 source으로 스왑
		papagoStore.languageArray[papagoStore.targetIndex].isSource.toggle()
		papagoStore.languageArray[papagoStore.targetIndex].isTarget.toggle()
		papagoStore.target = papagoStore.languageArray[papagoStore.sourceIndex].languageCode.rawValue
		
		// 배열에서 source와 target에 접근하기 위한 index를 서로 swap
		(papagoStore.sourceIndex, papagoStore.targetIndex) = (papagoStore.targetIndex, papagoStore.sourceIndex)
	}
}
