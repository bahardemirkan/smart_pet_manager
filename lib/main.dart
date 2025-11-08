import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const SmartPetManagerApp());
}

abstract class Friendly {
  String beFriendly();
}

mixin Flyable {
  String fly() => "I am flying!";
}

abstract class Pet {
  static int totalPets = 0;

  final String name;
  final int age;
  final String species;
  final String? imageAsset;

  Pet({
    required this.name,
    required this.age,
    required this.species,
    this.imageAsset,
  }) {
    Pet.totalPets++;
  }

  Pet.young({
    required String name,
    required String species,
    this.imageAsset,
  })  : name = name,
        age = 1,
        species = species {
    Pet.totalPets++;
  }

  String makeSound();
  String doSpecialAction();
  String beFriendly();

  String info() => "$name is a $species aged $age";
}

class Dog extends Pet implements Friendly {
  final String breed;
  final String _sound;
  final String _friendly;
  final String _special;

  Dog({
    required String name,
    required int age,
    this.breed = "Mixed",
    String? imageAsset,
    String? customSound,
    String? customFriendly,
    String? customSpecial,
  })  : _sound = customSound ?? "Woof!",
        _friendly = customFriendly ?? "Wags tail and brings a toy.",
        _special = customSpecial ?? "$name is fetching the ball!",
        super(name: name, age: age, species: "Dog", imageAsset: imageAsset);

  Dog.rescue(
      String name, {
        String? imageAsset,
        String? customSpecial,
      })  : breed = "Rescue",
        _sound = "Woof! (Rescued!)",
        _friendly = "Rubs thankfully against your leg.",
        _special = customSpecial ?? "$name is happy to be safe!",
        super(name: name, age: 2, species: "Dog", imageAsset: imageAsset);

  @override
  String makeSound() => _sound;

  @override
  String doSpecialAction() => _special;

  @override
  String beFriendly() => _friendly;
}

class Cat extends Pet implements Friendly {
  final bool indoor;
  final String _sound;
  final String _friendly;
  final String _special;

  Cat({
    required String name,
    required int age,
    this.indoor = true,
    String? imageAsset,
    String? customSound,
    String? customFriendly,
    String? customSpecial,
  })  : _sound = customSound ?? "Meow~",
        _friendly = customFriendly ?? "Purrs and rubs against your leg.",
        _special = customSpecial ?? "$name is scratching the post.",
        super(name: name, age: age, species: "Cat", imageAsset: imageAsset);

  Cat.kitten({
    required String name,
    this.indoor = true,
    String? imageAsset,
    String? customSpecial,
  })  : _sound = "Mew!",
        _friendly = "Plays with a string.",
        _special = customSpecial ?? "$name is chasing a toy mouse.",
        super.young(name: name, species: "Cat", imageAsset: imageAsset);

  @override
  String makeSound() => _sound;

  @override
  String doSpecialAction() => _special;

  @override
  String beFriendly() => _friendly;
}

class Bird extends Pet with Flyable implements Friendly {
  final String color;
  final String _sound;
  final String _friendly;
  final String _special;

  Bird({
    required String name,
    required int age,
    this.color = "Green",
    String? imageAsset,
    String? customSound,
    String? customFriendly,
    String? customSpecial,
  })  : _sound = customSound ?? "Chirp! Chirp!",
        _friendly = customFriendly ?? "Sits on your shoulder and whistles.",
        _special = customSpecial ?? "I can fly high in the sky!",
        super(name: name, age: age, species: "Bird", imageAsset: imageAsset);

  Bird.parrot({
    required String name,
    this.color = "Multi",
    String? imageAsset,
    String? customSpecial,
  })  : _sound = "Polly wants a cracker!",
        _friendly = "Mimics your voice.",
        _special = customSpecial ?? "$name is talking!",
        super(name: name, age: 3, species: "Bird", imageAsset: imageAsset);

  @override
  String makeSound() => _sound;

  @override
  String doSpecialAction() => _special;

  @override
  String beFriendly() => _friendly;

  // mixin'den gelen örnek kullanım
  String patrol() => fly();
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
        customFriendly: "don't touch me, don't talk to me",
        customSpecial: "Engineer wants to drink yellow cola.",
      ),
      Cat(
        name: "Doctor",
        age: 3,
        imageAsset: 'assets/images/doktorKedi.jpeg',
        customSound: "drink water",
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
        customSpecial: "Criminal Birds are investigating a crime scene.",
      ),
      Cat(
        name: "Shocked",
        age: 6,
        imageAsset: "assets/images/saskinKedi.jpeg",
      ),
      Dog(
        name: "Tourist Dogs",
        age: 4,
        imageAsset: "assets/images/TuristKopekler.jpeg",
        customSpecial: "Tourist dogs are taking a selfie.",
      ),
      Cat(
        name: "kryptonian",
        age: 1789,
        imageAsset: "assets/images/uzaylıKedi.jpeg",
        customSound: "Zorp~",
        customFriendly: "Telepathically projects friendship.",
        customSpecial: "Kryptonian is levitating.",
      ),
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
            // Artık soyut metotları çağırıyoruz (interface + abstraction)
            Text('Sound: ${pet.makeSound()}'),
            const SizedBox(height: 8),
            Text('Special: ${pet.doSpecialAction()}'),
            const SizedBox(height: 8),
            Text('Friendly: ${pet.beFriendly()}'),
            if (pet is Bird) ...[
              const SizedBox(height: 8),
              Text('Flight: ${(pet as Bird).fly()}'),
            ],
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
