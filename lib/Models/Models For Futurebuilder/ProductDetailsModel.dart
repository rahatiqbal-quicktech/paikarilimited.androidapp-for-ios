// class FutureModel_ProductDetails {
//   int? id;
//   String? name;
//   String? slug;
//   String? permalink;
//   String? dateCreated;
//   String? dateCreatedGmt;
//   String? dateModified;
//   String? dateModifiedGmt;
//   String? type;
//   String? status;
//   bool? featured;
//   String? catalogVisibility;
//   String? description;
//   String? shortDescription;
//   String? sku;
//   String? price;
//   String? regularPrice;
//   String? salePrice;
//   String? dateOnSaleFrom;
//   String? dateOnSaleFromGmt;
//   dynamic dateOnSaleTo;
//   dynamic dateOnSaleToGmt;
//   String? priceHtml;
//   bool? onSale;
//   bool? purchasable;
//   int? totalSales;
//   bool? virtual;
//   bool? downloadable;
//   List<dynamic>? downloads;
//   int? downloadLimit;
//   int? downloadExpiry;
//   String? externalUrl;
//   String? buttonText;
//   String? taxStatus;
//   String? taxClass;
//   bool? manageStock;
//   dynamic stockQuantity;
//   String? stockStatus;
//   String? backorders;
//   bool? backordersAllowed;
//   bool? backordered;
//   bool? soldIndividually;
//   String? weight;
//   Dimensions? dimensions;
//   bool? shippingRequired;
//   bool? shippingTaxable;
//   String? shippingClass;
//   int? shippingClassId;
//   bool? reviewsAllowed;
//   String? averageRating;
//   int? ratingCount;
//   List<int>? relatedIds;
//   List<dynamic>? upsellIds;
//   List<dynamic>? crossSellIds;
//   int? parentId;
//   String? purchaseNote;
//   List<Categories>? categories;
//   List<dynamic>? tags;
//   List<Images>? images;
//   List<dynamic>? attributes;
//   List<dynamic>? defaultAttributes;
//   List<dynamic>? variations;
//   List<dynamic>? groupedProducts;
//   int? menuOrder;
//   List<dynamic>? metaData;
//   Links? lLinks;

//   FutureModel_ProductDetails(
//       {this.id,
//       this.name,
//       this.slug,
//       this.permalink,
//       this.dateCreated,
//       this.dateCreatedGmt,
//       this.dateModified,
//       this.dateModifiedGmt,
//       this.type,
//       this.status,
//       this.featured,
//       this.catalogVisibility,
//       this.description,
//       this.shortDescription,
//       this.sku,
//       this.price,
//       this.regularPrice,
//       this.salePrice,
//       this.dateOnSaleFrom,
//       this.dateOnSaleFromGmt,
//       this.dateOnSaleTo,
//       this.dateOnSaleToGmt,
//       this.priceHtml,
//       this.onSale,
//       this.purchasable,
//       this.totalSales,
//       this.virtual,
//       this.downloadable,
//       this.downloads,
//       this.downloadLimit,
//       this.downloadExpiry,
//       this.externalUrl,
//       this.buttonText,
//       this.taxStatus,
//       this.taxClass,
//       this.manageStock,
//       this.stockQuantity,
//       this.stockStatus,
//       this.backorders,
//       this.backordersAllowed,
//       this.backordered,
//       this.soldIndividually,
//       this.weight,
//       this.dimensions,
//       this.shippingRequired,
//       this.shippingTaxable,
//       this.shippingClass,
//       this.shippingClassId,
//       this.reviewsAllowed,
//       this.averageRating,
//       this.ratingCount,
//       this.relatedIds,
//       this.upsellIds,
//       this.crossSellIds,
//       this.parentId,
//       this.purchaseNote,
//       this.categories,
//       this.tags,
//       this.images,
//       this.attributes,
//       this.defaultAttributes,
//       this.variations,
//       this.groupedProducts,
//       this.menuOrder,
//       this.metaData,
//       this.lLinks});

//   FutureModel_ProductDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     permalink = json['permalink'];
//     dateCreated = json['date_created'];
//     dateCreatedGmt = json['date_created_gmt'];
//     dateModified = json['date_modified'];
//     dateModifiedGmt = json['date_modified_gmt'];
//     type = json['type'];
//     status = json['status'];
//     featured = json['featured'];
//     catalogVisibility = json['catalog_visibility'];
//     description = json['description'];
//     shortDescription = json['short_description'];
//     sku = json['sku'];
//     price = json['price'];
//     regularPrice = json['regular_price'];
//     salePrice = json['sale_price'];
//     dateOnSaleFrom = json['date_on_sale_from'];
//     dateOnSaleFromGmt = json['date_on_sale_from_gmt'];
//     dateOnSaleTo = json['date_on_sale_to'];
//     dateOnSaleToGmt = json['date_on_sale_to_gmt'];
//     priceHtml = json['price_html'];
//     onSale = json['on_sale'];
//     purchasable = json['purchasable'];
//     totalSales = json['total_sales'];
//     virtual = json['virtual'];
//     downloadable = json['downloadable'];
//     // if (json['downloads'] != null) {
//     //   downloads = <dynamic>[];
//     //   json['downloads'].forEach((v) {
//     //     downloads!.add(new .fromJson(v));
//     //   });
//     // }
//     downloadLimit = json['download_limit'];
//     downloadExpiry = json['download_expiry'];
//     externalUrl = json['external_url'];
//     buttonText = json['button_text'];
//     taxStatus = json['tax_status'];
//     taxClass = json['tax_class'];
//     manageStock = json['manage_stock'];
//     stockQuantity = json['stock_quantity'];
//     stockStatus = json['stock_status'];
//     backorders = json['backorders'];
//     backordersAllowed = json['backorders_allowed'];
//     backordered = json['backordered'];
//     soldIndividually = json['sold_individually'];
//     weight = json['weight'];
//     dimensions = json['dimensions'] != null
//         ? new Dimensions.fromJson(json['dimensions'])
//         : null;
//     shippingRequired = json['shipping_required'];
//     shippingTaxable = json['shipping_taxable'];
//     shippingClass = json['shipping_class'];
//     shippingClassId = json['shipping_class_id'];
//     reviewsAllowed = json['reviews_allowed'];
//     averageRating = json['average_rating'];
//     ratingCount = json['rating_count'];
//     relatedIds = json['related_ids'].cast<int>();
//     // if (json['upsell_ids'] != null) {
//     //   upsellIds = <dynamic>[];
//     //   json['upsell_ids'].forEach((v) {
//     //     upsellIds!.add( upsellIds!.fromJson(v));
//     //   });
//     // }
//     // if (json['cross_sell_ids'] != null) {
//     //   crossSellIds = <Null>[];
//     //   json['cross_sell_ids'].forEach((v) {
//     //     crossSellIds!.add(new Null.fromJson(v));
//     //   });
//     // }
//     parentId = json['parent_id'];
//     purchaseNote = json['purchase_note'];
//     if (json['categories'] != null) {
//       categories = <Categories>[];
//       json['categories'].forEach((v) {
//         categories!.add(new Categories.fromJson(v));
//       });
//     }
//     tags:
//     // List<dynamic>.from(json["tags"].map((x) => x));
//     // if (json['tags'] != null) {
//     //   tags = [];
//     //   json['tags'].forEach((v) {
//     //     tags!.add(fromJson(v));
//     //   });
//     // }
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(Images.fromJson(v));
//       });
//     }
//     // if (json['attributes'] != null) {
//     //   attributes = <Null>[];
//     //   json['attributes'].forEach((v) {
//     //     attributes!.add(new Null.fromJson(v));
//     //   });
//     // }
//     if (json['default_attributes'] != null) {
//     //   defaultAttributes = <Null>[];
//     //   json['default_attributes'].forEach((v) {
//     //     defaultAttributes!.add(new Null.fromJson(v));
//     //   });
//     // }
//     if (json['variations'] != null) {
//       variations = <Null>[];
//       json['variations'].forEach((v) {
//         variations!.add((json[v].map));
//       });
//     }
//     if (json['grouped_products'] != null) {
//       groupedProducts = <Null>[];
//       json['grouped_products'].forEach((v) {
//         groupedProducts!.add(json[v].map);
//       });
//     }
//     menuOrder = json['menu_order'];
//     // if (json['meta_data'] != null) {
//     //   metaData = <Null>[];
//     //   json['meta_data'].forEach((v) {
//     //     metaData!.add(new Null.fromJson(v));
//     //   });
//     // }
//     // lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     data['permalink'] = this.permalink;
//     data['date_created'] = this.dateCreated;
//     data['date_created_gmt'] = this.dateCreatedGmt;
//     data['date_modified'] = this.dateModified;
//     data['date_modified_gmt'] = this.dateModifiedGmt;
//     data['type'] = this.type;
//     data['status'] = this.status;
//     data['featured'] = this.featured;
//     data['catalog_visibility'] = this.catalogVisibility;
//     data['description'] = this.description;
//     data['short_description'] = this.shortDescription;
//     data['sku'] = this.sku;
//     data['price'] = this.price;
//     data['regular_price'] = this.regularPrice;
//     data['sale_price'] = this.salePrice;
//     data['date_on_sale_from'] = this.dateOnSaleFrom;
//     data['date_on_sale_from_gmt'] = this.dateOnSaleFromGmt;
//     data['date_on_sale_to'] = this.dateOnSaleTo;
//     data['date_on_sale_to_gmt'] = this.dateOnSaleToGmt;
//     data['price_html'] = this.priceHtml;
//     data['on_sale'] = this.onSale;
//     data['purchasable'] = this.purchasable;
//     data['total_sales'] = this.totalSales;
//     data['virtual'] = this.virtual;
//     data['downloadable'] = this.downloadable;
//     if (this.downloads != null) {
//       data['downloads'] = this.downloads!.map((v) => v.toJson()).toList();
//     }
//     data['download_limit'] = this.downloadLimit;
//     data['download_expiry'] = this.downloadExpiry;
//     data['external_url'] = this.externalUrl;
//     data['button_text'] = this.buttonText;
//     data['tax_status'] = this.taxStatus;
//     data['tax_class'] = this.taxClass;
//     data['manage_stock'] = this.manageStock;
//     data['stock_quantity'] = this.stockQuantity;
//     data['stock_status'] = this.stockStatus;
//     data['backorders'] = this.backorders;
//     data['backorders_allowed'] = this.backordersAllowed;
//     data['backordered'] = this.backordered;
//     data['sold_individually'] = this.soldIndividually;
//     data['weight'] = this.weight;
//     if (this.dimensions != null) {
//       data['dimensions'] = this.dimensions!.toJson();
//     }
//     data['shipping_required'] = this.shippingRequired;
//     data['shipping_taxable'] = this.shippingTaxable;
//     data['shipping_class'] = this.shippingClass;
//     data['shipping_class_id'] = this.shippingClassId;
//     data['reviews_allowed'] = this.reviewsAllowed;
//     data['average_rating'] = this.averageRating;
//     data['rating_count'] = this.ratingCount;
//     data['related_ids'] = this.relatedIds;
//     if (this.upsellIds != null) {
//       data['upsell_ids'] = this.upsellIds!.map((v) => v.toJson()).toList();
//     }
//     if (this.crossSellIds != null) {
//       data['cross_sell_ids'] =
//           this.crossSellIds!.map((v) => v.toJson()).toList();
//     }
//     data['parent_id'] = this.parentId;
//     data['purchase_note'] = this.purchaseNote;
//     if (this.categories != null) {
//       data['categories'] = this.categories!.map((v) => v.toJson()).toList();
//     }
//     if (this.tags != null) {
//       data['tags'] = this.tags!.map((v) => v.toJson()).toList();
//     }
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     if (this.attributes != null) {
//       data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
//     }
//     if (this.defaultAttributes != null) {
//       data['default_attributes'] =
//           this.defaultAttributes!.map((v) => v.toJson()).toList();
//     }
//     if (this.variations != null) {
//       data['variations'] = this.variations!.map((v) => v.toJson()).toList();
//     }
//     if (this.groupedProducts != null) {
//       data['grouped_products'] =
//           this.groupedProducts!.map((v) => v.toJson()).toList();
//     }
//     data['menu_order'] = this.menuOrder;
//     if (this.metaData != null) {
//       data['meta_data'] = this.metaData!.map((v) => v.toJson()).toList();
//     }
//     if (this.lLinks != null) {
//       data['_links'] = this.lLinks!.toJson();
//     }
//     return data;
//   }
// }

// class Dimensions {
//   String? length;
//   String? width;
//   String? height;

//   Dimensions({this.length, this.width, this.height});

//   Dimensions.fromJson(Map<String, dynamic> json) {
//     length = json['length'];
//     width = json['width'];
//     height = json['height'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['length'] = this.length;
//     data['width'] = this.width;
//     data['height'] = this.height;
//     return data;
//   }
// }

// class Categories {
//   int? id;
//   String? name;
//   String? slug;

//   Categories({this.id, this.name, this.slug});

//   Categories.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['slug'] = this.slug;
//     return data;
//   }
// }

// class Images {
//   int? id;
//   String? dateCreated;
//   String? dateCreatedGmt;
//   String? dateModified;
//   String? dateModifiedGmt;
//   String? src;
//   String? name;
//   String? alt;

//   Images(
//       {this.id,
//       this.dateCreated,
//       this.dateCreatedGmt,
//       this.dateModified,
//       this.dateModifiedGmt,
//       this.src,
//       this.name,
//       this.alt});

//   Images.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     dateCreated = json['date_created'];
//     dateCreatedGmt = json['date_created_gmt'];
//     dateModified = json['date_modified'];
//     dateModifiedGmt = json['date_modified_gmt'];
//     src = json['src'];
//     name = json['name'];
//     alt = json['alt'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['date_created'] = this.dateCreated;
//     data['date_created_gmt'] = this.dateCreatedGmt;
//     data['date_modified'] = this.dateModified;
//     data['date_modified_gmt'] = this.dateModifiedGmt;
//     data['src'] = this.src;
//     data['name'] = this.name;
//     data['alt'] = this.alt;
//     return data;
//   }
// }

// class Links {
//   List<Self>? self;
//   List<Collection>? collection;

//   Links({this.self, this.collection});

//   Links.fromJson(Map<String, dynamic> json) {
//     if (json['self'] != null) {
//       self = <Self>[];
//       json['self'].forEach((v) {
//         self!.add(new Self.fromJson(v));
//       });
//     }
//     if (json['collection'] != null) {
//       collection = <Collection>[];
//       json['collection'].forEach((v) {
//         collection!.add(new Collection.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.self != null) {
//       data['self'] = this.self!.map((v) => v.toJson()).toList();
//     }
//     if (this.collection != null) {
//       data['collection'] = this.collection!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Self {
//   String? href;

//   Self({this.href});

//   Self.fromJson(Map<String, dynamic> json) {
//     href = json['href'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['href'] = this.href;
//     return data;
//   }
// }
