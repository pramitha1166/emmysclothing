import 'package:ecommerce/model/product_item_model.dart';
import 'package:ecommerce/presentaion/misc/colors.dart';
import 'package:ecommerce/presentaion/widget/app_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductItemWidget extends StatefulWidget {
  ProductItem productItem;

  ProductItemWidget({Key? key, required this.productItem}) : super(key: key);

  @override
  _ProductItemWidgetState createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 150,
      margin: const EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 226, 226, 233),
                blurRadius: 10,
                offset: Offset(0, 0),
                blurStyle: BlurStyle.outer),
          ]),
      child: Column(
        children: [
          Expanded(
              child: Container(
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(200),
              image: DecorationImage(
                  image: AssetImage(widget.productItem.img),
                  fit: BoxFit.contain),
            ),
          )),
          Container(
            height: 60,
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                AppText(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    size: 15,
                    text: widget.productItem.name),
                const SizedBox(
                  height: 5,
                ),
                AppText(
                    size: 11,
                    text: widget.productItem.status,
                    color: AppColors.main,
                    fontWeight: FontWeight.w400),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                        size: 11,
                        text: "\$",
                        color: AppColors.main,
                        fontWeight: FontWeight.w400),
                    const SizedBox(
                      width: 2,
                    ),
                    AppText(
                        size: 20,
                        text: widget.productItem.price.toString(),
                        color: Colors.black,
                        fontWeight: FontWeight.bold)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
