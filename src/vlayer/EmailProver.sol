// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Strings} from "@openzeppelin-contracts-5.0.1/utils/Strings.sol";

import {Proof} from "vlayer-0.1.0/Proof.sol";
import {Prover} from "vlayer-0.1.0/Prover.sol";
import {RegexLib} from "vlayer-0.1.0/Regex.sol";
import {VerifiedEmail, UnverifiedEmail, EmailProofLib} from "vlayer-0.1.0/EmailProof.sol";

import {AddressParser} from "./utils/AddressParser.sol";

interface IExample {
    function exampleFunction() external returns (uint256);
}

contract EmailProver is Prover {
    using Strings for string;
    using RegexLib for string;
    using AddressParser for string;
    using EmailProofLib for UnverifiedEmail;

     string targetDomain = "hello@ethglobal.com";

    function main(UnverifiedEmail calldata unverifiedEmail) public view returns (Proof memory) {
        VerifiedEmail memory email = unverifiedEmail.verify();

        require(email.from.equal(targetDomain), "incorrect sender domain");
        require(email.subject.equal("Your ticket for ETHGlobal Bangkok!"), "incorrect subject");


        return (proof());
    }
}
