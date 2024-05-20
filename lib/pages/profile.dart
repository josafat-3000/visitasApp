import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String userUUID;
  final String userEmail;

  const ProfilePage({
    Key? key,
    required this.userName,
    required this.userUUID,
    required this.userEmail,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    try {
      final fileName = 'profile_pictures/${widget.userUUID}.jpg';
      
      final response = await Supabase.instance.client
          .storage
          .from('foto')
          .createSignedUrl(fileName, 60);

      if (response.isNotEmpty) {
        setState(() {
          _profileImageUrl = response;
        });
      } else {
        print('No se encontró la imagen');
      }
    } catch (e) {
      print('Error al cargar la imagen de perfil: $e');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      await _uploadImage(_imageFile!);
    }
  }

  Future<void> _uploadImage(File image) async {
    try {
      final fileName = 'profile_pictures/${widget.userUUID}.jpg';

      final response = await Supabase.instance.client.storage
          .from('foto')
          .upload(fileName, image, fileOptions: const FileOptions(cacheControl: '3600', upsert: false));

      if (response.isEmpty) {
        print('Imagen subida correctamente');
        await _loadProfileImage();
      } else {
        print('Error al subir imagen: ');
      }
    } catch (e) {
      print('Error al subir imagen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Acción al presionar el botón de editar
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImageUrl != null
                      ? NetworkImage(_profileImageUrl!)
                      : null,
                  child: _profileImageUrl == null
                      ? Icon(Icons.person, size: 50)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      await _pickImage(ImageSource.gallery);
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Datos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person, color: const Color.fromARGB(255, 0, 81, 121)),
                      title: Text(
                        'Nombre',
                        style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 81, 121)),
                      ),
                      subtitle: Text(widget.userName),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.key, color: const Color.fromARGB(255, 0, 81, 121)),
                      title: Text(
                        'Usuario',
                        style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 81, 121)),
                      ),
                      subtitle: Text(widget.userUUID),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.email, color: const Color.fromARGB(255, 0, 81, 121)),
                      title: Text(
                        'Correo',
                        style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 81, 121)),
                      ),
                      subtitle: Text(widget.userEmail),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
