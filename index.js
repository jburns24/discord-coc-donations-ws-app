import 'dotenv/config';
import { Client as DiscordClient, GatewayIntentBits } from 'discord.js';
import { Client as ClashClient } from 'clashofclans.js';
import { getClanTag } from './helpers.js';

// Create a new client instance with intents that allow the bot to get information about guilds, messages, and message content
const discordClient = new DiscordClient({ intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMessages, GatewayIntentBits.MessageContent] });
const clashClient = new ClashClient({ keys: [process.env.CLASH_TOKEN] });

// Need to build a map of the guilds that have this bot registered.
// Need to make sure that only one clan is registered per guild.
let registeredGuilds = new Map();

// When the client is ready, run this code. Log 'Ready!' in the console.
discordClient.once('ready', () => {
    console.log('Ready!');
});

// Listen for a message that is 'ping' and reply with 'Pong!'
discordClient.on('messageCreate', async message => {
    // Avoid bot responding to its own messages
    if (message.author.bot) return;

    // Check if the bot is mentioned in the message
    if (message.mentions.has(discordClient.user.id) && message.content.includes('register clan')) {
        const clanTag = getClanTag(message.content);
        const guildId = message.guild.id;
        registeredGuilds.set(guildId, clanTag);
        message.channel.send(`Registered clan ${clanTag} for this guild.`);
    }
});

// Listen for a message that is 'beep' and reply with 'Boop!' But this should be an async handler
discordClient.on('messageCreate', async message => {
    if (message.content === 'donations') {
        if (!registeredGuilds.has(message.guild.id)) {
            await message.reply('No clan registered for this guild.');
            return;
        }
        const clan = await clashClient.getClan(registeredGuilds.get(message.guild.id));
        const players = await clan.fetchMembers();
        const playerAndDonations = players.map(p => [p.name, p.donations]);
        // Get the season for a player
        const sortedDonations = playerAndDonations.sort((a, b) => b[1] - a[1]);
        message.channel.send(`Top 10 Donators in ${clan.name}:\n${sortedDonations.slice(0, 10).map(p => `${p[0]}: ${p[1]}`).join('\n')}`);
    }
});

// Login to Discord with your app's token from .env file
discordClient.login(process.env.DISCORD_TOKEN);
