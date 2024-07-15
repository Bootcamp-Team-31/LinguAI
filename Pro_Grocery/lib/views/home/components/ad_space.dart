import 'package:flutter/material.dart';
import '../../../core/components/title_and_action_button.dart';
import '../../../core/constants/constants.dart';

class AdSpace extends StatelessWidget {
  const AdSpace({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleAndActionButton(
            title: 'Başlık', // Başlığınızı burada güncelleyin
            onTap: () {
              // Eylem butonu tıklandığında yapılacak işlemler
            },
          ),
          const SizedBox(height: 10), // Başlık ile görsel arasındaki boşluk
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/Community.jpeg',
                    fit: BoxFit.cover, // Görüntünün nasıl sığdırılacağını belirler
                  ),
                  Positioned(
                    top: 10, // Başlığın resmin üzerinde olması için top değerini ayarlayın
                    left: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(10), // Çerçevenin iç boşluğu
                      child: TitleAndActionButton(
                        title: '', // Başlığınızı burada güncelleyin
                        onTap: () {
                          // Eylem butonu tıklandığında yapılacak işlemler
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
