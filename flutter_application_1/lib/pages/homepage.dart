import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller= ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onscroll);
  }
  void onscroll(){
    print(controller.offset);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(onscroll);
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
         CustomScrollView(
          controller: controller,
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
              
            ),
            
               
          
        
          ],
        ),

        Positioned(
          right: 16,
          top: MediaQuery.of(context).size.height/2-90,
          child: Column(
                  
                  children: [
                    FloatingActionButton(onPressed: (){}, child: Icon(Icons.arrow_upward),),
                    SizedBox(height: 15,),
                    FloatingActionButton(onPressed: (){}, child: Icon(Icons.arrow_downward),)
                  ],
                ),
        ),

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