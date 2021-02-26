import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

class HealthRecord{
  String disease;
  String shortDescription;
  String fullDescription;
  String additionalInfo;
  String visibileToAddress;

  HealthRecord({this.disease,this.shortDescription,this.fullDescription,this.additionalInfo,this.visibileToAddress});

}

class HealthInfo{
  String name;
  String address;
  String gender;
  int age;
  String bloodGroup;
  List<String> records;

  HealthInfo({this.address,this.name, this.gender, this.age, this.records,this.bloodGroup});

  Future<DeployedContract> loadContract()async{
    String abi = await rootBundle.loadString('assets/abi.json');
    String contractAddress = '0x14DD8CD8Ab426E729eB450326680EeaA7E0addDb';

    final contract = DeployedContract(ContractAbi.fromJson(abi, 'Patient'), EthereumAddress.fromHex(contractAddress));

    return contract;
  }
  Future getRecord(Web3Client ethClient)async{

//    EthereumAddress _address = EthereumAddress.fromHex(this.address);

    dynamic result = await query(ethClient, 'viewAllRecord', []);

    return result[0];

  }

  Future<List> query(Web3Client ethClient,String functionName, List<dynamic> args)async{

    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(contract:contract,function:ethFunction,params:args);

    return result;
  }

  Future submit(Web3Client ethClient,String functionName,List<dynamic>args , String privateKey)async{
    EthPrivateKey cred = EthPrivateKey.fromHex(privateKey);

    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.sendTransaction(cred, Transaction.callContract(contract:contract, function: ethFunction, parameters: args),fetchChainIdFromNetworkId: true);

    return result;
  }

  Future setPatientId(Web3Client ethClient,String patientAddress, String privateKey)async{

    final result = await submit(ethClient, 'setPatientId', [EthereumAddress.fromHex(patientAddress)], privateKey);
  }

  Future addToRecords(Web3Client ethClient,String record, String privateKey)async{

    dynamic result = await submit(ethClient, 'addToRecords', [record], privateKey);

  }

  Future setVisiblity(Web3Client ethClient, String toAddress, String privateKey)async{

    final result = await submit(ethClient,'setVisibleToAddress',[ EthereumAddress.fromHex(toAddress)],privateKey);

  }

  Future viewAllowedRecord(Web3Client ethClient , String patientAddress)async{

    return await query(ethClient, 'viewAllowedRecord', []);

  }

  Future changeVisibilityOfRecordAtIndices(Web3Client ethClient, int index, String toAddress, String privateKey)async{

    final result = await submit(ethClient,'changeVisibilityOfRecordAtIndices',[BigInt.from(index),EthereumAddress.fromHex(toAddress)],privateKey);
  }

  Future resetVisiblity(Web3Client ethClient, String privateKey)async{
    final result = await submit(ethClient,'resetVisiblity',[],privateKey);
  }

  Future addPatient(Web3Client ethClient, String privateKey)async{

    final result =  await submit(ethClient,'addPatient',[age,name,gender,bloodGroup],privateKey);

  }


}

