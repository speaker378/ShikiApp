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
        static let failLoading = "Данные не загрузились"
        static let generalDescription = "Попробуйте позже, должно получиться"
    }
    
    enum Empty {
        static let noDescription = "Нет описания"
        static let noTitle = "Без названия"
        static let noScore = "Не оценено"
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
        static let all = "Вce"
    }
   
    enum OtherMessage {
        static let open = "Открыть"
        static let openInYoutube = "Открыть в Youtube"
        static let episodes = "эп."
        static let minutes = "мин."
        static let volumes = "т."
        static let chapters = "гл."
    }
    
    enum DetailLabels {
        static let episodes = "Эпизодов"
    }
    
    enum ButtonTitles {
        static let addToList = "Добавить в список"
        static let close = "Закрыть"
        static let removeFromList = "Удалить из списка"
    }
    
    enum DummyTextForProfileVC {
        static let nameLabelText = "Вел1чайший"
        static let sexAndAgeLabelText = "мужчина, 24"
        static let webLinkText = "myanimelist.com/firefly784"
        static let logoutButtonText = "Выйти из аккаунта"
        static let versionLabelText = "Версия 1.0.0(1)"
    }

    enum ListTypesSelectItems {
        static let all = "Вce"
        static let completed = "Просмотрено"
        static let planned = "Запланировано"
        static let watching = "Смотрю"
        static let onHold = "На паузе"
        static let dropped = "Брошено"
        static let rewatching = "Пересматриваю"
    }
    
    struct NetworkLayerErrorMessages {
        static let success = "Успешный запрос"
        static let redirect = "Необходимо перенаправить запрос"
        static let authenticationError = "Клиент не авторизован"
        static let clientError = "Некорректный запрос к серверу"
        static let serverError = "Ошибка сервера"
        static let outdated = "URL адрес устарел"
        static let requestFailed = "Ошибка выполнения сетевого запроса"
        static let noData = "Ответ сервера не содержит данных"
        static let unableToDecode = "Ошибка декодирования ответа сервера"
        static let badResponse = "Некорректный ответ сервера"
        static let tooManyRequests = "Слишком много запросов"
        static let accessDenied = "Доступ запрещен"
    }
}
