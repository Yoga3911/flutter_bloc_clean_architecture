import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_form/product_form_bloc.dart';
import 'product_text_field.dart';

class CreateProductInputWidget extends StatelessWidget {
  const CreateProductInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<ProductFormBloc>();

    return Column(
      children: [
        ProductTextField(
          label: "nama_produk".tr(),
          onChanged: (val) {
            formBloc.add(ProductNameChangedEvent(val));
          },
          hinText: "input_nama_produk".tr(),
        ),
        ProductTextField(
          label: "harga_produk".tr(),
          onChanged: (val) {
            formBloc.add(ProductPriceChangedEvent(val));
          },
          inputType: TextInputType.number,
          inputFormat: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          hinText: "input_harga_produk".tr(),
        ),
        BlocSelector<ProductFormBloc, ProductFormState, String>(
          selector: (state) => state.price,
          builder: (_, state) {
            final price = int.tryParse(state) ?? 0;
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
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
