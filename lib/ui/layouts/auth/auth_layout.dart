import 'package:admin_dashboard/ui/layouts/auth/widgets/wisgets.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Scrollbar(
      //isAlwaysShown: true,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          (size.width > 1000)
              ? _DesktopBody(child: child)
              : _MobileBody(child: child),
          const LinkBar()
        ],
      ),
    ));
  }
}

class _MobileBody extends StatelessWidget {
  const _MobileBody({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomTitle(),
          SizedBox(
            width: double.infinity,
            height: 420,
            child: child,
          ),
          SizedBox(
            width: double.infinity,
            height: 400,
            child: Flex(
                direction: Axis.horizontal,
                children: const [BackgroundTwitter()]),
          )
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.95,
      child: Row(
        children: [
          // Twiter Background
          const BackgroundTwitter(),
          //View Container
          Container(
            width: 600,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                const CustomTitle(),
                const SizedBox(height: 50),
                Expanded(child: child),
              ],
            ),
          )
        ],
      ),
    );
  }
}
