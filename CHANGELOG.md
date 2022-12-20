# Changelog

## [7.6.0](https://github.com/Nmbrs/tf-modules/compare/v7.5.0...v7.6.0) (2022-12-20)


### Features

* **dns_zone:** update caf provider ([#157](https://github.com/Nmbrs/tf-modules/issues/157)) ([ae7467a](https://github.com/Nmbrs/tf-modules/commit/ae7467a6b62e0d3e35d25bc124838ad166ede723))
* **resource_group:** update caf provider ([#156](https://github.com/Nmbrs/tf-modules/issues/156)) ([6f7f7b6](https://github.com/Nmbrs/tf-modules/commit/6f7f7b67e8dd2757d05ac641fda8de18b9f96bf4))
* **storage_account:** update caf provider ([#158](https://github.com/Nmbrs/tf-modules/issues/158)) ([1f5835d](https://github.com/Nmbrs/tf-modules/commit/1f5835d70ac8715679d44b900be71a3662693349))
* **virtual_network:** update caf provider ([#155](https://github.com/Nmbrs/tf-modules/issues/155)) ([ca9a90f](https://github.com/Nmbrs/tf-modules/commit/ca9a90f60d28003a9089bc9ae57184f3d661f0a1))


### Bug Fixes

* **key_vault:** update default tags precedence ([#160](https://github.com/Nmbrs/tf-modules/issues/160)) ([d4fb56e](https://github.com/Nmbrs/tf-modules/commit/d4fb56e2f18c32ec65afded98d17facb126172fa))
* **resource_group:** update default tags precedence ([#162](https://github.com/Nmbrs/tf-modules/issues/162)) ([a191381](https://github.com/Nmbrs/tf-modules/commit/a19138120c720fd2a55f2fa7ef0183aba14e8944))
* **storage_account:** update default tags precedence ([#161](https://github.com/Nmbrs/tf-modules/issues/161)) ([b174aa9](https://github.com/Nmbrs/tf-modules/commit/b174aa95eca972f16d7e0ef377da6ccf8a83b156))
* **virtual_network:** update tag precedence vnet ([#163](https://github.com/Nmbrs/tf-modules/issues/163)) ([f498333](https://github.com/Nmbrs/tf-modules/commit/f49833319647c5637d57d546b76f63f178eb9204))

## [7.5.0](https://github.com/Nmbrs/tf-modules/compare/v7.4.0...v7.5.0) (2022-12-13)


### Features

* **key_vault:** update kv documetation ([#153](https://github.com/Nmbrs/tf-modules/issues/153)) ([d23d498](https://github.com/Nmbrs/tf-modules/commit/d23d498b702afe91a01caa29a1090415da3fa097))

## [7.4.0](https://github.com/Nmbrs/tf-modules/compare/v7.3.0...v7.4.0) (2022-09-09)


### Features

* **dns_records:** update dns_records module ([#149](https://github.com/Nmbrs/tf-modules/issues/149)) ([7cc7b35](https://github.com/Nmbrs/tf-modules/commit/7cc7b35b7fe903238c22b6729b7c5d4ec17a6c24))


### Bug Fixes

* **storage_account:** modified the default tag to be aligned with nmbrs tag strategy. ([#150](https://github.com/Nmbrs/tf-modules/issues/150)) ([2833ef2](https://github.com/Nmbrs/tf-modules/commit/2833ef263a246bd95f4c053209b74c4c4149204e))

## [7.3.0](https://github.com/Nmbrs/tf-modules/compare/v7.2.0...v7.3.0) (2022-08-24)


### Features

* **key_vault:** add key and storage permissions to access policies ([#147](https://github.com/Nmbrs/tf-modules/issues/147)) ([22d4c30](https://github.com/Nmbrs/tf-modules/commit/22d4c30ce3ef8f35599c5b4cc68af9ef548c7909))
* **key_vault:** add managed_by tag ([#148](https://github.com/Nmbrs/tf-modules/issues/148)) ([f72c23c](https://github.com/Nmbrs/tf-modules/commit/f72c23c95814087f6d2b87b7d0eda43a05048484))
* **key_vault:** ignore updated_at and created_at tags ([#145](https://github.com/Nmbrs/tf-modules/issues/145)) ([04245c1](https://github.com/Nmbrs/tf-modules/commit/04245c11d4ae02143cbf3f21fa0961a5d0d38dd7))
* **repository:** remove archive_on_destroy behavior ([#138](https://github.com/Nmbrs/tf-modules/issues/138)) ([fd72f4d](https://github.com/Nmbrs/tf-modules/commit/fd72f4dd76e9b1afbe704e32192708d94b8e4039))


### Bug Fixes

* **provider:** update modules ([#146](https://github.com/Nmbrs/tf-modules/issues/146)) ([64e38c5](https://github.com/Nmbrs/tf-modules/commit/64e38c5479524801bf10981f16c4b0c93ddcd18c))

## [7.2.0](https://github.com/Nmbrs/tf-modules/compare/v7.1.0...v7.2.0) (2022-08-09)


### Features

* **key_vault:** add readers and writers polcies to kv outputs ([#142](https://github.com/Nmbrs/tf-modules/issues/142)) ([28aedf3](https://github.com/Nmbrs/tf-modules/commit/28aedf38b98f557392127c2820993597f3660ecd))
* **key_vault:** trim spaces and lower case acess policies indexes ([#140](https://github.com/Nmbrs/tf-modules/issues/140)) ([ed61323](https://github.com/Nmbrs/tf-modules/commit/ed6132342d9b663a541592e610329da053cd3743))
* **repositories:** add github repositories output ([#137](https://github.com/Nmbrs/tf-modules/issues/137)) ([247e7bc](https://github.com/Nmbrs/tf-modules/commit/247e7bc35a4042a1502f15be0b90ec5208aed9ea))
* **resource_group:** update resource group tags to adhere to azure policy ([#139](https://github.com/Nmbrs/tf-modules/issues/139)) ([a0f273b](https://github.com/Nmbrs/tf-modules/commit/a0f273b70d33bc61903053602ca115f5cae68077))


### Bug Fixes

* **github:** trim spaces and lower case repository indexes ([#141](https://github.com/Nmbrs/tf-modules/issues/141)) ([01db6f7](https://github.com/Nmbrs/tf-modules/commit/01db6f76f436572743254dcea07d9baa311f5648))

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
