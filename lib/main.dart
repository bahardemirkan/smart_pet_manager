// lib/main.dart
// BIM493 Mobile Programming I – Assignment #2
// Smart Pet Manager App in Flutter (uses local asset images)
// GÜNCELLEME: Davranışlar artık Constructor (Kurucu Metot) üzerinden
// "Dependency Injection" ile enjekte ediliyor.

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const SmartPetManagerApp());
}
abstract class Pet {
  static int totalPets = 0;

  final String name;
  final int age;
  final String species;
  final String? imageAsset;
  final String sound;
  final String friendlyBehavior;
  final String specialAction;


  Pet({
    required this.name,
    required this.age,
    required this.species,
    this.imageAsset,
    required this.sound,
    required this.friendlyBehavior,
    required this.specialAction,
  }) {
    Pet.totalPets++;
  }

  Pet.young({
    required String name,
    required String species,
    this.imageAsset,
    required this.sound,
    required this.friendlyBehavior,
    required this.specialAction,
  })  : name = name,
        age = 1,
        species = species {
    Pet.totalPets++;
  }

  String info() => "${this.name} is a ${this.species} aged ${this.age}";
}

class Dog extends Pet {
  final String breed;

  Dog({
    required String name,
    required int age,
    this.breed = "Mixed",
    String? imageAsset,
    String? customSound,
    String? customFriendly,
    String? customSpecial,
  }) : super(
          name: name,
          age: age,
          species: "Dog",
          imageAsset: imageAsset,
          sound: customSound ?? "Woof!",
          friendlyBehavior: customFriendly ?? "Wags tail and brings a toy.",
          specialAction: customSpecial ?? "$name is fetching the ball!",
        );

  Dog.rescue(
    String name, {
    String? imageAsset,
    String? customSpecial,
  })  : breed = "Rescue",
        super(
          name: name,
          age: 2,
          species: "Dog",
          imageAsset: imageAsset,
          
          sound: "Woof! (Rescued!)",
          friendlyBehavior: "Rubs thankfully against your leg.",
          specialAction: customSpecial ?? "$name is happy to be safe!",
        );
}

class Cat extends Pet {
  final bool indoor;

  Cat({
    required String name,
    required int age,
    this.indoor = true, 
    String? imageAsset,
    String? customSound,
    String? customFriendly,
    String? customSpecial,
  }) : 
        super(
          name: name,
          age: age,
          species: "Cat",
          imageAsset: imageAsset,
          sound: customSound ?? "Meow~",
          friendlyBehavior: customFriendly ?? "Purrs and rubs against your leg.",
          specialAction: customSpecial ?? "$name is scratching the post.",
        );

  Cat.kitten({
    required String name,
    this.indoor = true, 
    String? imageAsset,
    String? customSpecial,
  }) : 
        super.young(
          name: name,
          species: "Cat",
          imageAsset: imageAsset,
          sound: "Mew!",
          friendlyBehavior: "Plays with a string.",
          specialAction: customSpecial ?? "$name is chasing a toy mouse.",
        );
}


class Bird extends Pet {
  final String color;

  Bird({
    required String name,
    required int age,
    this.color = "Green", 
    String? imageAsset,
    String? customSound,
    String? customFriendly,
    String? customSpecial,
  }) : 
        super(
          name: name,
          age: age,
          species: "Bird",
          imageAsset: imageAsset,
          sound: customSound ?? "Chirp! Chirp!",
          friendlyBehavior:
              customFriendly ?? "Sits on your shoulder and whistles.",
          specialAction: customSpecial ?? "I can fly high in the sky!",
        );

  Bird.parrot({
    required String name, 
    this.color = "Multi",  
    String? imageAsset,
    String? customSpecial,
  }) : 
        super(
          name: name,
          age: 3,
          species: "Bird",
          imageAsset: imageAsset,
          sound: "Polly wants a cracker!",
          friendlyBehavior: "Mimics your voice.",
          specialAction: customSpecial ?? "$name is talking!",
        );
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

    Pet.totalPets = 0;

    pets = [
      Dog(
        name: "Mina",
        age: 4,
        breed: "Golden Retriever",
        imageAsset: 'assets/images/dog.png',
        customSpecial: "Mina can catch the ball in the air!",
      ),
      Cat.kitten(
        name: "Eva", 
        imageAsset: 'assets/images/eva.png',
        customSpecial: "Eva is sleeping on the keyboard.",
      ),
      Bird.parrot(
        name: "Necmi", 
        color: "Blue & White",
        imageAsset: 'assets/images/necmi.png',
        customSpecial: "Necmi is swearing in Turkish!",
      ),
      Dog.rescue(
        "Sherlock", 
        imageAsset: 'assets/images/kopke2.png',
      ),
      Dog(
        name: "Engineer",
        age: 4,
        imageAsset: "assets/images/caliskankopek.jpeg",
        customSound: "Working on it",
        customFriendly: "dont touch me, dont talk to me",
        customSpecial: "Engineer want to drink yellow cola."
      ),
      Cat(
        name: "Doctor",
        age: 3,
        imageAsset: 'assets/images/doktorKedi.jpeg',
        customSound: "drink water"
      ),
      Bird(
        name: "Captain",
        age: 3,
        imageAsset: "assets/images/bordoBereli.jpeg",
        customSpecial: "Captain is on patrol.",
        customFriendly: "Gives a sharp salute.",
      ),
      Bird(
        name: "Criminal Birds",
        age: 1,
        imageAsset: "assets/images/KriminalKuslar.jpeg",
        customSound: "give me the money!",
        customSpecial: "Criminal Birds is investigating a crime scene.",
      ),
      Cat(
        name: "Shocked",
        age: 6,
        imageAsset: "assets/images/şaşkınKedi.jpeg",
        
      ),
      Dog(
        name: "Tourist Dogs",
        age: 4,
        imageAsset: "assets/images/TuristKöpekler.jpeg",
        customSpecial: "Tourist dogs is taking a selfie.",
      ),
      Cat(
        name: "kryptonian",
        age: 1789,
        imageAsset: "assets/images/uzaylıKedi.jpeg",
        customSound: "Zorp~",
        customFriendly: "Telepathically projects friendship.",
        customSpecial: "Kriptonlu is levitating.",
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
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
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _buildPetExpansionTile(
                  title: 'Dogs',
                  icon: FontAwesomeIcons.dog,
                  pets: dogs,
                ),
                const SizedBox(height: 10),
                _buildPetExpansionTile(
                  title: 'Birds',
                  icon: FontAwesomeIcons.dove,
                  pets: birds,
                ),
                const SizedBox(height: 10),
                _buildPetExpansionTile(
                  title: 'Cats',
                  icon: FontAwesomeIcons.cat,
                  pets: cats,
                ),
              ],
            ),
          ),
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

  Widget _buildPetExpansionTile({
    required String title,
    required IconData icon,
    required List<Pet> pets,
  }) {
    if (pets.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: false,
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(
          '$title (${pets.length})',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        children: pets.map((pet) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: PetCard(pet: pet),
          );
        }).toList(),
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final Pet pet;
  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_iconFor(pet), size: 28, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  '${pet.species}: ${pet.name}',
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            if (pet.imageAsset != null) ...[
              const SizedBox(height: 10),
              Center(
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
            Text(pet.info()),
            const SizedBox(height: 8),
            // Artık metotları değil, doğrudan 'final' alanları okuyoruz.
            Text('Sound: ${pet.sound}'),
            const SizedBox(height: 8),
            Text('Special: ${pet.specialAction}'),
            const SizedBox(height: 8),
            Text('Friendly: ${pet.friendlyBehavior}'),
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