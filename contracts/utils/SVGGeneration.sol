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

    function mirrorOverYAxis(uint16 xPoint) private pure returns (uint16) {
        if (150 > xPoint) {
            return 150 - xPoint;
        }
        return xPoint - 150;
    }

    function buildMandala(cordInput[] memory cordsToPlot, colorInput[] memory colorsToPlot) private pure returns (string memory) {
        bytes memory circles;
        string[7] memory colorPallet = ['ffc2df', 'dfbef8', 'ffe780', '99e2ff', '000000', '97e8ec', '111111'];
        for (uint i=0; i<cordsToPlot.length; i++) {
            cordInput memory reflectedCords = cordInput(cordsToPlot[i].cy,cordsToPlot[i].cx);
            circles = string.concat(
                circles,
                abi.encodePacked(
                    circleSVG( // Q1
                        cordsToPlot[i].cx,
                        cordsToPlot[i].cy,
                        colorPallet[colorsToPlot[i].fillColor], 
                        colorPallet[colorsToPlot[i].borderColor],
                        '2', 
                        '3'
                    ),
                    circleSVG( // Q2
                        150 - mirrorOverYAxis(cordsToPlot[i].cx),
                        cordsToPlot[i].cy,
                        colorPallet[colorsToPlot[i].fillColor], 
                        colorPallet[colorsToPlot[i].borderColor],
                        '2', 
                        '3'
                    ),
                    circleSVG( // Q3
                        150 - mirrorOverYAxis(cordsToPlot[i].cx),
                        300 - cordsToPlot[i].cy,
                        colorPallet[colorsToPlot[i].fillColor], 
                        colorPallet[colorsToPlot[i].borderColor],
                        '2', 
                        '3'
                    ),
                    circleSVG( // Q4
                        cordsToPlot[i].cx,
                        300 - cordsToPlot[i].cy,
                        colorPallet[colorsToPlot[i].fillColor], 
                        colorPallet[colorsToPlot[i].borderColor],
                        '2', 
                        '3'
                    )
                )
            );
            circles = string.concat(
                circles,
                abi.encodePacked(
                    // Refelction Qs
                    circleSVG( // Q1
                        reflectedCords.cx,
                        reflectedCords.cy,
                        colorPallet[colorsToPlot[i].fillColor], 
                        colorPallet[colorsToPlot[i].borderColor],
                        '2', 
                        '3'
                    ),
                    circleSVG( // Q2
                        150 - mirrorOverYAxis(reflectedCords.cx),
                        reflectedCords.cy,
                        colorPallet[colorsToPlot[i].fillColor], 
                        colorPallet[colorsToPlot[i].borderColor],
                        '2', 
                        '3'
                    ),
                    circleSVG( // Q3
                        150 - mirrorOverYAxis(reflectedCords.cx),
                        300 - reflectedCords.cy,
                        colorPallet[colorsToPlot[i].fillColor], 
                        colorPallet[colorsToPlot[i].borderColor],
                        '2', 
                        '3'
                    ),
                    circleSVG( // Q4
                        reflectedCords.cx,
                        300 - reflectedCords.cy,
                        colorPallet[colorsToPlot[i].fillColor], 
                        colorPallet[colorsToPlot[i].borderColor],
                        '2', 
                        '3'
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