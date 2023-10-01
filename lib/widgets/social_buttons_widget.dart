///
/// This is the social media buttons widget containing twitter, google and
/// facebook buttons

import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        children: [
          TextButton(
            onPressed: () {},
            child: Image.asset('assets/images/twitter.png'),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          const Text(
            'Twitter',
            style: TextStyle(
              color: Color(0xFF03A9F4),
              fontSize: 12,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
              height: 0.17,
            ),
          )
        ],
      ),
      const SizedBox(
        width: 27,
      ),
      Column(
        children: [
          TextButton(
            onPressed: () {},
            child: Image.asset('assets/images/google.png'),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          const Text(
            'Google',
            style: TextStyle(
              color: Color(0xFF1976D2),
              fontSize: 12,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
              height: 0.17,
            ),
          )
        ],
      ),
      const SizedBox(
        width: 27,
      ),
      Column(
        children: [
          TextButton(
            onPressed: () {},
            child: Image.asset('assets/images/facebook.png'),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          const Text(
            'Facebook',
            style: TextStyle(
              color: Color(0xFF3F51B4),
              fontSize: 12,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
              height: 0.17,
            ),
          )
        ],
      ),
    ]);
  }
}
