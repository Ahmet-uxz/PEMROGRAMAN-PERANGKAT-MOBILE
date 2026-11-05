
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';
import 'detail_screen.dart';
import 'add_post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostService service = PostService();

  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();

    // Mengambil data saat halaman pertama dibuka
    futurePosts = service.getPosts();
  }

  // Memuat ulang data
  Future<void> refreshPosts() async {
    setState(() {
      futurePosts = service.getPosts();
    });

    await futurePosts;
  }

  // Membuka halaman tambah pengumuman
  Future<void> openAddPost() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddPostScreen(),
      ),
    );

    if (!mounted) return;

    if (result != null && result is Post) {
      setState(() {
        futurePosts = service.getPosts();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengumuman berhasil dibuat!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7FC),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        title: const Text(
          'NusaInfo',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: openAddPost,
            icon: const Icon(Icons.add, size: 30),
          ),
        ],
      ),

      body: FutureBuilder<List<Post>>(
        future: futurePosts,

        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.wifi_off,
                      size: 65,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Gagal Memuat Pengumuman',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Periksa koneksi internet kamu, '
                          'kemudian coba lagi.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          futurePosts = service.getPosts();
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final posts = snapshot.data ?? [];

          // Data kosong
          if (posts.isEmpty) {
            return const Center(
              child: Text('Belum ada pengumuman'),
            );
          }

          // Daftar pengumuman
          return RefreshIndicator(
            onRefresh: refreshPosts,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: posts.length,

              itemBuilder: (context, index) {
                final post = posts[index];

                return Card(
                  color: const Color(0xFFF7F1FA),
                  elevation: 2,
                  margin: const EdgeInsets.only(
                    bottom: 15,
                    left: 5,
                    right: 5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),

                    // Nomor pengumuman
                    leading: CircleAvatar(
                      radius: 27,
                      backgroundColor: const Color(0xFFEADDFF),
                      child: Text(
                        '${post.id}',
                        style: const TextStyle(
                          color: Color(0xFF59408C),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Judul dan isi
                    title: Text(
                      post.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        post.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    trailing: const Icon(
                      Icons.chevron_right,
                      size: 30,
                    ),

                    // Membuka detail pengumuman
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailScreen(post: post);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),

      // Tombol tambah pengumuman
      floatingActionButton: FloatingActionButton(
        onPressed: openAddPost,
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
