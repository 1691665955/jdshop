// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:jdshop/model/cate_model_entity.dart';
import 'package:jdshop/generated/json/cate_model_entity_helper.dart';
import 'package:jdshop/model/focus_model_entity.dart';
import 'package:jdshop/generated/json/focus_model_entity_helper.dart';
import 'package:jdshop/model/product_detail_model_entity.dart';
import 'package:jdshop/generated/json/product_detail_model_entity_helper.dart';
import 'package:jdshop/model/product_model_entity.dart';
import 'package:jdshop/generated/json/product_model_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {			case CateModelEntity:
			return cateModelEntityFromJson(data as CateModelEntity, json) as T;			case CateModelResult:
			return cateModelResultFromJson(data as CateModelResult, json) as T;			case FocusModelEntity:
			return focusModelEntityFromJson(data as FocusModelEntity, json) as T;			case FocusModelResult:
			return focusModelResultFromJson(data as FocusModelResult, json) as T;			case ProductDetailModelEntity:
			return productDetailModelEntityFromJson(data as ProductDetailModelEntity, json) as T;			case ProductDetailModelResult:
			return productDetailModelResultFromJson(data as ProductDetailModelResult, json) as T;			case ProductDetailModelResultAttr:
			return productDetailModelResultAttrFromJson(data as ProductDetailModelResultAttr, json) as T;			case ProductModelEntity:
			return productModelEntityFromJson(data as ProductModelEntity, json) as T;			case ProductModelResult:
			return productModelResultFromJson(data as ProductModelResult, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {			case CateModelEntity:
			return cateModelEntityToJson(data as CateModelEntity);			case CateModelResult:
			return cateModelResultToJson(data as CateModelResult);			case FocusModelEntity:
			return focusModelEntityToJson(data as FocusModelEntity);			case FocusModelResult:
			return focusModelResultToJson(data as FocusModelResult);			case ProductDetailModelEntity:
			return productDetailModelEntityToJson(data as ProductDetailModelEntity);			case ProductDetailModelResult:
			return productDetailModelResultToJson(data as ProductDetailModelResult);			case ProductDetailModelResultAttr:
			return productDetailModelResultAttrToJson(data as ProductDetailModelResultAttr);			case ProductModelEntity:
			return productModelEntityToJson(data as ProductModelEntity);			case ProductModelResult:
			return productModelResultToJson(data as ProductModelResult);    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {			case 'CateModelEntity':
			return CateModelEntity().fromJson(json);			case 'CateModelResult':
			return CateModelResult().fromJson(json);			case 'FocusModelEntity':
			return FocusModelEntity().fromJson(json);			case 'FocusModelResult':
			return FocusModelResult().fromJson(json);			case 'ProductDetailModelEntity':
			return ProductDetailModelEntity().fromJson(json);			case 'ProductDetailModelResult':
			return ProductDetailModelResult().fromJson(json);			case 'ProductDetailModelResultAttr':
			return ProductDetailModelResultAttr().fromJson(json);			case 'ProductModelEntity':
			return ProductModelEntity().fromJson(json);			case 'ProductModelResult':
			return ProductModelResult().fromJson(json);    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {			case 'CateModelEntity':
			return List<CateModelEntity>();			case 'CateModelResult':
			return List<CateModelResult>();			case 'FocusModelEntity':
			return List<FocusModelEntity>();			case 'FocusModelResult':
			return List<FocusModelResult>();			case 'ProductDetailModelEntity':
			return List<ProductDetailModelEntity>();			case 'ProductDetailModelResult':
			return List<ProductDetailModelResult>();			case 'ProductDetailModelResultAttr':
			return List<ProductDetailModelResultAttr>();			case 'ProductModelEntity':
			return List<ProductModelEntity>();			case 'ProductModelResult':
			return List<ProductModelResult>();    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}