require('dotenv').config();

async function main() {
    const MandalaToken = await ethers.getContractFactory("MandalaToken");
    const mandalaToken = await MandalaToken.deploy();
    console.log("Contract MandalaToken deployed to address:", mandalaToken.address);
    const myNftContract = await MandalaToken.attach(mandalaToken.address);
    const heightWidth =  100;
    const overallMaxHeightWidth = 500;
    const colorArray = ['ffc2df', 'dfbef8', 'ffe780', '99e2ff', '000000', '97e8ec', '111111']
    const numCircles = 6;
    let startingRadius = 20
    let radius = startingRadius;
    const radiusIncrement = Math.floor(((100)-startingRadius) / numCircles);
    let cordsArray = [];
    let colorsArray = [];
    let multiplier = 1;
    const startingRadian = 0;
    const endingRadian = Math.PI / 4;
    for (let i=0; i < numCircles; i++) {
        let numObjects = 3;
        for (let angle=startingRadian; angle <= endingRadian; angle+=((endingRadian)/numObjects)) {
            colorIndex = Math.floor(Math.random() * colorArray.length);
            colorIndex2 = Math.floor(Math.random() * colorArray.length);
            cx=Math.floor((radius*Math.sin(angle)) + 127),
            cy=Math.floor((radius*Math.cos(angle)) + 127)
            if (cx < 127) {
                cx = 127
            }
            cordsArray.push(cx)
            cordsArray.push(cy)
            colorsArray.push(colorIndex)
            colorsArray.push(colorIndex2)
        }
        radius += radiusIncrement
        if ((i % 2) == 0) {
            numObjects = (numObjects * 2) + 1
        }
    }
    console.log("Total Points: ", cordsArray.length / 2 * 8);
    console.log("Saved Points:", cordsArray.length / 2);
    console.log(cordsArray);
    console.log("Color Pallet Cords", colorsArray);
    
    
    let saveBPTxn = await myNftContract.saveMandalaBluePrint(cordsArray);
    console.log(saveBPTxn);
    let tokenURI = await myNftContract.constructTokenURI();
    /*
    let tokenURI = await myNftContract.constructTokenURI();
    const string = tokenURI.split(',');
    const decode = Buffer.from(string[1], 'base64').toString('utf-8')
    const json = JSON.parse(decode)
    const decodedSVG = Buffer.from(json['image'], 'base64').toString('utf-8')
    console.log(decodedSVG)
    */
}


main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });