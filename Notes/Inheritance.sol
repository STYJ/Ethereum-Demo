pragma solidity ^0.4.24;

contract A {
    
    function hi() public pure returns (string) {
        return "hi A";
    }
}

contract B is A {
    // A's hi is overridden.
    function hi() public pure returns (string) {
        return "hi B";
    }
}

contract C is A {
    // Use super to call hi from A.
    function hi() public pure returns (string) {
        return super.hi();
    }
}

contract D is B, C{
    // Super looks at C
    // Super in C looks at A and B
    // Since B is also A, returns hi B
    function hi() public pure returns (string) {
        return super.hi();
    }
}

contract E is C, B{
    // Super looks at B
    // returns hi B
    function hi() public pure returns (string) {
        return super.hi();
    }
}

contract F {
    function hi() public pure returns (string) {
        return "hi F";
    }
}

contract G is F {
    function hi() public pure returns (string) {
        return super.hi();
    }
}


contract H is F, C{
    // Super looks at C
    // Super in C looks at A and F
    // Since different (and F is also not A), returns Hi A
    // You can add "is A" to F and this will return Hi F instead.
    function hi() public pure returns (string) {
        return super.hi();
    }
}

contract I is F, G {
    // Super looks at G
    // Super in G looks at F and F
    // since same, returns F.
    function hi() public pure returns (string) {
        return super.hi();
    }
}

// Note that order of importance is important. See https://ethereumdev.io/inheritance-in-solidity/