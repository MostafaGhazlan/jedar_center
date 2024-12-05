import 'package:flutter_application_1/core/params/base_params.dart';
import 'package:flutter_application_1/core/usecase/usecase.dart';
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/results/result.dart';
import '../../../matrix/data/model/matrix.dart';
import '../repositiory/search_repositiory.dart';

class SearchParams extends BaseParams {
  String? term;
  int? discountFrom;
  int? discountTo;
  int? priceFrom;
  int? priceTo;
  String? sorting;
  List<String>? categoryIds;
  List<int>? categoryIntIds;
  List<String>? brandIds;
  bool? isDiscount;
  bool? sortByDiscount;
  bool? sortByPriceAsc;
  bool? sortByPriceDesc;
  final GetListRequest? request;

  SearchParams({
    this.term,
    this.brandIds,
    this.categoryIds,
    this.categoryIntIds,
    this.discountFrom,
    this.discountTo,
    this.priceFrom,
    this.priceTo,
    this.isDiscount,
    this.sortByDiscount,
    this.sortByPriceAsc,
    this.sortByPriceDesc,
    this.sorting,
    required this.request,
  });

  SearchParams copyWith({
    String? term,
    int? discountFrom,
    int? discountTo,
    int? priceFrom,
    int? priceTo,
    String? sorting,
    List<String>? categoryIds,
    List<int>? categoryIntIds,
    List<String>? brandIds,
    bool? isDiscount,
    bool? sortByDiscount,
    bool? sortByPriceAsc,
    bool? sortByPriceDesc,
    GetListRequest? request,
  }) {
    return SearchParams(
      term: term ?? this.term,
      discountFrom: discountFrom ?? this.discountFrom,
      discountTo: discountTo ?? this.discountTo,
      priceFrom:priceFrom ?? this.priceFrom,
      priceTo: priceTo ?? this.priceTo,
      sorting: sorting ?? this.sorting,
      categoryIds: categoryIds ?? this.categoryIds,
      categoryIntIds: categoryIntIds ?? this.categoryIntIds,
      brandIds: brandIds ?? this.brandIds,
      isDiscount: isDiscount ?? this.isDiscount,
      sortByDiscount: sortByDiscount ?? this.sortByDiscount,
      sortByPriceAsc: sortByPriceAsc ?? this.sortByPriceAsc,
      sortByPriceDesc: sortByPriceDesc ?? this.sortByPriceDesc,
      request: request ?? this.request,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (request != null) data.addAll(request!.toJson());

    if (term != null && term!.isNotEmpty) data["Term"] = term;
    if (isDiscount != null && isDiscount != false) {
      data["IsDiscount"] = isDiscount;
    }
    if (sortByPriceDesc != null && sortByPriceDesc != false) {
      data["SortByPriceDesc"] = sortByPriceDesc;
    }
    if (sortByPriceAsc != null && sortByPriceAsc != false) {
      data["SortByPriceAsc"] = sortByPriceAsc;
    }
    if (sortByDiscount != null && sortByDiscount != false) {
      data["SortByDiscount"] = sortByDiscount;
    }
    if (discountFrom != null && discountFrom != 0.0) {
      data["DiscountFrom"] = discountFrom;
    }
    if (discountTo != null && discountTo != 0.0) {
      data["DiscountTo"] = discountTo;
    }
    if (priceFrom != null && priceFrom != 0.0) {
      data["PriceFrom"] = priceFrom;
    }
    if (priceTo != null && priceTo != 0.0) {
      data["PriceTo"] = priceTo;
    }
    if (categoryIds != null && categoryIds!.isNotEmpty) {
      data["CategoryIds"] = categoryIds;
    }
    if (categoryIntIds != null && categoryIntIds!.isNotEmpty) {
      data["CategoryIntIds"] = categoryIntIds;
    }
    if (brandIds != null && brandIds!.isNotEmpty) data["BrandIds"] = brandIds;
    if (sorting != null && sorting!.isNotEmpty) data["Sorting"] = sorting;

    return data;
  }
}

class SearchUsecase extends UseCase<List<MatrixModel>, SearchParams> {
  late final SearchRepository repository;
  SearchUsecase(this.repository);

  @override
  Future<Result<List<MatrixModel>>> call({required SearchParams params}) {
    return repository.searchRequest(params: params);
  }
}
