class PageImpl {
  static const String CONTENT = 'content';
  static const String PAGEABLE = 'pageable';
  static const String LAST = 'last';
  static const String TOTAL_ELEMENTS = 'totalElements';
  static const String TOTAL_PAGES = 'totalPages';
  static const String SIZE = 'size';
  static const String NUMBER = 'number';
  static const String SORT = 'sort';
  static const String FIRST = 'first';
  static const String NUMBER_OF_ELEMENTS = 'numberOfElements';
  static const String EMPTY = 'empty';

  List<dynamic>? content;
  Pageable? pageable;
  bool? last;
  int? totalElements;
  int? totalPages;
  int? size;
  int? number;
  Sort? sort;
  bool? first;
  int? numberOfElements;
  bool? empty;

  PageImpl({
    content,
    pageable,
    last,
    totalElements,
    totalPages,
    size,
    number,
    sort,
    first,
    numberOfElements,
    empty,
  });

  PageImpl.fromJson(Map<String, dynamic> json) {
    if (json[CONTENT] != null) {
      content = [];
      json[CONTENT].forEach((v) {
        content!.add(v);
      });
    }
    pageable =
        json[PAGEABLE] != null ? Pageable.fromJson(json[PAGEABLE]) : null;
    last = json[LAST];
    totalElements = json[TOTAL_ELEMENTS];
    totalPages = json[TOTAL_PAGES];
    size = json[SIZE];
    number = json[NUMBER];
    sort = json[SORT] != null ? Sort.fromJson(json[SORT]) : null;
    first = json[FIRST];
    numberOfElements = json[NUMBER_OF_ELEMENTS];
    empty = json[EMPTY];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data[CONTENT] = content!.toList();
    }
    if (pageable != null) {
      data[PAGEABLE] = pageable!.toJson();
    }
    data[LAST] = last;
    data[TOTAL_ELEMENTS] = totalElements;
    data[TOTAL_PAGES] = totalPages;
    data[SIZE] = size;
    data[NUMBER] = number;
    if (sort != null) {
      data[SORT] = sort!.toJson();
    }
    data[FIRST] = first;
    data[NUMBER_OF_ELEMENTS] = numberOfElements;
    data[EMPTY] = empty;
    return data;
  }
}

class Pageable {
  static String SORT = 'sort';
  static String OFFSET = 'offset';
  static String PAGE_SIZE = 'pageSize';
  static String PAGE_NUMBER = 'pageNumber';
  static String PAGED = 'paged';
  static String UNPAGED = 'unpaged';

  Sort? sort;
  int? offset;
  int? pageSize;
  int? pageNumber;
  bool? paged;
  bool? unpaged;

  Pageable({sort, offset, pageSize, pageNumber, paged, unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json[SORT] != null ? Sort.fromJson(json[SORT]) : null;
    offset = json[OFFSET];
    pageSize = json[PAGE_SIZE];
    pageNumber = json[PAGE_NUMBER];
    paged = json[PAGED];
    unpaged = json[UNPAGED];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sort != null) {
      data[SORT] = sort!.toJson();
    }
    data[OFFSET] = offset;
    data[PAGE_SIZE] = pageSize;
    data[PAGE_NUMBER] = pageNumber;
    data[PAGED] = paged;
    data[UNPAGED] = unpaged;
    return data;
  }
}

class Sort {
  static String SORTED = 'sorted';
  static String UNSORTED = 'unsorted';
  static String EMPTY = 'empty';

  bool? sorted;
  bool? unsorted;
  bool? empty;

  Sort({sorted, unsorted, empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json[SORTED];
    unsorted = json[UNSORTED];
    empty = json[EMPTY];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[SORTED] = sorted;
    data[UNSORTED] = unsorted;
    data[EMPTY] = empty;
    return data;
  }
}
