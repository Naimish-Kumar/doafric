

import 'package:dio/dio.dart';
import '../db_helper/dialog_helper.dart';
import 'api.dart';

class ApiClient {
  static Dio dio = Dio();

  int total = 0;

  static getHomeApi() async {
    String path = HOME;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});
    try {
      Response response = await dio.get(path, options: options);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      //CustomFunctions.showToast('Error $e');
    }
  }

  static GetProfileDetails({required int id}) async {
    String path = GETUSERDETAILS;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      Response response = await dio.get(path,
          queryParameters: {"user_id": id}, options: options);
      if (response.statusCode == 200) {
        print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static getPrivacyPolicy() async {
    String path = PRIVACYPOLICY;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});
    try {
      Response response = await dio.get(path, options: options);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      //CustomFunctions.showToast('Error $e');
    }
  }

  static getAboutUs() async {
    String path = ABOUTUS;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});
    try {
      Response response = await dio.get(path, options: options);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      //CustomFunctions.showToast('Error $e');
    }
  }

  static getTermsandConditions() async {
    String path = TERMSCONDITION;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});
    try {
      Response response = await dio.get(path, options: options);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      //CustomFunctions.showToast('Error $e');
    }
  }

  static ForgatePassword({
    required String email,
  }) async {
    String path = FORGOTPASSWORD;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {"email": email};

      print(email);
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        print("cart_list_add ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static loginApi({required String email, required String password}) async {
    String path = LOGIN;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {"email": email, "password": password};
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static AddtoCart(
      {required int productid,
      required int userid,
      required String qty}) async {
    String path = ADDTOCART;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      print('add_to_Cart ${productid}, ${userid}, ${qty}');
      var data;
      for (int i = 0; i < int.parse(qty); i++) {
        data = {
          "add_to_cart[${i}][product_id]": productid,
          "add_to_cart[${i}][user_id]": userid,
          "add_to_cart[${i}][qty]": qty
        };
      }

      print('add_to_Cart12 ${data},');
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        print("cart_list_add ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static DeleteAddtoCart({
    required int id,
  }) async {
    String path = DELETEADDTOCART;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {"id": id};

      print(id);
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        print("cart_list_add ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static GetCartList({required int id}) async {
    String path = GETADDTOCART;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      Response response =
          await dio.get(path, queryParameters: {"id": id}, options: options);
      if (response.statusCode == 200) {
        // print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static getorderlist({required int id}) async {
    String path = GETORDERLIST;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      Response response =
          await dio.get(path, queryParameters: {"id": id}, options: options);
      if (response.statusCode == 200) {
        print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static cancleorder({required int id, required String msg}) async {
    String path = CANCELORDER;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {"id": id, "cancellation_reason": msg};
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static getOrderDetails({required int id}) async {
    String path = ORDERDETAILS;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      Response response =
          await dio.get(path, queryParameters: {"id": id}, options: options);
      if (response.statusCode == 200) {
        print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static getCategoryApi() async {
    String path = CATEGORIESLIST;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});
    try {
      Response response = await dio.get(path, options: options);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      //CustomFunctions.showToast('Error $e');
    }
  }

  static getSubCategoryApi({required int category_id}) async {
    String path = SUBCATEGORIESLIST;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});
    try {
      Response response = await dio.get(path,
          queryParameters: {"category_id": category_id}, options: options);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      //CustomFunctions.showToast('Error $e');
    }
  }

  static getBrandListApi() async {
    String path = BRANDLISTS;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});
    try {
      Response response = await dio.get(path, options: options);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      //CustomFunctions.showToast('Error $e');
    }
  }

  static getProductListApi(
      {required int category_id, required int sub_category_id}) async {
    String path = PRODUCTLIST;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});
    try {
      Response response = await dio.get(path,
          queryParameters: {
            "category_id": category_id,
            "sub_category_id": sub_category_id
          },
          options: options);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      //CustomFunctions.showToast('Error $e');
    }
  }

  static getAllProductListApi() async {
    String path = PRODUCTLIST;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});
    try {
      Response response = await dio.get(path, options: options);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      //CustomFunctions.showToast('Error $e');
    }
  }

  static getTaxApi() async {
    String path = TAXLIST;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});
    try {
      Response response = await dio.get(path, options: options);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      //CustomFunctions.showToast('Error $e');
    }
  }

  static getOfferList() async {
    String path = OFFERLIST;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});
    try {
      Response response = await dio.get(path, options: options);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      //CustomFunctions.showToast('Error $e');
    }
  }

  static getProductDetailsApi(
      {required int id,
      required String variant_1,
      required String variant_2,
      required String variant_3}) async {
    String path = PRODUCTDETAILS;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {
        "id": id,
        "variant_1": variant_1,
        "variant_2": variant_2,
        "variant_3": variant_3
      };
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        // print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static getProductDetailsSlugApi({required int slug}) async {
    String path = PRODUCTDETAILS;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {
        "slug": slug,
      };
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        // print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static getDeleteProductApi({required int id}) async {
    String path = DELETEPRODUCT;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {
        "id": id,
      };
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        // print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static deleteSaveProductApi({required int id}) async {
    String path = DELETEWISHLIST;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {
        "id": id,
      };
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        // print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static deleteReviewApi({required int id}) async {
    String path = DELETEREVIEW;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {
        "id": id,
      };
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        // print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static getShowWishlistApi({
    required int id,
  }) async {
    String path = SHOWISHLIST;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      // var data = {
      //   "id": id,
      // };
      Response response =
          await dio.get(path, queryParameters: {"id": id}, options: options);
      // Response response = await dio.get(path, data: data, options: options);
      if (response.statusCode == 200) {
        // print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static addSaveProductApi(
      {required int product_id, required int user_id}) async {
    String path = ADDSAVEPRODUCT;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {
        "product_id": product_id,
        "user_id": user_id,
      };
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        // print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static addReview(
      {required int user_id,
      required int product_id,
      required double rating,
      required String review}) async {
    String path = ADDREVIEW;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {
        "user_id": user_id,
        "product_id": product_id,
        "rating": rating,
        "review": review,
      };
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        // print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static getProductDetailswithVariantApi(
      {required int id,
      required String variant_1,
      required String variant_2}) async {
    String path = PRODUCTDETAILS;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {"id": id, "variant_1": variant_1, "variant_2": variant_2};
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        // print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static getProductVariantApi({required int product_id}) async {
    String path = PRODUCTVARIANT;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {
        "product_id": product_id,
      };
      Response response =
          await dio.get(path, queryParameters: data, options: options);
      if (response.statusCode == 200) {
        // print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static getAddressApi({
    required String full_name,
    required String mobile_no,
    required String address_line_1,
    required String address_line_2,
    required String country,
    required String zip,
    required String state,
    required String email,
  }) async {
    String path = ADDADDRESS;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {
        "full_name": full_name,
        "mobile_no": mobile_no,
        "address_line_1": address_line_1,
        "address_line_2": address_line_2,
        "country": country,
        "zip": zip,
        "state": state,
        "email": email
      };
      Response response =
          await dio.get(path, queryParameters: data, options: options);
      if (response.statusCode == 200) {
        // print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static getCountryApi() async {
    String path = COUNTRYLIST;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});
    try {
      Response response = await dio.get(path, options: options);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      //CustomFunctions.showToast('Error $e');
    }
  }

  static getStateApi({
    required int id,
  }) async {
    String path =
        'https://duafrik.imperialitforweb.com/api/state?country_id=$id';
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});
    try {
      Response response = await dio.get(path, options: options);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      //CustomFunctions.showToast('Error $e');
    }
  }

  static getAddressListApi({
    required int id,
  }) async {
    String path = ADDRESSLIST;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {
        "id": id,
      };
      Response response =
          await dio.get(path, queryParameters: data, options: options);
      if (response.statusCode == 200) {
        // print("login ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static getAddOrder({
    required String userid,
    required String orderduration,
    required String orderquantity,
    required String orderprice,
    required String paymenttype,
    required String orderstatus,
    required String shippingaddess,
    required String billingaddress,
    required String productid1,
    required String qty1,
    required String singleprice1,
    required String totalprice1,
    required String productid2,
    required String qty2,
    required String singleprice2,
    required String totalprice2,
    required String gstbilling,
    required String gstnumber,
    required String companyname,
    required String usertype,
    required String shipingfee,
    required String taxfee,
    required List allData,
  }) async {
    try {
      Map<String, String> data = {
        "user_id": userid,
        "order_duration": orderduration,
        "order_quantity": orderquantity,
        "order_price": orderprice,
        "payment_type": paymenttype,
        "order_status": orderstatus,
        "shipping_addess": shippingaddess,
        "billing_address": billingaddress,
        "gst_billing": gstbilling,
        "gst_number": gstnumber,
        "company_name": companyname,
        "user_type": usertype,
        "shiping_fee": shipingfee,
        "tax_fee": taxfee,
      };

      for (int i = 0; i < allData.length; i++) {
        data["order_product[${i}]['product_id']"] =
            allData[i]['product_id'].toString();
        data["order_product[${i}]['qty']"] = allData[i]['qty'].toString();
        data["order_product[${i}]['single_price']"] =
            allData[i]['product']["sale_price"].toString();
        data["order_product[${i}]['total_price']"] =
            (allData[i]['product']["regular_price"] * allData[i]['qty'])
                .toString();
        data["order_product[${i}]['variant_id']"] =
            allData[i]['variant_id'] ?? "";
      }

      print(data);
      Response res = await dio.post(
        "https://duafrik.imperialitforweb.com/api/add_order",
        data: FormData.fromMap(data),
      );

      print(res.data);
      if (res.statusCode == 200) {
        print("login ${res.data}");
        return res.data;
      } else {
        print("elseloginff ${res.data}");

        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static removeallcart({
    required int user_id,
  }) async {
    String path = REMOVEALLCART;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {"user_id": user_id};

      print(user_id);
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        print("cart_list_add ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static deletewishlist({
    required int id,
  }) async {
    String path = DELETEWISHLIST;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {"id": id};

      print(id);
      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        print("cart_list_add ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static resendmail({
    required String email,
  }) async {
    String path = RESENDMAIL;
    Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {Headers.acceptHeader: 'application/json'});

    try {
      var data = {"email": email};

      Response response = await dio.post(path, data: data, options: options);
      if (response.statusCode == 200) {
        print("cart_list_add ${response.data}");
        return response.data;
      } else {
        throw Exception('Authentication Error');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        DialogHelper.hideLoading();
        DialogHelper.showFlutterToast(
            strMsg: 'Please Check Internet Connection');
      }
    }
  }

  static signUpApi({required}) {}
}
