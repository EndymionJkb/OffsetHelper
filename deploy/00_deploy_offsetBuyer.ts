import { DeployFunction } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { poolAddresses, offsetHelperAddresses, stewardTokens } from "../utils/paths";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const offsetHelperAddress = offsetHelperAddresses[hre.network.name];
  const poolAddressesToUse = poolAddresses[hre.network.name];
  const certificateUri = 'https://nftstorage.link/ipfs/bafkreifqanwtgazgn4mkludrc6yi2tfmvpkcj7p77ys2vib5irdfhvckpa';

  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  if (!deployer) {
    throw new Error("Missing deployer address");
  }

  await deploy("EthixOffsetBuyer", {
    from: deployer,
    args: [offsetHelperAddress, poolAddressesToUse.NCT, stewardTokens[hre.network.name], certificateUri],
    log: true,
    autoMine: true, // speed up deployment on local network (ganache, hardhat), no effect on live networks
  });
};
export default func;
