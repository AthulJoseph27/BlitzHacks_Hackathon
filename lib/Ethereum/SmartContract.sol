pragma solidity 0.7.4;
pragma experimental ABIEncoderV2;

// SPDX-License-Identifier: MIT

contract Patient{
    uint256 public patientCount = 0;
    mapping(address => PatientInfo) public allPatients;
    mapping(address => int) existingAddress;


    modifier onlyOwner(){
        require(existingAddress[msg.sender] == 1);
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
        bool [] isVisible;
    }


    function setPatientId(address _patientAddress)public{
        // patientAddress = _patientAddress;
    }


    function getVisiblityArray() public view returns(address [] memory){
        return allPatients[msg.sender].visibileToAddress;
    }

    function getBoolVisibleArray() public view returns(bool [] memory){
        return allPatients[msg.sender].isVisible;
    }

    function addPatient(int age, string memory name, string memory gender, string memory bloodGroup) public {
        patientCount ++;
        PatientInfo memory _patientInfo;
        existingAddress[msg.sender] = 1;
        _patientInfo.id = patientCount;
        _patientInfo.age = age;
        _patientInfo.name = name;
        _patientInfo.gender = gender;
        _patientInfo.toAddress = msg.sender;
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
        allPatients[msg.sender].isVisible.push(false);

    }

    function changeVisibilityOfRecordAtIndices(uint256 index, address _address)public onlyOwner{
        allPatients[msg.sender].visibileToAddress[index] = _address;
        allPatients[msg.sender].isVisible[index] = true;
    }

    function resetVisiblity()public onlyOwner{
        for(uint i=0;i<allPatients[msg.sender].records.length;i++){
            allPatients[msg.sender].visibileToAddress[i] = msg.sender ;
            allPatients[msg.sender].isVisible[i] = false;
        }
    }

    function getTotalNumberOfRecords(address _patientAddress) public view returns(uint){

        return allPatients[_patientAddress].records.length;

    }


    function addNewRecordToPatient(address _patientAddress,address myAddress,string memory newRecord)public returns(string memory){

        if(myAddress == allPatients[_patientAddress].toAddress){
            allPatients[_patientAddress].records.push(newRecord);
            return 'Updated';
        }else{

            return 'Permission Denied 2';
        }

    }

    function viewAllowedRecord(uint index, address _patientAddress, address myAddress) public view returns(string memory){

        if(allPatients[msg.sender].isVisible[index] == false)
            return 'Permission Denied 1!';


        if(myAddress == allPatients[_patientAddress].visibileToAddress[index])
            return allPatients[_patientAddress].records[index];
        else
            return 'Permission Denied 2!';


    }

}