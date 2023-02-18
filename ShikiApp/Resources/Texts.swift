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
        static let filtersTitle = "Фильтры"
    }
    
    enum ErrorMessage {
        static let general = "Что-то пошло не так.\nПопробуйте позже, должно получиться"
        static let noResults = "Ничего не найдено"
    }
    
    enum LoadingMessage {
        static let inProgress = "Загрузка..."
    }
    
    enum FilterLabels {
        static let rating = "Оценка от"
        static let type = "Тип"
        static let status = "Статус"
        static let genre = "Жанр"
        static let releaseYear = "Год выхода"
        static let season = "Сезон"
    }
    
    enum FilterButtons {
        static let resetAll = "Сбросить все"
        static let apply = "Применить"
    }
    
    enum FilterPlaceholders {
        static let rating = "Выберите оценку"
        static let type = "Выберите тип"
        static let status = "Выберите статус"
        static let genre = "Выберите жанр"
        static let releaseYearStart = "С"
        static let releaseYearEnd = "По"
        static let season = "Выберите сезон"
    }
    enum OtherMessage {
        static let open = "Открыть"
        static let openInYoutube = "Открыть в Youtube"
        static let episodes = "эп."
        static let minutes = "мин."
    }
    
    enum ButtonTitles {
        static let addToList = "Добавить в список"
    }
}
