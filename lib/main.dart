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
  final String? imageAsset; // asset-based photo

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

    pets = [
      Dog(name: "Mina", age: 4, breed: "Golden Retriever", imageAsset: 'assets/images/dog.png'),
      Cat.kitten("Eva", imageAsset: 'assets/images/eva.png'),
      Bird.parrot("Necmi", color: "Blue & White", imageAsset: 'assets/images/necmi.png'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Pet Manager'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: pets.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final pet = pets[index];
                return PetCard(pet: pet);
              },
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(pet.imageAsset!, height: 100, fit: BoxFit.cover),
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
