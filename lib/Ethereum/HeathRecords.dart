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
    String contractAddress = '0x8ff948818973066AE23Faf73bFd05DDf42D2DfAB';

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
    final result = await ethClient.sendTransaction(cred, Transaction.callContract(contract:contract, function: ethFunction, parameters: args));

    return result;
  }

  Future setPatientId(Web3Client ethClient,String patientAddress, String privateKey)async{

    final result = await submit(ethClient, 'setPatientId', [EthereumAddress.fromHex(patientAddress)], privateKey);
  }

  Future setVisiblity(Web3Client ethClient, String toAddress, String privateKey)async{

    final result = await submit(ethClient,'setVisibleToAddress',[ EthereumAddress.fromHex(toAddress)],privateKey);

    getVisiblityArray(ethClient);
    getBoolVisibleArray(ethClient);

  }

  Future<List<String>> viewAllowedRecord(Web3Client ethClient, String address, String myAddress)async{

    int recordLength = int.parse((await query(ethClient, 'getTotalNumberOfRecords', [EthereumAddress.fromHex(address)]))[0].toString());

    List<String> records = [];
    print(recordLength);
    for(int i=0;i<recordLength;i++) {
      var result = await query(ethClient, 'viewAllowedRecord', [BigInt.from(i),EthereumAddress.fromHex(address),EthereumAddress.fromHex(myAddress)]);
      print(result);
      print("__________");
//      if(result[0] == 'Permission Denied!')
//        continue;
      records.add(result[0]);
    }

    return records;

  }

  Future changeVisibilityOfRecordAtIndices(Web3Client ethClient, int index, String toAddress, String privateKey)async{

    final result = await submit(ethClient,'changeVisibilityOfRecordAtIndices',[BigInt.from(index),EthereumAddress.fromHex(toAddress)],privateKey);
  }

  Future resetVisiblity(Web3Client ethClient, String privateKey)async{
    final result = await submit(ethClient,'resetVisiblity',[],privateKey);
  }

  Future addPatient(Web3Client ethClient, String privateKey)async{

    final result =  await submit(ethClient,'addPatient',[BigInt.from(age),name,gender,bloodGroup],privateKey);

  }

  Future addToRecords(Web3Client ethClient,String record, String privateKey)async{

    dynamic result = await submit(ethClient, 'addToRecords', [record], privateKey);

  }

  Future getVisiblityArray(Web3Client ethClient)async{

    dynamic result =  await query(ethClient,'getVisiblityArray',[]);

    for(var i in result)
      print(i);

  }

  Future getBoolVisibleArray(Web3Client ethClient)async{

    dynamic result =  await query(ethClient,'getBoolVisibleArray',[]);

    for(var i in result)
      print(i);

  }

  Future addNewRecord(Web3Client ethClient , String newRecord, String patientAddress, String myAddress,String privateKey)async{
    final result = await submit(ethClient,'addNewRecordToPatient',[EthereumAddress.fromHex(patientAddress),EthereumAddress.fromHex(myAddress),newRecord],privateKey);
  }
}

//getBoolVisibleArray()