# 🔧 utilities macOS (Hammerspoon + Lua)

Script tiện ích cho macOS được xây dựng bằng **Hammerspoon + Lua**. Bao gồm:

- 📋 Clipboard Manager
- 📋 Paste name branch in field filter Sourcetree
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
~/.hammerspoon/init.lua
```

Có thể phát triển thêm tính năng và gán hotkey nếu cần.

Các bước triển khai:

1. Tạo file `feature.lua` trong cùng thư mục `~/.hammerspoon/` (`feature` là tính năng mà bạn muốn triển khai thêm)
2. Trong `init.lua`, thêm dòng:

```lua
require("feature")
```

3. Sau khi chỉnh sửa xong, mở Hammerspoon → chọn **"Reload Config"** để áp dụng thay đổi

---

### ⌨️ Hotkeys có sẵn

| Tổ hợp phím       | Tính năng                                                                 |
| ----------------- | ------------------------------------------------------------------------- |
| `Cmd + Shift + C` | Mở menu clipboard history và dán mục đã chọn                              |
| `Cmd + Shift + V` | Dán phần cuối của nhánh Git (phù hợp với filter branch Sourcetree)        |
| `Cmd + Shift + T` | Mở Terminal với thư mục đang được mở ở Finder                             |

> 💡 Sẽ triển khai thêm tính năng Help: Hiển thị tất cả hotkey - feature được config

---

## 🧑‍💻 Tác giả

Le Tien Dat

---

## 📜 License

MIT License.
