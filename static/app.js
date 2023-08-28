var positions = [];
var currentPositionIndex = 0;
let game = new Chess();

function loadPgn(pgnText) {
    game.reset();  // Reset the game.
    positions = [];  // Clear previous positions.
    currentPositionIndex = 0;  // Start at the beginning.

    game.load_pgn(pgnText);
    // Store starting position
    positions.push(game.fen());

    // Play through the moves and store each position.
    const moves = game.history();
    game.reset();  // Start from the beginning.
    for(let move of moves) {
        game.move(move);
        positions.push(game.fen());
    }
    board.position(positions[0]);
}

const board = Chessboard('board', {
    draggable: false,
    position: 'start'
});

$('#prevBtn').on('click', function() {
     if (currentPositionIndex > 0) {
        currentPositionIndex--;
        board.position(positions[currentPositionIndex]);
    }
});

$('#nextBtn').on('click', function() {
     if (currentPositionIndex < positions.length - 1) {
        currentPositionIndex++;
        board.position(positions[currentPositionIndex]);
    }
});

$(document).ready(function() {
    fetch('/api/games').then(response => response.json()).then(data => {
        let gamesTable = $('#gamesTable tbody');
        data.games.forEach(game => {
            gamesTable.append(`
                <tr>
                    <td>${game.game_id}</td>
                    <td>${game.white}</td>
                    <td>${game.black}</td>
                </tr>
            `);
        });
    });


 fetch('/api/players').then(response => response.json()).then(data => {
        let playersTable = $('#playersTable tbody');
        data.players.forEach(player => {
            playersTable.append(`
                <tr>
                    <td>${player.player_id}</td>
                    <td>${player.username}</td>
                    <td>${player.rating}</td>
                </tr>
            `);
        });
    });

    fetch('/api/game-details').then(response => response.json()).then(data => {
        let gameDetailsTable = $('#gameDetailsTable tbody');
        data.game_details.forEach(detail => {
            gameDetailsTable.append(`
                <tr>
                    <td>${detail.game_id}</td>
                    <td>${detail.winner}</td>
                    <td>${detail.result}</td>
                    <td>${detail.time_control}</td>
                    <td>${detail.move_count}</td>
                    <td>${detail.moves}</td>
                </tr>
            `);
        });
    });

    // Event listener to load the PGN onto the board when a row in gameDetailsTable is clicked
    $('#gameDetailsTable').on('click', 'tr', function() {
        const moves = $(this).find("td:last").text();
        loadPgn(moves);
    });

    // SQL Query execution
    $('#executeQueryBtn').on('click', function() {
        const query = $('#sqlQueryInput').val();
        fetch('/api/execute-query', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({query: query})
        }).then(response => response.json()).then(data => {
            if (data.error) {
                alert(data.error);
            } else {
                displayQueryResults(data.results);
            }
        });
function displayQueryResults(results) {
    let tableHtml = '<table class="query-results-table">';
    if (results.length > 0) {
        tableHtml += '<thead><tr>';
        for (let key in results[0]) {
            tableHtml += `<th>${key}</th>`;
        }
        tableHtml += '</tr></thead><tbody>';

        for (let row of results) {
            tableHtml += '<tr>';
            for (let key in row) {
                tableHtml += `<td>${row[key]}</td>`;
            }
            tableHtml += '</tr>';
        }
        tableHtml += '</tbody>';
    } else {
        tableHtml += '<tr><td>No results found</td></tr>';
    }
    tableHtml += '</table>';
    document.querySelector('#queryOutput').innerHTML = tableHtml;
}
    });
});

