import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
                            id: null,
                            title: '',
                            price: 0,
                            description: '',
                            imageUrl: ''
                        );
  var _isInit = true;
  var _initValues = {
    'title' : '',
    'description' : '',
    'price' : '',
    'imageUrl' : ''
  };
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isInit){
      final productId = ModalRoute.of(context).settings.arguments as String;
      if(productId != null){
        _editedProduct = Provider.of<Products>(context).findById(productId);
        _initValues = {
          'title' : _editedProduct.title,
          'description' : _editedProduct.description,
          'price' : _editedProduct.price.toString(),
          // 'imageUrl' : _editedProduct.imageUrl
          'imageUrl' : ''
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if((!_imageUrlController.text.startsWith("http") &&
              !_imageUrlController.text.startsWith("https")) ||
          (!_imageUrlController.text.endsWith(".png") &&
              !_imageUrlController.text.endsWith(".jpg") &&
              !_imageUrlController.text.endsWith(".jpeg"))
      ){
        return ;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if(!isValid){
      return ;
    }
    _form.currentState.save();
    if(_editedProduct.id != null){
      Provider.of<Products>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct);
    }else{
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editedProduct.id != null ? "Edit Product" : "Add Product"),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(labelText: "Title"),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Please provide a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        title: value,
                        price: _editedProduct.price,
                        description: _editedProduct.description,
                        imageUrl: _editedProduct.imageUrl,
                        id: _editedProduct.id,
                        isFavorite: _editedProduct.isFavorite
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(labelText: "Price"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionNode);
                  },
                  validator: (value) {
                    if(value.isEmpty){
                      return "Please enter a price";
                    }
                    if(double.tryParse(value) == null){
                      return 'Please enter a valid number!';
                    }
                    if(double.parse(value) <= 0){
                      return "Please enter a number!";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        title: _editedProduct.title,
                        price: double.parse(value),
                        description: _editedProduct.description,
                        imageUrl: _editedProduct.imageUrl,
                        id: _editedProduct.id,
                        isFavorite: _editedProduct.isFavorite
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(labelText: "Description"),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                  },
                  validator: (value) {
                    if(value.isEmpty){
                      return "Please enter a description";
                    }
                    if(value.length < 10){
                      return "10자 이상 입력해주세여.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        description: value,
                        imageUrl: _editedProduct.imageUrl,
                        id: _editedProduct.id,
                        isFavorite: _editedProduct.isFavorite
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      alignment: Alignment.center,
                      child: _imageUrlController.text.isEmpty
                          ? Text("Enter a URL")
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        // initialValue: _initValues['imageUrl'],
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        validator: (value) {
                          if(value.isEmpty){
                            return "Please enter image URL";
                          }
                          if(!value.startsWith("http") && !value.startsWith("https")){
                            return "Please enter a valid URL!";
                          }
                          if(!value.endsWith(".png") && !value.endsWith(".jpg") && !value.endsWith(".jpeg")){
                            return "Please enter a valid Image URL!";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              description: _editedProduct.description,
                              imageUrl: value,
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}