pragma solidity ^0.5.0;


contract BloodDonation {
address public bloodbank;
uint PatientID; 
uint Amount; 
uint Date;
mapping(address => bool) doctor; // only authorized doctors are allowed
mapping(address => bool) donor; // only registered donors are allowed
enum OrderStatus {StartDelivery, Enroute, EndDelivery}
OrderStatus public Orderstate;
enum BloodComponentType {redcellstype, whitecellstype, plasmatype, plateletstype}
BloodComponentType public BloodcomponentType;


constructor() public {
    bloodbank = msg.sender;
    emit consumptionAdress(msg.sender);
}

// Events 
event RedcellsRequest (address indexed doctor, uint BloodcomponentType, uint Amount, uint indexed Date);
event WhiteCellsRequest (address indexed doctor, uint BloodcomponentType, uint Amount, uint indexed Date);
event PlasmaRequest (address indexed doctor, uint BloodcomponentType, uint Amount, uint indexed Date); 
event PlateletsRequest (address indexed doctor, uint BloodcomponentType, uint Amount, uint indexed Date); 
event BloodComponentUnitsOrderReceived (address indexed doctor);
event DoctorRedcellsPrescription(address indexed doctor, uint BloodcomponentType, uint PatientID, uint Amount);
event DoctorWhitecellsPrescription(address indexed doctor, uint BloodcomponentType, uint PatientID, uint Amount);
event DoctorplasmaPrescription(address indexed doctor, uint BloodcomponentType, uint PatientID, uint Amount);
event DoctorplateletsPrescription(address indexed doctor, uint BloodcomponentType, uint PatientID, uint Amount);
event consumptionend(address indexed doctor, uint PatientID, uint Date);
event consumptionAdress(address deployer);

//Defining Modifiers 

modifier onlybloodbank() {
    require(bloodbank == msg.sender, "You do not have privileges to run this function");
    _;
}

modifier onlydonor() {
    require(donor[msg.sender], "You do not have privileges to run this function");
    _;
}

modifier onlydoctor() {
    require(doctor[msg.sender], "You do not have privileges to run this function");
    _;
}


 function BloodComponentRequested(BloodComponentType _BloodcomponentType, uint A, uint ReqDate) public onlydoctor{  

     Amount = A; 
     Date=ReqDate; 
        if (_BloodcomponentType == BloodComponentType.redcellstype){
        
        emit RedcellsRequest(msg.sender, 0 ,Amount, Date);
    }
        if (_BloodcomponentType == BloodComponentType.whitecellstype){
        
        emit RedcellsRequest(msg.sender, 1 ,Amount, Date);
    }
        if (_BloodcomponentType == BloodComponentType.plasmatype){
        
         emit PlasmaRequest(msg.sender, 2 , Amount,  Date );
    }
        if (_BloodcomponentType == BloodComponentType.plateletstype) {
        
        emit PlateletsRequest(msg.sender, 3 ,  Amount , Date);
    }
   
}
    
 function BloodUnitPrescription(BloodComponentType _BloodcomponentType,uint _ID, uint _A) public onlydoctor{  
    PatientID = _ID; 
    Amount= _A; 
        if (_BloodcomponentType == BloodComponentType.redcellstype){
        
        emit DoctorRedcellsPrescription(msg.sender, 0 , PatientID, Amount);
    }
        if (_BloodcomponentType == BloodComponentType.whitecellstype){
        
         emit DoctorplasmaPrescription(msg.sender, 1 , PatientID , Amount);
    }
        if (_BloodcomponentType == BloodComponentType.plasmatype){
        
         emit DoctorplasmaPrescription(msg.sender, 2 , PatientID , Amount);
    }
        if (_BloodcomponentType == BloodComponentType.plateletstype) {
        
        emit DoctorplateletsPrescription(msg.sender, 3 , PatientID , Amount);
    }
   
}

function BloodUnitTransfusion(uint ID, uint OfDate) public onlydoctor {
        PatientID = ID;
        Date = OfDate; 
        emit consumptionend(msg.sender, ID, Date);
    }

}