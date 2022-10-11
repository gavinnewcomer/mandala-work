pragma solidity 0.8.9;

import "../utils/SVGGeneration.sol";
import "../utils/base64.sol";
import "../structs/Mandala.sol";
import "@nomiclabs/buidler/console.sol";

contract MandalaToken {

    constructor() {

    }

    uint256[] internal savedCords;

    function saveMandalaBluePrint(uint8[] memory cords) public returns (uint256) {
        for (uint j=0; j<cords.length/32; j++) {
            uint256 savedCord = cords[0+(j*32)];
            savedCord |= uint256(cords[1+(j*32)])<<8;
            savedCord |= uint256(cords[2+(j*32)])<<16;
            savedCord |= uint256(cords[3+(j*32)])<<24;
            savedCord |= uint256(cords[4+(j*32)])<<32;
            savedCord |= uint256(cords[5+(j*32)])<<40;
            savedCord |= uint256(cords[6+(j*32)])<<48;
            savedCord |= uint256(cords[7+(j*32)])<<56;
            savedCord |= uint256(cords[8+(j*32)])<<64;
            savedCord |= uint256(cords[9+(j*32)])<<72;
            savedCord |= uint256(cords[10+(j*32)])<<80;
            savedCord |= uint256(cords[11+(j*32)])<<88;
            savedCord |= uint256(cords[12+(j*32)])<<96;
            savedCord |= uint256(cords[13+(j*32)])<<104;
            savedCord |= uint256(cords[14+(j*32)])<<112;
            savedCord |= uint256(cords[15+(j*32)])<<120;
            savedCord |= uint256(cords[16+(j*32)])<<128;
            savedCord |= uint256(cords[17+(j*32)])<<136;
            savedCord |= uint256(cords[18+(j*32)])<<144;
            savedCord |= uint256(cords[19+(j*32)])<<152;
            savedCord |= uint256(cords[20+(j*32)])<<160;
            savedCord |= uint256(cords[21+(j*32)])<<168;
            savedCord |= uint256(cords[22+(j*32)])<<176;
            savedCord |= uint256(cords[23+(j*32)])<<184;
            savedCord |= uint256(cords[24+(j*32)])<<192;
            savedCord |= uint256(cords[25+(j*32)])<<200;
            savedCord |= uint256(cords[26+(j*32)])<<208;
            savedCord |= uint256(cords[27+(j*32)])<<216;
            savedCord |= uint256(cords[28+(j*32)])<<224;
            savedCord |= uint256(cords[29+(j*32)])<<232;
            savedCord |= uint256(cords[30+(j*32)])<<240;
            savedCord |= uint256(cords[31+(j*32)])<<248;
            savedCords.push(savedCord);
        }
        return savedCords.length;
    }

    function constructTokenURI() public view returns (string memory) {
        string memory uri = string(abi.encodePacked(
                'data:application/json;base64,',
                string(
                    Base64.encode(
                        string(abi.encodePacked(
                            '{"image": "',
                                string(Base64.encode(OnChainSVGGenerator.generateSVG(savedCords))),
                            '", "name": "helloWorldImage"',
                            '}'
                        ))
                    )
                )
            )
        );
        return uri;
    }

}