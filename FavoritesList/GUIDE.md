# Favorites List: пошагово

Тема: десерты (20 штук). Если в группе у кого-то такая же, поменяй тему и данные в `FavoriteItem.swift`.

## 1. Проект
1. Xcode → **File → New → Project → iOS → App**.
2. Product Name: `FavoritesList`, Interface: **Storyboard**, Language: **Swift**. Сохрани в `~/Desktop/ios/`.
3. Перетащи в проект (в левую панель, в папку с `ViewController.swift`) файлы `FavoriteItem.swift` и `FavoriteCell.swift`.
   В окне: **Copy items if needed** ✓, **Add to targets: FavoritesList** ✓.
4. Открой созданный Xcode `ViewController.swift`, сотри всё и вставь содержимое моего `ViewController.swift`.
5. Положи файл `.gitignore` в корневую папку проекта (там, где лежит `FavoritesList.xcodeproj`).
   Чтобы увидеть скрытые файлы в Finder: **⌘ + Shift + .**

## 2. Картинки
1. Скачай 20 картинок (например, с unsplash.com или pixabay.com).
2. Открой **Assets** в Xcode и перетащи их туда.
3. Переименуй каждую ровно как в `imageName`:
   `tiramisu, cheesecake, baklava, macarons, churros, cremebrulee, brownie, chakchak, napoleon, medovik, pannacotta, mochi, strudel, pavlova, cinnamonroll, gulabjamun, lemontart, redvelvet, pasteldenata, fondant`

## 3. Table View (Main.storyboard)
1. Открой `Main.storyboard`. Нажми **+** (Library, вверху справа), найди **Table View**, перетащи на экран.
2. Выдели Table View → кнопка **Add New Constraints** (квадратик с палками внизу справа).
   Сними галочку Constrain to margins, поставь **0** со всех 4 сторон (вверх/вниз/влево/вправо), нажми **Add 4 Constraints**.
   Верх и низ должны быть привязаны к **Safe Area**.
3. Attributes inspector (справа, иконка ползунков) у Table View: **Prototype Cells = 1**.
   Row Height: оставь **Automatic**.
4. Подключи outlet: открой рядом код (**Editor → Assistant**), зажми **Control** и перетащи Table View
   на строку `@IBOutlet weak var tableView` в `ViewController.swift`.

## 4. Прототип ячейки
1. Выдели ячейку (Table View Cell) в списке слева.
   - **Identity inspector** (иконка карточки): Class = `FavoriteCell`.
   - **Attributes inspector**: Identifier = `FavoriteCell` (точно так же, как в коде).
2. Внутрь ячейки (Content View) добавь:
   - **Image View**
   - **Label** (title)
   - **Label** (subtitle)
   - 5 штук **Image View** (звёзды)

### Стеки
3. Выдели 5 звёзд → кнопка **Embed In → Stack View** (внизу справа). Это **горизонтальный** стек.
   Attributes: Axis Horizontal, Spacing **2**, Distribution **Fill Equally**.
4. Выдели title, subtitle и стек звёзд → **Embed In → Stack View**.
   Attributes: Axis **Vertical**, Alignment **Leading**, Spacing **4**.
5. Выдели Image View и вертикальный стек → **Embed In → Stack View**.
   Attributes: Axis **Horizontal**, Alignment **Center**, Spacing **12**.

### Констрейнты (только 2 места)
6. **Внешний горизонтальный стек**: Add New Constraints → top **12**, bottom **12**, leading **16**, trailing **16**.
7. **Image View**: Add New Constraints → Width **72**, Height **72**.
   Потом выдели констрейнт Height (в списке слева) и поставь **Priority 999**, чтобы не было жёлтых предупреждений про высоту ячейки.

### Настройки вьюшек
8. Image View: Content Mode **Aspect Fill**, **Clip to Bounds** ✓.
9. Title: Font **Headline**, Lines **0** (переносится, если длинный).
10. Subtitle: Font **Subheadline**, Color **Secondary Label**, Lines **0**.
11. Каждая звезда: Image `star`, Tint **System Yellow**, Content Mode Aspect Fit.
   Чтобы звёзды были маленькие: Configuration → **Point Size**, Point Size **14**.

### Outlets ячейки
12. Открой Assistant, сверху выбери файл `FavoriteCell.swift` (если открылся другой — переключи вручную).
13. Control-перетаскиванием подключи: картинку → `itemImageView`, title → `titleLabel`, subtitle → `subtitleLabel`,
    звёзды слева направо → `star1` … `star5`.

## 5. Проверка
1. Внизу storyboard нажми **Update Frames** (иконка ⟳) если есть оранжевые линии.
2. В Document Outline не должно быть красной/жёлтой стрелки.
3. Запусти на **iPhone SE (3rd generation)** и **iPhone 16 Pro Max**. Последний десерт с длинным названием
   специально длинный: он должен переноситься, а не залезать на картинку.
4. Если приложение падает на старте с `unable to dequeue a cell with identifier` — не совпадает Identifier.
   Если `this class is not key value coding-compliant` — оборван старый outlet (Connections inspector, удали крестиком).

## 6. Сдача
1. Скриншоты: в симуляторе **⌘ + S** (сохранится на рабочий стол). Создай в проекте папку `Screenshots`,
   положи их как `iphone-se.png` и `iphone-16-pro-max.png`.
2. Запись экрана: в симуляторе **File → Record Screen**, прокрути весь список, останови. Положи как `Screenshots/scroll.mp4`.
3. Положи `README.md` в корень проекта.
4. Загрузи папку проекта на GitHub (отдельный репозиторий), ссылку — преподавателю.
