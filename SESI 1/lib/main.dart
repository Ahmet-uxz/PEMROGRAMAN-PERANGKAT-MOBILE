import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter Sesi 1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;

  // Ganti data berikut sesuai identitas
  final String nama = "Ahmat Sapi'i Harahap";
  final String nim = "20240040117";
  final String prodi = "Teknik Informatika";
  final String kelas = "TI 24 G";

  void tambah() {
    setState(() {
      counter++;
    });
  }

  void kurang() {
    if (counter == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Counter tidak boleh di bawah 0"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      counter--;
    });
  }

  void reset() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isEven = counter % 2 == 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PPM Sesi 1 - Ahmat Sapi'i Harahap (20240040117)",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Kartu identitas
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nama,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text("NIM: $nim"),
                          Text("$prodi - $kelas"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              "COUNTER",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 15),

            // Angka counter
            Text(
              "$counter",
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: isEven ? Colors.blue : Colors.red,
              ),
            ),

            const SizedBox(height: 10),

            // Status genap / ganjil
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isEven
                    ? Colors.blue.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isEven ? "Angka Genap" : "Angka Ganjil",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isEven ? Colors.blue : Colors.red,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Tombol + dan -
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 65,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: kurang,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Icon(
                      Icons.remove,
                      size: 30,
                    ),
                  ),
                ),

                const SizedBox(width: 25),

                SizedBox(
                  width: 65,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: tambah,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Tombol Reset
            SizedBox(
              width: 160,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: reset,
                icon: const Icon(Icons.refresh),
                label: const Text(
                  "Reset",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}