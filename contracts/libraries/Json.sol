// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

library Json {    

    function openJsonObject() internal pure returns (string memory) {        
        return string(abi.encodePacked("{"));
    }

    function closeJsonObject() internal pure returns (string memory) {
        return string(abi.encodePacked("}"));
    }

    function openJsonArray() internal pure returns (string memory) {        
        return string(abi.encodePacked("["));
    }

    function closeJsonArray() internal pure returns (string memory) {        
        return string(abi.encodePacked("]"));
    }

    function pushJsonPrimitiveStringAttribute(string memory name, string memory value, bool insertComma) internal pure returns (string memory) {
        return string(abi.encodePacked('"', name, '": "', value, '"', insertComma ? ',' : ''));
    }

    function pushJsonPrimitiveNonStringAttribute(string memory name, string memory value, bool insertComma) internal pure returns (string memory) {
        return string(abi.encodePacked('"', name, '": ', value, insertComma ? ',' : ''));
    }

    function pushJsonComplexAttribute(string memory name, string memory value, bool insertComma) internal pure returns (string memory) {
        return string(abi.encodePacked('"', name, '": ', value, insertComma ? ',' : ''));
    }

    function pushJsonArrayElement(string memory value, bool insertComma) internal pure returns (string memory) {
        return string(abi.encodePacked(value, insertComma ? ',' : ''));
    }
}