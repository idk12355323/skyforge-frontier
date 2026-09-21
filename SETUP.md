# Skyforge Frontier — Studio setup

## Prerequisites
- Roblox Studio
- Rojo 7.x (VS Code extension or Rojo CLI)
- A published Roblox experience for DataStore and monetization testing

## Open the project
1. Clone/download this repository.
2. Install Rojo from https://rojo.space/.
3. Open Roblox Studio and create a Baseplate experience.
4. Open a terminal in this repository and run `rojo serve`.
5. In Studio, open the Rojo plugin and connect to `SkyforgeFrontier`.
6. Keep Rojo connected while editing. The server scripts appear under ServerScriptService, shared modules/remotes under ReplicatedStorage, and the client script under StarterPlayerScripts.
7. Press Play (not only Run) to test multiplayer behavior. Use Test > Start with 2 Players for trading.

## Publish and DataStores
1. File > Publish to Roblox As... and publish the place.
2. In Game Settings > Security, enable **Enable Studio Access to API Services** for Studio DataStore testing.
3. DataStore writes are disabled/limited in unpublished places; publish before testing persistence.

## Replace monetization IDs
Edit `src/ReplicatedStorage/Shared/Config.lua`:
- `Gamepasses.VIP`, `Gamepasses.Lucky`, and `Gamepasses.AutoCollect`
- `Products.GemsSmall`, `Products.GemsLarge`, `Products.VIPBundle`, and `Products.RebirthToken`
- `AdminUserIds`

Create passes/products in Creator Dashboard first, then paste their numeric IDs into Config.lua and reconnect Rojo. Product receipts are handled server-side in `MonetizationService.lua`.

## Test checklist
- Collect crystals and verify Gems/leaderstats.
- Hatch eggs, equip pets, upgrade, rebirth, and unlock zones.
- Claim daily reward and redeem `SKYFORGE`, `FRIENDSHIP`, or `LAUNCH`.
- Start with two players and send/accept a trade.
- Test VIP and product prompts after replacing IDs.
- Publish, leave, rejoin, and verify DataStore persistence.

## Limitations
A binary `.rbxlx` place is not generated here because Roblox place files contain serialized engine assets and cannot be reliably authored through GitHub text-file APIs. The Rojo project is the source of truth and generates the playable place in Studio.
