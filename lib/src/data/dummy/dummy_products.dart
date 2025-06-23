import 'package:bloc_ecommerce/src/data/model/product_model';

final List<ProductModel> dummyProducts = [
  ProductModel(
      productName: "Winter T-shirt",
      productPrice: "200.0",
      imageGallary: [
        ImageGallary(
            title: "Image-1",
            imageUrl:
                "https://images.othoba.com/images/thumbs/0574991_winter-long-full-sleeves-t-shirt.jpeg"),
        ImageGallary(
            title: "Image-2",
            imageUrl:
                "https://images.othoba.com/images/thumbs/0574988_winter-long-full-sleeves-t-shirt.jpeg")
      ],
      variants: [
        Variant(
          category: "Size",
          items: [
            Item(
              title: "S",
              price: "150.0",
              description: "Winter Long Full Sleeves T shirt",
            ),
            Item(
              title: "M",
              price: "200.0",
              description: "Winter Long Full Sleeves T shirt",
            ),
            Item(
              title: "L",
              price: "250.0",
              description: "Winter Long Full Sleeves T shirt",
            ),
            Item(
              title: "XL",
              price: "300.0",
              description: "Winter Long Full Sleeves T shirt",
            )
          ],
        )
      ],
      productDetails: """
Winter Long Full Sleeves T shirt
Item code: WST-13
Material: Propylene
Sleeve: Full Sleeve
Style: Casual
Made in Bangladesh
Color: As given picture
Size- M, L, XL
""",
      brand: ""),
];
