// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EpisodeLocal.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const EpisodeLocalSchema = Schema(
  name: r'EpisodeLocal',
  id: -6671020244601315233,
  properties: {
    r'paginationEpisode': PropertySchema(
      id: 0,
      name: r'paginationEpisode',
      type: IsarType.objectList,

      target: r'PageEpisodeLocal',
    ),
    r'serverName': PropertySchema(
      id: 1,
      name: r'serverName',
      type: IsarType.string,
    ),
  },

  estimateSize: _episodeLocalEstimateSize,
  serialize: _episodeLocalSerialize,
  deserialize: _episodeLocalDeserialize,
  deserializeProp: _episodeLocalDeserializeProp,
);

int _episodeLocalEstimateSize(
  EpisodeLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.paginationEpisode.length * 3;
  {
    final offsets = allOffsets[PageEpisodeLocal]!;
    for (var i = 0; i < object.paginationEpisode.length; i++) {
      final value = object.paginationEpisode[i];
      bytesCount += PageEpisodeLocalSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  bytesCount += 3 + object.serverName.length * 3;
  return bytesCount;
}

void _episodeLocalSerialize(
  EpisodeLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<PageEpisodeLocal>(
    offsets[0],
    allOffsets,
    PageEpisodeLocalSchema.serialize,
    object.paginationEpisode,
  );
  writer.writeString(offsets[1], object.serverName);
}

EpisodeLocal _episodeLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EpisodeLocal();
  object.paginationEpisode =
      reader.readObjectList<PageEpisodeLocal>(
        offsets[0],
        PageEpisodeLocalSchema.deserialize,
        allOffsets,
        PageEpisodeLocal(),
      ) ??
      [];
  object.serverName = reader.readString(offsets[1]);
  return object;
}

P _episodeLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<PageEpisodeLocal>(
                offset,
                PageEpisodeLocalSchema.deserialize,
                allOffsets,
                PageEpisodeLocal(),
              ) ??
              [])
          as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension EpisodeLocalQueryFilter
    on QueryBuilder<EpisodeLocal, EpisodeLocal, QFilterCondition> {
  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  paginationEpisodeLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'paginationEpisode', length, true, length, true);
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  paginationEpisodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'paginationEpisode', 0, true, 0, true);
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  paginationEpisodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'paginationEpisode', 0, false, 999999, true);
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  paginationEpisodeLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'paginationEpisode', 0, true, length, include);
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  paginationEpisodeLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'paginationEpisode',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  paginationEpisodeLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'paginationEpisode',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  serverNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'serverName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  serverNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'serverName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  serverNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'serverName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  serverNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'serverName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  serverNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'serverName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  serverNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'serverName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  serverNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'serverName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  serverNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'serverName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  serverNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'serverName', value: ''),
      );
    });
  }

  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  serverNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'serverName', value: ''),
      );
    });
  }
}

extension EpisodeLocalQueryObject
    on QueryBuilder<EpisodeLocal, EpisodeLocal, QFilterCondition> {
  QueryBuilder<EpisodeLocal, EpisodeLocal, QAfterFilterCondition>
  paginationEpisodeElement(FilterQuery<PageEpisodeLocal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'paginationEpisode');
    });
  }
}
