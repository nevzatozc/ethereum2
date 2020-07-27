pragma solidity ^0.6.10;

contract Lottery {
    
    struct Student {
        uint age;
        string fName;
        string lName;
        bool joined;
    }
    
    mapping (address => Student) students;
    address[]  public studentAccounts;
    address chairperson;
    constructor () public {
        chairperson = msg.sender;
    }
    function registerStudents(address _address, uint _age, string memory _fName, string memory  _lName) public {
        
        Student storage student = students[_address];
        if(student.joined)
            return;
        student.age = _age;
        student.fName = _fName;
        student.lName = _lName;
        student.joined = true;
        studentAccounts.push(_address) ;
    }
    
    function getStudents() view public returns(address[] memory) {
        return studentAccounts;
    }
    
    function studentAccountsf(address  _address) view public returns (  string memory  , string memory  ) {
        return (students[_address].fName, students[_address].lName);
    }
    
    function countStudents() view public returns (uint) {
        return studentAccounts.length;
    }

   function random() private view returns (uint8) {
        uint num_of_students = countStudents();
        return uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)))%num_of_students);
    }
    function findwinnerStudent()  view public returns (string memory, string memory ) {
        if (chairperson != msg.sender)
            return ("false","false");

        uint random_number = random();
        address winner_address = studentAccounts[random_number];
        return (students[winner_address].fName, students[winner_address].lName);
    }
   
}
