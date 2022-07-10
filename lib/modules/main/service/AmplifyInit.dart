import '../../../models/ModelProvider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import '../../../utils/amplifyconfiguration.dart';

class AmplifyInit{

  final AmplifyDataStore _dataStorePlugin =
  AmplifyDataStore(modelProvider: ModelProvider.instance);
  final AmplifyStorageS3 _storagePlugin = AmplifyStorageS3();
  final AmplifyAPI _apiPlugin = AmplifyAPI();
  final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();

  Future<void> configureAmplify() async {
    await Amplify.addPlugins(
        [_dataStorePlugin, _apiPlugin, _authPlugin, _storagePlugin]);

    try {
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      print('An error occurred while configuring Amplify: $e');
    }
  }

}