import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:random_user/data/models/Post.dart';


part 'serializers.g.dart';

// ignore: always_specify_types
@SerializersFor([
  Post
])
final Serializers serializers = (_$serializers.toBuilder()
  ..add(Iso8601DateTimeSerializer())
  ..addPlugin(StandardJsonPlugin()))
    .build();