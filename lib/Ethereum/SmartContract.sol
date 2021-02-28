pragma solidity 0.7.4;
pragma experimental ABIEncoderV2;

// SPDX-License-Identifier: MIT

contract Patient{
    uint256 public patientCount = 0;
    mapping(address => PatientInfo) public allPatients;
    mapping(address => int) existingAddress;

    address patientAddress;

    modifier onlyOwner(){
        require(existingAddress[msg.sender] == 1);
        _;
    }

    modifier ownerAndDoctor(){
        require(existingAddress[msg.sender] == 1 || allPatients[patientAddress].toAddress == msg.sender);
        _;
    }

    struct PatientInfo{
        uint256 id;
        int age;
        string name;
        string gender;
        string bloodGroup;
        address toAddress;
        string [] records;
        address [] visibileToAddress;
    }


    function setPatientId(address _patientAddress)public{
        patientAddress = _patientAddress;
    }

    function addPatient(int age, string memory name, string memory gender, string memory bloodGroup) public {
        patientCount ++;
        PatientInfo memory _patientInfo;
        existingAddress[msg.sender] = 1;
        _patientInfo.id = patientCount;
        _patientInfo.age = age;
        _patientInfo.name = name;
        _patientInfo.gender = gender;
        _patientInfo.bloodGroup = bloodGroup;
        allPatients[msg.sender] = _patientInfo;

    }

    function setVisibleToAddress(address _address)public onlyOwner{
        allPatients[msg.sender].toAddress = _address;
    }

    function viewAllRecord() public view onlyOwner returns(string[] memory){
        return allPatients[msg.sender].records;
    }

    function addToRecords(string memory record) public onlyOwner{

        allPatients[msg.sender].records.push(record);
        allPatients[msg.sender].visibileToAddress.push(msg.sender);

    }

    function changeVisibilityOfRecordAtIndices(uint256 index, address _address)public onlyOwner{
        allPatients[msg.sender].visibileToAddress[index] = _address;
    }

    function resetVisiblity()public onlyOwner{
        for(uint i=0;i<allPatients[msg.sender].records.length;i++){
            allPatients[msg.sender].visibileToAddress[i] = msg.sender ;
        }
    }

    function getTotalNumberOfRecords() public view returns(uint){

        return allPatients[patientAddress].records.length;

    }

    function viewAllowedRecord(uint index) public view returns(string memory){


        if(msg.sender == allPatients[patientAddress].visibileToAddress[index])
            return allPatients[patientAddress].records[index];
        else
            return 'Permission Denied!';


    }

}