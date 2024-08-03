import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/components/network_image.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/constants/app_images.dart';
import '../../core/themes/app_themes.dart';
import 'dialogs/verified_dialogs.dart';

// OTPProvider sınıfı için değişiklikler
class OTPProvider with ChangeNotifier {
  String _otp = '';

  String get otp => _otp;

  void updateOTP(String otp) {
    _otp = otp;
    notifyListeners();
  }
}

class NumberVerificationPage extends StatelessWidget {
  const NumberVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  margin: const EdgeInsets.all(AppDefaults.margin),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackground,
                    borderRadius: AppDefaults.borderRadius,
                  ),
                  child: const Column(
                    children: [
                      NumberVerificationHeader(),
                      OTPTextFields(),
                      SizedBox(height: AppDefaults.padding * 3),
                      ResendButton(),
                      SizedBox(height: AppDefaults.padding),
                      VerifyButton(),
                      SizedBox(height: AppDefaults.padding),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NumberVerificationHeader extends StatelessWidget {
  const NumberVerificationHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDefaults.padding),
        Text(
          'Enter Your 6 digit code',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppDefaults.padding),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: const AspectRatio(
            aspectRatio: 1 / 1,
            child: NetworkImageWithLoader(
              AppImages.numberVerfication,
            ),
          ),
        ),
        const SizedBox(height: AppDefaults.padding * 3),
      ],
    );
  }
}

class OTPTextFields extends StatefulWidget {
  const OTPTextFields({Key? key}) : super(key: key);

  @override
  State<OTPTextFields> createState() => _OTPTextFieldsState();
}

class _OTPTextFieldsState extends State<OTPTextFields> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.otpInputDecorationTheme,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(6, (index) {
          return SizedBox(
            width: 50,
            height: 50,
            child: TextFormField(
              controller: _controllers[index],
              onChanged: (v) {
                final otpProvider = Provider.of<OTPProvider>(context, listen: false);
                otpProvider.updateOTP(
                  _controllers.map((c) => c.text).join(),
                );

                if (v.length == 1) {
                  if (index < 5) {
                    FocusScope.of(context).nextFocus();
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                } else if (v.isEmpty && index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              },
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          );
        }),
      ),
    );
  }
}

class VerifyButton extends StatelessWidget {
  const VerifyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final otpProvider = Provider.of<OTPProvider>(context, listen: false);
          final otp = otpProvider.otp;
          if (otp.length == 6) {
            final success = await verifyOTP(otp);
            if (success) {
              showGeneralDialog(
                barrierLabel: 'Dialog',
                barrierDismissible: true,
                context: context,
                pageBuilder: (ctx, anim1, anim2) => const VerifiedDialog(),
                transitionBuilder: (ctx, anim1, anim2, child) => ScaleTransition(
                  scale: anim1,
                  child: child,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verification failed')));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a 6 digit code')));
          }
        },
        child: const Text('Verify'),
      ),
    );
  }

  Future<bool> verifyOTP(String otp) async {
    // Firebase doğrulama kodu burada olacak
    // Örnek:
    // try {
    //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //     verificationId: verificationId,
    //     smsCode: otp,
    //   );
    //   await FirebaseAuth.instance.signInWithCredential(credential);
    //   return true;
    // } catch (e) {
    //   return false;
    // }
    return true; // Firebase kodunuzu buraya ekleyin
  }
}

class ResendButton extends StatelessWidget {
  const ResendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Did you don\'t get code?'),
        TextButton(
          onPressed: () {
            // Burada kodu yeniden gönderme işlemini başlatın
          },
          child: const Text('Resend'),
        ),
      ],
    );
  }
}
