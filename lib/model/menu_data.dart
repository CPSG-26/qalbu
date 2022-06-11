class Menu {
  String id;
  String title;
  String image;

  Menu({
    required this.id,
    required this.title,
    required this.image,
  });
}

var menuData = [
  Menu(
      id: '1',
      title: 'Al-Qur\'an',
      image: 'assets/icons/al-quran.png'
  ),
  Menu(
      id: '2',
      title: 'Tasbih',
      image: 'assets/icons/tasbih.png'
  ),
  Menu(
      id: '3',
      title: 'Doa',
      image: 'assets/icons/doa.png'
  ),
  Menu(
      id: '4',
      title: 'Jadwal Sholat',
      image: 'assets/icons/jadwal-sholat.png'
  ),
  Menu(
      id: '5',
      title: 'Catatan Ibadah',
      image: 'assets/icons/catatan-ibadah.png'
  ),
];
