function getClanTag (message) {
    const tag = message.match(/#[A-Z0-9]+/);
    return tag ? tag[0] : null;
}

export { getClanTag };
