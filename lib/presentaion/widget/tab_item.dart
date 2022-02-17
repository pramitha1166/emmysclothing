import 'package:ecommerce/model/tab_item_model.dart';
import 'package:ecommerce/presentaion/misc/colors.dart';
import 'package:flutter/material.dart';

class TabItem extends StatefulWidget {
  TabItemModel tabItemModel;

  TabItem({Key? key, required this.tabItemModel}) : super(key: key);

  @override
  State<TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 40,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(
              color: widget.tabItemModel.active ? AppColors.main : Colors.grey,
              width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Image(
            width: 35,
            image: AssetImage(widget.tabItemModel.img),
            fit: BoxFit.cover,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              widget.tabItemModel.title,
              style: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
