import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:project_internship_laundry/cubit/cart_cubit.dart';
import 'package:project_internship_laundry/data/model/product_model.dart';
import 'package:project_internship_laundry/utils/const.dart';
import 'package:basic_utils/basic_utils.dart';

class ProductCard extends StatefulWidget {
  ProductCard(this.product, this.inCartOrNot);
  final bool inCartOrNot;

  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Box box = Hive.box('cart');
  CartCubit cartCubit;
  int count;

  String formatNumber(int number) {
    var s = StringUtils.reverse(number.toString());
    s = StringUtils.addCharAtPosition(s, " ", 3, repeat: true);
    return StringUtils.reverse(s);
  }

  bool checkCount() {
    if (widget.product.count > 0) {
      return true;
    } else {
      return false;
    }
  }

  void checkBox() {
    if (box.isEmpty) {
      widget.product.count = 0;
    } else if (box.containsKey(widget.product.id)) {
      Product product = box.get(widget.product.id);
      widget.product.count = product.count;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkBox();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      height: 102,
      child: Stack(
        children: [
          Row(
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                    child: Image(
                      height: 100,
                      width: 63,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://api.doover.tech${widget.product.picture}'),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: kProductCardTextStyle,
                      ),
                      Row(
                        children: [
                          Text(
                            'Срок чистки / ',
                            style: kProductCardTextStyle.copyWith(
                                color: Colors.grey),
                          ),
                          Text(
                            '${widget.product.duration ~/ 86400} день',
                            style: kProductCardTextStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.product.count++;
                                      BlocProvider.of<CartCubit>(context)
                                          .addProducts(widget.product.id,
                                              widget.product..count);
                                    });
                                  },
                                  child: Container(
                                    child: SvgPicture.asset(kPlusButtonIcon),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  widget.product.count.toString(),
                                  style: kProductCardTextStyle,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  child: checkCount()
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (widget.product.count > 0) {
                                                widget.product.count--;
                                                BlocProvider.of<CartCubit>(
                                                        context)
                                                    .addProducts(
                                                        widget.product.id,
                                                        widget.product..count);
                                                if (widget.product.count == 0) {
                                                  box.delete(widget.product.id);
                                                }
                                              }
                                            });
                                          },
                                          child: Container(
                                            child: SvgPicture.asset(
                                                kMinusButtonIcon),
                                          ),
                                        )
                                      : Offstage(),
                                ),
                              ],
                            ),
                          ),
                          widget.inCartOrNot
                              ? Text(
                                  '${formatNumber(widget.product.price.toInt() * widget.product.count)} тг',
                                  style: kProductCardTextStyle,
                                )
                              : Text(
                                  '${formatNumber(widget.product.price.toInt())} тг',
                                  style: kProductCardTextStyle,
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          widget.inCartOrNot
              ? Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.product.count = 0;
                        BlocProvider.of<CartCubit>(context).addProducts(
                            widget.product.id, widget.product..count);
                        box.delete(widget.product.id);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFFEDEFF6),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      height: 24,
                      width: 24,
                      child: SvgPicture.asset(
                        kCrossIcon,
                        color: Color(0xFFB0B3BC),
                      ),
                    ),
                  ),
                )
              : Offstage(),
          widget.inCartOrNot
              ? Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      showModalPopUp(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFFEDEFF6),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: SvgPicture.asset(
                        kQuestionIcon,
                        color: Color(0xFFB0B3BC),
                      ),
                      height: 24,
                      width: 24,
                    ),
                  ),
                )
              : Offstage(),
          widget.inCartOrNot
              ? Offstage()
              : Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      showModalPopUp(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFFEDEFF6),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: SvgPicture.asset(
                        kQuestionIcon,
                        color: Color(0xFFB0B3BC),
                      ),
                      height: 24,
                      width: 24,
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Future showModalPopUp(BuildContext context) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Stack(children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              height: 204,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(top: 32, left: 16, right: 16),
                    child: Text(
                      widget.product.hintTitle,
                      style: TextStyle(
                          fontSize: 20,
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF172853)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                    child: Text(
                      widget.product.hintDescription,
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.43,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16,
              top: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDEFF6),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(
                    kCrossIcon,
                    color: Color(0xFF172853),
                  ),
                ),
              ),
            ),
          ]);
        });
  }
}
