import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
 final product_detail_name;
  final product_detail_price;
 final product_detail_picture;


 ProductDetails({
   this.product_detail_name,
   this.product_detail_price,
   this.product_detail_picture
}) ;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Center(child: Text('Name')),
        actions: <Widget>[
          new IconButton(onPressed: (){}, icon: Icon(Icons.search),color: Colors.white,),
          new IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart),color: Colors.white,)

        ],
      ),
      body: new ListView(
        children: [

          new Container(
            height: 285.0 ,
         child: GridTile(
           child: Container(
             color: Colors.white,
             child: Image.asset(widget.product_detail_picture),
             
            
           ),
           
           footer: 
           new Container(
             color: Colors.white,
             child: ListTile(
               leading: new Text(widget.product_detail_name,
                 style: TextStyle(fontWeight:FontWeight.bold , fontSize: 18.0), textAlign: TextAlign.start,),
               title: new Text("${widget.product_detail_price}\d" ,
                 style: TextStyle(fontWeight:FontWeight.bold , fontSize: 18.0),textAlign: TextAlign.center,)
             ),
           ),

         ),

          ),







       // ====================== the first button ==========================
          Row(
            children:  [




              //============size===========
              Expanded(child: MaterialButton(
                onPressed: () {
                showDialog(context: context, builder: (context){
                  return new AlertDialog(
                    title: new Text("Size") ,
                    content: new Text("Choose the size"),
                    actions: [
                      new MaterialButton(onPressed: (){
                        Navigator.of(context).pop(context);
                      },
                      child: new Text("Close"),)
                    ],
                  );
                }
                );
              },
                color: Colors.white,
                textColor: Colors.black,
                child:
                Row(
                  children: [
                    Expanded(child: new Text("Size")
                    ),
                    Expanded(child: new Icon((Icons.arrow_drop_down))
                    ),
                  ],
                ),

              )
              ),

              //========color=====================


              Expanded(child: MaterialButton(
                onPressed: () {
                showDialog(context: context, builder: (context){
                  return new AlertDialog(
                    title: new Text("Colors") ,
                    content: new Text("Choose a color"),
                    actions: [
                      new MaterialButton(onPressed: (){
                        Navigator.of(context).pop(context);
                      },
                        child: new Text("Close"),)
                    ],
                  );
                }
                );
              },
                color: Colors.white,
                textColor: Colors.black,
                child:
                Row(
                  children: [
                    Expanded(child: new Text("Color")
                    ),
                    Expanded(child: new Icon((Icons.arrow_drop_down))
                    ),
                  ],
                ),

              )
              ) ,

//========================= Qty =======================
              Expanded(child: MaterialButton( onPressed: () {
                showDialog(context: context, builder: (context){
                  return new AlertDialog(
                    title: new Text("Quantity") ,
                    content: new Text("Choose  the Quantity"),
                    actions: [
                      new MaterialButton(onPressed: (){
                        Navigator.of(context).pop(context);
                      },
                        child: new Text("Close"),)
                    ],
                  );
                }
                );
              },
                color: Colors.white,
                textColor: Colors.black,
                child:
                Row(
                  children: [
                    Expanded(child: new Text("Qty")
                    ),
                    Expanded(child: new Icon((Icons.arrow_drop_down))
                    ),
                  ],
                ),

              )
              )
            ],

          ),


          // ===================== second line ==============
          Row(
            children:  [


              //============size===========
              Expanded(child: MaterialButton(onPressed: () {},
                color: Colors.red,
                textColor: Colors.white,
                child:
               new Text("Buy now")

              )
              ),

              //========color=====================
              new IconButton(onPressed:(){} , icon :Icon(Icons.add_shopping_cart,color: Colors.red,)),
              new IconButton(onPressed:(){} , icon :Icon(Icons.favorite_border, color: Colors.red,))



            ],

          ),

            Divider(color: Colors.red,) ,
 new ListTile(
   title: new Text("product details",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
   subtitle: new Text("is simply dummy text of the printing and typesetting "
       "industry. Lorem Ipsum has been the industry's standard dummy text ever "
       "since the 1500s, when an unknown printer took a galley of type and "
       "scrambled it to make a type specimen book. It has survived not only"
       " five centuries, but also the leap into electronic typesetting, "
       "remaining essentially unchanged. It was popularised in the 1960s "
       "with the release of Letraset sheets containing Lorem Ipsum passages,"
       " and more recently with desktop publishing software like Aldus PageMaker "
       "including versions of Lorem Ipsum."),
 )

        ],
      ),


    );
  }
}
