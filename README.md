# Utilities macOS (Hammerspoon + Lua)

Dựa trên **Hammerspoon + Lua**. Các tính năng:

- 📋 Clipboard Manager (Danh sách text item đã được sao chép)

---

## ✨ Cài đặt

### 1. Cài môi trường

#### 1. Homebrew (nếu chưa)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 2. Hammerspoon (nếu chưa)

```bash
brew install --cask hammerspoon
```

Cài Hammerspoon thì mở nó lên và cấp các quyền nó yêu cầu

### 2. Cài đặt tool

Chạy script sau để tải và cài đặt
```
git clone https://github.com/letienndat/utilities-macos.git
cd utilities-macos
bash install.sh
```

Chạy script cài xong rồi thì bấm `Reload config` ở item Hammerspoon trên thanh menubar của MacOS

---

## ✨ Sử dụng

Hotkey **Cmd + Shift + H** — Mở menu Help hiển thị tất cả các tính năng và hotkey được config (Ấn vào từng tính năng để ON/OFF)

Hotkey **Cmd + Shift + C** — Mở danh sách text value được sao chép

(Các tính năng đều được cache vào file .json, không bị reset mỗi lần khởi động lại. Mặc định nằm trong `<PATH_INSTALL_HAMMERSPOON>/*.json`)

---

## 📸 Demo

<img src="/assets/preview-help.png" width="600" alt="Preview help">
<img src="/assets/preview-clipboard-manager.png" width="600" alt="Preview clipboard manager">

---

## 📜 License

[MIT License.](https://github.com/letienndat/utilities-macos?tab=MIT-1-ov-file#)