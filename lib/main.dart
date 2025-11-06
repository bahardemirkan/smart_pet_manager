// lib/main.dart
// BIM493 Mobile Programming I – Assignment #2
// Smart Pet Manager App in Flutter (uses local asset images)

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const SmartPetManagerApp());
}

abstract class Friendly {
  String beFriendly();
}

mixin Flyable {
  String fly() => "I can fly high in the sky!";
}

abstract class Pet {
  static int totalPets = 0;

  final String name;
  final int age;
  final String species;
  final String? imageAsset; 

  Pet({required this.name, required this.age, required this.species, this.imageAsset}) {
    Pet.totalPets++;
  }

  Pet.young({required String name, required String species, this.imageAsset})
      : name = name,
        age = 1,
        species = species {
    Pet.totalPets++;
  }

  String makeSound();

  String info() => "${this.name} is a ${this.species} aged ${this.age}";
}

class Dog extends Pet implements Friendly {
  final String breed;

  Dog({required String name, required int age, this.breed = "Mixed", String? imageAsset})
      : super(name: name, age: age, species: "Dog", imageAsset: imageAsset);

  Dog.rescue(String name, {String? imageAsset})
      : breed = "Rescue",
        super(name: name, age: 2, species: "Dog", imageAsset: imageAsset);

  @override
  String makeSound() => "Woof!";

  @override
  String beFriendly() => "Wags tail and brings a toy.";

  String fetch() => "${this.name} is fetching the ball!";
}

class Cat extends Pet implements Friendly {
  final bool indoor;

  Cat({required String name, required int age, this.indoor = true, String? imageAsset})
      : super(name: name, age: age, species: "Cat", imageAsset: imageAsset);

  Cat.kitten(String name, {bool indoor = true, String? imageAsset})
      : indoor = indoor,
        super(name: name, age: 1, species: "Cat", imageAsset: imageAsset);

  @override
  String makeSound() => "Meow~";

  @override
  String beFriendly() => "Purrs and rubs against your leg.";

  String scratch() => "${this.name} is scratching the post.";
}

class Bird extends Pet with Flyable implements Friendly {
  final String color;

  Bird({required String name, required int age, this.color = "Green", String? imageAsset})
      : super(name: name, age: age, species: "Bird", imageAsset: imageAsset);

  Bird.parrot(String name, {String color = "Multi", String? imageAsset})
      : color = color,
        super(name: name, age: 3, species: "Bird", imageAsset: imageAsset);

  @override
  String makeSound() => "Chirp! Chirp!";

  @override
  String beFriendly() => "Sits on your shoulder and whistles.";

  String hop() => "${this.name} is hopping around.";
}

class SmartPetManagerApp extends StatelessWidget {
  const SmartPetManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Pet Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PetHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ---------------------------------------------------
// DEĞİŞİKLİKLER BU SINIFTA BAŞLIYOR
// ---------------------------------------------------

class PetHomePage extends StatefulWidget {
  const PetHomePage({super.key});

  @override
  State<PetHomePage> createState() => _PetHomePageState();
}

class _PetHomePageState extends State<PetHomePage> {
  late final List<Pet> pets;

  @override
  void initState() {
    super.initState();
    
    // `Pet.totalPets`'in her "hot reload"da artmasını önlemek için 
    // sayaç burada sıfırlanır ve liste yeniden oluşturulur.
    Pet.totalPets = 0; 

    pets = [
      Dog(name: "Mina", age: 4, breed: "Golden Retriever", imageAsset: 'assets/images/dog.png'),
      Cat.kitten("Eva", imageAsset: 'assets/images/eva.png'),
      Bird.parrot("Necmi", color: "Blue & White", imageAsset: 'assets/images/necmi.png'),
      Dog.rescue("sherlock", imageAsset: 'assets/images/köpke2.png'),
      Dog(name:"Mühendis", age: 4, imageAsset: "assets/images/çalışkanKöpek.jpeg"),
      Cat(name: "Doktor", age: 3, imageAsset: 'assets/images/doktorKedi.jpeg'),
      Bird(name:"Çavuş", age: 3, imageAsset: "assets/images/bordoBereli.jpeg"),
      Bird(name: "Kriminal Kuşlar", age: 1, imageAsset: "assets/images/KriminalKuşlar.jpeg"),
      Cat(name: "Şaşkaloz", age: 6, imageAsset: "assets/images/şaşkınKedi.jpeg"),
      Dog(name: "Turist Köpekler", age: 4,imageAsset: "assets/images/TuristKöpekler.jpeg"),
      Cat(name: "Kriptonlu", age: 1789, imageAsset: "assets/images/uzaylıKedi.jpeg")

    ];
  }

  @override
  Widget build(BuildContext context) {
    // Evcil hayvanları türlerine göre filtreliyoruz
    final dogs = pets.whereType<Dog>().toList();
    final cats = pets.whereType<Cat>().toList();
    final birds = pets.whereType<Bird>().toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Pet Manager'),
      ),
      body: Column(
        children: [
          Expanded(
            // Orijinal ListView.separated yerine ExpansionTile'ları
            // tutan bir ListView kullanıyoruz.
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [

                // 1. Köpekler Bölümü (İsteğinize göre)
                _buildPetExpansionTile(
                  title: 'Köpekler',
                  icon: FontAwesomeIcons.dog,
                  pets: dogs,
                ),
                
                const SizedBox(height: 10), // Bölümler arasına boşluk

                // 2. Kuşlar Bölümü (İsteğinize göre)
                _buildPetExpansionTile(
                  title: 'Kuşlar',
                  icon: FontAwesomeIcons.dove,
                  pets: birds,
                ),

                const SizedBox(height: 10), // Bölümler arasına boşluk
                
                // 3. Kediler Bölümü (İsteğinize göre)
                _buildPetExpansionTile(
                  title: 'Kediler',
                  icon: FontAwesomeIcons.cat,
                  pets: cats,
                ),


              ],
            ),
          ),
          
          // --- Alt Toplam Bilgisi (Aynı kalıyor) ---
          SafeArea(
            top: false,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Text(
                'Total pets: ${Pet.totalPets}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ExpansionTile (Akordiyon) widget'ı oluşturmak için yardımcı bir metot
  Widget _buildPetExpansionTile({
    required String title,
    required IconData icon,
    required List<Pet> pets,
  }) {
    // Eğer o türde hayvan yoksa, o bölümü hiç gösterme
    if (pets.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2, // Hafif bir gölge
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias, // Card'ın köşelerini içeriğe uygulamak için
      child: ExpansionTile(
        // Başlangıçta kapalı olması için
        initiallyExpanded: false,
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(
          '$title (${pets.length})', // Başlıkta o türden kaç hayvan olduğunu da yazalım
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        
        // Açılınca gösterilecek widget listesi (PetCard'lar)
        children: pets.map((pet) {
          // Kartların kenarlardan biraz içeride olması için Padding ekliyoruz
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: PetCard(pet: pet),
          );
        }).toList(),
      ),
    );
  }
}

// ---------------------------------------------------
// DEĞİŞİKLİKLER BURADA BİTİYOR
// ---------------------------------------------------


// ... (Diğer sınıflar aynı) ...

class PetCard extends StatelessWidget {
  final Pet pet;
  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String specialBehavior(Pet p) {
      if (p is Dog) return p.fetch();
      if (p is Cat) return p.scratch();
      if (p is Bird) return p.fly();
      return '';
    }

    String friendlyAction(Pet p) => (p is Friendly) ? (p as Friendly).beFriendly() : '';

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // 1. DEĞİŞİKLİK: Tüm çocukları (Row, Image, Text) yatayda ortala
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              // 2. DEĞİŞİKLİK: Row'un genişliğini minimuma indir ki
              // Column onu bir bütün olarak ortalayabilsin.
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_iconFor(pet), size: 28, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  '${pet.species}: ${pet.name}',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            if (pet.imageAsset != null) ...[
              const SizedBox(height: 10),
              Center( // Resim zaten Center içindeydi, bu ayarda da düzgün çalışır
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    pet.imageAsset!,
                    height: 200, 
                    width: 200,  
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8),
            Text(pet.info()), // Bu artık ortalanacak
            const SizedBox(height: 8),
            Text('Sound: ${pet.makeSound()}'), // Bu artık ortalanacak
            const SizedBox(height: 8),
            Text('Special: ${specialBehavior(pet)}'), // Bu artık ortalanacak
            const SizedBox(height: 8),
            Text('Friendly: ${friendlyAction(pet)}'), // Bu artık ortalanacak
          ],
        ),
      ),
    );
  }

  IconData _iconFor(Pet pet) {
    if (pet is Dog) return FontAwesomeIcons.dog;
    if (pet is Cat) return FontAwesomeIcons.cat;
    if (pet is Bird) return FontAwesomeIcons.dove;
    return Icons.help_outline;
  }
}
