import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:cleanmate_customer_app/Server/server.dart';
import 'package:cleanmate_customer_app/colorCode/HexColor.dart';
import 'package:cleanmate_customer_app/data/Product.dart' as _product;

//fetch product
Future<List<_product.Product>> fetchProduct(id,type) async {
  String branchGroupID="1";
  try {
    http.Response response;
    List responseJson;
    if(type=="service") {
      response =
      await http.get(
          Server().IPAddress + '/data/get/ser/Product.php?BranchGroupID=' +
              branchGroupID + '&ServiceType=' + id.toString());
      responseJson = json.decode(response.body);

    }else{
      response =
      await http.get(Server().IPAddress + '/data/get/cate/Product.php?BranchGroupID=' +
          branchGroupID+'&CategoryID='+id.toString());
      responseJson = json.decode(response.body);
    }
    return responseJson.map((m) => new _product.Product.fromJson(m)).toList();
  }catch (exception) {
    print(exception.toString());
  }
}

class Product extends StatefulWidget {
  int typeID;
  String typeName;
  String type;
  Product({
    Key key,
    @required this.typeID,
    @required this.typeName,
    @required this.type,
  }) : super(key: key);
  @override
  _ProductState createState() => new _ProductState();
}
class _ProductState extends State<Product> {
  Color cl_bar = HexColor("#18b4ed");
  Color cl_back=HexColor("#e9eef4");
  Color cl_card=HexColor("#ffffff");
  Color cl_text_pro_th=HexColor("#667787");
  Color cl_text_pro_en=HexColor("#989fa7");
  Color cl_cart=HexColor("#e64d3f");
  Color cl_line_ver=HexColor("#677787");
  Color cl_favorite=HexColor("#e44b3b");

  int totalAmount = 0;
  int counts=0;
  getTotalAmount(price) {
    setState(() {
      totalAmount += price;
      counts += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final makeBody = FutureBuilder<List<_product.Product>>(
        future: fetchProduct(widget.typeID,widget.type),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            // Shows progress indicator until the data is load.
            return new MaterialApp(
                debugShowCheckedModeBanner: false,
                home: new Scaffold(
                  body: new Center(
                    child: new CircularProgressIndicator(),
                  ),
                )
            );
          // Shows the real data with the data retrieved.
          List<_product.Product> product = snapshot.data;
          return Container(
            child: ListView.builder(
              itemCount: product.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    getTotalAmount(int.tryParse(product[index].ProductPrice));
                  },
                  child: Card(
                    elevation: 8.0,
                    margin: new EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.0),
                          color: cl_card),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 1.0,
                                      color: HexColor(
                                          product[index].ColorCode)))),
                          child: new SizedBox(
                            height: 60.0,
                            width: 60.0,
                            child: Image.network(
                                'http://119.59.115.80/cleanmate_god_test/' +
                                    product[index].ImageFile.substring(
                                        3, product[index].ImageFile.length),
                                fit: BoxFit.cover),

                          ),
                        ),
                        title: Text(
                          product[index].ProductNameEN,
                          style: TextStyle(color: cl_text_pro_th,
                              fontFamily: 'Poppins'
                          ),
                        ),
                        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                        subtitle: Row(
                          children: <Widget>[
                            /* Icon(Icons.linear_scale,
                                  color: Colors.yellowAccent),*/
                            Text(product[index].ProductPrice + ' ฿',
                                style: TextStyle(color: cl_text_pro_en,
                                    fontFamily: 'Poppins'
                                )
                            ),
                          ],
                        ),
                        trailing:
                        Icon(Icons.more_vert, color: cl_text_pro_th,
                            size: 28.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
    );

    // TODO: implement build
    return Scaffold(
      backgroundColor: cl_back,
      appBar: new AppBar(
        backgroundColor: cl_bar,
        title: new Text(
          widget.typeName,
          style: new TextStyle(
              fontSize: Theme
                  .of(context)
                  .platform == TargetPlatform.iOS ? 17.0 : 20.0,
              fontFamily: 'Poppins'
          ),
        ),
      ),
      body: makeBody,
      bottomNavigationBar: Container(
          height: 60.0,
          width: double.infinity,
          color: cl_back,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                  'Total: \$' + totalAmount.toString(),
                  style: TextStyle(color: cl_text_pro_th,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins')

              ),
              SizedBox(width: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {},
                  elevation: 0.5,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Pay Now',
                      style: TextStyle(color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  textColor: Colors.white,
                ),
              )
            ],
          )
      ),
    );
  }

}
