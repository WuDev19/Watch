// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CountryLocal.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCountryLocalCollection on Isar {
  IsarCollection<CountryLocal> get countryLocals => this.collection();
}

const CountryLocalSchema = CollectionSchema(
  name: r'CountryLocal',
  id: 1370996286407874021,
  properties: {
    r'countryId': PropertySchema(
      id: 0,
      name: r'countryId',
      type: IsarType.string,
    ),
    r'countryName': PropertySchema(
      id: 1,
      name: r'countryName',
      type: IsarType.string,
    ),
    r'countrySlug': PropertySchema(
      id: 2,
      name: r'countrySlug',
      type: IsarType.string,
    ),
  },

  estimateSize: _countryLocalEstimateSize,
  serialize: _countryLocalSerialize,
  deserialize: _countryLocalDeserialize,
  deserializeProp: _countryLocalDeserializeProp,
  idName: r'id',
  indexes: {
    r'countryId': IndexSchema(
      id: -5115696458787596369,
      name: r'countryId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'countryId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'countryName': IndexSchema(
      id: -1763007470810089281,
      name: r'countryName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'countryName',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _countryLocalGetId,
  getLinks: _countryLocalGetLinks,
  attach: _countryLocalAttach,
  version: '3.3.0',
);

int _countryLocalEstimateSize(
  CountryLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.countryId.length * 3;
  bytesCount += 3 + object.countryName.length * 3;
  bytesCount += 3 + object.countrySlug.length * 3;
  return bytesCount;
}

void _countryLocalSerialize(
  CountryLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.countryId);
  writer.writeString(offsets[1], object.countryName);
  writer.writeString(offsets[2], object.countrySlug);
}

CountryLocal _countryLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CountryLocal(
    reader.readString(offsets[0]),
    reader.readString(offsets[1]),
    reader.readString(offsets[2]),
  );
  object.id = id;
  return object;
}

P _countryLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _countryLocalGetId(CountryLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _countryLocalGetLinks(CountryLocal object) {
  return [];
}

void _countryLocalAttach(
  IsarCollection<dynamic> col,
  Id id,
  CountryLocal object,
) {
  object.id = id;
}

extension CountryLocalByIndex on IsarCollection<CountryLocal> {
  Future<CountryLocal?> getByCountryId(String countryId) {
    return getByIndex(r'countryId', [countryId]);
  }

  CountryLocal? getByCountryIdSync(String countryId) {
    return getByIndexSync(r'countryId', [countryId]);
  }

  Future<bool> deleteByCountryId(String countryId) {
    return deleteByIndex(r'countryId', [countryId]);
  }

  bool deleteByCountryIdSync(String countryId) {
    return deleteByIndexSync(r'countryId', [countryId]);
  }

  Future<List<CountryLocal?>> getAllByCountryId(List<String> countryIdValues) {
    final values = countryIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'countryId', values);
  }

  List<CountryLocal?> getAllByCountryIdSync(List<String> countryIdValues) {
    final values = countryIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'countryId', values);
  }

  Future<int> deleteAllByCountryId(List<String> countryIdValues) {
    final values = countryIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'countryId', values);
  }

  int deleteAllByCountryIdSync(List<String> countryIdValues) {
    final values = countryIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'countryId', values);
  }

  Future<Id> putByCountryId(CountryLocal object) {
    return putByIndex(r'countryId', object);
  }

  Id putByCountryIdSync(CountryLocal object, {bool saveLinks = true}) {
    return putByIndexSync(r'countryId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCountryId(List<CountryLocal> objects) {
    return putAllByIndex(r'countryId', objects);
  }

  List<Id> putAllByCountryIdSync(
    List<CountryLocal> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'countryId', objects, saveLinks: saveLinks);
  }
}

extension CountryLocalQueryWhereSort
    on QueryBuilder<CountryLocal, CountryLocal, QWhere> {
  QueryBuilder<CountryLocal, CountryLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CountryLocalQueryWhere
    on QueryBuilder<CountryLocal, CountryLocal, QWhereClause> {
  QueryBuilder<CountryLocal, CountryLocal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterWhereClause> countryIdEqualTo(
    String countryId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'countryId', value: [countryId]),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterWhereClause>
  countryIdNotEqualTo(String countryId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'countryId',
                lower: [],
                upper: [countryId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'countryId',
                lower: [countryId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'countryId',
                lower: [countryId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'countryId',
                lower: [],
                upper: [countryId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterWhereClause>
  countryNameEqualTo(String countryName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'countryName',
          value: [countryName],
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterWhereClause>
  countryNameNotEqualTo(String countryName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'countryName',
                lower: [],
                upper: [countryName],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'countryName',
                lower: [countryName],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'countryName',
                lower: [countryName],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'countryName',
                lower: [],
                upper: [countryName],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension CountryLocalQueryFilter
    on QueryBuilder<CountryLocal, CountryLocal, QFilterCondition> {
  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'countryId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'countryId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'countryId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'countryId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'countryId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'countryId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'countryId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'countryId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'countryId', value: ''),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'countryId', value: ''),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'countryName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'countryName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'countryName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'countryName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'countryName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'countryName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'countryName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'countryName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'countryName', value: ''),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countryNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'countryName', value: ''),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countrySlugEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'countrySlug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countrySlugGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'countrySlug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countrySlugLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'countrySlug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countrySlugBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'countrySlug',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countrySlugStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'countrySlug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countrySlugEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'countrySlug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countrySlugContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'countrySlug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countrySlugMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'countrySlug',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countrySlugIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'countrySlug', value: ''),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition>
  countrySlugIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'countrySlug', value: ''),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension CountryLocalQueryObject
    on QueryBuilder<CountryLocal, CountryLocal, QFilterCondition> {}

extension CountryLocalQueryLinks
    on QueryBuilder<CountryLocal, CountryLocal, QFilterCondition> {}

extension CountryLocalQuerySortBy
    on QueryBuilder<CountryLocal, CountryLocal, QSortBy> {
  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy> sortByCountryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countryId', Sort.asc);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy> sortByCountryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countryId', Sort.desc);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy> sortByCountryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countryName', Sort.asc);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy>
  sortByCountryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countryName', Sort.desc);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy> sortByCountrySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countrySlug', Sort.asc);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy>
  sortByCountrySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countrySlug', Sort.desc);
    });
  }
}

extension CountryLocalQuerySortThenBy
    on QueryBuilder<CountryLocal, CountryLocal, QSortThenBy> {
  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy> thenByCountryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countryId', Sort.asc);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy> thenByCountryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countryId', Sort.desc);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy> thenByCountryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countryName', Sort.asc);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy>
  thenByCountryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countryName', Sort.desc);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy> thenByCountrySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countrySlug', Sort.asc);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy>
  thenByCountrySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'countrySlug', Sort.desc);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension CountryLocalQueryWhereDistinct
    on QueryBuilder<CountryLocal, CountryLocal, QDistinct> {
  QueryBuilder<CountryLocal, CountryLocal, QDistinct> distinctByCountryId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'countryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QDistinct> distinctByCountryName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'countryName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CountryLocal, CountryLocal, QDistinct> distinctByCountrySlug({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'countrySlug', caseSensitive: caseSensitive);
    });
  }
}

extension CountryLocalQueryProperty
    on QueryBuilder<CountryLocal, CountryLocal, QQueryProperty> {
  QueryBuilder<CountryLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CountryLocal, String, QQueryOperations> countryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'countryId');
    });
  }

  QueryBuilder<CountryLocal, String, QQueryOperations> countryNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'countryName');
    });
  }

  QueryBuilder<CountryLocal, String, QQueryOperations> countrySlugProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'countrySlug');
    });
  }
}
