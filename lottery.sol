pragma solidity ^0.4.18;
contract Lottery {
    
    struct Student {
        uint age;
        string fName;
        string lName;
        bool joined;
    }
    
    struct Winneraddressstruct {
        address  wa ;
  }

    
    mapping (address => Student) students;
    address[]  public studentAccounts;
    address chairperson;
    address wa;
    constructor() public {
        chairperson = msg.sender;
    }
    function registerStudents(address _address, uint _age, string _fName, string _lName) public {
        
        Student storage student = students[_address];
        if(student.joined)
            return;
        student.age = _age;
        student.fName = _fName;
        student.lName = _lName;
        student.joined = true;
        studentAccounts.push(_address) -1;
    }
    
    function getStudents() view public returns(address[]) {
        return studentAccounts;
    }
    
    function studentAccounts(address _address) view public returns (uint, string, string) {
        return (students[_address].age, students[_address].fName, students[_address].lName);
    }
    
    function countStudents() view public returns (uint) {
        return studentAccounts.length;
    }
    
    function findwinnerStudent() view public returns (string, string) {
        if (chairperson != msg.sender)
            return;
        uint num_of_students = countStudents();
        uint random_number = uint(sha3(block.blockhash(block.number-1), now ))% num_of_students;
        address winner_address = studentAccounts[random_number];
        wa = winner_address;
        return (students[winner_address].fName, students[winner_address].lName);
    }
    function showwinnerStudent() view public returns (string, string) {
        
        return (students[wa].fName, students[wa].lName);
    }
}
