# Watch

Ứng dụng xem phim được xây dựng bằng Flutter và Dart. Watch hỗ trợ khám phá phim, xem theo tập, lưu phim yêu thích, theo dõi lịch sử và tạo phòng xem chung với bạn bè.

Tên package: `movie_app` · Phiên bản: `1.0.0+1`.

## Tính năng

- Khám phá phim, xem thông tin chi tiết, diễn viên và danh sách tập.
- Tìm kiếm theo từ khóa, thể loại, quốc gia và năm phát hành.
- Phát video bằng Better Player Plus.
- Lưu phim yêu thích, lịch sử tìm kiếm và lịch sử xem trên thiết bị.
- Đăng ký, đăng nhập bằng email và mật khẩu, gửi email đặt lại mật khẩu.
- Cập nhật tên, email và ảnh đại diện.
- Đăng và xóa bình luận phim.
- Tạo phòng xem chung, tìm người dùng để mời, nhận và chấp nhận lời mời; đồng bộ trạng thái phát, vị trí xem và tốc độ qua Firestore.
- Tải video bằng FFmpeg qua dịch vụ chạy nền và lưu vào thư viện thiết bị.

## Công nghệ

| Thành phần | Thư viện / dịch vụ |
| --- | --- |
| Giao diện | Flutter, Lottie, Rive |
| Quản lý trạng thái | Flutter BLoC / Cubit |
| Điều hướng | GoRouter |
| Dependency injection | GetIt, Injectable |
| Gọi API | Dio, interceptor thử lại yêu cầu |
| Lưu trữ cục bộ | Isar Community, SharedPreferences |
| Tài khoản và dữ liệu thời gian thực | Firebase Authentication, Cloud Firestore |
| Ảnh đại diện | Image Picker, Cloudinary |
| Video và tải xuống | Better Player Plus, FFmpeg Kit, Flutter Foreground Task, Gal |

## Yêu cầu môi trường

- Flutter SDK có Dart tương thích với ràng buộc `^3.10.3` trong `pubspec.yaml`.
- Android Studio / Android SDK và thiết bị Android hoặc trình giả lập để chạy trên Android. Cấu hình Android hiện sử dụng Java 17.
- Nếu chạy iOS: máy macOS, Xcode và môi trường build iOS phù hợp.
- API phim tương thích với các endpoint trong `MovieApi.dart`, một dự án Firebase và tài khoản Cloudinary.

Repository có thư mục cho Android, iOS, web và desktop. Các tính năng dùng plugin native cần được kiểm tra riêng trên nền tảng đích; sự có mặt của thư mục nền tảng không đảm bảo toàn bộ tính năng hoạt động. Firebase hiện chưa được cấu hình cho Linux.

## Cài đặt và cấu hình

### 1. Cài dependency

Mở terminal tại thư mục gốc dự án:

```sh
flutter doctor
flutter pub get
```

### 2. Cấu hình biến môi trường

Tạo file `.env` ở thư mục gốc, cùng cấp với `pubspec.yaml`:

```dotenv
BASE_URL=https://your-movie-api.example
CLOUD_NAME=your_cloudinary_cloud_name
UPLOAD_PRESET=your_cloudinary_upload_preset
```

| Biến | Ý nghĩa |
| --- | --- |
| `BASE_URL` | URL gốc của API phim, không bao gồm đường dẫn endpoint |
| `CLOUD_NAME` | Cloud name của tài khoản Cloudinary |
| `UPLOAD_PRESET` | Upload preset dùng để tải ảnh đại diện lên Cloudinary |

Thay các giá trị mẫu bằng cấu hình thực tế. Cloudinary cần upload preset cho phép upload từ client theo cách sử dụng `CloudinaryPublic` trong dự án.

Ứng dụng đọc `.env` khi khởi động và đã khai báo file này trong danh sách assets. File được bỏ qua bởi Git nhưng vẫn được đóng gói vào ứng dụng; chỉ đặt cấu hình dành cho client tại đây, không đặt API secret hoặc thông tin quản trị.

API cần trả dữ liệu theo các DTO hiện có. Các endpoint được sử dụng:

```text
/v1/api/danh-sach
/v1/api/tim-kiem
/v1/api/the-loai
/v1/api/the-loai/{slug}
/v1/api/quoc-gia
/v1/api/quoc-gia/{slug}
/v1/api/nam/{year}
/v1/api/phim/{slug}
/v1/api/phim/{slug}/peoples
/nam-phat-hanh
```

### 3. Cấu hình Firebase

Repository đã có `lib/firebase_options.dart` và cấu hình FlutterFire. Nếu sử dụng dự án Firebase của riêng bạn:

1. Tạo hoặc chọn dự án trong Firebase Console.
2. Bật phương thức đăng nhập **Email/Password** trong Authentication.
3. Tạo Cloud Firestore; cấu hình quy tắc truy cập cho các collection `users`, `comments` và `rooms` theo luồng xác thực và quyền của ứng dụng.
4. Cài FlutterFire CLI và tạo lại cấu hình từ thư mục gốc:

   ```sh
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

Đăng nhập Firebase CLI trước khi cấu hình nếu công cụ yêu cầu. Bảo đảm cấu hình Firebase của nền tảng đích, bao gồm `android/app/google-services.json` khi chạy Android, trỏ đến cùng dự án với `lib/firebase_options.dart`.

### 4. Chạy ứng dụng

```sh
flutter devices
flutter run -d <device-id>
```

Thay `<device-id>` bằng ID thiết bị từ `flutter devices`. Khi sử dụng tải phim, cấp các quyền mà ứng dụng yêu cầu, chẳng hạn thông báo và truy cập thư viện.

## Cấu trúc mã nguồn

```text
lib/
├── main.dart                 # Điểm vào ứng dụng
├── firebase_options.dart     # Cấu hình Firebase theo nền tảng
├── core/
│   ├── colors/               # Màu sắc dùng chung
│   ├── di/                   # Đăng ký dependency và các module dịch vụ
│   └── routes/               # Cấu hình điều hướng
├── features/
│   ├── auth/                 # Đăng nhập, đăng ký, đặt lại mật khẩu
│   ├── movie/                # Khám phá, tìm kiếm, xem, tải phim, phòng xem chung
│   └── profile/              # Hồ sơ, phim yêu thích, lịch sử xem
└── utils/                    # Hằng số, extension và tiện ích
assets/                       # Hình ảnh, animation Lottie và Rive
test/                         # Kiểm thử Flutter
```

Mã nguồn được tổ chức theo tính năng, mỗi tính năng chia thành ba lớp:

- `presentation`: màn hình, widget và quản lý trạng thái BLoC / Cubit.
- `domain`: model, hợp đồng repository và use case.
- `data`: triển khai repository, nguồn dữ liệu local / remote, DTO và mapper.

## Lệnh phát triển

Tạo lại mã Injectable và Isar sau khi thay đổi đăng ký dependency hoặc entity:

```sh
dart run build_runner build --delete-conflicting-outputs
```

Phân tích mã và chạy kiểm thử:

```sh
flutter analyze
flutter test
```

`test/widget_test.dart` hiện vẫn là bài kiểm thử bộ đếm mặc định của Flutter, chưa phù hợp với giao diện Watch và chưa khởi tạo các dependency cần thiết cho `MyApp`. Cần cập nhật bài kiểm thử này trước khi dùng kết quả để đánh giá chức năng ứng dụng.

Build APK để thử nghiệm trên Android:

```sh
flutter build apk --release
```

APK được tạo tại `build/app/outputs/flutter-apk/app-release.apk`. Cấu hình release hiện dùng khóa ký debug trong `android/app/build.gradle.kts`; cần thiết lập khóa ký phát hành riêng trước khi phân phối chính thức.
