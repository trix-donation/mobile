import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/core/widgets/line_progress_of_zbir.dart';

class DetailedCardPage extends StatelessWidget {
  const DetailedCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Збір'),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: HeaderDelegate(),
              pinned: true, // This keeps the header pinned at the top
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                    child: LineProgressOfZbir(
                      collected: 80000,
                      goal: 300000,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                    child: Text("Збір Данилу на Вебку",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onBackground)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
                    child: Text(
                        "БАЛДВІАОВФІИ РОБАЮИРОФІВИРАОЛ ИРФІВОЛАОЛЖФІВ ИРОЛДраол івролаолівр фола олфів арлофівр аолрфіволар олфіжвар олжфір вБАЛДВІАОВФІИ РОБАЮИРОФІВИРАОЛ ИРФІВОЛАОЛЖФІВ ИРОЛДраол івролаолівр фола олфів арлофівр аолрфіволар олфіжвар олжфір вБАЛДВІАОВФІИ РОБАЮИРОФІВИРАОЛ ИРФІВОЛАОЛЖФІВ ИРОЛДраол івролаолівр фола олфів арлофівр аолрфіволар олфіжвар олжфір вБАЛДВІАОВФІИ РОБАЮИРОФІВИРАОЛ ИРФІВОЛАОЛЖФІВ ИРОЛДраол івролаолівр фола олфів арлофівр аолрфіволар олфіжвар олжфір вБАЛДВІАОВФІИ РОБАЮИРОФІВИРАОЛ ИРФІВОЛАОЛЖФІВ ИРОЛДраол івролаолівр фола олфів арлофівр аолрфіволар олфіжвар олжфір вБАЛДВІАОВФІИ РОБАЮИРОФІВИРАОЛ ИРФІВОЛАОЛЖФІВ ИРОЛДраол івролаолівр фола олфів арлофівр аолрфіволар олфіжвар олжфір в",
                        style: bodyMediumText.copyWith(
                            color: Theme.of(context).colorScheme.onBackground)),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
              onPressed: () {},
              child: Text('Пожертвувати',
                  style: bodySemiBoldText.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer)),
            ),
          ),
        ));
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: CachedNetworkImage(
        imageUrl: 'https://picsum.photos/400?image=4',
        fit: BoxFit.fill,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
      ),
    );
  }

  @override
  double get maxExtent => 300.0;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
