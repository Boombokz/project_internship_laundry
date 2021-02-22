import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_internship_laundry/data/model/product_category_model.dart';

class CategoryCard extends StatelessWidget {
  final ProductCategory category;
  final int index;

  CategoryCard({this.category, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      height: 84,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name.toUpperCase(),
                    style: TextStyle(
                      color: Color(0xFF172853),
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                      letterSpacing: 0.03,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    category.description,
                    style: TextStyle(
                        fontSize: 12, height: 1.17, color: Color(0xFFB0B3BC)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: Image(
                  height: 84,
                  width: 114,
                  image: NetworkImage(
                      'https://api.doover.tech${category.picture}'),
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
