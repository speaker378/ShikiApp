
[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Platform][platform-image]][platform-url]
[![PRs][prs-image]][prs-url]

[swift-image]: https://img.shields.io/badge/Swift-5.7-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[platform-image]: https://img.shields.io/badge/Platform-ios-purple.svg
[platform-url]: http://cocoapods.org/pods/LFAlertController
[prs-image]: https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square
[prs-url]: http://makeapullrequest.com

# ShikiApp
<br />
<p align="center">
  <a href="https://github.com/speaker378/ShikiApp">
    <img src="logo.png" alt="Logo" width="80" height="80">
  </a>
  <p align="center">
    Приложение для просмотра информации об аниме, манге и ранобэ на основе данных <a href="https://shikimori.one"> Shikimori </a>
  </p>
</p>

## Функции

-  управлять списками просмотров
-  читать новости из мира аниме
-  просматривать календарь выхода новых серий
-  находить информацию о тайтлах
-  смотреть трейлеры, опенинги, эндинги

## Требования

- iOS 16.2+
- Xcode 14.2

## Вклад

Мы будем рады, если вы сделаете вклад в **ShikiApp**, проверьте файл ``LICENSE`` для получения дополнительной информации.

### Спринт2
####Сделано (branch feature/SA-9):

Разработан сетевой слой приложения достаточный для минимального рабочего приложения:
- Core/Network/ - ядро для формирования запросов URLSession
- App/BusinessLogic/Network/Forums/  - фабрика запросов  API Forums
- App/BusinessLogic/Network/Topics -  фабрика запросов API Topics
- App/BusinessLogic/Network/Users -  фабрика запросов API Users
- App/BusinessLogic/Network/ApiFactory -  фабрика фабрик 

Начал покрывать smoke тестами запросы:
- API Forums (ForumsApiTests.swift) - полностью 
- API Topics (TopicsApiTests.swift) - частично

####Долги: 
- Покрыть до конца smoke тестами API Topics 
- Покрыть smoke тестами API Users 
- Пулл реквест сетевого слоя feature/SA-9 -> develop

####Проблемы:
- Отсутствуют спецификации и/или схемы JSON респонсов API. Модели данных создаются на основе примеров


