# 🔧 utilities macOS (Hammerspoon + Lua)

Script tiện ích cho macOS được xây dựng bằng **Hammerspoon + Lua**. Bao gồm:

- 📋 Clipboard Manager
- 🪄 Paste name branch in field filter Sourcetree
- 💻 Open current folder in Terminal

---

## ✨ Cài đặt

### 1. Cài Homebrew (nếu chưa có)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Cài Hammerspoon

```bash
brew install hammerspoon --cask
```

Hoặc tải từ trang chính thức: [https://www.hammerspoon.org/](https://www.hammerspoon.org/)

### 3. Mở Hammerspoon & cấp quyền

- Mở Hammerspoon.app (Trong kho ứng dụng)
- Là lần đầu chạy → bấm `Open Preferences`
- Vào `System Preferences → Security & Privacy → Accessibility`
- Thêm Hammerspoon vào danh sách được cấp quyền
- Mở lại Hammerspoon.app -> app hiển thị trên menu bar -> Bấm icon Hammerspoon -> Chọn Preference -> Chọn option Lauch Hammerspoon at login (để mỗi lần mở máy nó chạy config)

### 4. Setup project

```
git clone https://github.com/letienndat/utilities-macos.git
cd utilities-macos
bash setup.sh
```
Các bước:
1. Kéo repo về
2. Đi vào folder repo 
3. Chạy lệnh `bash setup.sh` để di chuyển các file vào folder `~/.hammerspoon` (folder mà Hammerspoon có thể load config)
4. Bấm vào icon Hammerspoon ở menu bar -> Chọn Reload Config
5. Bây giờ có thể bấm hotkey `Command + Shift + H` để mở hộp thoại Help (Hiển thị các chức năng được config)

---

## 📁 Cấu trúc thư mục

Tất cả script nằm tại:

```
~/.hammerspoon/
```

Có thể phát triển thêm tính năng và gán hotkey nếu cần.

Các bước triển khai:

1. Tạo file `feature.lua` trong cùng thư mục `~/.hammerspoon/` (`feature` là tính năng mà bạn muốn triển khai thêm)
2. Khai báo `feature` ở vào `features` ở file `feature.lua`
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
| `Cmd + Shift + T` | Mở Terminal với thư mục đang được mở ở Finder                                     |

> Có thể xây dựng tính năng mới và gán hotkey tuỳ chỉnh của riêng bạn

---

## 📸 Screenshot

<img src="/assets/preview.png" width="600" alt="Preview utilities macOS (Hammerspoon + Lua)">

---

## 🧑‍💻 Tác giả

Le Tien Dat

---

## 📜 License

MIT License.

## 🫶 Thanks for reading