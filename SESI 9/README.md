# NusaKas

Aplikasi Flutter sederhana untuk mencatat pemasukan dan pengeluaran kas himpunan.

## Fitur

- Menampilkan saldo, total pemasukan, dan total pengeluaran
- Daftar transaksi dengan `ListView`
- Hapus transaksi dengan geser (`Dismissible`)
- Tambah transaksi dengan validasi form (`GlobalKey`)
- Menolak nominal nol atau negatif
- Menolak pengeluaran yang melebihi saldo

## Struktur Project

```
lib/
├── main.dart
├── domain/
│   ├── kas_calculator.dart
│   └── models/transaksi.dart
├── data/
│   └── repositories/transaksi_repository.dart
└── ui/kas/
    ├── kas_view_model.dart
    ├── home_screen.dart
    └── tambah_transaksi_screen.dart
test/
├── unit/kas_calculator_test.dart
└── widget/tambah_transaksi_screen_test.dart
integration_test/
└── app_test.dart
```

## Screenshot Aplikasi

| Home Screen | Tambah Transaksi |
|---|---|
| ![Home Screen](<img width="1209" height="2553" alt="Screenshot_20261119_192517" src="https://github.com/user-attachments/assets/6fa67379-0781-49b6-9221-94daaf7751fd" />
) | ![Tambah Transaksi](<img width="1209" height="2553" alt="Screenshot_20261119_192537" src="https://github.com/user-attachments/assets/125bee55-ff6d-42ec-aac2-d3e7e5cd8989" />
) |

## Hasil Pengujian

### Unit Test dan Widget Test (`flutter test`)

![Hasil flutter test](<img width="957" height="75" alt="Screenshot 2026-11-19 193332" src="https://github.com/user-attachments/assets/33e42043-f715-4adf-93af-4de3289d822f" />
)

### Integration Test (`flutter test integration_test`)

![Hasil integration test](<img width="926" height="283" alt="Screenshot 2026-11-19 193427" src="https://github.com/user-attachments/assets/1c4f11d6-f824-4d48-a045-dfdc1986a495" />
)

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

## Cara Menjalankan Test

```bash
flutter test
flutter test integration_test
```

> Integration test membutuhkan emulator atau HP yang tersambung.
