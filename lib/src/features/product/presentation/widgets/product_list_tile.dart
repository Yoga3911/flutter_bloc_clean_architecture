import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_ca/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_route_path.dart';
import '../../../../widgets/dialog_widget.dart';
import '../../../../widgets/error_widget.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/snackbar_widget.dart';
import '../bloc/product/product_bloc.dart';

class ProductDataWidget extends StatelessWidget {
  const ProductDataWidget({super.key});

  Future<void> _openDeleteDialog(
    BuildContext context,
    String productId,
  ) async {
    await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (_) => AppDialog(title: "pesan_hapus_produk".tr()),
    ).then(
      (value) => value ?? false
          ? context.read<ProductBloc>().add(
                DeleteProductEvent(
                  productId: productId,
                ),
              )
          : null,
    );
  }

  Widget _priceChip(int price) {
    if (price > 0 && price <= 10000) {
      return Chip(
        label: Text("murah".tr()),
        backgroundColor: Colors.green,
      );
    } else if (price > 10000 && price <= 100000) {
      return Chip(
        label: Text("sedang".tr()),
        backgroundColor: Colors.orange,
      );
    } else if (price > 100000) {
      return Chip(
        label: Text("mahal".tr()),
        backgroundColor: Colors.red,
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listenWhen: (_, current) {
        return current is DeleteProductLoadingState ||
            current is DeleteProductSuccessState ||
            current is DeleteProductFailureState;
      },
      listener: (context, state) {
        if (state is DeleteProductLoadingState) {
          showDialog(
            context: context,
            builder: (_) => const AppLoadingWidget(),
          );
        } else if (state is DeleteProductSuccessState) {
          context.pop();
          context.read<ProductBloc>().add(GetProductListEvent());
          appSnackBar(context, Colors.green, "Product deleted successfully");
        } else if (state is DeleteProductFailureState) {
          context.pop();
          appSnackBar(
            context,
            Colors.red,
            state.message,
          );
        }
      },
      buildWhen: (_, current) {
        return current is ProductInitialState ||
            current is GetProductListLoadingState ||
            current is GetProductListFailureState ||
            current is GetProductListSuccessState;
      },
      builder: (context, state) {
        if (state is GetProductListLoadingState) {
          return const AppLoadingWidget();
        } else if (state is GetProductListFailureState) {
          return AppErrorWidget(state.message);
        } else if (state is GetProductListSuccessState) {
          final products = state.data;

          return ListView(
            children: products
                .map(
                  (e) => ListTile(
                    title: Text(e.name ?? ""),
                    subtitle: Row(
                      children: [
                        Text(e.price.toString()),
                        20.wS,
                        _priceChip(e.price ?? 0),
                      ],
                    ),
                    onTap: () {
                      context.pushNamed(
                        AppRoute.updateProduct.name,
                        extra: context,
                        pathParameters: {
                          "product_id": e.productId ?? "",
                          "product_name": e.name ?? "",
                          "product_price": (e.price ?? 0).toString(),
                        },
                      );
                    },
                    trailing: IconButton(
                      onPressed: () {
                        _openDeleteDialog(
                          context,
                          e.productId ?? "",
                        );
                      },
                      icon: const Icon(Icons.delete_rounded),
                      color: Colors.red,
                    ),
                  ),
                )
                .toList(),
          );
        }

        return const SizedBox();
      },
    );
  }
}
