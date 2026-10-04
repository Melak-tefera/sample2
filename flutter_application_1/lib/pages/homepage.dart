import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
class HomePage extends StatefulWidget {
const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller= ScrollController();
  double op1=0.0;
  double op2=0.0;
  double previousOffset = 0.0;
  double movedDown = 0.0; 
  double movedUp = 0.0;  
  double threshold = 100.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onscroll);
  }
  void onscroll(){
    final double currentOffset = controller.offset;
    final double difference = currentOffset - previousOffset;
    final bool isAtTop = controller.offset == controller.position.minScrollExtent;
    final bool isAtBottom = controller.offset == controller.position.maxScrollExtent;

    if (difference > 0) {
    // User is scrolling down:
    // content moves upward on the screen
    movedDown += difference;
    movedUp = 0.0;
  } else if (difference < 0) {
    // User is scrolling up:
    // content moves downward on the screen
    movedUp += -difference;
    movedDown = 0.0;
  }
  previousOffset= currentOffset;

  setState(() {
    if (isAtTop) {
      op1 = 0.3;
      op2 = 0.5;
    } else if (isAtBottom) {
      op1 = 0.5;
      op2 = 0.3;
    } else if(movedDown >= threshold) {
      op1 = 0.3;
      op2 = 0.4;
    }
    else if(movedUp >= threshold){
      op1=0.4;
      op2=0.3;
    }
  });
  }
  
  



  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(onscroll);
    controller.dispose();
    super.dispose();
  }

  Future<void> handlerefresh()async{
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        ///// / / / / 
      });
      
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: handlerefresh,
        color: Colors.deepPurple[200],
        height: 300,
        backgroundColor: Colors.deepPurple,
        animSpeedFactor: 3,
        showChildOpacityTransition: true,
        child: Stack(
          children: [
           CustomScrollView(
            controller: controller,
            physics: ClampingScrollPhysics(),
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
                  childCount: 300
                ) ,
                
              ),
              
                 
            
          
            ],
          ),
        
          Positioned(
            right: 16,
            top: MediaQuery.of(context).size.height/1.26,
            child: Column(
                    
                    children: [
                      Opacity(
                        opacity: op1,
                        child: FloatingActionButton(
                          onPressed: (){
                            controller.animateTo(
                              controller.position.minScrollExtent, 
                              duration: const Duration(milliseconds: 600), 
                              curve: Curves.easeIn
                              );
                          }, 
                          child: Icon(Icons.arrow_upward),
                          ),
                      ),
                      SizedBox(height: 15,),
        
        
                      Opacity(
                        opacity: op2,
                        child: FloatingActionButton(onPressed: (){
                          controller.animateTo(
                            controller.position.maxScrollExtent, 
                            duration: Duration(milliseconds: 600), 
                            curve: Curves.easeIn
                            );
                        }, child: Icon(Icons.arrow_downward),),
                      )
                    ],
                  ),
          ),
        
          ],
        ),
      ),

    );
  }
}
class Mainheader extends SliverPersistentHeaderDelegate {
@override
  double get minExtent => 90;

@override
  double get maxExtent =>300;

@override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final currentHeight = maxExtent - (shrinkOffset.clamp(0, maxExtent - minExtent));
    return Material(
           
           elevation: overlapsContent ? 4:0,
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