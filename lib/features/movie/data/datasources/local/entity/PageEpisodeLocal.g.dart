// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PageEpisodeLocal.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PageEpisodeLocalSchema = Schema(
  name: r'PageEpisodeLocal',
  id: -343848043845120574,
  properties: {
    r'episodeList': PropertySchema(
      id: 0,
      name: r'episodeList',
      type: IsarType.objectList,

      target: r'EpisodeListLocal',
    ),
    r'page': PropertySchema(id: 1, name: r'page', type: IsarType.long),
  },

  estimateSize: _pageEpisodeLocalEstimateSize,
  serialize: _pageEpisodeLocalSerialize,
  deserialize: _pageEpisodeLocalDeserialize,
  deserializeProp: _pageEpisodeLocalDeserializeProp,
);

int _pageEpisodeLocalEstimateSize(
  PageEpisodeLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.episodeList.length * 3;
  {
    final offsets = allOffsets[EpisodeListLocal]!;
    for (var i = 0; i < object.episodeList.length; i++) {
      final value = object.episodeList[i];
      bytesCount += EpisodeListLocalSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  return bytesCount;
}

void _pageEpisodeLocalSerialize(
  PageEpisodeLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<EpisodeListLocal>(
    offsets[0],
    allOffsets,
    EpisodeListLocalSchema.serialize,
    object.episodeList,
  );
  writer.writeLong(offsets[1], object.page);
}

PageEpisodeLocal _pageEpisodeLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PageEpisodeLocal();
  object.episodeList =
      reader.readObjectList<EpisodeListLocal>(
        offsets[0],
        EpisodeListLocalSchema.deserialize,
        allOffsets,
        EpisodeListLocal(),
      ) ??
      [];
  object.page = reader.readLong(offsets[1]);
  return object;
}

P _pageEpisodeLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<EpisodeListLocal>(
                offset,
                EpisodeListLocalSchema.deserialize,
                allOffsets,
                EpisodeListLocal(),
              ) ??
              [])
          as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PageEpisodeLocalQueryFilter
    on QueryBuilder<PageEpisodeLocal, PageEpisodeLocal, QFilterCondition> {
  QueryBuilder<PageEpisodeLocal, PageEpisodeLocal, QAfterFilterCondition>
  episodeListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'episodeList', length, true, length, true);
    });
  }

  QueryBuilder<PageEpisodeLocal, PageEpisodeLocal, QAfterFilterCondition>
  episodeListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'episodeList', 0, true, 0, true);
    });
  }

  QueryBuilder<PageEpisodeLocal, PageEpisodeLocal, QAfterFilterCondition>
  episodeListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'episodeList', 0, false, 999999, true);
    });
  }

  QueryBuilder<PageEpisodeLocal, PageEpisodeLocal, QAfterFilterCondition>
  episodeListLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'episodeList', 0, true, length, include);
    });
  }

  QueryBuilder<PageEpisodeLocal, PageEpisodeLocal, QAfterFilterCondition>
  episodeListLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'episodeList', length, include, 999999, true);
    });
  }

  QueryBuilder<PageEpisodeLocal, PageEpisodeLocal, QAfterFilterCondition>
  episodeListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'episodeList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PageEpisodeLocal, PageEpisodeLocal, QAfterFilterCondition>
  pageEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'page', value: value),
      );
    });
  }

  QueryBuilder<PageEpisodeLocal, PageEpisodeLocal, QAfterFilterCondition>
  pageGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'page',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PageEpisodeLocal, PageEpisodeLocal, QAfterFilterCondition>
  pageLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'page',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PageEpisodeLocal, PageEpisodeLocal, QAfterFilterCondition>
  pageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'page',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension PageEpisodeLocalQueryObject
    on QueryBuilder<PageEpisodeLocal, PageEpisodeLocal, QFilterCondition> {
  QueryBuilder<PageEpisodeLocal, PageEpisodeLocal, QAfterFilterCondition>
  episodeListElement(FilterQuery<EpisodeListLocal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'episodeList');
    });
  }
}
