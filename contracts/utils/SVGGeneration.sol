// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "../libraries/Strings.sol";
import "../structs/Mandala.sol";
import "@nomiclabs/buidler/console.sol";

library OnChainSVGGenerator {

    function decodeSavedCordsToStruct(uint256 savedCord, uint256 xBitSlice, uint256 yBitSlice) internal pure returns (uint256, uint256) {
        return (uint256(uint8(savedCord>>xBitSlice)), uint256(uint8(savedCord>>yBitSlice)));
    }

    function generateSVG(uint256[] memory savedCords) internal view returns (string memory svg) {
        return
            string(
                abi.encodePacked(
                    generateSVGDefs('1000'),
                    buildMandala(savedCords),
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

    function mirrorOverYAxis(uint256 xPoint) private pure returns (uint256) {
        if (127 > xPoint) {
            return 127 - xPoint;
        }
        return xPoint - 127;
    }

    function buildMandala(uint256[] memory cordsToPlot) private view returns (string memory) {
        bytes memory circles;
        string[7] memory colorPallet = ['ffc2df', 'dfbef8', 'ffe780', '99e2ff', '000000', '97e8ec', '111111'];
        for (uint j=0; j<cordsToPlot.length; j++) {
            for (uint i=8; i<241; i+=8) {
                (uint256 cx, uint256 cy) = decodeSavedCordsToStruct(cordsToPlot[j], i, i+8);
                cordInputOptimized memory reflectedCords = cordInputOptimized(cy, cx);
                cordInputOptimized memory cords = cordInputOptimized(cx, cy);
                circles = string.concat(
                    circles,
                    abi.encodePacked(
                        circleSVG( // Q1
                            cords.cx,
                            cords.cy,
                            'ffc2df',
                            '99e2ff',
                            '1', 
                            '2'
                        ),
                        circleSVG( // Q2
                            127 - mirrorOverYAxis(cords.cx),
                            cords.cy,
                            'ffc2df', 
                            '99e2ff',
                            '1', 
                            '2'
                        ),
                        circleSVG( // Q3
                            127 - mirrorOverYAxis(cords.cx),
                            255 - cords.cy,
                            'ffc2df', 
                            '99e2ff',
                            '1', 
                            '2'
                        ),
                        circleSVG( // Q4
                            cords.cx,
                            255 - cords.cy,
                            'ffc2df', 
                            '99e2ff',
                            '1', 
                            '2'
                        )
                    )
                );
                // Refelction Quadrants
                circles = string.concat(
                    circles,
                    abi.encodePacked(
                        circleSVG( // Q1
                            reflectedCords.cx,
                            reflectedCords.cy,
                            'ffc2df', 
                            '99e2ff',
                            '1', 
                            '2'
                        ),
                        circleSVG( // Q2
                            127 - mirrorOverYAxis(reflectedCords.cx),
                            reflectedCords.cy,
                            'ffc2df', 
                            '99e2ff',
                            '1', 
                            '2'
                        ),
                        circleSVG( // Q3
                            127 - mirrorOverYAxis(reflectedCords.cx),
                            255 - reflectedCords.cy,
                            'ffc2df', 
                            '99e2ff',
                            '1', 
                            '2'
                        ),
                        circleSVG( // Q4
                            reflectedCords.cx,
                            255 - reflectedCords.cy,
                            'ffc2df', 
                            '99e2ff',
                            '1', 
                            '2'
                        )
                    )
                );
            }
        }
        return string(circles);
    }

    function circleSVG(
        uint256 cx,
        uint256 cy,
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