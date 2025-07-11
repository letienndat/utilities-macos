# 🔧 utilities macOS (Hammerspoon + Lua)

Script tiện ích cho macOS được xây dựng bằng **Hammerspoon + Lua**. Bao gồm:

- 📋 Clipboard Manager (Hiển thị lịch sử những từ được sao chép)
- 🪄 Paste name branch in field filter Sourcetree (Dán đuôi của branch - phù hợp với chức năng filter ở Sourcetree)
- 💻 Open current folder in Terminal (Mở Terminal với đường dẫn hiện tại ở Finder)

---

## ✨ Cài đặt

### 1. Cài Homebrew (nếu chưa có)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Cài chương trình

**Bước 1:** Cài hammerspoon + utilities-macos
#### Version lastest
```bash
brew install --cask hammerspoon && brew install letienndat/hstools/utilities-macos
```

#### Chỉ định version (ví dụ: 1.1.4)
```bash
brew install --cask hammerspoon && brew install letienndat/hstools/utilities-macos@1.1.4
```

Nó cần cài: hammerspoon (bắt buộc, nếu thiết bị của bạn đã cài thì nó tự động bỏ qua không cài nữa, vì chương trình của tôi chạy trên môi trường hammerspoon)

**Bước 2:** Chạy script install.sh để sao chép script `.lua` vào folder `~/.hammerspoon`
#### Version lastest
```bash
bash $(brew --cellar utilities-macos)/$(brew list --versions utilities-macos | awk '{print $2}')/install.sh
```

#### Chỉ định version (ví dụ: 1.1.4)
```bash
bash $(brew --cellar utilities-macos@1.1.4)/1.1.4/install.sh
```

Chạy script install.sh để copy script `.lua` thù folder mặc định brew pull về sang folder `~/.hammerspoon` của Hammerspoon

**Bước 3:** Mở app Hammerspoon & cấp quyền

1. Mở Hammerspoon.app (Trong kho ứng dụng)
2. Là lần đầu chạy → bấm `Open Preferences` → Vào `System Preferences → Security & Privacy → Accessibility`
3. Thêm Hammerspoon vào danh sách được cấp quyền
4. Mở lại Hammerspoon.app -> app hiển thị trên menu bar -> Bấm icon Hammerspoon -> Chọn Preference -> Chọn option Lauch Hammerspoon at login (để mỗi lần mở máy nó tự động chạy config)
5. Bấm vào icon Hammerspoon ở menu bar -> Chọn Reload Config
6. Bây giờ có thể bấm hotkey `Command + Shift + H` để mở hộp thoại Help (Hiển thị các chức năng được config)

---

## 📁 Cấu trúc thư mục

Tất cả script nằm tại:

```
~/.hammerspoon/
```

### Có thể phát triển thêm tính năng và gán hotkey nếu muốn 😆

Các bước triển khai:

1. Tạo file `feature.lua` trong thư mục `~/.hammerspoon/features/` (`feature` là tính năng mà bạn muốn triển khai thêm)
2. Khai báo `feature` bạn muốn vào biến `features` trong file `features.lua`
```
feature = {
    title = "Tiêu đề feature",
    description = "Mô tả feature",
    hotkey = "Cmd + Shift + J",
    enabled = true,
    module = "Tên module feature"
}
```
- title: Tên của feature
- description: Mô tả chung về feature
- hotkey: Hot key hướng dẫn cho việc sử dụng
- enabled: Trạng thái bật/tắt feature (true hoặc false)
- module: Tên module của feature (chính là tên file `feature.lua` đã tạo, nhớ bỏ `.lua` đi)

3. Sau khi chỉnh sửa xong, mở Hammerspoon → chọn **"Reload Config"** để áp dụng thay đổi

---

### ⌨️ Hotkeys có sẵn

> 🆘 **Cmd + Shift + H** — Mở menu Help hiển thị tất cả các feature và hotkey được config

### ⌨️ Hotkeys khác

| Tổ hợp phím       | Tính năng                                                                         |
| ----------------- | --------------------------------------------------------------------------------- |
| `Cmd + Shift + C` | Mở menu clipboard history và dán mục đã chọn                                      |
| `Cmd + Shift + V` | Dán phần cuối của nhánh Git (phù hợp với filter branch Sourcetree)                |
| `Cmd + Shift + T` | Mở Terminal với đường dẫn hiện tại ở Finder                                       |

> Có thể xây dựng tính năng mới và gán hotkey tuỳ chỉnh của riêng bạn

---

## Gỡ cài đặt

#### Khi bạn đã cài version lastest:

```bash
brew uninstall --cask hammerspoon && brew uninstall letienndat/hstools/utilities-macos
brew untap letienndat/hstools
```

#### Chỉ định version (ví dụ 1.1.4)
```bash
brew uninstall --cask hammerspoon && brew uninstall letienndat/hstools/utilities-macos@1.1.4
brew untap letienndat/hstools
```

---

## 📸 Screenshot

<img src="/assets/preview.png" width="600" alt="Preview utilities macOS (Hammerspoon + Lua)">

---

## 📜 License

[MIT License.](https://github.com/letienndat/utilities-macos?tab=MIT-1-ov-file#)