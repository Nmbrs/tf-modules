# Changelog

## [6.0.0](https://github.com/Nmbrs/tf-modules/compare/v5.1.0...v6.0.0) (2022-05-23)


### ⚠ BREAKING CHANGES

* **storage-account:** load location and tags from the resource group  (#118)

### Features

* **resource_group:** update azurerm and caf providers ([#111](https://github.com/Nmbrs/tf-modules/issues/111)) ([efc0516](https://github.com/Nmbrs/tf-modules/commit/efc0516d19c100324741e92e23460190a7d4e789))


### Bug Fixes

* **storage-account:** load location and tags from the resource group  ([#118](https://github.com/Nmbrs/tf-modules/issues/118)) ([bf1e2f2](https://github.com/Nmbrs/tf-modules/commit/bf1e2f23f0d992bcb8177ae2eadb8bf91994cea0))

## [5.1.0](https://github.com/Nmbrs/tf-modules/compare/v5.0.0...v5.1.0) (2022-05-03)


### Features

* **dns_zone:** create DNS Zone module ([#82](https://github.com/Nmbrs/tf-modules/issues/82)) ([334bfa1](https://github.com/Nmbrs/tf-modules/commit/334bfa117737b6acef530e454382d386198117f0))
* **keyvault:** update environment variable ([#109](https://github.com/Nmbrs/tf-modules/issues/109)) ([52f0afe](https://github.com/Nmbrs/tf-modules/commit/52f0afe8fcedd4ab8cdf7615c611368d63ba8ccb))
* **resource_group:** add sandbox environment ([#110](https://github.com/Nmbrs/tf-modules/issues/110)) ([17dbcf9](https://github.com/Nmbrs/tf-modules/commit/17dbcf9693afcf76a1a8e4e2acd86bf9c4904bd0))

## [5.0.0](https://github.com/Nmbrs/tf-modules/compare/v4.0.0...v5.0.0) (2022-04-28)


### ⚠ BREAKING CHANGES

* **custom_domain_binding:** fix version custom domain dependency (#106)

### Bug Fixes

* **custom_domain_binding:** fix version custom domain dependency ([#106](https://github.com/Nmbrs/tf-modules/issues/106)) ([6ae0720](https://github.com/Nmbrs/tf-modules/commit/6ae07209bc95d7dfe698f6edae21ffc2432e1516))

## [4.0.0](https://github.com/Nmbrs/tf-modules/compare/3.1.0...v4.0.0) (2022-04-20)


### ⚠ BREAKING CHANGES

* **keyvault:** update environment validation to support 'dev', 'test', 'stag' and 'prod' (#99)

### Features

* **build:** added release workflow for automation ([#98](https://github.com/Nmbrs/tf-modules/issues/98)) ([6452074](https://github.com/Nmbrs/tf-modules/commit/6452074c462e7191c10b68e19305ec12a6c60edd))
* **keyvault:** update environment validation to support 'dev', 'test', 'stag' and 'prod' ([#99](https://github.com/Nmbrs/tf-modules/issues/99)) ([5498daa](https://github.com/Nmbrs/tf-modules/commit/5498daafd04981cb8552721954fb3b302ef5eb9b))
* **resource_group:** update environment validation to support 'dev', 'test', 'prod' and 'stag' ([#100](https://github.com/Nmbrs/tf-modules/issues/100)) ([10bfbab](https://github.com/Nmbrs/tf-modules/commit/10bfbab2843491fbed239ec23e94f20134eff3c4))
