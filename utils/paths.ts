interface IfcPoolAddresses {
  BCT: string;
  NCT: string;
}
interface IfcOneNetworkAddresses {
  mcUSD?: string[];
  cUSD?: string[];
  CELO?: string[];
  WETH?: string[];
  USDC?: string[];
  WMATIC?: string[];
}
interface IfcAddresses {
  celo: IfcOneNetworkAddresses | IfcPoolAddresses;
  alfajores: IfcOneNetworkAddresses | IfcPoolAddresses;
  polygon: IfcOneNetworkAddresses | IfcPoolAddresses;
  mumbai: IfcOneNetworkAddresses | IfcPoolAddresses;
}

const paths: IfcAddresses = {
  celo: {
    mcUSD: ["0x918146359264c492bd6934071c6bd31c854edbc3"],
    cUSD: [
      "0x765DE816845861e75A25fCA122bb6898B8B1282a",
      "0x918146359264c492bd6934071c6bd31c854edbc3",
    ],
    CELO: [
      "0x471EcE3750Da237f93B8E339c536989b8978a438",
      "0x765DE816845861e75A25fCA122bb6898B8B1282a",
      "0x918146359264c492bd6934071c6bd31c854edbc3",
    ],
    WETH: [
      "0x122013fd7dF1C6F636a5bb8f03108E876548b455",
      "0x918146359264c492bd6934071c6bd31c854edbc3",
    ],
    USDC: [
      "0xef4229c8c3250C675F21BCefa42f58EfbfF6002a",
      "0x765DE816845861e75A25fCA122bb6898B8B1282a",
      "0x918146359264c492bd6934071c6bd31c854edbc3",
    ],
  },
  alfajores: {
    mcUSD: ["0x71DB38719f9113A36e14F409bAD4F07B58b4730b"],
    cUSD: [
      "0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1",
      "0x71DB38719f9113A36e14F409bAD4F07B58b4730b",
    ],
    CELO: [
      "0xF194afDf50B03e69Bd7D057c1Aa9e10c9954E4C9",
      "0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1",
      "0x71DB38719f9113A36e14F409bAD4F07B58b4730b",
    ],
  },
  polygon: {
    USDC: ["0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174"],
    WETH: [
      "0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619",
      "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174",
    ],
    WMATIC: [
      "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270",
      "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174",
    ],
  },
  mumbai: {
    USDC: ["0xe6b8a5CF854791412c1f6EFC7CAf629f5Df1c747"],
    WETH: [
      "0xA6FA4fB5f76172d178d61B04b0ecd319C5d1C0aa",
      "0xe6b8a5CF854791412c1f6EFC7CAf629f5Df1c747",
    ],
    WMATIC: [
      "0x9c3C9283D3e44854697Cd22D3Faa240Cfb032889",
      "0xe6b8a5CF854791412c1f6EFC7CAf629f5Df1c747",
    ],
  },
};

export const poolAddresses: IfcAddresses = {
  celo: {
    BCT: "0x0CcB0071e8B8B716A2a5998aB4d97b83790873Fe",
    NCT: "0x02De4766C272abc10Bc88c220D214A26960a7e92",
  },
  alfajores: {
    BCT: "0x4c5f90C50Ca9F849bb75D93a393A4e1B6E68Accb",
    NCT: "0xfb60a08855389F3c0A66b29aB9eFa911ed5cbCB5",
  },
  polygon: {
    BCT: "0x2F800Db0fdb5223b3C3f354886d907A671414A7F",
    NCT: "0xD838290e877E0188a4A44700463419ED96c16107",
  },
  mumbai: {
    BCT: "0xf2438A14f668b1bbA53408346288f3d7C71c10a1",
    NCT: "0x7beCBA11618Ca63Ead5605DE235f6dD3b25c530E",
  },
};

export const routerAddresses = {
  celo: "0x7D28570135A2B1930F331c507F65039D4937f66c", // ubeswap
  polygon: "0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506", // sushiswap
};

export const offsetHelperAddresses = {
  celo: "0xC3f8CB0F188A0ADB3216f8d05EaB3FAD78cc8413",
  mumbai: "0xcf240660E6802487Ba8e3791075862B79eC255cC",
  polygon: "0xe932D677B732e3C949596dFa0034B0bd695DC79c",
}

export const stewardTokens = {
  celo: "0x15501a485990d4586930ca7F30Be6C6cd90354b2",
}

export default paths;
