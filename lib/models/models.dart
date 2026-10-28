class Project {
  final String id, title, description;
  final List<String> techStack;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.techStack,
  });
}

class Profile {
  final String name, bio;
  final String jabatan;

  const Profile({
    required this.name,
    required this.bio,
    this.jabatan = 'Software Engineer & Dosen',
  });

  Profile copyWith({
    String? name,
    String? bio,
    String? jabatan,
  }) {
    return Profile(
      name: name ?? this.name,
      bio: bio ?? this.bio,
      jabatan: jabatan ?? this.jabatan,
    );
  }
}
