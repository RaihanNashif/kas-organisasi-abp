import 'package:flutter/material.dart';
import '../../services/user_service.dart';

class AnggotaContent extends StatefulWidget {
  const AnggotaContent({super.key});

  @override
  State<AnggotaContent> createState() => _AnggotaContentState();
}

class _AnggotaContentState extends State<AnggotaContent> {
  List<dynamic> anggota = [];
  bool isLoading = true;

  final namaController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final alamatController = TextEditingController();
  final noHpController = TextEditingController();
  String selectedRole = 'anggota';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final data = await UserService.getUsers();
      setState(() {
        anggota = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Data Anggota",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showTambahDialog();
                },
                icon: const Icon(Icons.add),
                label: const Text("Tambah"),
              )
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(
                    Colors.green.shade100,
                  ),
                  columns: const [
                    DataColumn(label: Text("Nama")),
                    DataColumn(label: Text("Username")),
                    DataColumn(label: Text("Role")),
                    DataColumn(label: Text("No HP")),
                    DataColumn(label: Text("Aksi")),
                  ],
                  rows: anggota.map((item) {
                    return DataRow(
                      cells: [
                        DataCell(Text(item["nama"] ?? "-")),
                        DataCell(Text(item["username"] ?? "-")),
                        DataCell(Text(item["role"] ?? "-")),
                        DataCell(Text(item["no_hp"] ?? "-")),
                        DataCell(
                          Row(
                            children: [
                              TextButton(
                                onPressed: () => showDetailDialog(item),
                                child: const Text("Detail"),
                              ),
                              TextButton(
                                onPressed: () => showEditDialog(item),
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ),
                              TextButton(
                                onPressed: () => showHapusConfirmDialog(item),
                                child: const Text(
                                  "Hapus",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDetailDialog(dynamic item) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Detail Anggota"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama       : ${item["nama"] ?? "-"}"),
                const SizedBox(height: 8),
                Text("Username   : ${item["username"] ?? "-"}"),
                const SizedBox(height: 8),
                Text("Role       : ${item["role"] ?? "-"}"),
                const SizedBox(height: 8),
                Text("Alamat     : ${item["alamat"] ?? "-"}"),
                const SizedBox(height: 8),
                Text("No HP      : ${item["no_hp"] ?? "-"}"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  void showTambahDialog() {
    namaController.clear();
    usernameController.clear();
    passwordController.clear();
    alamatController.clear();
    noHpController.clear();
    selectedRole = 'anggota';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Tambah Anggota"),
              content: SizedBox(
                width: 400,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: namaController,
                        decoration: const InputDecoration(
                          labelText: "Nama",
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          labelText: "Username",
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedRole,
                        decoration: const InputDecoration(
                          labelText: "Role",
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'superadmin',
                            child: Text('Superadmin'),
                          ),
                          DropdownMenuItem(
                            value: 'admin',
                            child: Text('Admin'),
                          ),
                          DropdownMenuItem(
                            value: 'anggota',
                            child: Text('Anggota'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setStateDialog(() {
                              selectedRole = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: alamatController,
                        decoration: const InputDecoration(
                          labelText: "Alamat",
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: noHpController,
                        decoration: const InputDecoration(
                          labelText: "No HP",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (namaController.text.isEmpty ||
                        usernameController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Nama, Username, dan Password wajib diisi"),
                        ),
                      );
                      return;
                    }

                    bool berhasil = await UserService.tambahUser(
                      nama: namaController.text,
                      username: usernameController.text,
                      password: passwordController.text,
                      role: selectedRole,
                      alamat: alamatController.text,
                      noHp: noHpController.text,
                    );

                    if (berhasil) {
                      Navigator.pop(context);
                      await loadData();
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Anggota berhasil ditambahkan"),
                          ),
                        );
                      }
                    } else {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Gagal menambahkan anggota"),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showEditDialog(dynamic item) {
    namaController.text = item["nama"] ?? "";
    usernameController.text = item["username"] ?? "";
    passwordController.clear(); // Biarkan kosong jika tidak ingin ganti password
    alamatController.text = item["alamat"] ?? "";
    noHpController.text = item["no_hp"] ?? "";
    selectedRole = item["role"] ?? "anggota";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Edit Anggota"),
              content: SizedBox(
                width: 400,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: namaController,
                        decoration: const InputDecoration(
                          labelText: "Nama",
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          labelText: "Username",
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password baru (kosongkan jika tidak diubah)",
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedRole,
                        decoration: const InputDecoration(
                          labelText: "Role",
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'superadmin',
                            child: Text('Superadmin'),
                          ),
                          DropdownMenuItem(
                            value: 'admin',
                            child: Text('Admin'),
                          ),
                          DropdownMenuItem(
                            value: 'anggota',
                            child: Text('Anggota'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setStateDialog(() {
                              selectedRole = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: alamatController,
                        decoration: const InputDecoration(
                          labelText: "Alamat",
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: noHpController,
                        decoration: const InputDecoration(
                          labelText: "No HP",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (namaController.text.isEmpty ||
                        usernameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Nama dan Username wajib diisi"),
                        ),
                      );
                      return;
                    }

                    bool berhasil = await UserService.updateUser(
                      idUsers: item["id_users"].toString(),
                      nama: namaController.text,
                      username: usernameController.text,
                      password: passwordController.text.isNotEmpty
                          ? passwordController.text
                          : null,
                      role: selectedRole,
                      alamat: alamatController.text,
                      noHp: noHpController.text,
                    );

                    if (berhasil) {
                      Navigator.pop(context);
                      await loadData();
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Anggota berhasil diperbarui"),
                          ),
                        );
                      }
                    } else {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Gagal memperbarui anggota"),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showHapusConfirmDialog(dynamic item) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Hapus Anggota"),
          content: Text("Apakah Anda yakin ingin menghapus '${item["nama"]}'?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                bool berhasil = await UserService.hapusUser(item["id_users"].toString());
                if (berhasil) {
                  Navigator.pop(context);
                  await loadData();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Anggota berhasil dihapus"),
                      ),
                    );
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Gagal menghapus anggota"),
                      ),
                    );
                  }
                }
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    alamatController.dispose();
    noHpController.dispose();
    super.dispose();
  }
}
