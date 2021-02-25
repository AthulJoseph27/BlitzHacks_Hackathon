import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

class HealthInfo{
  String name;
  String address;
  String gender;
  int age;
  List<String> records;

  HealthInfo({this.address,this.name, this.gender, this.age, this.records});

  Future<DeployedContract> loadContract()async{
    String abi = await rootBundle.loadString('assets/abi.json');
    String contractAddress = '0xbCF02a1d3015b52E0E62CcF8a407644A7Be04774';

    final contract = DeployedContract(ContractAbi.fromJson(abi, 'HealthInfo'), EthereumAddress.fromHex(contractAddress));

    return contract;
  }
  Future getRecord(Web3Client ethClient)async{

//    EthereumAddress _address = EthereumAddress.fromHex(this.address);

    dynamic result = await query(ethClient, 'getRecord', []);

    return result[0];

  }

  Future<List> query(Web3Client ethClient,String functionName, List<dynamic> args)async{

    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(contract:contract,function:ethFunction,params:args);

    return result;
  }

  Future submit(Web3Client ethClient,String functionName,List<dynamic>args)async{
    EthPrivateKey cred = EthPrivateKey.fromHex('8864fce42cb94733a3a7363349a93edd0f36fa084d21a369e7c8cfc079b901bd');

    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.sendTransaction(cred, Transaction.callContract(contract:contract, function: ethFunction, parameters: args),fetchChainIdFromNetworkId: true);

    return result;
  }

  Future addToRecords(Web3Client ethClient,String record)async{

    dynamic result = await submit(ethClient, 'addToRecords', [record]);

  }


}

