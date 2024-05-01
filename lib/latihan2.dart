import 'package:flutter/material.dart'; // Package untuk membuat UI Flutter
import 'package:http/http.dart' as http; // Package untuk membuat HTTP requests
import 'dart:convert'; // Package untuk mengonversi data

void main() {
  runApp(const MyApp());
}

// Menampung data hasil pemanggilan API
class Activity {
  String aktivitas; // Aktivitas yang diperoleh dari API
  String jenis; // Jenis aktivitas yang diperoleh dari API

  Activity({required this.aktivitas, required this.jenis}); // Constructor

  // Mapping dari JSON ke atribut objek Activity
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      aktivitas: json['activity'],
      jenis: json['type'],
    );  
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  late Future<Activity> futureActivity; // Menampung hasil dari pemanggilan API

  // late Future<Activity>? futureActivity;
  String url = "https://www.boredapi.com/api/activity";

  Future<Activity> init() async {
    return Activity(aktivitas: "", jenis: ""); // Inisialisasi futureActivity
  }

  // Fungsi untuk mengambil data dari API
  Future<Activity> fetchData() async {
    final response = await http.get(Uri.parse(url)); // Melakukan HTTP GET request ke API
    if (response.statusCode == 200) {
      // Jika server merespons dengan kode status 200 OK (berhasil),
      // parse JSON dan kembalikan objek Activity
      return Activity.fromJson(jsonDecode(response.body));
    } else {
      // Jika terjadi kesalahan (kode status bukan 200 OK),
      // lemparkan exception dengan pesan "Gagal load"
      throw Exception('Gagal load');
    }
  }

  @override
  void initState() {
    super.initState();
    futureActivity = init(); // Inisialisasi futureActivity pada initState
  }

  @override
  Widget build(Object context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      futureActivity = fetchData(); // Memperbarui futureActivity dengan hasil pemanggilan API terbaru
                    });
                  },
                  child: Text("Saya bosan ..."),
                ),
              ),
              // Widget FutureBuilder untuk menampilkan hasil pemanggilan API
              FutureBuilder<Activity>(
                future: futureActivity,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // Jika data telah tersedia, tampilkan aktivitas dan jenisnya
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snapshot.data!.aktivitas), // Tampilkan aktivitas
                          Text("Jenis: ${snapshot.data!.jenis}") // Tampilkan jenis aktivitas
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // Jika terjadi kesalahan, tampilkan pesan kesalahan
                    return Text('${snapshot.error}');
                  }
                  // Default: tampilkan indikator loading (CircularProgressIndicator)
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}