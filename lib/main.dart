// lib/main.dart
// BIM493 Mobile Programming I – Assignment #2
// Smart Pet Manager App in Flutter (uses local asset images)

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const SmartPetManagerApp());
}

abstract class SoundBehavior {
  String makeNoise();
}

class BarkSound implements SoundBehavior {
  @override
  String makeNoise() => "Woof!";
}

class MeowSound implements SoundBehavior {
  @override
  String makeNoise() => "Meow~";
}

class ChirpSound implements SoundBehavior {
  @override
  String makeNoise() => "Chirp! Chirp!";
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

  final SoundBehavior soundBehavior;

  Pet({
    required this.name,
    required this.age,
    required this.species,
    this.imageAsset,
    required this.soundBehavior,
  }) {
    Pet.totalPets++;
  }

  Pet.young({
    required String name,
    required String species,
    this.imageAsset,
    required this.soundBehavior,
  })  : name = name,
        age = 1,
        species = species {
    Pet.totalPets++;
  }

  String makeSound() {
    return soundBehavior.makeNoise();
  }

  String info() => "${this.name} is a ${this.species} aged ${this.age}";
}

class Dog extends Pet implements Friendly {
  final String breed;

  Dog({required String name, required int age, this.breed = "Mixed", String? imageAsset})
      : super(
    name: name,
    age: age,
    species: "Dog",
    imageAsset: imageAsset,
    soundBehavior: BarkSound(),
  );

  Dog.rescue(String name, {String? imageAsset})
      : breed = "Rescue",
        super(
        name: name,
        age: 2,
        species: "Dog",
        imageAsset: imageAsset,
        soundBehavior: BarkSound(),
      );

  @override
  String beFriendly() => "Wags tail and brings a toy.";

  String fetch() => "${this.name} is fetching the ball!";
}

class Cat extends Pet implements Friendly {
  final bool indoor;

  Cat({required String name, required int age, this.indoor = true, String? imageAsset})
      : super(
    name: name,
    age: age,
    species: "Cat",
    imageAsset: imageAsset,
    soundBehavior: MeowSound(),
  );

  Cat.kitten(String name, {bool indoor = true, String? imageAsset})
      : indoor = indoor,
        super.young(
        name: name,
        species: "Cat",
        imageAsset: imageAsset,
        soundBehavior: MeowSound(),
      );

  @override
  String beFriendly() => "Purrs and rubs against your leg.";

  String scratch() => "${this.name} is scratching the post.";
}

class Bird extends Pet with Flyable implements Friendly {
  final String color;

  Bird({required String name, required int age, this.color = "Green", String? imageAsset})
      : super(
    name: name,
    age: age,
    species: "Bird",
    imageAsset: imageAsset,
    soundBehavior: ChirpSound(),
  );

  Bird.parrot(String name, {String color = "Multi", String? imageAsset})
      : color = color,
        super(
        name: name,
        age: 3,
        species: "Bird",
        imageAsset: imageAsset,
        soundBehavior: ChirpSound(),
      );

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
      Dog(name: "Mina", age: 4, breed: "Golden Retriever", imageAsset: 'assets/images/dog.png'),
      Cat.kitten("Eva", imageAsset: 'assets/images/eva.png'),
      Bird.parrot("Necmi", color: "Blue & White", imageAsset: 'assets/images/necmi.png'),
      Dog.rescue("Sherlock", imageAsset: 'assets/images/köpke2.png'),
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
    final dogs = pets.whereType<Dog>().toList();
    final cats = pets.whereType<Cat>().toList();
    final birds = pets.whereType<Bird>().toList();

    return Scaffold(
      appBar: AppBar(leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/pet_logo.png',
        ),
      ),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
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
            Text('Sound: ${pet.makeSound()}'),
            const SizedBox(height: 8),
            Text('Special: ${specialBehavior(pet)}'),
            const SizedBox(height: 8),
            Text('Friendly: ${friendlyAction(pet)}'),
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
