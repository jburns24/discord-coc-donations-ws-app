const { Client, GatewayIntentBits } = require('discord.js');

// Create a new client instance with intents that allow the bot to get information about guilds, messages, and message content
const client = new Client({ intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMessages, GatewayIntentBits.MessageContent] });

// When the client is ready, run this code. Log 'Ready!' in the console.
client.once('ready', () => {
    console.log('Ready!');
});

// Listen for a message that is 'ping' and reply with 'Pong!'
client.on('messageCreate', message => {
    if (message.content === 'ping') {
        message.reply('Pong!');
    }
});

// Listen for a message that is 'beep' and reply with 'Boop!' But this should be an async handler
client.on('messageCreate', async message => {
    if (message.content === 'beep') {
        await message.reply('Boop!');
    }
});

// Login to Discord with your app's token from .env file
client.login(process.env.DISCORD_TOKEN);
