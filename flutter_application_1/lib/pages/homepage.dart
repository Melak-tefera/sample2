import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          
          SliverPersistentHeader(
            pinned:true,
            delegate: Mainheader(),
          ),
          SliverList(
            delegate:SliverChildBuilderDelegate(
              (context, index){
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text('Product ${index + 1}'),
                  subtitle: const Text('Product description'),
                );
              },
              childCount: 100
            ) ,
            
          )

        ],
      ),

    );
  }
}
class Mainheader extends SliverPersistentHeaderDelegate {
@override
  double get minExtent => 70;

@override
  double get maxExtent =>200;

@override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final currentHeight = maxExtent - (shrinkOffset.clamp(0, maxExtent - minExtent));
    return Material(
           elevation: overlapsContent ? 3:0,
           color: Colors.deepPurple,
            child: SizedBox(
                height: currentHeight,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Title 101"),
                    
                      IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none))
                    ],
                  ),
              ),

          );
    
  }
@override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  
}