// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HistorySearchEntity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHistorySearchEntityCollection on Isar {
  IsarCollection<HistorySearchEntity> get historySearchEntitys =>
      this.collection();
}

const HistorySearchEntitySchema = CollectionSchema(
  name: r'HistorySearchEntity',
  id: 3744925406311137283,
  properties: {
    r'movieName': PropertySchema(
      id: 0,
      name: r'movieName',
      type: IsarType.string,
    ),
    r'searchTime': PropertySchema(
      id: 1,
      name: r'searchTime',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _historySearchEntityEstimateSize,
  serialize: _historySearchEntitySerialize,
  deserialize: _historySearchEntityDeserialize,
  deserializeProp: _historySearchEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'movieName': IndexSchema(
      id: 5194734592820502892,
      name: r'movieName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'movieName',
          type: IndexType.value,
          caseSensitive: true,
        ),
      ],
    ),
    r'searchTime': IndexSchema(
      id: -5754215868534102497,
      name: r'searchTime',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'searchTime',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _historySearchEntityGetId,
  getLinks: _historySearchEntityGetLinks,
  attach: _historySearchEntityAttach,
  version: '3.3.0',
);

int _historySearchEntityEstimateSize(
  HistorySearchEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.movieName.length * 3;
  return bytesCount;
}

void _historySearchEntitySerialize(
  HistorySearchEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.movieName);
  writer.writeDateTime(offsets[1], object.searchTime);
}

HistorySearchEntity _historySearchEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HistorySearchEntity();
  object.id = id;
  object.movieName = reader.readString(offsets[0]);
  object.searchTime = reader.readDateTime(offsets[1]);
  return object;
}

P _historySearchEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _historySearchEntityGetId(HistorySearchEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _historySearchEntityGetLinks(
  HistorySearchEntity object,
) {
  return [];
}

void _historySearchEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  HistorySearchEntity object,
) {
  object.id = id;
}

extension HistorySearchEntityQueryWhereSort
    on QueryBuilder<HistorySearchEntity, HistorySearchEntity, QWhere> {
  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhere>
  anyMovieName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'movieName'),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhere>
  anySearchTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'searchTime'),
      );
    });
  }
}

extension HistorySearchEntityQueryWhere
    on QueryBuilder<HistorySearchEntity, HistorySearchEntity, QWhereClause> {
  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  idNotEqualTo(Id id) {
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

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  idBetween(
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

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  movieNameEqualTo(String movieName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'movieName', value: [movieName]),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  movieNameNotEqualTo(String movieName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'movieName',
                lower: [],
                upper: [movieName],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'movieName',
                lower: [movieName],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'movieName',
                lower: [movieName],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'movieName',
                lower: [],
                upper: [movieName],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  movieNameGreaterThan(String movieName, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'movieName',
          lower: [movieName],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  movieNameLessThan(String movieName, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'movieName',
          lower: [],
          upper: [movieName],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  movieNameBetween(
    String lowerMovieName,
    String upperMovieName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'movieName',
          lower: [lowerMovieName],
          includeLower: includeLower,
          upper: [upperMovieName],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  movieNameStartsWith(String MovieNamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'movieName',
          lower: [MovieNamePrefix],
          upper: ['$MovieNamePrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  movieNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'movieName', value: ['']),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  movieNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'movieName', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'movieName',
                lower: [''],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'movieName',
                lower: [''],
              ),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'movieName', upper: ['']),
            );
      }
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  searchTimeEqualTo(DateTime searchTime) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'searchTime', value: [searchTime]),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  searchTimeNotEqualTo(DateTime searchTime) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'searchTime',
                lower: [],
                upper: [searchTime],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'searchTime',
                lower: [searchTime],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'searchTime',
                lower: [searchTime],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'searchTime',
                lower: [],
                upper: [searchTime],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  searchTimeGreaterThan(DateTime searchTime, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'searchTime',
          lower: [searchTime],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  searchTimeLessThan(DateTime searchTime, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'searchTime',
          lower: [],
          upper: [searchTime],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterWhereClause>
  searchTimeBetween(
    DateTime lowerSearchTime,
    DateTime upperSearchTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'searchTime',
          lower: [lowerSearchTime],
          includeLower: includeLower,
          upper: [upperSearchTime],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension HistorySearchEntityQueryFilter
    on
        QueryBuilder<
          HistorySearchEntity,
          HistorySearchEntity,
          QFilterCondition
        > {
  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
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

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
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

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  idBetween(
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

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  movieNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'movieName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  movieNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'movieName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  movieNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'movieName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  movieNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'movieName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  movieNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'movieName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  movieNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'movieName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  movieNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'movieName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  movieNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'movieName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  movieNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'movieName', value: ''),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  movieNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'movieName', value: ''),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  searchTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'searchTime', value: value),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  searchTimeGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'searchTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  searchTimeLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'searchTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterFilterCondition>
  searchTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'searchTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension HistorySearchEntityQueryObject
    on
        QueryBuilder<
          HistorySearchEntity,
          HistorySearchEntity,
          QFilterCondition
        > {}

extension HistorySearchEntityQueryLinks
    on
        QueryBuilder<
          HistorySearchEntity,
          HistorySearchEntity,
          QFilterCondition
        > {}

extension HistorySearchEntityQuerySortBy
    on QueryBuilder<HistorySearchEntity, HistorySearchEntity, QSortBy> {
  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterSortBy>
  sortByMovieName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieName', Sort.asc);
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterSortBy>
  sortByMovieNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieName', Sort.desc);
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterSortBy>
  sortBySearchTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchTime', Sort.asc);
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterSortBy>
  sortBySearchTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchTime', Sort.desc);
    });
  }
}

extension HistorySearchEntityQuerySortThenBy
    on QueryBuilder<HistorySearchEntity, HistorySearchEntity, QSortThenBy> {
  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterSortBy>
  thenByMovieName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieName', Sort.asc);
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterSortBy>
  thenByMovieNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieName', Sort.desc);
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterSortBy>
  thenBySearchTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchTime', Sort.asc);
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QAfterSortBy>
  thenBySearchTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchTime', Sort.desc);
    });
  }
}

extension HistorySearchEntityQueryWhereDistinct
    on QueryBuilder<HistorySearchEntity, HistorySearchEntity, QDistinct> {
  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QDistinct>
  distinctByMovieName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'movieName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HistorySearchEntity, HistorySearchEntity, QDistinct>
  distinctBySearchTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchTime');
    });
  }
}

extension HistorySearchEntityQueryProperty
    on QueryBuilder<HistorySearchEntity, HistorySearchEntity, QQueryProperty> {
  QueryBuilder<HistorySearchEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HistorySearchEntity, String, QQueryOperations>
  movieNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'movieName');
    });
  }

  QueryBuilder<HistorySearchEntity, DateTime, QQueryOperations>
  searchTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchTime');
    });
  }
}
