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
    
    enum NavigationBarTitles {
        static let newsTitle = "Новость"
    }
    
    enum ErrorMessage {
        static let general = "Что-то пошло не так.\nПопробуйте позже, должно получиться"
    }
    
    enum LoadingMessage {
        static let inProgress = "Загрузка..."
    }
}
