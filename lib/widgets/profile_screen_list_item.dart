import 'package:flutter/material.dart';

class ProfileScreenListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final Function? onTapFunc;
  final bool isSignOutButton;

  const ProfileScreenListItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.leadingIcon,
      required this.trailingIcon,
      required this.onTapFunc,
      this.isSignOutButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: !isSignOutButton ? Colors.black : Colors.red,
            ),
      ),
      subtitle: !isSignOutButton
          ? Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall,
            )
          : null,
      iconColor: !isSignOutButton ? Colors.black : Colors.red,
      trailing: Icon(
        trailingIcon,
        size: 16,
      ),
      onTap: onTapFunc == null ? null : () => onTapFunc!(),
    );
  }
}