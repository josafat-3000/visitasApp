import 'package:flutter/material.dart';
import 'package:app/pages/login_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 81, 121),
        title: Image.asset(
          'lib/images/virtu.png',
          width: 120,
          fit: BoxFit.cover,
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 0, 81, 121),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons
                            .calendar_month_rounded, // calendar_badge_plus icon
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        "Generar visita",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 0, 81, 121),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.view_list,
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        "Visualizar elementos",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 0, 81, 121),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons
                            .check, // calendar_badge_plus icon
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        "Validar datos",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ],
            
          ),
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