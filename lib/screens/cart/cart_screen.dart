// ignore_for_file: deprecated_member_use

import 'package:ecommerce_project/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_project/models/cart_model.dart';
import 'package:ecommerce_project/widgets/cart_product_card.dart';
import 'package:ecommerce_project/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const CartScreen());
  }

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Your Cart',
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {},
                    child: Text(
                      'GO TO CHECKOUT',
                      style: Theme.of(context).textTheme.headline3,
                    ))
              ],
            ),
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
            if (state is CartLoaded) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Cart().freeDeliveryString,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/');
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    shape: const RoundedRectangleBorder(),
                                    elevation: 0),
                                child: Text(
                                  'Add More Items',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.white),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // CartProductCard(
                        //   product: Product.products[0],
                        // ),
                        // CartProductCard(
                        //   product: Product.products[0],
                        // ),
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
                              itemCount: state.cart.products.length,
                              itemBuilder: (context, index) {
                                return CartProductCard(
                                  product: state.cart.products[index],
                                );
                              }),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Divider(
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'SUBTOTAL',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Text(
                                    '\$${state.cart.subtotalString}',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'DELIVERY FEE',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Text(
                                    '\$${state.cart.deliveryFeeString}',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(50)),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration:
                                  const BoxDecoration(color: Colors.black),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'TOTAL',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      '\$${state.cart.totalString}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Something went Wrong!!'));
            }
          },
        ));
  }
}
