// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";


contract School is Ownable {

    struct Student{
        string name;
        uint noteBio;
        uint noteMath;
        uint noteFr;
    }

    mapping(address=>bool) teachers;
    mapping(string=>Student) students;

    uint[] notesBio;
    uint[] notesMath;
    uint[] notesFr;

    modifier onlyTeacher() {
        require(teachers[msg.sender], "Not a teacher");
        _;
    }

    function addTeacher(address _addr) external onlyOwner{
        teachers[_addr] = true;
    }

    function addStudent(string calldata _name) external onlyTeacher {
        require(keccak256(abi.encodePacked(students[_name].name)) == keccak256(abi.encodePacked("")), "Student already exist");
        Student memory student;
        student.name = _name;
        students[_name] = student;
    }

    function addNoteBio(uint note, string calldata _name) external onlyTeacher {
        require(keccak256(abi.encodePacked(students[_name].name)) != keccak256(abi.encodePacked("")), "Student dont exist");
        notesBio.push(note);
        students[_name].noteBio = note;
    }

    function addNoteMath(uint note, string calldata _name) external onlyTeacher {
        require(keccak256(abi.encodePacked(students[_name].name)) != keccak256(abi.encodePacked("")), "Student dont exist");
        notesMath.push(note);
        students[_name].noteMath = note;
    }

    function addNoteFr(uint note, string calldata _name) external onlyTeacher {
        require(keccak256(abi.encodePacked(students[_name].name)) != keccak256(abi.encodePacked("")), "Student dont exist");
        notesFr.push(note);
        students[_name].noteFr = note;
    }

    function getStudentNoteAverage(string calldata _name) public view returns (uint){
        require(keccak256(abi.encodePacked(students[_name].name)) != keccak256(abi.encodePacked("")), "Student dont exist");
        return (students[_name].noteBio + students[_name].noteMath + students[_name].noteFr) / 3;
    }

    function hasSuccess(string calldata _name) external view returns (bool) {
         require(keccak256(abi.encodePacked(students[_name].name)) != keccak256(abi.encodePacked("")), "Student dont exist");
        return (getStudentNoteAverage(_name) >= 10);
    }

    function getBioNoteAverage() public view returns (uint){
        uint average;
        for(uint i=0; i<notesBio.length; i++){
            average += notesBio[i];
        }
        return (average / notesBio.length);
    }

    function getMathNoteAverage() public view returns (uint){
        uint average;
        for(uint i=0; i<notesMath.length; i++){
            average += notesMath[i];
        }
        return (average / notesMath.length);
    }

    function getFrNoteAverage() public view returns (uint){
        uint average;
        for(uint i=0; i<notesFr.length; i++){
            average += notesFr[i];
        }
        return (average / notesFr.length);
    }

    function getGlobalAverage() external  view returns (uint) {
        return (getBioNoteAverage() + getMathNoteAverage() + getFrNoteAverage()) / 3;
    }

}
