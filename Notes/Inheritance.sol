pragma solidity ^0.4.24;

contract C {
  uint public u = 0; // try changing this to private and internal. If you don't realise the issue with public or internal variables, other contracts can simply inherit your contract and manipulate your public and internal variables by implementing their own setter methods.
  function f() public {
    u = 1;
  }
  
  function getU() public constant returns (uint) {
      return u;
  }
}

contract B is C {
  function f() public {
    u = 2;
  }
}

contract A is B {
  function f() public {  // will set u to 3
    u = 3;
  }
  // The super keyword in Solidity gives access to the immediate parent contract from which the current contract is derived.
  function f1() public { // will set u to 2 (immediate parent and not the parent of your parent, note you can't do super.super.f() lol)
    super.f();
  }
  // Alternatively, one can explicitly specifying the parent of which one wants to call the overridden function because multiple overriding steps are possible as exemplified in the example below:
  function f2() public { // will set u to 2
    B.f();
  }
  function f3() public { // will set u to 1
    C.f();
  }
}

// Note that order of importance is important. See https://ethereumdev.io/inheritance-in-solidity/