pragma solidity 0.8.9;

import "../utils/SVGGeneration.sol";
import "../utils/base64.sol";
import "../structs/Mandala.sol";

contract MandalaToken {

    constructor() {

    }

    cordInput[] internal savedCords;
    colorInput[] internal savedColors;

    function saveMandalaBluePrint(cordInput[] memory cordsToPlot, colorInput[] memory colorsToPlot) public {
        for (uint i=0; i<cordsToPlot.length; i++) {
            savedCords.push(cordsToPlot[i]);
            savedColors.push(colorsToPlot[i]);
        }
    }

    function constructTokenURI() public view returns (string memory) {

        return string(
            abi.encodePacked(
                'data:application/json;base64,',
                string(
                    Base64.encode(
                        string(abi.encodePacked(
                            '{"image": "',
                            string(Base64.encode(OnChainSVGGenerator.generateSVG(savedCords, savedColors))),
                            '", "name": "helloWorldImage"',
                            '}'
                        ))
                    )
                )
            )
        );
    }

}