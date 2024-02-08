import 'package:biblioteca/home/bloc/home_event.dart';
import 'package:biblioteca/home/bloc/home_state.dart';
import 'package:biblioteca/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return PreferredSize(
      preferredSize: Size(screenWidth, 70),
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              height: 70,
              padding: const EdgeInsets.only(top: 15),
              child: AppBar(
                centerTitle: false,
                title: Row(
                  children: [
                    Image.asset(
                      'assets/ucuLogo.png',
                      height: 70,
                    ),
                    const SizedBox(width: 40),
                    SizedBox(width: screenWidth * 0.001),
                    const _OptionSelectedBiblio(
                      pageSelected: PageSelected.home,
                      title: 'Home',
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    const _OptionSelectedBiblio(
                      pageSelected: PageSelected.chat,
                      title: 'Chat',
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    const _OptionSelectedBiblio(
                      pageSelected: PageSelected.bibliography,
                      title: 'Biografía',
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(200, 90);
}

class _OptionSelectedBiblio extends StatelessWidget {
  const _OptionSelectedBiblio({
    required this.pageSelected,
    required this.title,
  });

  final PageSelected pageSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    final newPageSelected =
        context.select((HomeBloc bloc) => bloc.state.pageSelected);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            context
                .read<HomeBloc>()
                .add(HomePageSelectedChanged(pageSelected: pageSelected));
          },
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
        newPageSelected == pageSelected
            ? const _SelectedItem()
            : const SizedBox(height: 2)
      ],
    );
  }
}

class _SelectedItem extends StatelessWidget {
  const _SelectedItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      alignment: Alignment.bottomLeft,
      height: 3,
      color: Theme.of(context).colorScheme.secondary,
      width: 30,
    );
  }
}
