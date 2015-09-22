$(function() {
    var availableGames = [
        "League of Legends",
        "SOMA",
        "Dota",
        "FIFA",
        "NBA 2K15",
        "Mad Max",
        "Dragon Ball"
    ];
    $( "#stream_game" ).autocomplete({
        source: availableGames
    });
});