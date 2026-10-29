# Music Player: пошагово

## 1. Проект
1. Xcode → **File → New → Project → iOS → App**.
2. Product Name: `MusicPlayer`, Interface: **Storyboard**, Language: **Swift**.
3. Перетащи `Track.swift` в проект (**Copy items if needed** ✓, **Add to targets** ✓).
4. Замени содержимое `ViewController.swift` на моё.
5. `.gitignore` положи рядом с `MusicPlayer.xcodeproj`.

## 2. Музыка и обложки
1. Скачай 10 бесплатных треков с **pixabay.com/music** (каждый меньше 10 MB) и 10 картинок для обложек.
2. Переименуй треки: `track01.mp3` … `track10.mp3`. Если файл `.m4a`, поменяй расширение и в `Track.swift`.
3. Перетащи mp3 в проект. В окне обязательно **Add to targets: MusicPlayer** ✓.
   Проверка: выдели файл → File inspector (справа) → **Target Membership** ✓.
4. Обложки перетащи в **Assets** и назови `cover01` … `cover10`.
5. В `Track.swift` впиши настоящие названия и исполнителей с сайта.

## 3. Layout (Main.storyboard)
1. Добавь на экран (через **+**):
   - **Image View** (обложка)
   - 2 **Label** (title, artist)
   - 3 **Button** (previous, play, next)

### Стеки
2. Выдели 2 лейбла → **Embed In → Stack View**: Axis **Vertical**, Alignment **Fill**, Spacing **4**.
   Обоим лейблам: Alignment текста по центру. Title — Font **Title 2**, Bold; Artist — **Body**, Color Secondary Label.
3. Выдели 3 кнопки → **Embed In → Stack View**: Axis **Horizontal**, Distribution **Fill Equally**, Spacing **20**.
4. Выдели обложку, стек лейблов и стек кнопок → **Embed In → Stack View**:
   Axis **Vertical**, Alignment **Fill**, Distribution **Fill**, Spacing **24**. Это root stack.

### Констрейнты (только 2 места)
5. **Root stack**: Add New Constraints → leading **20**, trailing **20** (к Safe Area).
   Потом **Align** (иконка рядом) → **Vertically in Container** ✓ → Add.
6. **Обложка**: Control-перетащи с обложки на неё же → **Aspect Ratio**.
   Выдели этот констрейнт → Multiplier **1:1**.

### Кнопки
7. Каждая кнопка: Attributes → Style **Default** (не Plain), Title — пустой.
   Image: previous `backward.fill`, play `play.fill`, next `forward.fill`.
   Чтобы иконки были крупнее: Configuration → **Point Size** — 28 для previous/next, 44 для play.
8. Обложка: Content Mode **Aspect Fill**, **Clip to Bounds** ✓.

### Подключение к коду
9. Assistant (**Editor → Assistant**), Control-перетаскиванием:
   - обложка → `coverImageView`, title → `titleLabel`, artist → `artistLabel`, кнопка play → `playPauseButton`
   - кнопка previous → `@IBAction func previousTapped`
   - кнопка play → `@IBAction func playPauseTapped`
   - кнопка next → `@IBAction func nextTapped`
   (тянешь на уже написанную строку функции, Xcode подсветит её)

## 4. Проверка
1. В Document Outline не должно быть красной/жёлтой стрелки.
2. Запусти на **iPhone SE (3rd generation)** и **iPhone 16 Pro Max**: обложка квадратная, всё помещается.
3. Проверь: play → pause, next/previous меняют обложку и текст, если играло — продолжает играть,
   next на 10-м → 1-й, previous на 1-м → 10-й, после конца трека включается следующий.
4. Если в консоли `File not found in bundle` — у файла не стоит Target Membership или имя не совпадает.

## 5. Сдача
1. Скриншоты: в симуляторе **⌘ + S**, положи в `Screenshots/` как `iphone-se.png` и `iphone-16-pro-max.png`.
2. Запись 20–30 секунд (**File → Record Screen**): play, pause, next, previous и переход с последнего на первый.
   Положи как `Screenshots/demo.mp4`.
3. `README.md` в корень проекта, загрузи на GitHub отдельным репозиторием.
