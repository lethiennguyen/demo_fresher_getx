# 📱 Demo Fresher GetX

Ứng dụng Flutter demo dành cho fresher, áp dụng kiến trúc **Clean Architecture** kết hợp **GetX** (state management, routing, DI). Dự án được xây dựng theo tuần với mục tiêu học tập và thực hành từng layer rõ ràng.

---

## 🎯 Mục tiêu tuần

| Tuần | Mục tiêu |
|------|-----------|
| **Tuần 1** | Setup dự án, cấu hình FVM, GetX, Hive, cấu trúc thư mục Clean Architecture |
| **Tuần 2** | Xây dựng base layer: `BaseController`, `BaseRepository`, `BaseUseCase`, `BaseResponse`, xử lý API với Dio |
| **Tuần 3** | Implement tính năng **Login**: UI, validation, call API, lưu session bằng Hive, hỗ trợ offline login |
| **Tuần 4** | Implement tính năng **Home**: danh sách sản phẩm (phân trang, pull-to-refresh), danh sách category, xoá sản phẩm/category |
| **Tuần 5** | Implement tính năng **Detail & Image Picker**: xem chi tiết sản phẩm, chụp/chọn ảnh, upload lên Cloudinary |

---

## 🏗️ Kiến trúc

Dự án áp dụng **Clean Architecture** theo 3 layer cho mỗi feature:

```
lib/
├── main.dart                    # Entrypoint, khởi tạo Hive, GetX
├── core/
│   ├── base/                    # BaseController, BaseRepository, BaseUseCase, BaseResponse, BaseMapper
│   ├── router/                  # AppRouter (route names), RouterPage (GetPage list), AppBinding
│   └── values/                  # App-wide values
├── feature/
│   ├── app/                     # SplashPage, AppBinding
│   ├── login/                   # Tính năng đăng nhập
│   │   ├── data/                # Model, DataSource (Dio), RepositoryImpl
│   │   ├── domain/              # Entity, Repository interface, UseCase
│   │   ├── mapper/              # Request/Response mapper
│   │   └── presentation/        # Page, Controller, Binding, Component
│   ├── home/                    # Danh sách sản phẩm & category
│   │   ├── data/
│   │   ├── domain/
│   │   ├── mapper/
│   │   └── presentation/
│   ├── detail/                  # Chi tiết sản phẩm
│   │   ├── data/
│   │   ├── domain/
│   │   ├── mapper/
│   │   └── presentation/
│   └── image_picker_load/       # Chụp/chọn ảnh, upload Cloudinary
├── shared/
│   ├── constants/               # ApiUrl, AppConst, AppDimens, AppTextStyle
│   ├── themes/                  # AppColors, ThemeData
│   ├── utils/                   # Helper utilities
│   ├── widgets/                 # Shared widgets tái sử dụng
│   ├── model/                   # Shared models
│   ├── exceptions/              # Exception handling
│   └── mappers/                 # Shared mappers
└── generated/
    └── locales.g.dart           # Auto-generated i18n keys
```

### Luồng data trong mỗi Feature

```
UI (Page/Widget)
    │
    ▼
Controller (GetxController)
    │
    ▼
UseCase (Business Logic)
    │
    ▼
Repository (Interface)
    │
    ▼
DataSource Impl (Dio + Hive)
    │
    ├──► REST API  (backend: http://192.168.1.29:8080/api/v1/)
    └──► Hive DB   (local cache / offline)
```

---

## 📦 Các thư viện chính

| Thư viện | Mục đích |
|----------|----------|
| `get` | State management, routing, dependency injection |
| `dio` | HTTP client, gọi REST API |
| `hive` + `hive_flutter` | Local storage, offline login session |
| `envied` | Quản lý biến môi trường (.env) |
| `syncfusion_flutter_charts` | Biểu đồ |
| `flutter_svg` | Hiển thị SVG icons |
| `camera` + `image_picker` | Chụp/chọn ảnh |
| `bot_toast` | Toast/notification UI |
| `skeletonizer` + `shimmer` | Loading skeleton |
| `carousel_slider` | Carousel UI |
| `google_fonts` | Font Nunito Sans |
| `intl` | Định dạng ngày, số, tiền tệ |
| `pull_to_refresh` | Pull-to-refresh danh sách |

---

## ⚙️ Cách chạy dự án

### Yêu cầu

- **Flutter SDK**: `^3.6.2` (quản lý qua FVM)
- **FVM** (Flutter Version Manager): [https://fvm.app](https://fvm.app)
- **Backend API** đang chạy tại `http://192.168.1.29:8080/api/v1/` (hoặc cập nhật `ApiUrl.baseUrl`)
- **Cloudinary account** (nếu dùng tính năng upload ảnh)

### Bước 1 – Cài đặt FVM & Flutter version

```bash
# Cài FVM (nếu chưa có)
dart pub global activate fvm

# Cài Flutter version theo dự án
fvm install

# Dùng Flutter version của dự án
fvm use
```

### Bước 2 – Cài dependencies

```bash
fvm flutter pub get
```

### Bước 3 – Cấu hình môi trường

Dự án dùng `envied` để quản lý biến môi trường. Tạo file `.env` ở root:

```env
# .env
BASE_URL=http://192.168.1.29:8080/api/v1/
CLOUDINARY_UPLOAD_URL=https://api.cloudinary.com/v1_1/dh5rrukew/image/upload
```

> **Lưu ý**: Nếu chưa có file `.env.dart` generated, chạy:
> ```bash
> fvm flutter pub run build_runner build --delete-conflicting-outputs
> ```

### Bước 4 – Chạy ứng dụng

```bash
fvm flutter run
```

### Sample Data (test đăng nhập)

Dùng tài khoản mẫu sau để test login (cần backend đang chạy):

```
Username: cuongpc
Password: 123456
```

---

## 🔄 Flow chính

### 1. Splash → Login → Home

```
App khởi động
    │
    ▼
SplashPage (/splash)
    │── Kiểm tra session Hive
    │     ├── Có session → /home
    │     └── Không có   → /login
    ▼
LoginPage (/login)
    │── Nhập username + password
    │── Validate input (empty check, format)
    │── POST /api/v1/login
    │     ├── Thành công → Lưu token vào Hive → /home
    │     └── Thất bại   → Hiển thị lỗi (BotToast)
    │── Offline login: match dữ liệu cache trong Hive
    ▼
HomePage (/home)
    │── GET /api/v1/products   (phân trang, pull-to-refresh)
    │── GET /api/v1/categories
    │── DELETE /api/v1/products/{id}  (xoá sản phẩm)
    │── DELETE /api/v1/categories/{id}
    │── PUT /api/v1/categories/{id}   (cập nhật category)
    ▼
DetailProductPage (/detail)
    │── Hiển thị chi tiết sản phẩm
    │── Chụp / chọn ảnh (Camera / Gallery)
    │── Upload ảnh lên Cloudinary
```

### 2. Xử lý API (Base Layer)

```
Controller.callApi()
    │
    ▼
UseCase.execute(entity)
    │
    ▼
Repository.method(entity)
    │
    ▼
BaseRepositoryCl.baseCallApi()  ← Dio interceptor (token, timeout, error handling)
    │
    ▼
ApiResponse / ApiResponseList   ← Parse JSON, check code "00" = success
    │
    ├── Success → return data to Controller
    └── Error   → throw AppException → Controller hiển thị lỗi
```

---

## 🌐 Localization

Dự án hỗ trợ đa ngôn ngữ qua GetX Translations. Mặc định: **Tiếng Việt (vi_VN)**.

- File dịch: `assets/locales/`
- Generated keys: `lib/generated/locales.g.dart`

Chi tiết xem: [README_locales.md](README_locales.md)

---

## 🗂️ Cấu trúc Assets

```
assets/
├── icons/        # SVG/PNG icons
├── icons/empty/  # Empty state illustrations
├── images/       # Hình ảnh chung
└── locales/      # File ngôn ngữ (vi.json, en.json, ...)
```

Chi tiết xem: [README_image.md](README_image.md)

---

## 👨‍💻 Tác giả

Dự án được phát triển bởi team **SoftDreams** dành cho chương trình đào tạo fresher Flutter.
