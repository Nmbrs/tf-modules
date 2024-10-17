# Changelog

## [8.5.0](https://github.com/Nmbrs/tf-modules/compare/v8.4.0...v8.5.0) (2024-10-17)


### Features

* **sql_database:** add sql database module ([#284](https://github.com/Nmbrs/tf-modules/issues/284)) ([da73f5c](https://github.com/Nmbrs/tf-modules/commit/da73f5cbcfea9842eadf66c23d69d3719aa8384c))
* **sql_server:** add sql server module ([#285](https://github.com/Nmbrs/tf-modules/issues/285)) ([51306c1](https://github.com/Nmbrs/tf-modules/commit/51306c11c17fd55000490311a374acdc0e69a350))

## [8.4.0](https://github.com/Nmbrs/tf-modules/compare/v8.3.0...v8.4.0) (2024-10-07)


### Features

* **application_gateway:** ignore waf_settings ([#299](https://github.com/Nmbrs/tf-modules/issues/299)) ([116654a](https://github.com/Nmbrs/tf-modules/commit/116654a1d29e1691e65fba5ca60858de40dde0b3))
* **application-gateway:** add waf policy ([#301](https://github.com/Nmbrs/tf-modules/issues/301)) ([804bbc6](https://github.com/Nmbrs/tf-modules/commit/804bbc64f98bd680ae52c0daad6d19000ed871d6))
* **virtual_network:** add ddos plan settings virtual network ([#298](https://github.com/Nmbrs/tf-modules/issues/298)) ([82e5312](https://github.com/Nmbrs/tf-modules/commit/82e531256ffb5cbd296fa3b10293074c53ab24ba))

## [8.3.0](https://github.com/Nmbrs/tf-modules/compare/v8.2.0...v8.3.0) (2024-09-12)


### Features

* **azuredevopsproject:** add module ([#296](https://github.com/Nmbrs/tf-modules/issues/296)) ([49dda16](https://github.com/Nmbrs/tf-modules/commit/49dda16c818c5bb7404bae104a2981efb9f51644))
* **cosmos_db:** add cosmo db module ([#297](https://github.com/Nmbrs/tf-modules/issues/297)) ([15ceb33](https://github.com/Nmbrs/tf-modules/commit/15ceb337d0dbc8c706e9c5fbaeda511bc7b30653))
* **private_endpoint:** add new subresource to private endpoint ([#294](https://github.com/Nmbrs/tf-modules/issues/294)) ([7b61a97](https://github.com/Nmbrs/tf-modules/commit/7b61a978af99e29095ec18af35a250386e13aa51))
* **storage_account:** update https only parameter ([#292](https://github.com/Nmbrs/tf-modules/issues/292)) ([8cceda3](https://github.com/Nmbrs/tf-modules/commit/8cceda359e06d54d4d10935f004e947f7ce8928d))


### Bug Fixes

* **application_gateway:** update corrupted documentation ([#295](https://github.com/Nmbrs/tf-modules/issues/295)) ([e26cfeb](https://github.com/Nmbrs/tf-modules/commit/e26cfebd6489ab04c59e6e3bfd908667898d7636))

## [8.2.0](https://github.com/Nmbrs/tf-modules/compare/v8.1.0...v8.2.0) (2024-08-26)


### Features

* **app_service:** add aspnet core environment variable configured by the environment ([#288](https://github.com/Nmbrs/tf-modules/issues/288)) ([8a51799](https://github.com/Nmbrs/tf-modules/commit/8a517994354fda6fc3f94a830c36fbb4e5cbe9a6))
* **key_vault:** add adminstrators policy ([#289](https://github.com/Nmbrs/tf-modules/issues/289)) ([847b95a](https://github.com/Nmbrs/tf-modules/commit/847b95a986a025c7c1316550bb1c99dba5e4501d))
* **key_vault:** enable purge protection by default ([#287](https://github.com/Nmbrs/tf-modules/issues/287)) ([97fb276](https://github.com/Nmbrs/tf-modules/commit/97fb276d28b50a05f5d252aa6efa4e64c03b8888))
* **private_endpoint:** create private endpoint module ([#252](https://github.com/Nmbrs/tf-modules/issues/252)) ([b19a313](https://github.com/Nmbrs/tf-modules/commit/b19a313136847b51f88eda8fda062267d7ad2365))
* **ssl_certificate:** add module ([#290](https://github.com/Nmbrs/tf-modules/issues/290)) ([68c5242](https://github.com/Nmbrs/tf-modules/commit/68c524273c6575ba438eff3b54876479d9054982))
* **virtual_network_peering:** remove peering prefix from resource naming ([#291](https://github.com/Nmbrs/tf-modules/issues/291)) ([06f02a2](https://github.com/Nmbrs/tf-modules/commit/06f02a29bb90dada16278401d08394d9f8cc46b7))

## [8.1.0](https://github.com/Nmbrs/tf-modules/compare/v8.0.0...v8.1.0) (2024-03-21)


### Features

* **app_service:** ignore ip restriction default action parameter ([#282](https://github.com/Nmbrs/tf-modules/issues/282)) ([da9b289](https://github.com/Nmbrs/tf-modules/commit/da9b289b8f3dfeb9ab17ef137d63501658162bd2))

## [8.0.0](https://github.com/Nmbrs/tf-modules/compare/v7.16.0...v8.0.0) (2024-03-13)


### ⚠ BREAKING CHANGES

* **key_vault:** add rbac authorization support ([#279](https://github.com/Nmbrs/tf-modules/issues/279))

### Features

* **key_vault:** add rbac authorization support ([#279](https://github.com/Nmbrs/tf-modules/issues/279)) ([eb605e1](https://github.com/Nmbrs/tf-modules/commit/eb605e125fea6f95db97ebd04ea2db48383e6e4c))


### Bug Fixes

* **redis:** fix workload parameter validation ([#280](https://github.com/Nmbrs/tf-modules/issues/280)) ([ef7bbf7](https://github.com/Nmbrs/tf-modules/commit/ef7bbf7793fb263c52d7fe6f8495b1ae4a6d07f0))

## [7.16.0](https://github.com/Nmbrs/tf-modules/compare/v7.15.0...v7.16.0) (2024-02-27)


### Features

* **app_service:** add managed identity to app service ([#277](https://github.com/Nmbrs/tf-modules/issues/277)) ([68e230d](https://github.com/Nmbrs/tf-modules/commit/68e230d7fb5d919e6e449d7726c698df40ab0beb))
* **app_service:** added app insights to the app service ([#278](https://github.com/Nmbrs/tf-modules/issues/278)) ([d1d6dac](https://github.com/Nmbrs/tf-modules/commit/d1d6dac165277c2cf40a982cb8422373ec2eb148))
* **application_insights:** replace name parameter in favor of workload ([#273](https://github.com/Nmbrs/tf-modules/issues/273)) ([534ac03](https://github.com/Nmbrs/tf-modules/commit/534ac03b0975c826f48dd665a4554705eadb8ecb))
* **log_analytics_workspace:** replace name parameter in favor of workload ([#274](https://github.com/Nmbrs/tf-modules/issues/274)) ([a454149](https://github.com/Nmbrs/tf-modules/commit/a4541492e9b9774844e710bc5fdade239d1cbbfb))
* **redis_cache:** replace name parameter in favor of workload ([#276](https://github.com/Nmbrs/tf-modules/issues/276)) ([3dcb897](https://github.com/Nmbrs/tf-modules/commit/3dcb8976c5aea6598082c0c958404d005c628cad))

## [7.15.0](https://github.com/Nmbrs/tf-modules/compare/v7.14.0...v7.15.0) (2024-02-05)


### Features

* **app_service:** ignore auto-heal settings ([#264](https://github.com/Nmbrs/tf-modules/issues/264)) ([03190bc](https://github.com/Nmbrs/tf-modules/commit/03190bcaad6c3e3e433b2b614c0b4903bef1bbed))
* **custom_domain_binding:** remove custom_domain_binding module ([#218](https://github.com/Nmbrs/tf-modules/issues/218)) ([5b37080](https://github.com/Nmbrs/tf-modules/commit/5b37080604153b102782418a8b2fb290d72661e6))
* **key_vault:** remove caf provider reference ([#267](https://github.com/Nmbrs/tf-modules/issues/267)) ([a728109](https://github.com/Nmbrs/tf-modules/commit/a7281095953d44a5b8060927ad77e6cb64565d27))
* **resource_group:** replace name parameter in favor of workload ([#271](https://github.com/Nmbrs/tf-modules/issues/271)) ([2bf46cb](https://github.com/Nmbrs/tf-modules/commit/2bf46cb7bcff97b4288ac06ecfeb69757f95f638))
* **service_bus:** replace name parameter in favor of workload ([#272](https://github.com/Nmbrs/tf-modules/issues/272)) ([316d3ea](https://github.com/Nmbrs/tf-modules/commit/316d3eac997aa2ffc58b30ed4f93b72fd214df37))
* **storage_account:** remove caf provider reference ([#270](https://github.com/Nmbrs/tf-modules/issues/270)) ([3dd79bf](https://github.com/Nmbrs/tf-modules/commit/3dd79bfa730cef73f7e3b5dcce6ffc308e01e637))

## [7.14.0](https://github.com/Nmbrs/tf-modules/compare/v7.13.0...v7.14.0) (2023-11-29)


### Features

* **app_gateway:** Create module for applicaton gateway ([#256](https://github.com/Nmbrs/tf-modules/issues/256)) ([c4b015a](https://github.com/Nmbrs/tf-modules/commit/c4b015a9adb100ba1317826a710b14a13f82e70d))
* **app_service:** add client_affinity_enabled parameter and ignore log configurations ([#253](https://github.com/Nmbrs/tf-modules/issues/253)) ([3739fff](https://github.com/Nmbrs/tf-modules/commit/3739ffff79e2a544931a74554f552161726d5035))
* **app_service:** ignore auto heal and ip restriction settings ([#263](https://github.com/Nmbrs/tf-modules/issues/263)) ([b285f0e](https://github.com/Nmbrs/tf-modules/commit/b285f0ec5be0a7dc535edf4289445ef2e405cdd0))
* **app_service:** Update variable country to allow global  ([#250](https://github.com/Nmbrs/tf-modules/issues/250)) ([5437136](https://github.com/Nmbrs/tf-modules/commit/5437136b3f0021574127a195474f442b22973f49))
* **event_grid_domain:** add event grid domain module ([#249](https://github.com/Nmbrs/tf-modules/issues/249)) ([ce92579](https://github.com/Nmbrs/tf-modules/commit/ce925793df2fbfc8b2a998b12cb57bd792c3f708))
* **key_vault:** remove caf module by updating the naming logic ([#262](https://github.com/Nmbrs/tf-modules/issues/262)) ([71d9608](https://github.com/Nmbrs/tf-modules/commit/71d9608ce8cfabb3354a1de5058260123e105bd4))
* **managed_identity:** add managed identiy modlule ([#255](https://github.com/Nmbrs/tf-modules/issues/255)) ([dfc52d8](https://github.com/Nmbrs/tf-modules/commit/dfc52d81819d02e6c112088269c0bde117886fa6))
* **nat_gateway:** replace name parameter in favor of  workload ([#260](https://github.com/Nmbrs/tf-modules/issues/260)) ([8d8ecd3](https://github.com/Nmbrs/tf-modules/commit/8d8ecd3cb1e37261983e34de28df7ccf168d7794))
* **nat_gateway:** update public ip and nat gateway naming logic ([#254](https://github.com/Nmbrs/tf-modules/issues/254)) ([461dc6b](https://github.com/Nmbrs/tf-modules/commit/461dc6bc4bf4d9a4ed67c3020406ace23f7b549a))
* **private_dns_resolver:** update naming logic ([#257](https://github.com/Nmbrs/tf-modules/issues/257)) ([a21758c](https://github.com/Nmbrs/tf-modules/commit/a21758c4da9196c746f22f43fc9a37098c1af895))
* **private_dns_resolver:** update vnet link resource group ([#248](https://github.com/Nmbrs/tf-modules/issues/248)) ([a691dab](https://github.com/Nmbrs/tf-modules/commit/a691dab4c0d43a7e393d47500c9aa79f350bffb6))
* **storage_account:** remove caf module by updating the naming logic ([#261](https://github.com/Nmbrs/tf-modules/issues/261)) ([483b808](https://github.com/Nmbrs/tf-modules/commit/483b8089fcf4daa0d6d9d6a8d9d0209c111ba3c6))
* **virtual_network:** update naming logic ([#258](https://github.com/Nmbrs/tf-modules/issues/258)) ([910bc4b](https://github.com/Nmbrs/tf-modules/commit/910bc4bf287526b28b40d860d978550909ba4377))
* **vpn_gateway:** update naming logic ([#259](https://github.com/Nmbrs/tf-modules/issues/259)) ([79aa875](https://github.com/Nmbrs/tf-modules/commit/79aa875ce11f95c0271d783ed8ed13e6a8062009))

## [7.13.0](https://github.com/Nmbrs/tf-modules/compare/v7.12.0...v7.13.0) (2023-10-03)


### Features

* **private_dns_resolver:** update module naming logic ([#246](https://github.com/Nmbrs/tf-modules/issues/246)) ([af1cbaf](https://github.com/Nmbrs/tf-modules/commit/af1cbaf7aa0bc1822d961c2d0a4d6a616e850f4d))

## [7.12.0](https://github.com/Nmbrs/tf-modules/compare/v7.11.0...v7.12.0) (2023-09-29)


### Features

* **redis_cache:** add basic and standard tier support ([#241](https://github.com/Nmbrs/tf-modules/issues/241)) ([9897907](https://github.com/Nmbrs/tf-modules/commit/98979070548333342185c95e8fd1c2b28ca15206))
* **resource_group:** remove mandatory tags ([#243](https://github.com/Nmbrs/tf-modules/issues/243)) ([3eeff8e](https://github.com/Nmbrs/tf-modules/commit/3eeff8e8bb2d3a7545acf32e42d569bd1c2295e9))
* **service_bus:** add zone redundancy capability ([#245](https://github.com/Nmbrs/tf-modules/issues/245)) ([7e1acfd](https://github.com/Nmbrs/tf-modules/commit/7e1acfd773edd97e97e59a8bc25570dd132901ec))

## [7.11.0](https://github.com/Nmbrs/tf-modules/compare/v7.10.0...v7.11.0) (2023-09-13)


### Features

* **app_service:** ignore app settings  ([#216](https://github.com/Nmbrs/tf-modules/issues/216)) ([d5b6e68](https://github.com/Nmbrs/tf-modules/commit/d5b6e686c7efaaa11b758bda41830d5ec3b76f8b))
* **application_insights:** add application_insights module ([#238](https://github.com/Nmbrs/tf-modules/issues/238)) ([6c72718](https://github.com/Nmbrs/tf-modules/commit/6c72718e0e4cb056f9620b4ad4126cd8be800cdd))
* **cosmos_db:** add location cosmos db ([#223](https://github.com/Nmbrs/tf-modules/issues/223)) ([358eb88](https://github.com/Nmbrs/tf-modules/commit/358eb8810acd4aabb2ef7e861afe5f0eb19cacfb))
* **dns_records:** update terraform providers ([#224](https://github.com/Nmbrs/tf-modules/issues/224)) ([35903a7](https://github.com/Nmbrs/tf-modules/commit/35903a7db05c773e7f0e69ed6f9459b64cb11fe5))
* **dns_zone:** update terraform providers ([#221](https://github.com/Nmbrs/tf-modules/issues/221)) ([ca69907](https://github.com/Nmbrs/tf-modules/commit/ca699072f79abe5e0969e284e6208a5a3e80e31b))
* **key_vault:** add location parameter ([#231](https://github.com/Nmbrs/tf-modules/issues/231)) ([2b5eab0](https://github.com/Nmbrs/tf-modules/commit/2b5eab0ae1d569203a32bebade65c28347aa90a6))
* **location:** update terraform providers ([#220](https://github.com/Nmbrs/tf-modules/issues/220)) ([ddf840d](https://github.com/Nmbrs/tf-modules/commit/ddf840dd9beddc04d59799f79bb10dcac9b38019))
* **log_analytics_workspace:** add log analytics workspace module ([#217](https://github.com/Nmbrs/tf-modules/issues/217)) ([bf61d91](https://github.com/Nmbrs/tf-modules/commit/bf61d91908a585ed40cbf8b765f8a17eb1e848f6))
* **nat_gateway:** add location parameter ([#232](https://github.com/Nmbrs/tf-modules/issues/232)) ([c3b87cb](https://github.com/Nmbrs/tf-modules/commit/c3b87cba967cc3a438f1d63ee24a97e16b6f8c4f))
* **nat_gateway:** update naming logic ([#239](https://github.com/Nmbrs/tf-modules/issues/239)) ([23d6e5d](https://github.com/Nmbrs/tf-modules/commit/23d6e5d37b7dc056e75adc5f9537da958df14fce))
* **private_dns_resolver:** update terraform providers ([#230](https://github.com/Nmbrs/tf-modules/issues/230)) ([9694045](https://github.com/Nmbrs/tf-modules/commit/969404523ea70cac51be786278fe58d7c4584876))
* **private_dns_zone:** update terraform providers ([#229](https://github.com/Nmbrs/tf-modules/issues/229)) ([bcd6897](https://github.com/Nmbrs/tf-modules/commit/bcd68979de553addce7a90ac09c0a329b1dc4829))
* **redis_cache:** add location parameter ([#234](https://github.com/Nmbrs/tf-modules/issues/234)) ([9c61f85](https://github.com/Nmbrs/tf-modules/commit/9c61f8563c696eebaecd5ce700704ea1d8076c28))
* **resource_group:** ignore tags after creation process ([#240](https://github.com/Nmbrs/tf-modules/issues/240)) ([6e65a2c](https://github.com/Nmbrs/tf-modules/commit/6e65a2c0a000863cc78d17bbbba33045918869c1))
* **resource_group:** update terraform providers ([#219](https://github.com/Nmbrs/tf-modules/issues/219)) ([a6fb21e](https://github.com/Nmbrs/tf-modules/commit/a6fb21ee0bf624bec2c3ff4ad56d6109d787146a))
* **storage_account:** add location and environment parameters ([#225](https://github.com/Nmbrs/tf-modules/issues/225)) ([3c7fd6e](https://github.com/Nmbrs/tf-modules/commit/3c7fd6e5d95884d38a9f7e8a15f818bbcb8ce963))
* **virtual_machine:** add location parameter ([#227](https://github.com/Nmbrs/tf-modules/issues/227)) ([f7bcb7d](https://github.com/Nmbrs/tf-modules/commit/f7bcb7d557622ac6866dba9fb84521b75fee3967))
* **virtual_network_peering:** update terraform providers ([#228](https://github.com/Nmbrs/tf-modules/issues/228)) ([37a0034](https://github.com/Nmbrs/tf-modules/commit/37a0034ca295e2441716c999ec0ccb5e5e8e9663))
* **virtual_network:** add location parameter ([#233](https://github.com/Nmbrs/tf-modules/issues/233)) ([7828271](https://github.com/Nmbrs/tf-modules/commit/78282713a55c6b35d73157650ddea61908b0b86f))
* **vpn_gateway:** add a vpn gateway module ([#203](https://github.com/Nmbrs/tf-modules/issues/203)) ([fa0082c](https://github.com/Nmbrs/tf-modules/commit/fa0082c7cb205824c925980bd09a1e6df024fb8e))
* **windows_scaleset:** add location parameter ([#235](https://github.com/Nmbrs/tf-modules/issues/235)) ([f0af738](https://github.com/Nmbrs/tf-modules/commit/f0af738394e388803c9c62023d3235fd57825847))


### Bug Fixes

* **app_service:** update app service naming logic ([#236](https://github.com/Nmbrs/tf-modules/issues/236)) ([a1a7345](https://github.com/Nmbrs/tf-modules/commit/a1a7345f0d94c8d87819cf71210e221068987c91))
* **service_bus:** update capacity validations for all tiers ([#237](https://github.com/Nmbrs/tf-modules/issues/237)) ([20aa773](https://github.com/Nmbrs/tf-modules/commit/20aa7736e0553e277cfdda47534903a5b9454de3))

## [7.10.0](https://github.com/Nmbrs/tf-modules/compare/v7.9.0...v7.10.0) (2023-09-01)


### Features

* **service_bus:** update service bus validation and add naming concatenation ([#215](https://github.com/Nmbrs/tf-modules/issues/215)) ([9f3187c](https://github.com/Nmbrs/tf-modules/commit/9f3187ca4c08de007018b7875c3f573ab7613ccb))
* **virtual_network:** add subnet name output ([#210](https://github.com/Nmbrs/tf-modules/issues/210)) ([16b6cbd](https://github.com/Nmbrs/tf-modules/commit/16b6cbddb0d9d528fbbb78964f07652c4feb3cf1))
* **virtual_network:** add vnet peering ([#212](https://github.com/Nmbrs/tf-modules/issues/212)) ([cabff77](https://github.com/Nmbrs/tf-modules/commit/cabff77d7443682b2942ae10bb736e4f0e0c3bd8))

## [7.9.0](https://github.com/Nmbrs/tf-modules/compare/v7.8.0...v7.9.0) (2023-07-04)


### Features

* **storage-account:** remove queue properties ([#209](https://github.com/Nmbrs/tf-modules/issues/209)) ([add69c4](https://github.com/Nmbrs/tf-modules/commit/add69c41ab5951bdaa2922c787f5cea32d4ea1a8))
* **vnet:** update delegations list ([#204](https://github.com/Nmbrs/tf-modules/issues/204)) ([efe5810](https://github.com/Nmbrs/tf-modules/commit/efe58100820ffcd942c6d95a234b4ec61b369763))


### Reverts

* "feature(vnet): update delegations list ([#204](https://github.com/Nmbrs/tf-modules/issues/204))" ([#208](https://github.com/Nmbrs/tf-modules/issues/208)) ([36e2d53](https://github.com/Nmbrs/tf-modules/commit/36e2d5378d7c27c249c790418989e81a14bea671))

## [7.8.0](https://github.com/Nmbrs/tf-modules/compare/v7.7.0...v7.8.0) (2023-06-28)


### Features

* **cosmos_db:** remove provider configs to allow the use of for_each loops ([#198](https://github.com/Nmbrs/tf-modules/issues/198)) ([f4d460d](https://github.com/Nmbrs/tf-modules/commit/f4d460d53a03041c2e70b611c9eb117832bd0d0e))
* **dns_records:** remove provider configs to allow the use of for_each loops ([#199](https://github.com/Nmbrs/tf-modules/issues/199)) ([590bb7e](https://github.com/Nmbrs/tf-modules/commit/590bb7eedaf5e26fc86ae38375efd6e20cd556f7))
* **dns_zone:** remove provider configs to allow the use of for_each loops ([#197](https://github.com/Nmbrs/tf-modules/issues/197)) ([d5995e5](https://github.com/Nmbrs/tf-modules/commit/d5995e549a2aee4cb71eee0d18b733a189348b9b))
* **location:** remove provider configs to allow the use of for_each loops ([#196](https://github.com/Nmbrs/tf-modules/issues/196)) ([e8366b8](https://github.com/Nmbrs/tf-modules/commit/e8366b85f9f400da2a7cfab3b169fa521c312bc0))
* **private_dns_resolver:** add private dns resolver module ([#189](https://github.com/Nmbrs/tf-modules/issues/189)) ([7e50b91](https://github.com/Nmbrs/tf-modules/commit/7e50b91e15a60dface58b7819a178dc143071769))
* **private_dns_zone:** remove provider configs to allow the use of for_each loops ([#195](https://github.com/Nmbrs/tf-modules/issues/195)) ([0d36a71](https://github.com/Nmbrs/tf-modules/commit/0d36a71663f69bb49eb5fd797699ad7f80ac9216))
* **redis:** add sharding support to premium tier ([#206](https://github.com/Nmbrs/tf-modules/issues/206)) ([cc4d479](https://github.com/Nmbrs/tf-modules/commit/cc4d479bf5715a1e202df855bd1dca2229570db6))
* **resource_group:** remove caf dependency ([#201](https://github.com/Nmbrs/tf-modules/issues/201)) ([76884ac](https://github.com/Nmbrs/tf-modules/commit/76884aca1b13230b69646bf16eea95ec836aa4ad))
* **storage_account:** remove provider configs to allow the use of for_each loops ([#194](https://github.com/Nmbrs/tf-modules/issues/194)) ([e3e168b](https://github.com/Nmbrs/tf-modules/commit/e3e168b88c8753b7e48d125a56faa42f481dd828))
* **virtual_machine:** remove provider configs to allow the use of for_each loops ([#193](https://github.com/Nmbrs/tf-modules/issues/193)) ([4a02763](https://github.com/Nmbrs/tf-modules/commit/4a027636e13497c304c17ed27831f47e3bf7e3ca))
* **virtual_network:** remove provider configs to allow the use of for_each loops ([#200](https://github.com/Nmbrs/tf-modules/issues/200)) ([2c8aa2f](https://github.com/Nmbrs/tf-modules/commit/2c8aa2ffb4f5b03cfff0dd7aed4d3ca8a099fdd5))
* **vnet:** remove caf resource reference ([#205](https://github.com/Nmbrs/tf-modules/issues/205)) ([d2146e9](https://github.com/Nmbrs/tf-modules/commit/d2146e9d39bfd6d6cb3b6a0e3eecc0300ba2a298))
* **windows_scaleset:** remove provider configs to allow the use of for_each loops ([#192](https://github.com/Nmbrs/tf-modules/issues/192)) ([4c55137](https://github.com/Nmbrs/tf-modules/commit/4c551377459257b5c8a81676c5bc8d2e7b7b6137))

## [7.7.0](https://github.com/Nmbrs/tf-modules/compare/v7.6.0...v7.7.0) (2023-06-20)


### Features

* **cosmo_db:** create new cosmo db module ([#172](https://github.com/Nmbrs/tf-modules/issues/172)) ([5541101](https://github.com/Nmbrs/tf-modules/commit/55411011e83ff7bfb444f9ea00a80d28e9ef76f4))
* **dns_records:** remove tag logic from terraform ([#179](https://github.com/Nmbrs/tf-modules/issues/179)) ([31542fb](https://github.com/Nmbrs/tf-modules/commit/31542fb3fd0d455b231ebf804e84c6d605961f10))
* **dns_zone:** add validation against ICAAN rules ([#187](https://github.com/Nmbrs/tf-modules/issues/187)) ([821bd7d](https://github.com/Nmbrs/tf-modules/commit/821bd7d32af1cf20de2664d9e115c56714b3d25c))
* **dns_zone:** remove tag logic from terraform ([#175](https://github.com/Nmbrs/tf-modules/issues/175)) ([5e22761](https://github.com/Nmbrs/tf-modules/commit/5e22761d5e5449ca410d88f640282390d004dc3e))
* **dns-records:** update  documentation to include Azure's API limitation ([#188](https://github.com/Nmbrs/tf-modules/issues/188)) ([248f439](https://github.com/Nmbrs/tf-modules/commit/248f439de31bc15a723bcb5c45bbc995620d1133))
* **environment:** create environment module ([#167](https://github.com/Nmbrs/tf-modules/issues/167)) ([22b9fbb](https://github.com/Nmbrs/tf-modules/commit/22b9fbb0107efce5c3091557e26b9d222eb6cc29))
* **key_vault:** remove environment validation ([#170](https://github.com/Nmbrs/tf-modules/issues/170)) ([72b4261](https://github.com/Nmbrs/tf-modules/commit/72b4261714e63012c03648e083d4d72405bf124d))
* **key_vault:** remove provider configs to allow the use of for_each loops ([#190](https://github.com/Nmbrs/tf-modules/issues/190)) ([0508e38](https://github.com/Nmbrs/tf-modules/commit/0508e380790115905929f8ba59f38fd3a73b6161))
* **location:** create location module ([#168](https://github.com/Nmbrs/tf-modules/issues/168)) ([c71263d](https://github.com/Nmbrs/tf-modules/commit/c71263d1905754a33eb700518a8ef7e250d4cf2a))
* **nat_gateway:** remove tag logic from terraform ([#176](https://github.com/Nmbrs/tf-modules/issues/176)) ([cbab401](https://github.com/Nmbrs/tf-modules/commit/cbab40175ab4c89981e41339a659ca1f55c43d7a))
* **private_dns_zone:** add vnet links ([#185](https://github.com/Nmbrs/tf-modules/issues/185)) ([895564d](https://github.com/Nmbrs/tf-modules/commit/895564d497eb59f61a17b6fa1a2cd8ef8236c7e9))
* **private_dns_zone:** create private DNS Zone module ([#181](https://github.com/Nmbrs/tf-modules/issues/181)) ([ebde5c2](https://github.com/Nmbrs/tf-modules/commit/ebde5c2ed802f74d03629185de64f2f0f57b43db))
* **redis_cache:** add redis cache module ([#182](https://github.com/Nmbrs/tf-modules/issues/182)) ([00f1577](https://github.com/Nmbrs/tf-modules/commit/00f1577511b30a68c861e94eccd1883044d8d1bd))
* **resource_group:** remove environment and location validations ([#169](https://github.com/Nmbrs/tf-modules/issues/169)) ([25fc358](https://github.com/Nmbrs/tf-modules/commit/25fc3583cae3bdc4955d5f5fbd8830da3b391d7b))
* **storage_account:** remove tag logic ([#174](https://github.com/Nmbrs/tf-modules/issues/174)) ([f9ec3e7](https://github.com/Nmbrs/tf-modules/commit/f9ec3e7cee62fc2dcb3d37862ba7dfb6800e7d7e))
* **virtual_machine:** add virtual machine module ([#180](https://github.com/Nmbrs/tf-modules/issues/180)) ([02bc55b](https://github.com/Nmbrs/tf-modules/commit/02bc55bc4dacef431ca2ffefd0a7521276f2e9c4))
* **virtual_network:** remove environment validation ([#171](https://github.com/Nmbrs/tf-modules/issues/171)) ([38bd1d1](https://github.com/Nmbrs/tf-modules/commit/38bd1d1a42f459866563c64d72270392d909421d))
* **virtual_network:** remove tag logic from terraform ([#178](https://github.com/Nmbrs/tf-modules/issues/178)) ([063ca25](https://github.com/Nmbrs/tf-modules/commit/063ca25e7f932fb9c2d7c1b541a64e942375bfd2))
* **virtual_network:** update subnet parameters to prevent future deprecation ([#165](https://github.com/Nmbrs/tf-modules/issues/165)) ([34bfdb6](https://github.com/Nmbrs/tf-modules/commit/34bfdb6410dd82f54a044c8f19c2806767f98cea))


### Bug Fixes

* **cosmos_db:** removal old module cosmos db ([#177](https://github.com/Nmbrs/tf-modules/issues/177)) ([6a2dac2](https://github.com/Nmbrs/tf-modules/commit/6a2dac2a153479d7a60b355dd52280dc5720d404))
* **natgateway:** create nat gw module ([#183](https://github.com/Nmbrs/tf-modules/issues/183)) ([ec7ad66](https://github.com/Nmbrs/tf-modules/commit/ec7ad668a739ad15597305e057106236320c7c49))
* **virtual_network:** fix private_endpoint_network_policies_enabled misplacement ([#184](https://github.com/Nmbrs/tf-modules/issues/184)) ([c605af9](https://github.com/Nmbrs/tf-modules/commit/c605af945a0fe5dd2bdbad1ed29244aded393adb))
* **virtual_network:** update service delegation acitons ([#164](https://github.com/Nmbrs/tf-modules/issues/164)) ([4f961bc](https://github.com/Nmbrs/tf-modules/commit/4f961bc5865720f6d6f90eca56a25ebef500cc87))

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
