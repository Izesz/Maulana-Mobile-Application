import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'shared/follow_card.dart';

// ===== CONTROLLER: state reaktif + logika =====
class FollowController extends GetxController {
  final isFollowing = false.obs;
  final followers = 1200.obs;

  void toggleFollow() {
    isFollowing.value = !isFollowing.value;
    followers.value += isFollowing.value ? 1 : -1;

    // Snackbar tanpa BuildContext (praktis, tapi lihat catatan di bawah)
    Get.closeAllSnackbars();
    Get.snackbar(
      'Kartu Profil',
      isFollowing.value ? 'Kamu mulai mengikuti' : 'Kamu berhenti mengikuti',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

void main() => runApp(
      GetMaterialApp(
        theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
        home: const GetxDemo(),
      ),
    );

class GetxDemo extends StatelessWidget {
  const GetxDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftarkan controller (cukup sekali)
    final controller = Get.put(FollowController());

    return Scaffold(
      appBar: AppBar(title: const Text('5 · GetX')),
      body: Center(
        // Obx: rebuild otomatis saat .obs yang dibaca di dalamnya berubah
        child: Obx(
          () => FollowCard(
            name: 'Fakhry Firdaus',
            followers: controller.followers.value,
            isFollowing: controller.isFollowing.value,
            onFollowPressed: controller.toggleFollow,
          ),
        ),
      ),
    );
  }
}
