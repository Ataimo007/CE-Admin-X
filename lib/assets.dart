import 'dart:math';

class Assets
{
  static final avatars = const [
    'assets/avatars/boy1.svg',
    'assets/avatars/boy2.svg',
    'assets/avatars/boy3.svg',
    'assets/avatars/boy4.svg',
    'assets/avatars/man1.svg',
    'assets/avatars/man2.svg',
    'assets/avatars/man3.svg',
    'assets/avatars/man4.svg',
    'assets/avatars/woman1.svg',
    'assets/avatars/woman2.svg',
    'assets/avatars/woman3.svg',
    'assets/avatars/woman4.svg',
    'assets/avatars/woman5.svg',
    'assets/avatars/woman6.svg',
    'assets/avatars/woman7.svg',
    'assets/avatars/woman8.svg',
  ];
  static final rand = Random();

  static String getAvatar()
  {
    return avatars[ rand.nextInt( avatars.length )];
  }
}