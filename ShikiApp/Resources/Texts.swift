//
//  Texts.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 18.01.2023.
//
// Класс предназначен для всех статичных текстов и надписей

import Foundation

enum Texts {
    
    enum TabBarTitles {
        static let home = "Новости"
        static let search = "Поиск"
        static let myList = "Мой список"
        static let profile = "Профиль"
    }
    
    enum NavigationsBar {
        static let newTitle = "Новость"
    }
    
    enum ErrorMessage {
        static let failedFetchData = "Что-то пошло не так.\nПопробуйте позже, должно получиться"
    }
}