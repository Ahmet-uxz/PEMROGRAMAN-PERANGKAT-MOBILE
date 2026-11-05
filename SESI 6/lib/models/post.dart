
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  // Data pengumuman dalam bahasa Indonesia
  static const Map<int, Map<String, String>> pengumuman = {
    1: {
      'title': 'Informasi Jadwal Perkuliahan',
      'body': 'Diberitahukan kepada seluruh mahasiswa bahwa jadwal perkuliahan semester ini sudah dapat dilihat. Silakan periksa jadwal masing-masing melalui sistem akademik.',
    },
    2: {
      'title': 'Pengumuman Libur Perkuliahan',
      'body': 'Kegiatan perkuliahan akan diliburkan sesuai dengan kalender akademik universitas. Mahasiswa diharapkan memperhatikan informasi jadwal masuk kembali.',
    },
    3: {
      'title': 'Jadwal Ujian Akhir Semester',
      'body': 'Ujian Akhir Semester akan segera dilaksanakan. Seluruh mahasiswa diharapkan mempersiapkan diri dan memperhatikan jadwal ujian yang telah ditentukan.',
    },
    4: {
      'title': 'Informasi Pembayaran UKT',
      'body': 'Pembayaran Uang Kuliah Tunggal sudah dapat dilakukan sesuai jadwal yang telah ditentukan. Silakan melakukan pembayaran melalui kanal resmi universitas.',
    },
    5: {
      'title': 'Kegiatan Seminar Teknologi',
      'body': 'Universitas akan menyelenggarakan seminar teknologi yang membahas perkembangan dunia digital dan teknologi informasi. Seluruh mahasiswa dipersilakan untuk mengikuti kegiatan ini.',
    },
    6: {
      'title': 'Pendaftaran Organisasi Mahasiswa',
      'body': 'Pendaftaran anggota baru organisasi mahasiswa telah dibuka. Bagi mahasiswa yang berminat dapat segera melakukan pendaftaran sesuai ketentuan.',
    },
    7: {
      'title': 'Informasi Beasiswa Mahasiswa',
      'body': 'Tersedia informasi program beasiswa bagi mahasiswa yang memenuhi persyaratan. Silakan menghubungi bagian kemahasiswaan untuk informasi lebih lanjut.',
    },
    8: {
      'title': 'Jadwal Kegiatan Kampus',
      'body': 'Berikut informasi kegiatan kampus yang akan dilaksanakan dalam waktu dekat. Seluruh mahasiswa diharapkan mengikuti kegiatan sesuai jadwal.',
    },
    9: {
      'title': 'Pengumuman Praktikum',
      'body': 'Mahasiswa yang mengikuti kegiatan praktikum diharapkan mempersiapkan perlengkapan dan mengikuti arahan dosen pengampu.',
    },
    10: {
      'title': 'Informasi Kegiatan Mahasiswa',
      'body': 'Universitas mengajak seluruh mahasiswa untuk berpartisipasi dalam berbagai kegiatan akademik maupun nonakademik guna meningkatkan pengalaman dan kemampuan mahasiswa.',
    },
  };

  // Mengubah JSON menjadi objek Post
  factory Post.fromJson(Map<String, dynamic> json) {
    final int postId = json['id'];

    final dataIndonesia = pengumuman[postId];

    return Post(
      id: postId,
      userId: json['userId'],
      title: dataIndonesia?['title'] ?? json['title'],
      body: dataIndonesia?['body'] ?? json['body'],
    );
  }

  // Mengubah objek Post menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}
