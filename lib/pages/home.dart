import 'package:flutter/material.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/generar_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 11, 132, 193),
        title: Image.asset(
          'lib/images/virtu.png',
          width: 120,
          fit: BoxFit.cover,
        ),
      ),
      body:Container(
          padding: EdgeInsets.all(30.0),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GenerarVisita()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 11, 132, 193),
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Generar visita",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 11, 132, 193),
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.view_list,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Visualizar elementos",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 11, 132, 193),
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Validar datos",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      )
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
// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   //Sign Out User
//   Future<void> signOut() async {
//     await supabase.auth.signOut();
//     if (!mounted) return;
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  LoginPage()));
//   }

//   final noteStream = supabase.from('notes').stream(primaryKey: ['id']);

//   //Create Note
//   Future<void> createNote(String note) async {
//     await supabase.from('notes').insert({'body': note});
//   }

//   // Update Note
//   Future<void> updateNote(String noteId, String updatedNote) async {
//     await supabase.from('notes').update({'body': updatedNote}).eq('id', noteId);
//   }

//   // Delete Note
//   Future<void> deleteNote(String noteId) async {
//     await supabase.from('notes').delete().eq('id', noteId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Notes"),
//         actions: [
//           IconButton(
//             onPressed: signOut,
//             icon: const Icon(Icons.logout_outlined),
//           )
//         ],
//         automaticallyImplyLeading: false,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return SimpleDialog(
//                   title: const Text('Add a note'),
//                   children: [
//                     TextFormField(
//                       onFieldSubmitted: (value) {
//                         createNote(value);
//                         if (mounted) Navigator.pop(context);
//                       },
//                     )
//                   ],
//                 );
//               });
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: StreamBuilder(
//         stream: noteStream,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           final notes = snapshot.data!;

//           return ListView.builder(
//             itemCount: notes.length,
//             itemBuilder: (context, index) {
//               final note = notes[index];
//               final noteId = note['id'].toString();

//               return ListTile(
//                 title: Text(note['body']),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return SimpleDialog(
//                               title: const Text('Edit a note'),
//                               children: [
//                                 TextFormField(
//                                   initialValue: note['body'],
//                                   onFieldSubmitted: (value) async {
//                                     await updateNote(noteId, value);
//                                     if (mounted) Navigator.pop(context);
//                                   },
//                                 )
//                               ],
//                             );
//                           },
//                         );
//                       },
//                       icon: const Icon(Icons.edit),
//                     ),
//                     IconButton(
//                       onPressed: () async {
//                         bool deletedConfirmed = await showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               title: const Text('Delete note'),
//                               content: const Text('Are you sure you want to delete this note?'),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.pop(context, false);
//                                   },
//                                   child: const Text('Cancel'),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.pop(context, true);
//                                   },
//                                   child: const Text('Delete'),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                         if (deletedConfirmed) {
//                           await deleteNote(noteId);
//                         }
//                       },
//                       icon: const Icon(Icons.delete),
//                     )
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }