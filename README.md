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
brew install --cask hammerspoon
```

Hoặc tải từ trang chính thức: [https://www.hammerspoon.org/](https://www.hammerspoon.org/)

### 3. Mở Hammerspoon & cấp quyền

- Chạy lần đầu → bấm `Open Preferences`
- Vào `System Preferences → Security & Privacy → Accessibility`
- Thêm Hammerspoon vào danh sách được cấp quyền

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

---

## 📸 Screenshot

<img src="/assets/preview.png" width="600" alt="Preview utilities macOS (Hammerspoon + Lua)">

---

## 🧑‍💻 Tác giả

Le Tien Dat

---

## 📜 License

MIT License.
