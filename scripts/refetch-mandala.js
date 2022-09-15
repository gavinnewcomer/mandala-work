require('dotenv').config();

async function main() {
    const address = "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0";
    const MandalaToken = await ethers.getContractFactory("MandalaToken");
    const myNftContract = await MandalaToken.attach(address);
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