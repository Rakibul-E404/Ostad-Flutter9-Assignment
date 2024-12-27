import 'dart:io';

abstract class Role {
  void displayRole();
}

class StudentRole implements Role {
  @override
  void displayRole() {
    print('Role: Student');
  }
}

class TeacherRole implements Role {
  @override
  void displayRole() {
    print('Role: Teacher');
  }
}

class Person implements Role {
  String name;
  int age;
  String address;
  Role role;

  Person(this.name, this.age, this.address, this.role);

  @override
  void displayRole() {
    role.displayRole();
  }

  void displayPersonDetails() {
    print('Name: $name');
    print('Age: $age');
    print('Address: $address');
  }
}

class Student extends Person {
  List<int> courseScores;

  Student(String name, int age, String address, this.courseScores)
      : super(name, age, address, StudentRole());

  double calculateAverageScore() {
    int sum = courseScores.reduce((a, b) => a + b);
    return sum / courseScores.length;
  }

  @override
  void displayPersonDetails() {
    super.displayPersonDetails();
    print('Average Score: ${calculateAverageScore().toStringAsFixed(1)}');
  }
}

class Teacher extends Person {
  List<String> coursesTaught;

  Teacher(String name, int age, String address, this.coursesTaught)
      : super(name, age, address, TeacherRole());

  @override
  void displayPersonDetails() {
    super.displayPersonDetails();
    print('Courses Taught:');
    for (var course in coursesTaught) {
      print('- $course');
    }
  }
}

void main() {
  print('Enter role (Student/Teacher): ');
  String? role = stdin.readLineSync();

  if (role != null) {
    if (role.toLowerCase() == 'student') {
      print('Enter name: ');
      String? name = stdin.readLineSync();

      print('Enter age: ');
      int age = int.parse(stdin.readLineSync()!);

      print('Enter address: ');
      String? address = stdin.readLineSync();

      print('Enter course scores: ');
      List<String> scores = stdin.readLineSync()!.split(',');
      List<int> courseScores = scores.map(int.parse).toList();

      Student student = Student(name!, age, address!, courseScores);
      student.displayRole();
      student.displayPersonDetails();
    } else if (role.toLowerCase() == 'teacher') {
      print('Enter name: ');
      String? name = stdin.readLineSync();

      print('Enter age: ');
      int age = int.parse(stdin.readLineSync()!);

      print('Enter address: ');
      String? address = stdin.readLineSync();
      print('Enter courses taught (comma separated): ');
      List<String> coursesTaught = stdin
          .readLineSync()!
          .split(',')
          .map((course) => course.trim())
          .toList();

      Teacher teacher = Teacher(name!, age, address!, coursesTaught);
      teacher.displayRole();
      teacher.displayPersonDetails();
    } else {
      print('Invalid role entered.');
    }
  }
}
