# Changelog

## [7.1.0](https://github.com/Nmbrs/tf-modules/compare/v7.0.0...v7.1.0) (2022-07-27)


### Features

* **repositories:** add github repositories name uniqueness validation ([#133](https://github.com/Nmbrs/tf-modules/issues/133)) ([c6fe9e8](https://github.com/Nmbrs/tf-modules/commit/c6fe9e837f0f31e02964b7d504ee8f1b4bd47b0e))


### Bug Fixes

* **github:** change module indexes in tf state ([#131](https://github.com/Nmbrs/tf-modules/issues/131)) ([ea5c69c](https://github.com/Nmbrs/tf-modules/commit/ea5c69cc3eacfce79fc0208f13a850682ba12d9d))
* **key_vault:** update policies index based references in tfstate ([#136](https://github.com/Nmbrs/tf-modules/issues/136)) ([b2d89b1](https://github.com/Nmbrs/tf-modules/commit/b2d89b1f31d274a4b9fd2cf403e92587b3cfcabc))
* **virtual_netowrk:** update subnet index based references in tfstate ([#135](https://github.com/Nmbrs/tf-modules/issues/135)) ([d5cbe58](https://github.com/Nmbrs/tf-modules/commit/d5cbe5826c8bddef0b9be6e074b7e4e66e122ceb))

## [7.0.0](https://github.com/Nmbrs/tf-modules/compare/v6.1.0...v7.0.0) (2022-07-22)


### ⚠ BREAKING CHANGES

* **webapp_module_update:** update modules (#128)
* **vnet:** update vnet module (#127)

### Features

* **vnet:** update vnet module ([#127](https://github.com/Nmbrs/tf-modules/issues/127)) ([92f95b9](https://github.com/Nmbrs/tf-modules/commit/92f95b9a4c583719346e3579a7e625e7e08b92d1))


### Bug Fixes

* **webapp_module_update:** update modules ([#128](https://github.com/Nmbrs/tf-modules/issues/128)) ([c649d03](https://github.com/Nmbrs/tf-modules/commit/c649d034ed91999662eef35746179d8e5849d118))

## [6.1.0](https://github.com/Nmbrs/tf-modules/compare/v6.0.0...v6.1.0) (2022-06-14)


### Features

* **githubrepo:** Added module to create repos ([#120](https://github.com/Nmbrs/tf-modules/issues/120)) ([01fa1ed](https://github.com/Nmbrs/tf-modules/commit/01fa1ed7306697b4c6b11af5656a22ab4322fc93))
* replaced with mineiros module ([#123](https://github.com/Nmbrs/tf-modules/issues/123)) ([a140f36](https://github.com/Nmbrs/tf-modules/commit/a140f3667d3c13a644404219a224644b543f2f4b))


### Bug Fixes

* **githubrepo:** Removed provider github ([#122](https://github.com/Nmbrs/tf-modules/issues/122)) ([7e6a5c1](https://github.com/Nmbrs/tf-modules/commit/7e6a5c137f8d48f5b56a282135cc3b268ffae4bc))

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
