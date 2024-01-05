import '../data/boarding_item.dart';

class BoardingService {
  List<BoardingItem> getItems() {
    return const [
      BoardingItem(
        imagePath: 'assets/1.png',
        description: 'В этом приложении вы найдете множество фильмов про Стетхема.',
      ),
      BoardingItem(
        imagePath: 'assets/2.png',
        description: 'Можно добавлять фильмы в избранное.',
      ),
      BoardingItem(
        imagePath: 'assets/3.png',
        description: 'Приложение требует авторизации.',
      ),
    ];
  }
}