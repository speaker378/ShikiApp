
[![Swift Version][swift-image]][swift-url]
[![Platform][platform-image]][platform-url]

[swift-image]: https://img.shields.io/badge/Swift-5.7-orange.svg
[swift-url]: https://swift.org/
[platform-image]: https://img.shields.io/badge/Platform-ios-purple.svg
[platform-url]: http://cocoapods.org/pods/LFAlertController

# Styleguide

Добро пожаловать в руководство по стилю контента для Shiki App.

Общие вопросы по стилю или руководство по темам, которые здесь не рассматриваются, см. в <a href="https://github.com/kodecocodes/swift-style-guide">Kodeco swift style-guide</a>.

## Ширина страницы

Ширина страницы - 120 символов \
(Xcode / Preferences / Text Editing / Page guide at column). 

## Именование
- Используйте camelCase, а не snake_case
- Используйте верхний регистр для типов и протоколов, нижний регистр для всего остального
- Избегайте сокращений
- Выбирайте само-документируемые имена для параметров
- Включайте только необходимые слова, при этом избегая лишних
- Возьмите за основу американско-английское правописание в соответствии с API Apple.

### Булевы
Для булевых переменных принято использовать вспомогательный глагол в начале.

**Рекомендуется:**
```swift
var isFavoriteCategoryFilled: Bool
var hasRoaming: Bool
var isBlocked: Bool
```
**Не рекомендуется:**
```swift
var favoriteCategoryFilled: Bool
var roaming: Bool
var blocked: Bool
```

## Организация кода

Используйте расширения, чтобы разложить свой код на логические функциональные блоки. Каждое расширение должно быть подписано с помощью // MARK: - Комментарий, чтобы все было хорошо организовано.

Лучше соблюдать следующую последовательность:
```swift

// MARK: - Properties

// MARK: - Private properties

// MARK: - Construction

// MARK: - Lifecycle

// MARK: - Functions

// MARK: - Private functions

// MARK: - UITableViewDelegate // пример расширения

```

## Соответствие протокола

При добавлении соответствия протокола добавляйте отдельное расширение для реализации его методов. 

**Рекомендуется:**
```swift
final class MyViewController: UIViewController {
  // код класса
}

// MARK: - UITableViewDataSource
extension MyViewController: UITableViewDataSource {
  // методы датасорса
}

// MARK: - UITableViewDelegate
extension MyViewController: UITableViewDelegate {
  // методы делегата
}
```
**Не рекомендуется:**
```swift
final class MyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
  // все методы
}
```

## Неиспользованный код

- Неиспользованный (мертвый) код, включая код шаблона Xcode и комментарии к заполнению, должен быть удалены.\
- Пустые/неиспользуемые методы также должны быть удалены
- `//TODO:` , `//FIXME:` должны быть удалены при Pull request

## Отступы

- Для `struct`, `class`, `extension`, `protocol` - если длина более 1 строки, в начале добавляем `\n`
- Закрывающие скобки на новой строке `) ] }`
- Оставьте одну пустую строку между функциями и одну до и после MARK
- Для цепочки вызовов предпочитайте функциональный стиль

**Рекомендуется:**
```swift
let myArray = array
              .map { MyType($0) }
              .sorted()
```
**Не рекомендуется:**
```swift
let myArray = array.map { MyType($0) }.sorted()
```

## Классы и структуры
- Не добавляйте модификаторы доступа, такие как `internal`, `fileprivate`, если они уже установлены по умолчанию. 
- Скрывайте свойства и методы, не связанные с общим доступом с помощью контроля доступа
- Маркируйте класс как `final`, если не подразумеваете наследования

## Объявление и вызов функций

Сохраняйте короткие объявления функций или типов на одной строке, включая открывающую фигурную скобку:

```swift
func method(parameter: [Double]) -> Bool {
    // ...
}
```
Для функций надо добавить переносы строк для каждого аргумента, включая первый, если они превышают руководство по ширине страницы.

```swift
func method(
    parameter1: [Double], 
    parameter2: Double,
    parameter3: Int
) -> Bool {
    // ...
}
```
Это же правило применяется и для вызовов функций.

```swift
let result = method(
    parameter1: parameter1, 
    parameter2: parameter2,
    parameter3: parameter3
)
```
