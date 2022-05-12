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

  PageImpl(
      {this.content,
        this.pageable,
        this.last,
        this.totalElements,
        this.totalPages,
        this.size,
        this.number,
        this.sort,
        this.first,
        this.numberOfElements,
        this.empty});

  PageImpl.fromJson(Map<String, dynamic> json) {
    if (json[CONTENT] != null) {
      content = [];
      json[CONTENT].forEach((v) {
        content!.add(v);
      });
    }
    pageable =
    json[PAGEABLE] != null ? new Pageable.fromJson(json[PAGEABLE]) : null;
    last = json[LAST];
    totalElements = json[TOTAL_ELEMENTS];
    totalPages = json[TOTAL_PAGES];
    size = json[SIZE];
    number = json[NUMBER];
    sort = json[SORT] != null ? new Sort.fromJson(json[SORT]) : null;
    first = json[FIRST];
    numberOfElements = json[NUMBER_OF_ELEMENTS];
    empty = json[EMPTY];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data[CONTENT] = this.content!.toList();
    }
    if (this.pageable != null) {
      data[PAGEABLE] = this.pageable!.toJson();
    }
    data[LAST] = this.last;
    data[TOTAL_ELEMENTS] = this.totalElements;
    data[TOTAL_PAGES] = this.totalPages;
    data[SIZE] = this.size;
    data[NUMBER] = this.number;
    if (this.sort != null) {
      data[SORT] = this.sort!.toJson();
    }
    data[FIRST] = this.first;
    data[NUMBER_OF_ELEMENTS] = this.numberOfElements;
    data[EMPTY] = this.empty;
    return data;
  }
}

class Pageable {
  static const String SORT = 'sort';
  static const String OFFSET = 'offset';
  static const String PAGE_SIZE = 'pageSize';
  static const String PAGE_NUMBER = 'pageNumber';
  static const String PAGED = 'paged';
  static const String UNPAGED = 'unpaged';

  Sort? sort;
  int? offset;
  int? pageSize;
  int? pageNumber;
  bool? paged;
  bool? unpaged;

  Pageable(
      {this.sort,
        this.offset,
        this.pageSize,
        this.pageNumber,
        this.paged,
        this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json[SORT] != null ? new Sort.fromJson(json[SORT]) : null;
    offset = json[OFFSET];
    pageSize = json[PAGE_SIZE];
    pageNumber = json[PAGE_NUMBER];
    paged = json[PAGED];
    unpaged = json[UNPAGED];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sort != null) {
      data[SORT] = this.sort!.toJson();
    }
    data[OFFSET] = this.offset;
    data[PAGE_SIZE] = this.pageSize;
    data[PAGE_NUMBER] = this.pageNumber;
    data[PAGED] = this.paged;
    data[UNPAGED] = this.unpaged;
    return data;
  }
}

class Sort {
  static const String SORTED = 'sorted';
  static const String UNSORTED = 'unsorted';
  static const String EMPTY = 'empty';

  bool? sorted;
  bool? unsorted;
  bool? empty;

  Sort({this.sorted, this.unsorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json[SORTED];
    unsorted = json[UNSORTED];
    empty = json[EMPTY];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[SORTED] = this.sorted;
    data[UNSORTED] = this.unsorted;
    data[EMPTY] = this.empty;
    return data;
  }
}
