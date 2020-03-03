import Rails from 'rails-ujs';

const toggleWinner = (teamOne, teamTwo, match) => {
  teamOne.addEventListener("click", (event) => {
    teamOne.classList.toggle("winning-team");
    teamTwo.classList.toggle("losing-team");

    if (teamOne.classList.contains('losing-team')) {
      teamOne.classList.toggle("losing-team");
      teamTwo.classList.toggle("winning-team");
    }

    updateForecast(match);
  });
}

const updateForecast = match => {
  const form = match.querySelector('form');
  const winnerForecast = match.querySelector('.winning-team');
  const input = form.querySelector("#forecast_team");

  if (winnerForecast) {
    input.value = winnerForecast.dataset.teamId;
  } else {
    input.value = "";
  }

  Rails.fire(form, 'submit')
}

const addTeamToggles = match => {
  const teamA = match.children["team-a"];
  const teamB = match.children["team-b"];

  toggleWinner(teamA, teamB, match);
  toggleWinner(teamB, teamA, match);
}

const placeForecast = () => {
  const matches = document.querySelectorAll('.forecast-card');

  matches.forEach(match => addTeamToggles(match))
}

export { placeForecast };
