//
//  ViewState.swift
//  ImageFetcher
//

import Foundation

enum ViewState<T> {
    case loading
    case loaded(T)
    case failed(message: String)
}
