//
//  FiltersModel.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 14.02.2023.
//

import Foundation

struct FiltersModel {
    
    var ratingList: [String]
    var typeList: [String]
    var statusList: [String]
    var genreList: [String]
    var seasonList: [String]
}

final class FiltersModelFactory {
    
    // Для примера заполнения фильтров
    let filtersList = FiltersModel(
        ratingList: ["1.0",
                     "2.0",
                     "3.0",
                     "4.0",
                     "5.0",
                     "6.0",
                     "7.0",
                     "8.0",
                     "9.0",
                     "10.0"],
        typeList: ["Все",
                   "TV Сериал",
                   "TV Сериал(короткий)",
                   "TV Сериал(средний)",
                   "TV Сериал(длинный)",
                   "Фильм",
                   "Клип",
                   "Спешл",
                   "OVA",
                   "ONA",
                   "Манга",
                   "Манхва",
                   "Маньхуа",
                   "Ранобэ",
                   "Новелла",
                   "Ваншот",
                   "Додзинси"],
        statusList: ["Анонсировано",
                     "Сейчас выходит",
                     "Недавно вышедшее",
                     "Вышедшее"],
        genreList: ["Сёнен",
                    "Сёнен-ай",
                    "Сэйнэн",
                    "Сёдзё",
                    "Сёдзё-ай",
                    "Дзёсей",
                    "Комедия",
                    "Романтика",
                    "Школа",
                    "Безумие",
                    "Боевые искусства"],
        seasonList: ["Весна 2023",
                     "Зима 2023",
                     "Осень 2022",
                     "Лето 2022",
                     "Весна 2022",
                     "Зима 2022"]
    )
}
