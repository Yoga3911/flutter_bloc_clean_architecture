import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../configs/injector/injector_conf.dart';
import '../../../../core/network/network_checker.dart';
import '../../../../core/themes/app_color.dart';
import '../../../../widgets/leading_back_button_widget.dart';
import '../../../../widgets/snackbar_widget.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product_form/product_form_bloc.dart';
import '../widgets/update_product_input.dart';

class UpdateProductPage extends StatelessWidget {
  final BuildContext ctx;
  final String productId;
  final String productName;
  final String productPrice;
  const UpdateProductPage({
    super.key,
    required this.ctx,
    required this.productId,
    required this.productName,
    required this.productPrice,
  });

  void _updateProduct(BuildContext context) {
    primaryFocus?.unfocus();
    final formBloc = context.read<ProductFormBloc>().state;
    if (formBloc.isValid) {
      final network = getIt<NetworkInfo>();
      network.checkIsConnected.then(
        (value) {
          if (value) {
            context.read<ProductBloc>().add(
                  UpdateProductEvent(
                    productId: productId,
                    name: formBloc.name.trim(),
                    price: int.parse(formBloc.price.trim()),
                  ),
                );
          } else {
            appSnackBar(
              context,
              Colors.red,
              "tidak_ada_internet".tr(),
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ProductFormBloc>(),
        ),
        BlocProvider.value(
          value: ctx.read<ProductBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("ubah_produk".tr()),
          leading: const AppBackButton(),
        ),
        floatingActionButton: BlocBuilder<ProductFormBloc, ProductFormState>(
          builder: (context, formState) {
            if (formState is ProductFormInitialState) {
              context.read<ProductFormBloc>().add(
                    LoadDataEvent(productName, productPrice),
                  );
            }

            return BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is UpdateProductSuccessState) {
                  context.pop();
                  context.read<ProductBloc>().add(GetProductListEvent());
                  appSnackBar(
                      context, Colors.green, "Product updated successfully");
                } else if (state is UpdateProductFailureState) {
                  appSnackBar(context, Colors.red, state.message);
                }
              },
              builder: (context, state) {
                if (state is UpdateProductLoadingState) {
                  return FloatingActionButton(
                    onPressed: () {},
                    child: const CircularProgressIndicator(
                      color: AppColor.lightPurple,
                    ),
                  );
                }

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeInQuad,
                  switchOutCurve: Curves.easeOut,
                  child: formState.isValid
                      ? FloatingActionButton(
                          onPressed: () {
                            _updateProduct(context);
                          },
                          child: const Icon(Icons.save_rounded),
                        )
                      : const SizedBox(),
                );
              },
            );
          },
        ),
        body: SingleChildScrollView(
          child: UpdateProductInputWidget(
            productName: productName,
            productPrice: productPrice,
          ),
        ),
      ),
    );
  }
}
