import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

/// Example responsive widget demonstrating flutter_screenutil usage
/// This shows how to create a responsive product card
class ResponsiveProductCard extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String imageUrl;

  const ResponsiveProductCard({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Responsive margin
      margin: EdgeInsets.all(ResponsiveUtils.width(8)),
      // Responsive border radius
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveUtils.radius(12)),
      ),
      elevation: 2,
      child: SizedBox(
        // Responsive width and height
        width: ResponsiveUtils.width(180),
        height: ResponsiveUtils.height(240),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Responsive image container
            Container(
              width: double.infinity,
              height: ResponsiveUtils.height(140),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ResponsiveUtils.radius(12)),
                  topRight: Radius.circular(ResponsiveUtils.radius(12)),
                ),
                color: Colors.grey[300],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ResponsiveUtils.radius(12)),
                  topRight: Radius.circular(ResponsiveUtils.radius(12)),
                ),
                child: Icon(
                  Icons.image,
                  size: ResponsiveUtils.width(60),
                  color: Colors.grey[500],
                ),
              ),
            ),

            // Responsive padding for content
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.width(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name with responsive font size
                  Text(
                    productName,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.fontSize(14),
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Responsive spacing between elements
                  SizedBox(height: ResponsiveUtils.width(8)),

                  // Product price with responsive font size
                  Text(
                    productPrice,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.fontSize(16),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),

                  // Responsive spacing
                  SizedBox(height: ResponsiveUtils.width(8)),

                  // Responsive button
                  SizedBox(
                    width: double.infinity,
                    height: ResponsiveUtils.height(36),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            ResponsiveUtils.radius(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Add to cart logic
                      },
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: ResponsiveUtils.fontSize(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example responsive page layout
class ResponsiveExamplePage extends StatelessWidget {
  const ResponsiveExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Responsive app bar height
        toolbarHeight: ResponsiveUtils.height(60),
        title: Text(
          'Responsive Example',
          style: TextStyle(fontSize: ResponsiveUtils.fontSize(18)),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ResponsiveUtils.width(16)),
            child: Icon(Icons.shopping_cart, size: ResponsiveUtils.width(24)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ResponsiveUtils.width(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Responsive title
            Text(
              'Featured Products',
              style: TextStyle(
                fontSize: ResponsiveUtils.fontSize(24),
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: ResponsiveUtils.width(16)),

            // Responsive grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveUtils.responsive(
                  mobile: 2,
                  tablet: 3,
                  desktop: 4,
                ),
                crossAxisSpacing: ResponsiveUtils.width(12),
                mainAxisSpacing: ResponsiveUtils.width(12),
                childAspectRatio: 0.75,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return ResponsiveProductCard(
                  productName: 'Product ${index + 1}',
                  productPrice: '\$${(index + 1) * 10}.99',
                  imageUrl: 'https://via.placeholder.com/150',
                );
              },
            ),

            SizedBox(height: ResponsiveUtils.width(24)),

            // Responsive banner container
            Container(
              width: double.infinity,
              height: ResponsiveUtils.responsive(
                mobile: ResponsiveUtils.height(120),
                desktop: 100.0,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(ResponsiveUtils.radius(16)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Special Offer!',
                      style: TextStyle(
                        fontSize: ResponsiveUtils.fontSize(20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.width(8)),
                    Text(
                      'Get 50% off on all items',
                      style: TextStyle(fontSize: ResponsiveUtils.fontSize(14)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
