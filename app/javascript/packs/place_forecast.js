const toggleWinner = (teamOne, teamTwo) => {
  teamOne.addEventListener("click", (event) => {
    teamOne.classList.toggle("winning-team");
    teamTwo.classList.toggle("losing-team");

    if (teamOne.classList.contains('losing-team')) {
      teamOne.classList.toggle("losing-team");
      teamTwo.classList.toggle("winning-team");
    }
  });
}

const addTeamToggles = match => {
  const teamA = match.children["team-a"];
  const teamB = match.children["team-b"];

  toggleWinner(teamA, teamB);
  toggleWinner(teamB, teamA);
}

const placeForecast = () => {
  const matches = document.querySelectorAll('.forecast-card');

  matches.forEach(match => addTeamToggles(match))
}

export { placeForecast };
