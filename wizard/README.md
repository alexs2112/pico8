# Wizard Game
A cozy game where you act as a wizard managing a potion store. Grow and harvest plants, brew potions, and fulfill orders.

![Cartridge](./wizard.p8.png)

### Brainstorming
**Actions**
Garden:
- Use seeds to grow plants
- Harvest plants
- Start with 3 growth plots, can unlock more

Alchemy Lab:
- Use plants to brew potions
- Start with 2 plants per potion, unlock a third slot

Combine Plants:
- Mash a plant into Paste
- Mix Paste plus another Seed that has matching tags to combine them into a new seed with different stats to make more complicated potions 

Storefront:
- Sell potions for $$$

The Cat:
- Receive special orders for potions for additional $$$ if sold within a time limit

The Frog:
- Feed plants to The Frog to learn a tag on the plant

The Crow:
- Place an order with the crow to purchase seeds

Upgrade Store:
- Purchase upgrades or cosmetics

Journal:
- Keep track of harvested plants and brewed potions

**Components**
Seeds:
- Each seed has a Price
- Each seed has a Growth Time
- Each seed grows into a Plant
- Each seed can be mixed with exactly 1 Paste with a matching Tag to create a new seed

Plants:
- Each plant has some number of stats
- Each plant has some number of tags that are initially unknown
- Each plant can be Mashed into Paste
- Each plant can be Brewed into a Potion
- Each plant can be Fed to the Frog to learn a Tag

Potions:
- Each potion can be brewed with 1-3 plants
- Each potion has stats that are the sum of the plants required to brew it
- Each potion has a sell value
