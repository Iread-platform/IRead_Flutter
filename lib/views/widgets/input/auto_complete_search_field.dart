import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/models/model.dart';
import 'package:iread_flutter/utils/extensions.dart';

/// A textfield with search auto complete.
///
/// Use [onSearchTextChanges] to generate search results list.
///
/// [onResultSelected] Handles th result onclick action.
///
/// Use the [validator] to validate current selected value of the widget.
///
/// **Example**
/// ```
/// AutoCompleteTextField<Product>(
///   label: "Product",
///   itemView: (Product product) {
///     return product.name;
///   },
///   onResultSelected: (product) {
///     bloc.changeProduct(product);
///     if (bloc.product != null) {
///       _amounteditingController.text = bloc.amount.toString();
///     }
///   },
///   onSearchTextChanges: (value) async {
///     var data = await MainRepository.instance().searchProducts(value);
///     return data.data;
///   },
/// );
///
/// ```
///
class AutoCompleteTextField<T extends Model> extends StatefulWidget {
  final Future<List<T>> Function(String) onSearchTextChanges;
  final void Function(T) onResultSelected;
  final String Function(T) itemView;
  final InputDecoration inputDecoration;
  final String listTitle;
  final String label;
  final String Function(String) validator;
  final T value;

  AutoCompleteTextField(
      {this.onSearchTextChanges,
      this.onResultSelected,
      this.listTitle,
      this.validator,
      this.value,
      @required this.itemView,
      @required this.label,
      this.inputDecoration});
  @override
  _AutoCompleteTextFieldState<T> createState() =>
      _AutoCompleteTextFieldState<T>();
}

class _AutoCompleteTextFieldState<T extends Model>
    extends State<AutoCompleteTextField<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry _overlayEntry;
  final FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController;
  String _searchTerm;
  ValueNotifier<T> _value;

  @override
  void initState() {
    _searchTerm = "";
    _value = ValueNotifier<T>(widget.value);

    _textEditingController = TextEditingController();

    if (widget.value != null) {
      _textEditingController.text = widget.itemView(widget.value);
    }

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        if (this._overlayEntry == null) {
          _overlayEntry = _createOverlayEntry([]);
          Overlay.of(context).insert(this._overlayEntry);
        }
      } else {
        deleteOverlay();
      }
    });
    super.initState();
  }

  OverlayEntry _createOverlayEntry(List<T> products) {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    double listHeight = products != null
        ? (products.length * ((size.height) + 5.0).toDouble())
        : 0.0;
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        top: 0,
        right: 40,
        height: listHeight >= 200 ? 200 : listHeight,
        width: MediaQuery.of(context).size.width -
            (MediaQuery.of(context).size.width * 0.1),
        child: CompositedTransformFollower(
            link: this._layerLink,
            showWhenUnlinked: false,
            offset: Offset(size.height * 0.1, size.height * 0.8),
            child: Material(
                elevation: 4.0,
                child: products == null
                    ? Container()
                    : Column(children: [
                        Container(
                          height: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  size: 18,
                                ),
                                onPressed: () {
                                  this._overlayEntry.remove();
                                  _overlayEntry = null;
                                },
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: products.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(widget.itemView(products[index])),
                            onTap: () {
                              this._overlayEntry.remove();
                              _overlayEntry = null;
                              _textEditingController.text =
                                  widget.itemView(products[index]);
                              _value.value = products[index];
                              widget.onResultSelected(products[index]);
                            },
                          ),
                        ))
                      ]))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        CompositedTransformTarget(
            link: _layerLink,
            child: Container(
                height: 50,
                child: TextFormField(
                  controller: _textEditingController,
                  focusNode: _focusNode,
                  onFieldSubmitted: (value) {},
                  onEditingComplete: () {
                    _textEditingController.text = widget.itemView(_value.value);
                  },
                  validator: widget.validator ??
                      (value) {
                        return _value.value == null
                            ? "Please Select a product"
                            : null;
                      },
                  decoration: widget.inputDecoration ??
                      InputDecoration(
                        enabled: true,
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.secondary,
                        helperText: " ",
                        // suffix: ValueListenableBuilder<T>(
                        //     valueListenable: _value,
                        //     builder: (context, value, _) => Text(
                        //         value != null
                        //             ? "${widget.itemView(value)}"
                        //             : "Selection ")),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                  onTap: () {},
                  onChanged: (String value) async {
                    if (_searchTerm == value) {
                      return;
                    }
                    _searchTerm = value;
                    if (_searchTerm.isNullOrEmpty()) {
                      deleteOverlay();
                      return;
                    }
                    List<T> products = [];
                    products = await widget.onSearchTextChanges(value);
                    if (products != null) {
                      _overlayEntry?.remove();
                      _overlayEntry = _createOverlayEntry(products);
                      Overlay.of(context).insert(this._overlayEntry);
                    }
                  },
                )))
      ]);

  void deleteOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
