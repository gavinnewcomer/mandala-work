require('dotenv').config();

async function main() {
    const MandalaToken = await ethers.getContractFactory("MandalaToken");
    const mandalaToken = await MandalaToken.deploy();
    console.log("Contract MandalaToken deployed to address:", mandalaToken.address);
    const myNftContract = await MandalaToken.attach(mandalaToken.address);
    const heightWidth =  100;
    const overallMaxHeightWidth = 500;
    const colorArray = ['ffc2df', 'dfbef8', 'ffe780', '99e2ff', '000000', '97e8ec', '111111']
    const numCircles = 5;
    let startingRadius = 20
    let radius = startingRadius;
    const radiusIncrement = Math.floor(((100)-startingRadius) / numCircles);
    let cordsArray = [];
    let colorsArray = [];
    let multiplier = 1;
    const startingRadian = 0;
    const endingRadian = Math.PI / 4;
    for (let i=0; i < numCircles; i++) {
        const numObjects = Math.floor((Math.random() * multiplier * 3)) + 1;
        for (let angle=startingRadian; angle <= endingRadian; angle+=((endingRadian)/numObjects)) {
            colorIndex = Math.floor(Math.random() * colorArray.length);
            colorIndex2 = Math.floor(Math.random() * colorArray.length);
            cx=Math.floor((radius*Math.sin(angle)) + 150),
            cy=Math.floor((radius*Math.cos(angle)) + 150)
            if (cx < 150) {
                cx = 150
            }
            cordsArray.push([
                cx,
                cy
            ])
            colorsArray.push([
                Math.floor((Math.random() * (colorArray.length-1))) + 1,
                Math.floor((Math.random() * (colorArray.length-1))) + 1
            ])
        }
        radius += radiusIncrement
        if ((i % 2) == 0) {
            multiplier++
        }
    }
    console.log("Total Points: ", cordsArray.length * 8);
    console.log("Saved Points:", cordsArray.length);
    console.log(cordsArray);
    console.log("Color Pallet Cords", colorsArray);
    
    
    await myNftContract.saveMandalaBluePrint(cordsArray, colorsArray);
    let tokenURI = await myNftContract.constructTokenURI();
    const string = tokenURI.split(',');
    const decode = Buffer.from(string[1], 'base64').toString('utf-8')
    const json = JSON.parse(decode)
    const decodedSVG = Buffer.from(json['image'], 'base64').toString('utf-8')
    console.log(decodedSVG)
    
}


main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });