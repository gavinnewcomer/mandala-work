// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "../libraries/Strings.sol";
import "../structs/Mandala.sol";

library OnChainSVGGenerator {

    function generateSVG(cordInput[] memory cordsToPlot, colorInput[] memory colorsToPlot) internal pure returns (string memory svg) {
        //  calc the main raidus start point by taking 20% of the height width and incrementing up 10% until you get to 70% of the heightWidth var

        return
            string(
                abi.encodePacked(
                    generateSVGDefs('1000'),
                    buildMandala(cordsToPlot, colorsToPlot),
                    '</svg>'
                )
            );
    }

    function generateSVGDefs(string memory heightWidth) private pure returns (bytes memory) {
        return
            abi.encodePacked(
                '<?xml version="1.0" standalone="yes"?>',
                '<svg xmlns="http://www.w3.org/2000/svg" width="',
                heightWidth,
                '" height="',
                heightWidth,
                '">'
            );
    }

    function buildMandala(cordInput[] memory cordsToPlot, colorInput[] memory colorsToPlot) private pure returns (string memory) {
        require (cordsToPlot.length == colorsToPlot.length);
        bytes memory circles;
        for (uint i=0; i<cordsToPlot.length; i++) {
            circles = string.concat(
                circles,
                abi.encodePacked(
                    circleSVG( // Q1
                        cordsToPlot[i].cx,
                        cordsToPlot[i].cy,
                        colorsToPlot[i].fillColor, 
                        colorsToPlot[i].borderColor, 
                        '5', 
                        '7'
                    ),
                    circleSVG( // Q2
                        150 - cordsToPlot[i].xToEast,
                        cordsToPlot[i].cy,
                        colorsToPlot[i].fillColor, 
                        colorsToPlot[i].borderColor, 
                        '5', 
                        '7'
                    ),
                    circleSVG( // Q3
                        150 - cordsToPlot[i].xToEast,
                        300 - cordsToPlot[i].cy,
                        colorsToPlot[i].fillColor, 
                        colorsToPlot[i].borderColor,  
                        '5', 
                        '7'
                    ),
                    circleSVG( // Q4
                        cordsToPlot[i].cx,
                        300 - cordsToPlot[i].cy,
                        colorsToPlot[i].fillColor, 
                        colorsToPlot[i].borderColor,
                        '5', 
                        '7'
                    )
                )
            );
        }

        return string(circles);
    }

    function circleSVG(
        uint16 cx,
        uint16 cy,
        string memory fillColor,
        string memory strokeColor, 
        string memory strokeWidth, 
        string memory radius
    )  private pure returns (bytes memory) {
        return
            abi.encodePacked(
                '<circle cx="',
                Strings.toString(cx),
                '" cy="', 
                Strings.toString(cy),
                '" r="',
                radius,
                '" stroke="#',
                strokeColor,
                '" stroke-width="',
                strokeWidth,
                '" fill="#',
                fillColor,
                '"/>'
            );
    }
}