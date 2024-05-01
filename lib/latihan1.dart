
import 'dart:convert';

void main() {
  // Menyimpan data transkrip
  String jsonTranskrip = '''{
    "nama": "Septiono Raka Wahyu Sasongko",
    "npm": "220820100071",
    "jurusan": "Sistem Informasi",
    "semester": [
      {
        "semester": 1,
        "mata_kuliah": [
          {
            "nama": "Bahasa Inggris",
            "sks": 3,
            "nilai": 3.7
          },
          {
            "nama": "Pancasila",
            "sks": 2,
            "nilai": 4.0
          },
          {
            "nama": "Pengantar Sistem Informasi",
            "sks": 3,
            "nilai": 4.0
          }
        ]
      },
      {
        "semester": 2,
        "mata_kuliah": [
          {
            "nama": "Bahasa Indonesia",
            "sks": 2,
            "nilai": 4.0
          },
          {
            "nama": "Kewarganegaraan",
            "sks": 2,
            "nilai": 4.0
          },
          {
            "nama": "Agama Islam",
            "sks": 2,
            "nilai": 4.0
          }
        ]
      },
      {
        "semester": 3,
        "mata_kuliah": [
          {
            "nama": "Bela Negara",
            "sks": 3,
            "nilai": 4.0
          },
          {
            "nama": "Tata Kelola Teknologi Informasi",
            "sks": 3,
            "nilai": 4.0
          },
          {
            "nama": "Desain Manajemen Jaringan",
            "sks": 3,
            "nilai": 4.0
          }
        ]
      }
    ]
  }''';

  // Decode JSON
  Map<String, dynamic> mhsJson = jsonDecode(jsonTranskrip);

  // Menghitung total SKS dan total nilai semester 1
  int totalSKS1 = 0;
  double totalNilai1 = 0;
  for (var matkul in mhsJson['semester'][0]['mata_kuliah']) {
    int sks = matkul['sks'];
    double nilai = matkul['nilai'];
    totalSKS1 += sks;
    totalNilai1 += sks * nilai;
  }
  // Menghitung IPS semester 1
  double ips1 = totalNilai1 / totalSKS1;

  // Menghitung total SKS dan total nilai semester 2
  int totalSKS2 = 0;
  double totalNilai2 = 0;
  for (var matkul in mhsJson['semester'][1]['mata_kuliah']) {
    int sks = matkul['sks'];
    double nilai = matkul['nilai'];
    totalSKS2 += sks;
    totalNilai2 += sks * nilai;
  }
  // Menghitung IPS semester 2
  double ips2 = totalNilai2 / totalSKS2;

  // Menghitung total SKS dan total nilai semester 3
  int totalSKS3 = 0;
  double totalNilai3 = 0;
  for (var matkul in mhsJson['semester'][2]['mata_kuliah']) {
    int sks = matkul['sks'];
    double nilai = matkul['nilai'];
    totalSKS3 += sks;
    totalNilai3 += sks * nilai;
  }
  // Menghitung IPS semester 3
  double ips3 = totalNilai3 / totalSKS3;

  // Menghitung total IPS
  double totalIPS = (totalNilai1 + totalNilai2 + totalNilai3) / (totalSKS1 + totalSKS2 + totalSKS3);

  // Mencetak informasi transkrip dan IPK
  print('Nama Mahasiswa: ${mhsJson['nama']}');
  print('NPM: ${mhsJson['npm']}');
  print('Jurusan: ${mhsJson['jurusan']}');

  print('IPS Semester 1: ${ips1.toStringAsFixed(2)}');
  print('IPS Semester 2: ${ips2.toStringAsFixed(2)}');
  print('IPS Semester 3: ${ips3.toStringAsFixed(2)}');
  print('IPK TOTAL: ${totalIPS.toStringAsFixed(2)}');
}
