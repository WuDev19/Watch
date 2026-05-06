// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FavoriteMovie.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFavoriteMovieCollection on Isar {
  IsarCollection<FavoriteMovie> get favoriteMovies => this.collection();
}

const FavoriteMovieSchema = CollectionSchema(
  name: r'FavoriteMovie',
  id: 4711810972251588754,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'movieName': PropertySchema(
      id: 1,
      name: r'movieName',
      type: IsarType.string,
    ),
    r'movieSlug': PropertySchema(
      id: 2,
      name: r'movieSlug',
      type: IsarType.string,
    ),
    r'thumbUrl': PropertySchema(
      id: 3,
      name: r'thumbUrl',
      type: IsarType.string,
    ),
  },

  estimateSize: _favoriteMovieEstimateSize,
  serialize: _favoriteMovieSerialize,
  deserialize: _favoriteMovieDeserialize,
  deserializeProp: _favoriteMovieDeserializeProp,
  idName: r'id',
  indexes: {
    r'movieSlug': IndexSchema(
      id: 4321233994723338128,
      name: r'movieSlug',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'movieSlug',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _favoriteMovieGetId,
  getLinks: _favoriteMovieGetLinks,
  attach: _favoriteMovieAttach,
  version: '3.3.0',
);

int _favoriteMovieEstimateSize(
  FavoriteMovie object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.movieName.length * 3;
  bytesCount += 3 + object.movieSlug.length * 3;
  bytesCount += 3 + object.thumbUrl.length * 3;
  return bytesCount;
}

void _favoriteMovieSerialize(
  FavoriteMovie object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.movieName);
  writer.writeString(offsets[2], object.movieSlug);
  writer.writeString(offsets[3], object.thumbUrl);
}

FavoriteMovie _favoriteMovieDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FavoriteMovie(
    createdAt: reader.readDateTime(offsets[0]),
    movieName: reader.readString(offsets[1]),
    movieSlug: reader.readString(offsets[2]),
    thumbUrl: reader.readString(offsets[3]),
  );
  object.id = id;
  return object;
}

P _favoriteMovieDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _favoriteMovieGetId(FavoriteMovie object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _favoriteMovieGetLinks(FavoriteMovie object) {
  return [];
}

void _favoriteMovieAttach(
  IsarCollection<dynamic> col,
  Id id,
  FavoriteMovie object,
) {
  object.id = id;
}

extension FavoriteMovieByIndex on IsarCollection<FavoriteMovie> {
  Future<FavoriteMovie?> getByMovieSlug(String movieSlug) {
    return getByIndex(r'movieSlug', [movieSlug]);
  }

  FavoriteMovie? getByMovieSlugSync(String movieSlug) {
    return getByIndexSync(r'movieSlug', [movieSlug]);
  }

  Future<bool> deleteByMovieSlug(String movieSlug) {
    return deleteByIndex(r'movieSlug', [movieSlug]);
  }

  bool deleteByMovieSlugSync(String movieSlug) {
    return deleteByIndexSync(r'movieSlug', [movieSlug]);
  }

  Future<List<FavoriteMovie?>> getAllByMovieSlug(List<String> movieSlugValues) {
    final values = movieSlugValues.map((e) => [e]).toList();
    return getAllByIndex(r'movieSlug', values);
  }

  List<FavoriteMovie?> getAllByMovieSlugSync(List<String> movieSlugValues) {
    final values = movieSlugValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'movieSlug', values);
  }

  Future<int> deleteAllByMovieSlug(List<String> movieSlugValues) {
    final values = movieSlugValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'movieSlug', values);
  }

  int deleteAllByMovieSlugSync(List<String> movieSlugValues) {
    final values = movieSlugValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'movieSlug', values);
  }

  Future<Id> putByMovieSlug(FavoriteMovie object) {
    return putByIndex(r'movieSlug', object);
  }

  Id putByMovieSlugSync(FavoriteMovie object, {bool saveLinks = true}) {
    return putByIndexSync(r'movieSlug', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMovieSlug(List<FavoriteMovie> objects) {
    return putAllByIndex(r'movieSlug', objects);
  }

  List<Id> putAllByMovieSlugSync(
    List<FavoriteMovie> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'movieSlug', objects, saveLinks: saveLinks);
  }
}

extension FavoriteMovieQueryWhereSort
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QWhere> {
  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension FavoriteMovieQueryWhere
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QWhereClause> {
  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause> idBetween(
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause>
  movieSlugEqualTo(String movieSlug) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'movieSlug', value: [movieSlug]),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause>
  movieSlugNotEqualTo(String movieSlug) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'movieSlug',
                lower: [],
                upper: [movieSlug],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'movieSlug',
                lower: [movieSlug],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'movieSlug',
                lower: [movieSlug],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'movieSlug',
                lower: [],
                upper: [movieSlug],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause>
  createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'createdAt', value: [createdAt]),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause>
  createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [],
                upper: [createdAt],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [createdAt],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [createdAt],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [],
                upper: [createdAt],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause>
  createdAtGreaterThan(DateTime createdAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [createdAt],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause>
  createdAtLessThan(DateTime createdAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [],
          upper: [createdAt],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause>
  createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [lowerCreatedAt],
          includeLower: includeLower,
          upper: [upperCreatedAt],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension FavoriteMovieQueryFilter
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QFilterCondition> {
  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  movieNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'movieName', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  movieNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'movieName', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  movieSlugEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'movieSlug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  movieSlugGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'movieSlug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  movieSlugLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'movieSlug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  movieSlugBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'movieSlug',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  movieSlugStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'movieSlug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  movieSlugEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'movieSlug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  movieSlugContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'movieSlug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  movieSlugMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'movieSlug',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  movieSlugIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'movieSlug', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  movieSlugIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'movieSlug', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  thumbUrlEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'thumbUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  thumbUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'thumbUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  thumbUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'thumbUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  thumbUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'thumbUrl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  thumbUrlStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'thumbUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  thumbUrlEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'thumbUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  thumbUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'thumbUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  thumbUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'thumbUrl',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  thumbUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'thumbUrl', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
  thumbUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'thumbUrl', value: ''),
      );
    });
  }
}

extension FavoriteMovieQueryObject
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QFilterCondition> {}

extension FavoriteMovieQueryLinks
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QFilterCondition> {}

extension FavoriteMovieQuerySortBy
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QSortBy> {
  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> sortByMovieName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieName', Sort.asc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy>
  sortByMovieNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieName', Sort.desc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> sortByMovieSlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieSlug', Sort.asc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy>
  sortByMovieSlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieSlug', Sort.desc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> sortByThumbUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbUrl', Sort.asc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy>
  sortByThumbUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbUrl', Sort.desc);
    });
  }
}

extension FavoriteMovieQuerySortThenBy
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QSortThenBy> {
  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> thenByMovieName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieName', Sort.asc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy>
  thenByMovieNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieName', Sort.desc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> thenByMovieSlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieSlug', Sort.asc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy>
  thenByMovieSlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieSlug', Sort.desc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> thenByThumbUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbUrl', Sort.asc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy>
  thenByThumbUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbUrl', Sort.desc);
    });
  }
}

extension FavoriteMovieQueryWhereDistinct
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QDistinct> {
  QueryBuilder<FavoriteMovie, FavoriteMovie, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QDistinct> distinctByMovieName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'movieName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QDistinct> distinctByMovieSlug({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'movieSlug', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QDistinct> distinctByThumbUrl({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thumbUrl', caseSensitive: caseSensitive);
    });
  }
}

extension FavoriteMovieQueryProperty
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QQueryProperty> {
  QueryBuilder<FavoriteMovie, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FavoriteMovie, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FavoriteMovie, String, QQueryOperations> movieNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'movieName');
    });
  }

  QueryBuilder<FavoriteMovie, String, QQueryOperations> movieSlugProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'movieSlug');
    });
  }

  QueryBuilder<FavoriteMovie, String, QQueryOperations> thumbUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thumbUrl');
    });
  }
}
