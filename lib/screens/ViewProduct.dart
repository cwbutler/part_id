import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:part_id/models/AirtableProduct.dart';

class PartIDViewProduct extends HookConsumerWidget {
  final PartIDAirtableProduct product;
  const PartIDViewProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainImage = product.aSideCapturedImage1 ??
        "http://www.fremontgurdwara.org/wp-content/uploads/2020/06/no-image-icon-2.png";
    const partItemStyle = TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontSize: 14,
    );
    final otherImages = [
      product.aSideCapturedImage2,
      product.aSideCapturedImage3,
      product.bSideCapturedImage1,
      product.bSideCapturedImage2,
      product.bSideCapturedImage3,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                margin: const EdgeInsets.all(20),
                child: Stack(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                      },
                      child: Image.asset("assets/images/part_close.png"),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xffE8E8E8),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text(
                          "1 part found",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xff626262),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Product
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    // Image
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.network(
                        mainImage,
                        width: double.infinity,
                        height: 306,
                        fit: BoxFit.fill,
                      ),
                    ),
                    // Info
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Part Name
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              product.partName ?? "[No Part Name?]",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          // Part Description
                          if (product.description != null)
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                product.description!,
                                style: partItemStyle,
                              ),
                            ),
                          // Part Number
                          if (product.partNumber != null)
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                product.partNumber!,
                                style: partItemStyle,
                              ),
                            ),
                          // Part Fits Model
                          if (product.fitsModel != null)
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                product.fitsModel!,
                                style: partItemStyle,
                              ),
                            ),
                          // Part Make
                          if (product.make != null)
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                product.make!,
                                style: partItemStyle,
                              ),
                            ),
                          // Part Make
                          if (product.msrp2021 != null)
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                product.msrp2021!,
                                style: partItemStyle,
                              ),
                            )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Other Images",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
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
      ),
    );
  }
}
