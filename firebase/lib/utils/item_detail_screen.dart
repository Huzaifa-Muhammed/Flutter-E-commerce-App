import 'package:firebase/data/favorite_list.dart';
import 'package:firebase/data/users_review_api_data.dart';
import 'package:firebase/data/workers_api_data.dart';
import 'package:firebase/models/worker_class.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../data/users_review_list.dart';
import '../models/item_class.dart';
import '../data/workers_list.dart';

class ItemsDetailScreen extends StatefulWidget {
  final Item item;
  final double itemNameandDescriptionPadding;
  final double itemDescriptionandButtonsPadding;
  final VoidCallback? onCartButtonTap;

  ItemsDetailScreen({
    required this.item,
    required this.itemNameandDescriptionPadding,
    required this.itemDescriptionandButtonsPadding,
    this.onCartButtonTap,
  });

  @override
  _ItemsDetailScreenState createState() => _ItemsDetailScreenState();
}


class _ItemsDetailScreenState extends State<ItemsDetailScreen> {

  late IconData favrt=Icons.favorite_border_outlined;

  List<Worker> relatedWorkers=[];

  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchWorkerData();
  }

  void fetchData() async {
    UserReviewApi reviewUserApi = UserReviewApi();
    await reviewUserApi.apiCall();
    setState(() {});
  }

  void fetchWorkerData()async{
    WorkerApi workerApi=WorkerApi();
    await workerApi.apiCAll();
    setState(() {
      for(int i=0;i<WorkersList.workers.length;i++){
        if(widget.item.category==WorkersList.workers[i].category){
          relatedWorkers.add(WorkersList.workers[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(150, 196, 250, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SlidingUpPanel(
          body: Stack(
            children: [
              ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width, height: 300, child: PhotoView(initialScale: PhotoViewComputedScale.contained, maxScale: PhotoViewComputedScale.contained * 2, enableRotation: true, backgroundDecoration: const BoxDecoration(color: Colors.white), imageProvider: NetworkImage(widget.item.image),),),
                  SizedBox(width: MediaQuery.of(context).size.width, height: 300, child: PhotoView(enableRotation: true, backgroundDecoration: const BoxDecoration(color: Colors.white), imageProvider: NetworkImage(widget.item.image),),),
                  SizedBox(width: MediaQuery.of(context).size.width, height: 300, child: PhotoView(enableRotation: true, backgroundDecoration: const BoxDecoration(color: Colors.white), imageProvider: NetworkImage(widget.item.image),),),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width-50,top: 50),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (FavoriteDataList.favoriteItems.contains(widget.item)) {
                        favrt = Icons.favorite;
                        FavoriteDataList.favoriteItems.remove(widget.item);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('removed from favorites'), duration: Duration(milliseconds: 400)));
                      } else {
                        favrt = Icons.favorite;
                        FavoriteDataList.favoriteItems.add(widget.item);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('added to favorites'), duration: Duration(milliseconds: 400)));
                      }
                    });
                  },
                  child: Icon(
                    FavoriteDataList.favoriteItems.contains(widget.item) ? Icons.favorite : Icons.favorite_border_outlined,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          panel: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30,left: 20,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height:100,
                      width: (MediaQuery.of(context).size.width-10)/2,
                      child: Text(
                        widget.item.title,
                        style: GoogleFonts.aBeeZee(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 3),
                      ),
                    ),
                    SizedBox(
                      height:100,
                      child: Column(
                        children: [
                          Text(
                            '${widget.item.price} USD',
                            style: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,bottom: 20,top: 10),
                            child: Row(
                              children: [
                                Row(
                                  children: List.generate(5, (index) {
                                    if (widget.item.rating.toInt() > index+1) {
                                      return const Icon(Icons.star, color: Colors.orange);
                                    } else if(widget.item.rating.toInt()==index+1){
                                      return const Icon(Icons.star_half,color: Colors.orange,);
                                    } else {
                                      return const Icon(Icons.star_outline_sharp);
                                    }
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    widget.item.rating.toString(),
                                    style: GoogleFonts.aBeeZee(fontSize: 20,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text('Item Description',style: GoogleFonts.aBeeZee(color: Colors.blueAccent,letterSpacing: 1.5,fontWeight: FontWeight.w600),),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10,bottom: 10,right: 20),
                child: Expanded(
                  child: Text(
                    widget.item.description.length>=200?
                    widget.item.description.substring(0,200):widget.item.description,
                    style: GoogleFonts.aBeeZee(height: 1.7),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text('Related Workers', style: GoogleFonts.aBeeZee(color: Colors.blueAccent, letterSpacing: 1.5, fontWeight: FontWeight.w600,),),
              ),
              SizedBox(
                height: 110,
                width: MediaQuery.of(context).size.width,
                child: Scrollbar(
                  controller: _scrollController,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: WorkersList.workers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(WorkersList.workers[index].picture),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              WorkersList.workers[index].name,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.aBeeZee(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              Text('Reviews',style: GoogleFonts.aBeeZee(color: Colors.blueAccent,letterSpacing: 1.5,fontWeight: FontWeight.w600),),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 10),
                child: SizedBox(
                  height: 100,
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image(image: NetworkImage(UserReviewList.users[index].picture)),
                          title: Text(UserReviewList.users[index].name,style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 15),),
                          subtitle: Text(UserReviewList.users[index].comment,style: GoogleFonts.aBeeZee(fontSize: 12),),
                          minLeadingWidth: 20,
                          horizontalTitleGap: 20,
                        );
                      },
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: widget.itemDescriptionandButtonsPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: widget.onCartButtonTap,
                      style: OutlinedButton.styleFrom(
                        fixedSize: const Size(150, 70),
                        side: const BorderSide(),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Add to cart'), Icon(Icons.shopping_cart)]),
                    ),
                    OutlinedButton(
                      onPressed: (){},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(150, 196, 250, 1),
                        fixedSize: const Size(150, 70),
                        side: const BorderSide(),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text('check out', style: GoogleFonts.aBeeZee(color: Colors.black, letterSpacing: 2),),
                    ),
                  ],
                ),
              ),
            ],
          ),
          maxHeight: 650,
          color: const Color.fromRGBO(255, 250, 250, 1),
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
      ),
    );
  }
}
