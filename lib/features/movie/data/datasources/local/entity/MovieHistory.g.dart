// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MovieHistory.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMovieHistoryCollection on Isar {
  IsarCollection<MovieHistory> get movieHistorys => this.collection();
}

const MovieHistorySchema = CollectionSchema(
  name: r'MovieHistory',
  id: 659624536140206764,
  properties: {
    r'currentEpisode': PropertySchema(
      id: 0,
      name: r'currentEpisode',
      type: IsarType.object,

      target: r'EpisodeListLocal',
    ),
    r'currentListEpisode': PropertySchema(
      id: 1,
      name: r'currentListEpisode',
      type: IsarType.objectList,

      target: r'EpisodeListLocal',
    ),
    r'episodes': PropertySchema(
      id: 2,
      name: r'episodes',
      type: IsarType.objectList,

      target: r'EpisodeLocal',
    ),
    r'lastWatched': PropertySchema(
      id: 3,
      name: r'lastWatched',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(id: 4, name: r'name', type: IsarType.string),
    r'progress': PropertySchema(
      id: 5,
      name: r'progress',
      type: IsarType.double,
    ),
    r'slug': PropertySchema(id: 6, name: r'slug', type: IsarType.string),
    r'thumbUrl': PropertySchema(
      id: 7,
      name: r'thumbUrl',
      type: IsarType.string,
    ),
    r'total': PropertySchema(id: 8, name: r'total', type: IsarType.long),
  },

  estimateSize: _movieHistoryEstimateSize,
  serialize: _movieHistorySerialize,
  deserialize: _movieHistoryDeserialize,
  deserializeProp: _movieHistoryDeserializeProp,
  idName: r'id',
  indexes: {
    r'slug': IndexSchema(
      id: 6169444064746062836,
      name: r'slug',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'slug',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'lastWatched': IndexSchema(
      id: -3939082614237404951,
      name: r'lastWatched',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'lastWatched',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {
    r'EpisodeListLocal': EpisodeListLocalSchema,
    r'EpisodeLocal': EpisodeLocalSchema,
    r'PageEpisodeLocal': PageEpisodeLocalSchema,
  },

  getId: _movieHistoryGetId,
  getLinks: _movieHistoryGetLinks,
  attach: _movieHistoryAttach,
  version: '3.3.0',
);

int _movieHistoryEstimateSize(
  MovieHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount +=
      3 +
      EpisodeListLocalSchema.estimateSize(
        object.currentEpisode,
        allOffsets[EpisodeListLocal]!,
        allOffsets,
      );
  bytesCount += 3 + object.currentListEpisode.length * 3;
  {
    final offsets = allOffsets[EpisodeListLocal]!;
    for (var i = 0; i < object.currentListEpisode.length; i++) {
      final value = object.currentListEpisode[i];
      bytesCount += EpisodeListLocalSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  bytesCount += 3 + object.episodes.length * 3;
  {
    final offsets = allOffsets[EpisodeLocal]!;
    for (var i = 0; i < object.episodes.length; i++) {
      final value = object.episodes[i];
      bytesCount += EpisodeLocalSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.slug.length * 3;
  bytesCount += 3 + object.thumbUrl.length * 3;
  return bytesCount;
}

void _movieHistorySerialize(
  MovieHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<EpisodeListLocal>(
    offsets[0],
    allOffsets,
    EpisodeListLocalSchema.serialize,
    object.currentEpisode,
  );
  writer.writeObjectList<EpisodeListLocal>(
    offsets[1],
    allOffsets,
    EpisodeListLocalSchema.serialize,
    object.currentListEpisode,
  );
  writer.writeObjectList<EpisodeLocal>(
    offsets[2],
    allOffsets,
    EpisodeLocalSchema.serialize,
    object.episodes,
  );
  writer.writeDateTime(offsets[3], object.lastWatched);
  writer.writeString(offsets[4], object.name);
  writer.writeDouble(offsets[5], object.progress);
  writer.writeString(offsets[6], object.slug);
  writer.writeString(offsets[7], object.thumbUrl);
  writer.writeLong(offsets[8], object.total);
}

MovieHistory _movieHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MovieHistory(
    currentEpisode:
        reader.readObjectOrNull<EpisodeListLocal>(
          offsets[0],
          EpisodeListLocalSchema.deserialize,
          allOffsets,
        ) ??
        EpisodeListLocal(),
    currentListEpisode:
        reader.readObjectList<EpisodeListLocal>(
          offsets[1],
          EpisodeListLocalSchema.deserialize,
          allOffsets,
          EpisodeListLocal(),
        ) ??
        [],
    episodes:
        reader.readObjectList<EpisodeLocal>(
          offsets[2],
          EpisodeLocalSchema.deserialize,
          allOffsets,
          EpisodeLocal(),
        ) ??
        [],
    lastWatched: reader.readDateTime(offsets[3]),
    name: reader.readString(offsets[4]),
    progress: reader.readDouble(offsets[5]),
    slug: reader.readString(offsets[6]),
    thumbUrl: reader.readString(offsets[7]),
    total: reader.readLong(offsets[8]),
  );
  object.id = id;
  return object;
}

P _movieHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<EpisodeListLocal>(
                offset,
                EpisodeListLocalSchema.deserialize,
                allOffsets,
              ) ??
              EpisodeListLocal())
          as P;
    case 1:
      return (reader.readObjectList<EpisodeListLocal>(
                offset,
                EpisodeListLocalSchema.deserialize,
                allOffsets,
                EpisodeListLocal(),
              ) ??
              [])
          as P;
    case 2:
      return (reader.readObjectList<EpisodeLocal>(
                offset,
                EpisodeLocalSchema.deserialize,
                allOffsets,
                EpisodeLocal(),
              ) ??
              [])
          as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _movieHistoryGetId(MovieHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _movieHistoryGetLinks(MovieHistory object) {
  return [];
}

void _movieHistoryAttach(
  IsarCollection<dynamic> col,
  Id id,
  MovieHistory object,
) {
  object.id = id;
}

extension MovieHistoryByIndex on IsarCollection<MovieHistory> {
  Future<MovieHistory?> getBySlug(String slug) {
    return getByIndex(r'slug', [slug]);
  }

  MovieHistory? getBySlugSync(String slug) {
    return getByIndexSync(r'slug', [slug]);
  }

  Future<bool> deleteBySlug(String slug) {
    return deleteByIndex(r'slug', [slug]);
  }

  bool deleteBySlugSync(String slug) {
    return deleteByIndexSync(r'slug', [slug]);
  }

  Future<List<MovieHistory?>> getAllBySlug(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return getAllByIndex(r'slug', values);
  }

  List<MovieHistory?> getAllBySlugSync(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'slug', values);
  }

  Future<int> deleteAllBySlug(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'slug', values);
  }

  int deleteAllBySlugSync(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'slug', values);
  }

  Future<Id> putBySlug(MovieHistory object) {
    return putByIndex(r'slug', object);
  }

  Id putBySlugSync(MovieHistory object, {bool saveLinks = true}) {
    return putByIndexSync(r'slug', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySlug(List<MovieHistory> objects) {
    return putAllByIndex(r'slug', objects);
  }

  List<Id> putAllBySlugSync(
    List<MovieHistory> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'slug', objects, saveLinks: saveLinks);
  }
}

extension MovieHistoryQueryWhereSort
    on QueryBuilder<MovieHistory, MovieHistory, QWhere> {
  QueryBuilder<MovieHistory, MovieHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterWhere> anyLastWatched() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'lastWatched'),
      );
    });
  }
}

extension MovieHistoryQueryWhere
    on QueryBuilder<MovieHistory, MovieHistory, QWhereClause> {
  QueryBuilder<MovieHistory, MovieHistory, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MovieHistory, MovieHistory, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterWhereClause> idBetween(
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

  QueryBuilder<MovieHistory, MovieHistory, QAfterWhereClause> slugEqualTo(
    String slug,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'slug', value: [slug]),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterWhereClause> slugNotEqualTo(
    String slug,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [],
                upper: [slug],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [slug],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [slug],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [],
                upper: [slug],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterWhereClause>
  lastWatchedEqualTo(DateTime lastWatched) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'lastWatched',
          value: [lastWatched],
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterWhereClause>
  lastWatchedNotEqualTo(DateTime lastWatched) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'lastWatched',
                lower: [],
                upper: [lastWatched],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'lastWatched',
                lower: [lastWatched],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'lastWatched',
                lower: [lastWatched],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'lastWatched',
                lower: [],
                upper: [lastWatched],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterWhereClause>
  lastWatchedGreaterThan(DateTime lastWatched, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'lastWatched',
          lower: [lastWatched],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterWhereClause>
  lastWatchedLessThan(DateTime lastWatched, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'lastWatched',
          lower: [],
          upper: [lastWatched],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterWhereClause>
  lastWatchedBetween(
    DateTime lowerLastWatched,
    DateTime upperLastWatched, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'lastWatched',
          lower: [lowerLastWatched],
          includeLower: includeLower,
          upper: [upperLastWatched],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension MovieHistoryQueryFilter
    on QueryBuilder<MovieHistory, MovieHistory, QFilterCondition> {
  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  currentListEpisodeLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'currentListEpisode',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  currentListEpisodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'currentListEpisode', 0, true, 0, true);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  currentListEpisodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'currentListEpisode', 0, false, 999999, true);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  currentListEpisodeLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'currentListEpisode', 0, true, length, include);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  currentListEpisodeLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'currentListEpisode',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  currentListEpisodeLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'currentListEpisode',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  episodesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'episodes', length, true, length, true);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  episodesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'episodes', 0, true, 0, true);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  episodesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'episodes', 0, false, 999999, true);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  episodesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'episodes', 0, true, length, include);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  episodesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'episodes', length, include, 999999, true);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  episodesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  lastWatchedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastWatched', value: value),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  lastWatchedGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastWatched',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  lastWatchedLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastWatched',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  lastWatchedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastWatched',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  progressEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'progress',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  progressGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'progress',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  progressLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'progress',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  progressBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'progress',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> slugEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  slugGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> slugLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> slugBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'slug',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  slugStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> slugEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> slugContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> slugMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'slug',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  slugIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'slug', value: ''),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  slugIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'slug', value: ''),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
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

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
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

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
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

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
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

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
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

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
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

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
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

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
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

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  thumbUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'thumbUrl', value: ''),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  thumbUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'thumbUrl', value: ''),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> totalEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'total', value: value),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  totalGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'total',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> totalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'total',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition> totalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'total',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension MovieHistoryQueryObject
    on QueryBuilder<MovieHistory, MovieHistory, QFilterCondition> {
  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  currentEpisode(FilterQuery<EpisodeListLocal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'currentEpisode');
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  currentListEpisodeElement(FilterQuery<EpisodeListLocal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'currentListEpisode');
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterFilterCondition>
  episodesElement(FilterQuery<EpisodeLocal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'episodes');
    });
  }
}

extension MovieHistoryQueryLinks
    on QueryBuilder<MovieHistory, MovieHistory, QFilterCondition> {}

extension MovieHistoryQuerySortBy
    on QueryBuilder<MovieHistory, MovieHistory, QSortBy> {
  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> sortByLastWatched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWatched', Sort.asc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy>
  sortByLastWatchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWatched', Sort.desc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> sortByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> sortByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> sortBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> sortBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> sortByThumbUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbUrl', Sort.asc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> sortByThumbUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbUrl', Sort.desc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> sortByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.asc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> sortByTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.desc);
    });
  }
}

extension MovieHistoryQuerySortThenBy
    on QueryBuilder<MovieHistory, MovieHistory, QSortThenBy> {
  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> thenByLastWatched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWatched', Sort.asc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy>
  thenByLastWatchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWatched', Sort.desc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> thenByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> thenByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> thenBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> thenBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> thenByThumbUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbUrl', Sort.asc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> thenByThumbUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbUrl', Sort.desc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> thenByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.asc);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QAfterSortBy> thenByTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.desc);
    });
  }
}

extension MovieHistoryQueryWhereDistinct
    on QueryBuilder<MovieHistory, MovieHistory, QDistinct> {
  QueryBuilder<MovieHistory, MovieHistory, QDistinct> distinctByLastWatched() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastWatched');
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QDistinct> distinctByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progress');
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QDistinct> distinctBySlug({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'slug', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QDistinct> distinctByThumbUrl({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thumbUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MovieHistory, MovieHistory, QDistinct> distinctByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'total');
    });
  }
}

extension MovieHistoryQueryProperty
    on QueryBuilder<MovieHistory, MovieHistory, QQueryProperty> {
  QueryBuilder<MovieHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MovieHistory, EpisodeListLocal, QQueryOperations>
  currentEpisodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentEpisode');
    });
  }

  QueryBuilder<MovieHistory, List<EpisodeListLocal>, QQueryOperations>
  currentListEpisodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentListEpisode');
    });
  }

  QueryBuilder<MovieHistory, List<EpisodeLocal>, QQueryOperations>
  episodesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'episodes');
    });
  }

  QueryBuilder<MovieHistory, DateTime, QQueryOperations> lastWatchedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastWatched');
    });
  }

  QueryBuilder<MovieHistory, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<MovieHistory, double, QQueryOperations> progressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progress');
    });
  }

  QueryBuilder<MovieHistory, String, QQueryOperations> slugProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'slug');
    });
  }

  QueryBuilder<MovieHistory, String, QQueryOperations> thumbUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thumbUrl');
    });
  }

  QueryBuilder<MovieHistory, int, QQueryOperations> totalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'total');
    });
  }
}
