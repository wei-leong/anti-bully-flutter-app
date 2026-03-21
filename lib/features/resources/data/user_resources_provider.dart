import 'package:apu_assignment/features/resources/data/resources_provider.dart';
import 'package:apu_assignment/features/resources/model/resources_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sharedResourcesServiceProvider = Provider((ref) => ResourcesProvider());

final liveResourcesStreamProvider = StreamProvider.autoDispose<List<ResourceItem>>((ref) {
  final service = ref.watch(sharedResourcesServiceProvider);
  return service.fetchResources();
},);