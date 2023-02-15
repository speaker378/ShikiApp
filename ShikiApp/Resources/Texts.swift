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
        static let noResults = "Ничего не найдено"
    }
    
    enum LoadingMessage {
        static let inProgress = "Загрузка..."
    }
    
    enum OtherMessage {
        static let open = "Открыть"
        static let openInYoutube = "Открыть в Youtube"
    }
    
    enum DummyTextForProfileVC {
            static let nameLabelText = "Вел1чайший"
            static let sexAndAgeLabelText = "мужчина, 24"
            static let webLinkText = "myanimelist.com/firefly784"
            static let logoutButtonText = "Выйти из аккаунта"
            static let versionLabelText = "Версия 1.0.0(1)"
        }
}
